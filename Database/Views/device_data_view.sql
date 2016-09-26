CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `device_data_view` AS
    SELECT 
        `d`.`id` AS `deviceId`,
        `d`.`name` AS `deviceName`,
        `v`.`name` AS `VariableName`,
        `v`.`id` AS `variableId`,
        `vv`.`timestamp` AS `valueTimestamp`,
        `vv`.`value` AS `latestValue`
    FROM
        (((`smes_microgrid`.`device` `d`
        JOIN `smes_microgrid`.`variable` `v` ON ((`v`.`device_id` = `d`.`id`)))
        LEFT JOIN (SELECT 
            MAX(`smes_microgrid`.`variable_value`.`timestamp`) AS `latestTimestamp`,
                `smes_microgrid`.`variable_value`.`variable_id` AS `variable_id`
        FROM
            `smes_microgrid`.`variable_value`
        GROUP BY `smes_microgrid`.`variable_value`.`variable_id`) `latestvv` ON ((`latestvv`.`variable_id` = `v`.`id`)))
        LEFT JOIN `smes_microgrid`.`variable_value` `vv` ON (((`vv`.`variable_id` = `latestvv`.`variable_id`)
            AND (`vv`.`timestamp` = `latestvv`.`latestTimestamp`))))
    ORDER BY `d`.`id` , `v`.`id`