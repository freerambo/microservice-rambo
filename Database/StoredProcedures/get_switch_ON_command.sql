CREATE DEFINER=`root`@`localhost` PROCEDURE `get_switch_ON_command`(IN device_id INT, IN variable_id INT)
BEGIN

-- Parameter variable_id used to return switchON command when there are more than one CHANNELS
-- Channel_1_Status is one variable with some ON/OFF commands,
-- Channel_2_Status is another variable with some ON/OFF commands


-- SELECT * FROM smes_microgrid.command_type;

-- 10	Read	Read all values from device
-- 11	Switch ON	
-- 12	Switch OFF	
-- 90	Other	


SELECT  C.format_string as commandFormatString,
        C.id as commandId,
        C.name as commandName,
        C.command_protocol_id as protocolId,
        C.command_type_id as commandTypeId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
	CT.name as commandTypeName,
    CDV.variable_id as statusVariableId,
    V.name as statusVariableName 
FROM device 			as D 
INNER JOIN command 			as C ON C.device_id = D.id
INNER JOIN command_device_variable CDV ON CDV.command_id = C.id AND CDV.variable_id = variable_id 
INNER JOIN variable V ON V.id = variable_id 
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE D.id = device_id  AND CT.id = 11 -- Command type 11 is 'Switch On'
LIMIT 1;  

END