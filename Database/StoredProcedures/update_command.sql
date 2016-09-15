CREATE DEFINER=`root`@`localhost` PROCEDURE `update_command`(IN command_id INT, 
														  IN name VARCHAR(45), 
                                                          IN description VARCHAR(255), 
														  IN format_string VARCHAR(255),
                                                          IN input_variables VARCHAR(255), -- comma-separated list of variables IDs
                                                          IN output_variables VARCHAR(255))
BEGIN
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.add_command');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    RESIGNAL;
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW Command';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.update_command', CONCAT('Start Updateing COMMAND to with CommandID =', command_id, ' Values Are: Name= ', name));
-- End of Logging

	UPDATE `smes_microgrid`.`command`
	SET
	`name` = name,
	`description` = description,
	`format_string` = format_string
	WHERE `id` = command_id;

	
   -- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_command', CONCAT('Command Updated, CommandID=', command_id, ' New Values are: Name =', name, ' , Description=', description, ' , Format String=', format_string));
	-- End of Logging
    
    -- For parameter types 1 and 2 are hardcoded:
	-- ID   Name
	-- 1	Inpit Param	input to command
	-- 2	Output	output of the command

	-- Delete all references for this command before inserting new ones:
	DELETE FROM `smes_microgrid`.`command_device_variable`
	WHERE command_id = command_id ;


	INSERT INTO `smes_microgrid`.`command_device_variable`
	(`command_id`,
	`variable_id`,
	`parameter_type_id`)
	SELECT command_id , variable.id, 1 FROM variable WHERE FIND_IN_SET(variable.id, input_variables);

 	INSERT INTO `smes_microgrid`.`command_device_variable`
	(`command_id`,
	`variable_id`,
	`parameter_type_id`)
	SELECT command_id , variable.id, 2 FROM variable WHERE FIND_IN_SET(variable.id, output_variables);                                       
    
  -- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_command', CONCAT('Added INPUT and OUTPUT variables to the Command:', command_id));
	-- End of Logging                                          
	
	COMMIT;  
    
END