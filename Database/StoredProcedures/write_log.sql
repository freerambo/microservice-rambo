CREATE DEFINER=`root`@`localhost` PROCEDURE `write_log`(IN message_level CHAR(7),  IN sql_state CHAR(5), IN error_code SMALLINT(6),
								IN conn_id INTEGER, IN user VARCHAR(30), IN log_source VARCHAR(255), 
                                IN message TEXT)
BEGIN
START TRANSACTION;	

INSERT INTO smes_microgrid.`log`
							(`msg_timestamp`,
							`level`,
							`code`,
							`sqlstate`,
							`message`,
							`process_id`,
							`procedure`,
							`user`)
							VALUES
							( CURRENT_TIMESTAMP,
							message_level,
							error_code,
							sql_state, 		-- SQLSTATE class='00' indicates success
							message,
                            conn_id,
							log_source,    	-- name of the caller (stored procedure or script function)
							user); 
              
 COMMIT;   
END