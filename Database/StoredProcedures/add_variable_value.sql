CREATE DEFINER=`root`@`localhost` PROCEDURE `add_variable_value`(IN variable_id INT, IN data_timestamp TIMESTAMP, IN value DECIMAL(59,6))
BEGIN
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.add_variable_value');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW VALUE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_variable', CONCAT('Start Adding new VARIABLE_Value with VariableID =', variable_id, ' Values Are:  Timestamp = ', data_timestamp, ' Value = ', value));
-- End of Logging

	INSERT INTO `smes_microgrid`.`variable_value`
				(`timestamp`,
				`variable_id`,
				`value`)
				VALUES
				 (data_timestamp,
				  variable_id,
				  value);
	SELECT ROW_COUNT(); 
	COMMIT;  
    


END