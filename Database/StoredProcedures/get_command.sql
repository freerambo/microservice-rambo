CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command`(IN id INT)
BEGIN

SELECT C.`id` as id,
    C.`name` as name,
    C.`description` as description,
    C.`format_string` as formatString,
    C.`device_id` as deviceId,
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
	CT.name as commandTypeName,
    CDV_IN.variable_id as inputVariableId,
    CDV_out.variable_id as outputVariableId
FROM command as C
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
LEFT JOIN command_device_variable CDV_IN ON CDV_IN.command_id = C.id and CDV_IN.parameter_type_id = 1
LEFT JOIN command_device_variable CDV_OUT ON CDV_OUT.command_id = C.id and CDV_OUT.parameter_type_id = 2
WHERE C.id = id 
;

END