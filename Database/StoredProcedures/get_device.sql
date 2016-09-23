CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device`(IN id INT)
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
    C.id as readCommandId,
    C.format_string as readCommand
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
LEFT JOIN bus as B on B.id = D.bus_id
LEFT JOIN (SELECT id, format_string FROM command WHERE device_id = id LIMIT 1) as C  ON 1=1  -- This is to return only 1 row in case if more than 1 command exists. For SPrint1 version we assume there is only 1 command but the structure is done to support more. 
WHERE D.id=id
;

END