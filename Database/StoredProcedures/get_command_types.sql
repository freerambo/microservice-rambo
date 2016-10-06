CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_types`()
BEGIN

SELECT id as id, name as name, description as description 
FROM `smes_microgrid`.`command_type`;

END