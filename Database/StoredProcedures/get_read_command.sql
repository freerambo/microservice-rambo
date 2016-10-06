CREATE DEFINER=`root`@`localhost` PROCEDURE `get_read_command`(IN variable_id INT)
BEGIN

SELECT  V.id as variableId,
		V.name as variableName,
		C.format_string as commandFormatString,
        C.id as commandId,
        C.command_protocol_id as protocolId,
        C.command_type_id as commandTypeId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
		CP.name as protocolName,
		CT.name as commandTypeName
FROM variable as V 
INNER JOIN command 			as C ON C.id = V.get_command_id
INNER JOIN device 			as D ON D.id = V.device_id
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE V.id = variable_id;

END