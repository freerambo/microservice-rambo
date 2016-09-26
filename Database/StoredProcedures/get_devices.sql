CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices`()
BEGIN

SELECT D.`id` as id,
    D.`device_type_id` as typeId,
	 DT.`name` as typeName,
     DC.`id` as classID,
     DC.`name` as className,
    D.`name` as name,
    D.`description` as description,
    D.`microgrid_id` as microgridID,
     M.`name` as microgridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as vendor,
    D.`model` as model,
    D.`location` as location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as portNumber,
    D.`bus_id` as busID,
	B.name as busName,
    D.`is_programmable` as isProgrammable,
    D.`is_connected` as isConnected,
    D.`comment` as comment,
    0 as readCommandId,
    '' as readCommand
    -- C.id as readCommandId,
    -- C.format_string as readCommand
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
LEFT JOIN bus as B on B.id = D.bus_id
-- LEFT JOIN command as C ON C.device_id = D.id 
ORDER BY D.id
;

END