CREATE DEFINER=`root`@`localhost` PROCEDURE `update_device`(  IN id INT,
									IN device_type_id TINYINT,
									IN name VARCHAR(255),
									IN description VARCHAR(255),
									IN microgrid_id TINYINT,

									IN vendor VARCHAR(100),
									IN model VARCHAR(100),
									IN location VARCHAR(100),
									IN ip_adress VARCHAR(255),
									IN port_number VARCHAR(10),
									IN bus_id TINYINT,
									IN is_programmable BIT,
									IN is_connected BIT)
BEGIN

-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.update_device');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when UPDATING A DEVICE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.update_device', CONCAT('Start device update ,ID= ', id));
-- End of Logging

	-- Note - COALESCE takes first non-null value. it means, using it we can't set value to NULL (that is OK for now as we can set empty string for all the string columns)
	UPDATE smes_microgrid.device as D
	SET 
	`device_type_id` = COALESCE(device_type_id, D.device_type_id) ,
	`name` = COALESCE(name, D.name) ,
	`description` = COALESCE( description, D.description) ,
	`microgrid_id` = COALESCE( microgrid_id , D.microgrid_id),

	`vendor` = COALESCE( vendor, D.vendor),
	`model` = COALESCE( model, D.model),
	`location` = COALESCE(location , D.location),
	`ip_adress` = COALESCE(ip_adress , D.ip_adress),
	`port_number` = COALESCE( port_number, D.port_number),
	`bus_id` = COALESCE(bus_id , D.bus_id),
	`is_programmable` = COALESCE( is_programmable, D.is_programmable),
	`is_connected` = COALESCE( is_connected, D.is_connected) 
	WHERE D.id = id;



	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_device', 'Device Updated, New values are: TODO');
	-- End of Logging

	COMMIT;  

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
WHERE D.id=id
;

END