CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices`()
BEGIN

SELECT D.`id` as ID,
    D.`device_type_id` as TypeID,
	 DT.`name` as TypeName,
     DC.`id` as ClassID,
     DC.`name` as ClassName,
    D.`name` as Name,
    D.`description` as Description,
    D.`microgrid_id` as MicrogridID,
     M.`name` as MicrogridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as Vendor,
    D.`model` as Model,
    D.`location` as Location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as PortNumber,
    D.`bus_id` as BusID,
    D.`is_programmable` as IsProgrammable,
    D.`is_connected` as IsConnected
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
;

END