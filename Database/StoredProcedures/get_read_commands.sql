CREATE DEFINER=`root`@`localhost` PROCEDURE `get_read_commands`()
BEGIN

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

END