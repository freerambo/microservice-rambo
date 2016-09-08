CREATE DEFINER=`root`@`localhost` PROCEDURE `add_command`(IN device_id INT, IN name VARCHAR(45), IN description VARCHAR(255), 
														  IN format_string VARCHAR(255))
BEGIN
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.add_command');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW Command';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Start Adding new COMMAND to Device with DeviceID =', device_id, ' Values Are: Name= ', name));
-- End of Logging


	INSERT INTO `smes_microgrid`.`command`( `name`,
											`description`,
											`format_string`,
											`device_id`)
	VALUES 								  ( name,
											description,
                                            format_string,
                                            device_id
											);	
                                            
    -- SELECT
    --     app_id, GROUP_CONCAT(user_id)
    -- FROM
    --     smes_microgrid.variable V
    -- WHERE
    --     FIND_IN_SET(app_id, id_list) > 0
    -- GROUP BY app_id;
                                            
	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Command Added to Device ID=', device_id, ' New command ID is: ', LAST_INSERT_ID()));
	-- End of Logging
	COMMIT;  
    
END