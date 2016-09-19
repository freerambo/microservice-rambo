CREATE DEFINER=`root`@`localhost` PROCEDURE `get_units`()
BEGIN

SELECT `variable_unit`.`id` as id,
    `variable_unit`.`code` as code,
    `variable_unit`.`name` as name,
    `variable_unit`.`description` as description
FROM `smes_microgrid`.`variable_unit`;

END