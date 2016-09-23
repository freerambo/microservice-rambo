CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_data`(IN id INT, IN dateFrom DATETIME, IN dateTo DATETIME)
BEGIN

-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.get_device_data');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SET @msg = CONCAT('ERROR: An error occurred when getting DEVICE DATA, Device id = ', id);
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg ;
END;

SET @sql = NULL;
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

-- This this a quick fix, need to rewrite for null/not null parameters in one SQL statement.
IF dateFrom IS NULL OR dateTo IS NULL  -- no filtering
THEN
SET @sql = CONCAT(  'SELECT VV.timestamp, ', @sql, 
					' FROM smes_microgrid.variable_value as VV
					LEFT JOIN smes_microgrid.variable as V ON V.id= VV.variable_id
					 GROUP BY VV.timestamp;');
ELSE  -- filtering
SET @sql = CONCAT(  'SELECT VV.timestamp, ', @sql, 
					' FROM smes_microgrid.variable_value as VV
					LEFT JOIN smes_microgrid.variable as V ON V.id= VV.variable_id
                     WHERE (VV.timestamp> ''', dateFrom, ''') 
					 AND (VV.timestamp< ''', dateTo, ''')
					 GROUP BY VV.timestamp;');
END IF;    
                     
                     
 -- select @sql as sql2;
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


END