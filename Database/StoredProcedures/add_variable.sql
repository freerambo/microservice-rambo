CREATE DEFINER=`root`@`localhost` PROCEDURE `add_variable`(IN device_id INT, IN name VARCHAR(45), IN description VARCHAR(255), IN unit_id TINYINT, IN updating_duration TINYINT)
BEGIN
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.add_variable');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW VARIABLE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_variable', CONCAT('Start Adding new VARIABLE to Device with DeviceID =', device_id, ' Values Are:  ', 'TODO'));
-- End of Logging


		INSERT INTO `smes_microgrid`.`variable`
		(
		`device_id`,
		`name`,
		`description`,
		`unit_id`,
		`updating_duration`
		)
		VALUES
		(
		device_id,
		name,
		description,
		unit_id,
		updating_duration

		-- Get and Set commands can be added only when variable is assigned to IN/OUR parameter list
		-- set_command_id,
		-- get_command_id
		);


	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_variable', CONCAT('Variable Added to Device ID=', device_id, ' New variable ID is: ', LAST_INSERT_ID()));
	-- End of Logging

	COMMIT;  
    
SELECT V.`id` as id,
    V.`device_id` as deviceId,
    V.`name` as name,
    V.`description` as description,
    V.`unit_id` as unitID,
    V.`updating_duration` as updatingDuration,
    V.`set_command_id` as setCommandID,
    V.`get_command_id` as getCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = LAST_INSERT_ID(); 

END