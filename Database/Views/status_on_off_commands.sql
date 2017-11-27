CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `mysqluser`@`%` 
    SQL SECURITY DEFINER
VIEW `status_on_off_commands` AS
    SELECT 
        `v`.`id` AS `statusVariableId`,
        `v`.`name` AS `statusVariableName`,
        MAX(`onoff`.`switchOnCommandId`) AS `switchOnCommandId`,
        MAX(`onoff`.`switchOnCommandName`) AS `switchOnCommandName`,
        MAX(`onoff`.`switchOnCommand`) AS `switchOnCommand`,
        MAX(`onoff`.`switchOnCommandProtocolId`) AS `switchOnCommandProtocolId`,
        MAX(`onoff`.`switchOffCommandId`) AS `switchOffCommandId`,
        MAX(`onoff`.`switchOfCommandName`) AS `switchOfCommandName`,
        MAX(`onoff`.`switchOffCommand`) AS `switchOffCommand`,
        MAX(`onoff`.`switchOffCommandProtocolId`) AS `switchOffCommandProtocolId`
    FROM
        (`smes_microgrid`.`variable` `v`
        JOIN (SELECT 
            `c_on`.`id` AS `switchOnCommandId`,
                `c_on`.`name` AS `switchOnCommandName`,
                `c_on`.`format_string` AS `switchOnCommand`,
                `c_on`.`command_protocol_id` AS `switchOnCommandProtocolId`,
                NULL AS `switchOffCommandId`,
                NULL AS `switchOfCommandName`,
                NULL AS `switchOffCommand`,
                NULL AS `switchOffCommandProtocolId`,
                `cdv`.`variable_id` AS `variable_id`
        FROM
            (`smes_microgrid`.`command` `c_on`
        LEFT JOIN `smes_microgrid`.`command_device_variable` `cdv` ON ((`cdv`.`command_id` = `c_on`.`id`)))
        WHERE
            ((`c_on`.`id` = `cdv`.`command_id`)
                AND (`c_on`.`command_type_id` = 11)) UNION ALL SELECT 
            NULL AS `switchOnCommandId`,
                NULL AS `switchOnCommandName`,
                NULL AS `switchOnCommand`,
                NULL AS `switchOnCommandProtocolId`,
                `c_off`.`id` AS `switchOffCommandId`,
                `c_off`.`name` AS `switchOfCommandName`,
                `c_off`.`format_string` AS `switchOffCommand`,
                `c_off`.`command_protocol_id` AS `switchOffCommandProtocolId`,
                `cdv`.`variable_id` AS `variableId`
        FROM
            (`smes_microgrid`.`command` `c_off`
        LEFT JOIN `smes_microgrid`.`command_device_variable` `cdv` ON ((`cdv`.`command_id` = `c_off`.`id`)))
        WHERE
            ((`c_off`.`id` = `cdv`.`command_id`)
                AND (`c_off`.`command_type_id` = 12))) `onoff` ON ((`v`.`id` = `onoff`.`variable_id`)))
    GROUP BY `v`.`id`