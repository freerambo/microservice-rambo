CREATE DEFINER=`root`@`localhost` PROCEDURE `log_error`(IN sp_name VARCHAR(255))
BEGIN
GET DIAGNOSTICS @cno = NUMBER;
	GET DIAGNOSTICS CONDITION @cno 	@sqlstate = RETURNED_SQLSTATE, 
									@errno = MYSQL_ERRNO, 
									@text = MESSAGE_TEXT;
 
	CALL smes_microgrid.write_log('ERROR', @sqlstate, @errno, CONNECTION_ID(), CURRENT_USER(), sp_name, @text);
END