CREATE DEFINER=`root`@`localhost` PROCEDURE `add_device`(
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
IN is_connected BIT
)
BEGIN

-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.add_device');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW DEVICE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_device', CONCAT('Start Adding new device, Values Are:  ', 'TODO'));
-- End of Logging

			INSERT INTO `smes_microgrid`.`device`
						(`device_type_id`,
						`name`,
						`description`,
						`microgrid_id`,
						`vendor`,
						`model`,
						`location`,
						`ip_adress`,
						`port_number`,
						`bus_id`,
						`is_programmable`,
						`is_connected`)
			VALUES
						(device_type_id,
						name,
						description,
						microgrid_id,
						vendor,
						model,
						location,
						ip_adress,
						port_number,
						bus_id,
						is_programmable,
						is_connected
						);

	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_device', CONCAT('Device Added, New device ID is: ', LAST_INSERT_ID()));
	-- End of Logging

	COMMIT;  
    -- CALL smes_microgrid.get_device(LAST_INSERT_ID());
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
WHERE D.id=LAST_INSERT_ID()
;

END