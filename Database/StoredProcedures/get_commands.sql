CREATE DEFINER=`root`@`localhost` PROCEDURE `get_commands`(IN device_id INT)
BEGIN

SELECT C.`id` as id,
    C.`name` as name,
    C.`description` as description,
    C.`format_string` as formatString,
    C.`device_id` as deviceId,
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
	CT.name as commandTypeName
FROM `smes_microgrid`.`command` as C
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE C.device_id = device_id 
;

END