CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_data_latest`(IN id INT)
BEGIN

SELECT `device_data_view`.`deviceId`,
    `device_data_view`.`deviceName`,
    `device_data_view`.`VariableName`,
    `device_data_view`.`variableId`,
    `device_data_view`.`valueTimestamp`,
    `device_data_view`.`latestValue`
FROM `smes_microgrid`.`device_data_view`
WHERE `deviceId` = id;

/*
-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.get_device_data_latest');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    
    RESIGNAL;
    -- SET @msg = CONCAT('ERROR: An error occurred when getting DEVICE DATA, Device id = ', id);
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg ;
END;
*/
/*	SET @sql = NULL;
	SELECT
	  GROUP_CONCAT(DISTINCT
		CONCAT(
		  'coalesce(SUM(case when V.id = ',
		  smes_microgrid.variable.id,
		  ' then VV.value end), 0) AS ',
		  name
		)
	  ) INTO @sql
	FROM smes_microgrid.variable
	where device_id = id
	ORDER BY smes_microgrid.variable.id;  -- ORDER is important here, we map with headers taken from get_variables

	-- select @sql as sql1;

	SET @sql = CONCAT(  'SELECT VV.timestamp, ', @sql, 
						' FROM 
								(SELECT `timestamp`, `value`, `variable_id` FROM smes_microgrid.variable_value  
								ORDER BY `timestamp` DESC
								LIMIT 1)
							 as VV
						  LEFT JOIN smes_microgrid.variable as V ON V.id= VV.variable_id;');

					
select @sql as sql2;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

*/
END