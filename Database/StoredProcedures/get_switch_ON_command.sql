CREATE DEFINER=`root`@`localhost` PROCEDURE `get_switch_ON_command`(IN device_id INT)
BEGIN

-- SELECT * FROM smes_microgrid.command_type;

-- 10	Read	Read all values from device
-- 11	Switch ON	
-- 12	Switch OFF	
-- 90	Other	


SELECT  C.format_string as commandFormatString,
        C.id as commandId,
        C.command_protocol_id as protocolId,
        C.command_type_id as commandTypeId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
	CT.name as commandTypeName
FROM device 			as D 
INNER JOIN command 			as C ON C.device_id = D.id
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE D.id = device_id AND CT.id = 11;  -- Command type 11 is 'Switch On'

END