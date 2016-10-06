CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_protocols`()
BEGIN

SELECT id as id, name as name, description as description 
FROM `smes_microgrid_dev`.`command_protocol`;

END