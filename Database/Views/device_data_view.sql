CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `device_data_view` AS
    SELECT DISTINCT
        `d`.`id` AS `deviceId`,
        `d`.`name` AS `deviceName`,
        `v`.`name` AS `VariableName`,
        `v`.`id` AS `variableId`,
        `vv`.`timestamp` AS `valueTimestamp`,
        `vv`.`value` AS `latestValue`,
        `onoff`.`switchOnCommandId` AS `switchOnCommandId`,
        `onoff`.`switchOnCommandName` AS `switchOnCommandName`,
        `onoff`.`switchOnCommand` AS `switchOnCommand`,
        `onoff`.`switchOnCommandProtocolId` AS `switchOnCommandProtocolId`,
        `onoff`.`switchOffCommandId` AS `switchOffCommandId`,
        `onoff`.`switchOfCommandName` AS `switchOfCommandName`,
        `onoff`.`switchOffCommand` AS `switchOffCommand`,
        `onoff`.`switchOffCommandProtocolId` AS `switchOffCommandProtocolId`
    FROM
        (((((`smes_microgrid`.`device` `d`
        JOIN `smes_microgrid`.`variable` `v` ON ((`v`.`device_id` = `d`.`id`)))
        LEFT JOIN (SELECT 
            MAX(`smes_microgrid`.`variable_value`.`timestamp`) AS `latestTimestamp`,
                `smes_microgrid`.`variable_value`.`variable_id` AS `variable_id`
        FROM
            `smes_microgrid`.`variable_value`
        GROUP BY `smes_microgrid`.`variable_value`.`variable_id`) `latestvv` ON ((`latestvv`.`variable_id` = `v`.`id`)))
        LEFT JOIN `smes_microgrid`.`variable_value` `vv` ON (((`vv`.`variable_id` = `latestvv`.`variable_id`)
            AND (`vv`.`timestamp` = `latestvv`.`latestTimestamp`))))
        LEFT JOIN `smes_microgrid`.`command_device_variable` `cdv` ON (((`cdv`.`variable_id` = `v`.`id`)
            AND (`v`.`unit_id` = 50))))
        LEFT JOIN `smes_microgrid`.`status_on_off_commands` `onoff` ON ((`onoff`.`statusVariableId` = `cdv`.`variable_id`)))
    ORDER BY `d`.`id` , `v`.`id`