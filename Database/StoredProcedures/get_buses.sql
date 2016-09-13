CREATE DEFINER=`root`@`localhost` PROCEDURE `get_buses`()
BEGIN

SELECT id as ID, name as Name, description as Description 
FROM `smes_microgrid`.`bus`;

END