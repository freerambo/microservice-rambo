CREATE DEFINER=`root`@`localhost` PROCEDURE `get_read_commands`()
BEGIN

SELECT 
		C.format_string as commandFormatString,  -- for first version we assume there will be 1 command per device, but later many commands
        C.id as commandId, 
        C.name as commandName,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
        CP.name as protocolName,
		CT.name as commandTypeName,
		GROUP_CONCAT(V.id) as variableIds,  -- for first version we assume all varables of the device expected to be returned by the read command
		GROUP_CONCAT(V.name) as variableNames
FROM device as D  
INNER JOIN command as C ON C.device_id = D.id
INNER JOIN variable as V ON D.id = V.device_id
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE D.is_connected = 1
GROUP BY C.id  -- or b y D.id assuming that 1 device has 1 command only
ORDER BY D.id, V.id;

/* Put it back later when we resolve device concurrency problem
SELECT  V.id as variableId,
		V.name as variableName,
		C.format_string as commandFormatString,
        C.id as commandId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber
FROM variable as V 
INNER JOIN command as C ON C.id = V.get_command_id
INNER JOIN device as D ON D.id = V.device_id
ORDER BY D.id;
*/


END