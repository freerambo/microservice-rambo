CREATE DEFINER=`root`@`localhost` PROCEDURE `get_buses`()
BEGIN

SELECT id as id, name as name, description as description 
FROM `smes_microgrid`.`bus`;

END