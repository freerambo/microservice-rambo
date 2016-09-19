CREATE DEFINER=`root`@`localhost` PROCEDURE `update_variable`(IN variable_id INT, 
									IN name VARCHAR(45), 
									IN description VARCHAR(255), 
									IN unit_id TINYINT, 
									IN updating_duration TINYINT,
									IN set_command_id INT ,
									IN get_command_id INT)
BEGIN
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.update_variable');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when UPDATING VARIABLE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.update_variable', CONCAT('Start UPDATING VARIABLE for Device with VariableID =', variable_id, ' Values Are:  ', 'TODO'));
-- End of Logging


UPDATE `smes_microgrid`.`variable`
SET
`name` = name,
`description` = description,
`unit_id` = unit_id,
`updating_duration` = updating_duration,
`set_command_id` = set_command_id,
`get_command_id` = get_command_id
WHERE `id` = variable_id;

	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_variable', CONCAT('Variable Updated , VariableID=', variable_id));
	-- End of Logging

	COMMIT;  
    
SELECT V.`id` as id,
    V.`device_id` as deviceId,
    V.`name` as name,
    V.`description` as description,
    V.`unit_id` as unitId,
    V.`updating_duration` as updatingDuration,
    V.`set_command_id` as setCommandID,
    V.`get_command_id` as getCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = variable_id; 
    
END