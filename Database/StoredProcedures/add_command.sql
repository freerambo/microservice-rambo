CREATE DEFINER=`root`@`localhost` PROCEDURE `add_command`(IN device_id INT, IN name VARCHAR(45), IN description VARCHAR(255), 
														  IN format_string VARCHAR(255),
                                                          IN protocol_id TINYINT, -- default = 90
                                                          IN command_type_id TINYINT, -- default = 90
                                                          IN input_variables VARCHAR(255), -- comma-separated list of variables IDs
                                                          IN output_variables VARCHAR(255))
BEGIN
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid_dev.log_error('smes_microgrid_dev.add_command');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    RESIGNAL;
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW Command';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid_dev.log_info('smes_microgrid_dev.add_command', CONCAT('Start Adding new COMMAND to Device with DeviceID =', device_id, ' Values Are: Name= ', name));
-- End of Logging

	
	INSERT INTO `smes_microgrid_dev`.`command`( `name`,
											`description`,
											`format_string`,
											`device_id`,
                                            `command_protocol_id`,
                                            `command_type_id`)
	VALUES 						( name,
								description,
								format_string,
								device_id,
                                protocol_id,
                                command_type_id
								);	
	
   -- Log the end of excecution
		CALL smes_microgrid_dev.log_info('smes_microgrid_dev.add_command', CONCAT('Command Added to Device ID=', device_id, ' New command ID is: ', LAST_INSERT_ID()));
	-- End of Logging
    
    SET @cmd_id = LAST_INSERT_ID();
    
    -- For parameter types 1 and 2 are hardcoded:
-- ID   Name
-- 1	Inpit Param	input to command
-- 2	Output	output of the command

	INSERT INTO `smes_microgrid_dev`.`command_device_variable`
	(`command_id`,
	`variable_id`,
	`parameter_type_id`)
	SELECT @cmd_id, variable.id, 1 FROM variable WHERE FIND_IN_SET(variable.id, input_variables);

 	INSERT INTO `smes_microgrid_dev`.`command_device_variable`
	(`command_id`,
	`variable_id`,
	`parameter_type_id`)
	SELECT @cmd_id, variable.id, 2 FROM variable WHERE FIND_IN_SET(variable.id, output_variables);                                       
    
  -- Log the end of excecution
		CALL smes_microgrid_dev.log_info('smes_microgrid_dev.add_command', CONCAT('Added INPUT and OUTPUT variables to the Command:', @cmd_id, ' Device ID is: ', device_id));
	-- End of Logging                                          
	
	COMMIT;  
    
    -- Note: this SP returns command information without references variables. Use a separate call to get_command_variables(@cmd_id) to get variables as well.
    SELECT C.`id` as id,
    C.`name` as name,
    C.`description` as description,
    C.`format_string` as formatString,
    C.`device_id` as deviceID,
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
	CT.name as commandTypeName,
    CDV_IN.variable_id as inputVariableId,
    CDV_out.variable_id as outputVariableId
	FROM command as C
	INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
	INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
	LEFT JOIN command_device_variable CDV_IN ON CDV_IN.command_id = C.id and CDV_IN.parameter_type_id = 1
	LEFT JOIN command_device_variable CDV_OUT ON CDV_OUT.command_id = C.id and CDV_OUT.parameter_type_id = 2
	WHERE C.id = @cmd_id
	;

END