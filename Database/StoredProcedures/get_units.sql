CREATE DEFINER=`root`@`localhost` PROCEDURE `get_units`()
BEGIN

SELECT `variable_unit`.`id` as ID,
    `variable_unit`.`code` as 'Code',
    `variable_unit`.`name` as 'Name',
    `variable_unit`.`description` as 'Description'
FROM `smes_microgrid`.`variable_unit`;

END