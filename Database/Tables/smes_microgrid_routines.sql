CREATE DATABASE  IF NOT EXISTS `smes_microgrid` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `smes_microgrid`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: smes_microgrid
-- ------------------------------------------------------
-- Server version	5.7.13-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `device_data_view`
--

DROP TABLE IF EXISTS `device_data_view`;
/*!50001 DROP VIEW IF EXISTS `device_data_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `device_data_view` AS SELECT 
 1 AS `deviceId`,
 1 AS `deviceName`,
 1 AS `VariableName`,
 1 AS `variableId`,
 1 AS `valueTimestamp`,
 1 AS `latestValue`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `device_data_view`
--

/*!50001 DROP VIEW IF EXISTS `device_data_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `device_data_view` AS select `d`.`id` AS `deviceId`,`d`.`name` AS `deviceName`,`v`.`name` AS `VariableName`,`v`.`id` AS `variableId`,`vv`.`timestamp` AS `valueTimestamp`,`vv`.`value` AS `latestValue` from (((`smes_microgrid`.`device` `d` join `smes_microgrid`.`variable` `v` on((`v`.`device_id` = `d`.`id`))) left join (select max(`smes_microgrid`.`variable_value`.`timestamp`) AS `latestTimestamp`,`smes_microgrid`.`variable_value`.`variable_id` AS `variable_id` from `smes_microgrid`.`variable_value` group by `smes_microgrid`.`variable_value`.`variable_id`) `latestvv` on((`latestvv`.`variable_id` = `v`.`id`))) left join `smes_microgrid`.`variable_value` `vv` on(((`vv`.`variable_id` = `latestvv`.`variable_id`) and (`vv`.`timestamp` = `latestvv`.`latestTimestamp`)))) order by `d`.`id`,`v`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'smes_microgrid'
--

--
-- Dumping routines for database 'smes_microgrid'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_command` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
	CALL smes_microgrid.log_error('smes_microgrid.add_command');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    RESIGNAL;
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW Command';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Start Adding new COMMAND to Device with DeviceID =', device_id, ' Values Are: Name= ', name));
-- End of Logging

	
	INSERT INTO `smes_microgrid`.`command`( `name`,
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
		CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Command Added to Device ID=', device_id, ' New command ID is: ', LAST_INSERT_ID()));
	-- End of Logging
    
    SET @cmd_id = LAST_INSERT_ID();
    
    -- For parameter types 1 and 2 are hardcoded:
-- ID   Name
-- 1	Inpit Param	input to command
-- 2	Output	output of the command

	INSERT INTO `smes_microgrid`.`command_device_variable`
	(`command_id`,
	`variable_id`,
	`parameter_type_id`)
	SELECT @cmd_id, variable.id, 1 FROM variable WHERE FIND_IN_SET(variable.id, input_variables);

 	INSERT INTO `smes_microgrid`.`command_device_variable`
	(`command_id`,
	`variable_id`,
	`parameter_type_id`)
	SELECT @cmd_id, variable.id, 2 FROM variable WHERE FIND_IN_SET(variable.id, output_variables);                                       
    
  -- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Added INPUT and OUTPUT variables to the Command:', @cmd_id, ' Device ID is: ', device_id));
	-- End of Logging                                          
	
	COMMIT;  
    
    -- Note: this SP returns command information without references variables. Use a separate call to get_command_variables(@cmd_id) to get variables as well.
    SELECT C.`id` as id,
    C.`name` as name,
    C.`description` as description,
    C.`format_string` as formatString,
    C.`device_id` as deviceID,
    CP.name as protocolName,
	CT.name as commandTypeName
	FROM `smes_microgrid`.`command` as C
    INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
	INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
	WHERE C.id = @cmd_id
	;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_device` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_device`(
IN device_type_id TINYINT,
IN name VARCHAR(255),
IN description VARCHAR(255),
IN microgrid_id TINYINT,

IN vendor VARCHAR(100),
IN model VARCHAR(100),
IN location VARCHAR(100),
IN ip_adress VARCHAR(255),
IN port_number VARCHAR(10),
IN bus_id TINYINT,
IN is_programmable BIT,
IN is_connected BIT,
IN comment VARCHAR(255),
IN readCommand VARCHAR(255)
)
BEGIN

-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.add_device');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when ADDING NEW DEVICE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_device', CONCAT('Start Adding new device, Values Are:  ', 'TODO'));
-- End of Logging

			INSERT INTO `smes_microgrid`.`device`
						(`device_type_id`,
						`name`,
						`description`,
						`microgrid_id`,
						`vendor`,
						`model`,
						`location`,
						`ip_adress`,
						`port_number`,
						`bus_id`,
						`is_programmable`,
						`is_connected`,
                        `comment`)
			VALUES
						(device_type_id,
						name,
						description,
						microgrid_id,
						vendor,
						model,
						location,
						ip_adress,
						port_number,
						bus_id,
						is_programmable,
						is_connected,
                        comment
						);
		SET @newDeviceID = LAST_INSERT_ID();
        
	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_device', CONCAT('Device Added, New device ID is: ', @newDeviceID));
	-- End of Logging

	-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.add_device', CONCAT('Start Adding new COMMAND to Device with DeviceID =', @newDeviceID, ' Values Are: Command= ', readCommand));
	-- End of Logging

	
	INSERT INTO `smes_microgrid`.`command`( `name`,
											`description`,
											`format_string`,
											`device_id`)
	VALUES 								(   CONCAT('Read all for ', name),
											CONCAT('Command that reads all the variables of device ', name, 'in one communication request'),
                                            readCommand,
                                            @newDeviceID
										);	
	
   -- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Command Added to Device ID=', @newDeviceID, ' New command ID is: ', LAST_INSERT_ID()));
	-- End of Logging
    
	COMMIT;  
    -- CALL smes_microgrid.get_device(LAST_INSERT_ID());
    SELECT D.`id` as id,
    D.`device_type_id` as typeId,
	 DT.`name` as typeName,
     DC.`id` as classID,
     DC.`name` as className,
    D.`name` as name,
    D.`description` as description,
    D.`microgrid_id` as microgridId,
     M.`name` as microgridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as vendor,
    D.`model` as model,
    D.`location` as location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as portNumber,
    D.`bus_id` as busID,
    B.name as busName,
    D.`is_programmable` as isProgrammable,
    D.`is_connected` as isConnected,
    D.`comment` as comment,
    C.format_string as readCommand,
    C.id as readCommandId
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
LEFT JOIN command as C ON C.device_id = D.id
LEFT JOIN bus as B on B.id = D.bus_id
WHERE D.id=@newDeviceID
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_variable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
    U.code as unitCode,
    V.`updating_duration` as updatingDuration,
    V.`set_command_id` as setCommandID,
    V.`get_command_id` as getCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = LAST_INSERT_ID(); 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_variable_value` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
    


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_table_existence` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_table_existence`(IN table_name CHAR(64))
BEGIN
-- http://stackoverflow.com/questions/21236542/how-to-understand-a-mysql-temporary-table-already-exists-in-a-stored-procedure
    DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    SET @err = 0;
    SET @table_name = table_name;
    SET @sql_query = CONCAT('SELECT NULL FROM ',@table_name);
    PREPARE stmt1 FROM @sql_query;
    IF (@err = 1) THEN
        SET @table_exists = 0;
    ELSE
        SET @table_exists = 1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `doiterate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `doiterate`(p1 INT)
BEGIN
  label1: LOOP
    SET p1 = p1 + 1;
    IF p1 < 10 THEN ITERATE label1; END IF;
    LEAVE label1;
  END LOOP label1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_buses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_buses`()
BEGIN

SELECT id as id, name as name, description as description 
FROM `smes_microgrid`.`bus`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_commands` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_commands`(IN device_id INT)
BEGIN

SELECT C.`id` as id,
    C.`name` as name,
    C.`description` as description,
    C.`format_string` as formatString,
    C.`device_id` as deviceId,
    CP.name as protocolName,
	CT.name as commandTypeName
FROM `smes_microgrid`.`command` as C
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE C.device_id = device_id 
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_command_protocols` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_protocols`()
BEGIN

SELECT id as id, name as name, description as description 
FROM `smes_microgrid`.`command_protocol`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_command_types` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_types`()
BEGIN

SELECT id as id, name as name, description as description 
FROM `smes_microgrid`.`command_command_types`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_command_variables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_command_variables`(IN command_id INT)
BEGIN

SELECT command_id as commandId, 
V.id as variableId, V.Name as variableName, V.Description as variableDescription,
P.ID as parameterTypeId, P.Name as parameterTypeName, P.Name as parameterTypeDescription,
U.ID as unitId, U.Name as unitName, U.Description as unitDescription
FROM command_device_variable AS CDV
INNER JOIN `smes_microgrid`.variable AS V ON CDV.variable_id = V.id
INNER JOIN `smes_microgrid`.parameter_type AS P ON CDV.parameter_type_id = P.id
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE CDV.command_id = command_id 
ORDER BY P.ID
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_device` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device`(IN id INT)
BEGIN

SELECT D.`id` as id,
    D.`device_type_id` as typeId,
	 DT.`name` as typeName,
     DC.`id` as classID,
     DC.`name` as className,
    D.`name` as name,
    D.`description` as description,
    D.`microgrid_id` as microgridID,
     M.`name` as microgridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as vendor,
    D.`model` as model,
    D.`location` as location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as portNumber,
    D.`bus_id` as busID,
    B.name as busName,
    D.`is_programmable` as isProgrammable,
    D.`is_connected` as isConnected,
    D.`comment` as comment,
    C.id as readCommandId,
    C.format_string as readCommand
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
LEFT JOIN bus as B on B.id = D.bus_id
LEFT JOIN (SELECT id, format_string FROM command WHERE device_id = id LIMIT 1) as C  ON 1=1  -- This is to return only 1 row in case if more than 1 command exists. For SPrint1 version we assume there is only 1 command but the structure is done to support more. 
WHERE D.id=id
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_devices` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices`()
BEGIN

SELECT D.`id` as id,
    D.`device_type_id` as typeId,
	 DT.`name` as typeName,
     DC.`id` as classID,
     DC.`name` as className,
    D.`name` as name,
    D.`description` as description,
    D.`microgrid_id` as microgridID,
     M.`name` as microgridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as vendor,
    D.`model` as model,
    D.`location` as location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as portNumber,
    D.`bus_id` as busID,
	B.name as busName,
    D.`is_programmable` as isProgrammable,
    D.`is_connected` as isConnected,
    D.`comment` as comment,
    0 as readCommandId,
    '' as readCommand
    -- C.id as readCommandId,
    -- C.format_string as readCommand
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
LEFT JOIN bus as B on B.id = D.bus_id
-- LEFT JOIN command as C ON C.device_id = D.id 
ORDER BY D.id
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_device_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_data`(IN id INT, IN dateFrom DATETIME, IN dateTo DATETIME)
BEGIN

-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.get_device_data');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    
    RESIGNAL;
    -- SET @msg = CONCAT('ERROR: An error occurred when getting DEVICE DATA, Device id = ', id);
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg ;
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


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_device_types` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_types`()
BEGIN

SELECT T.id as typeId, T.name as typeName, T.description as typeDescription, C.id as classId, C.Name as className, C.Description as classDescription
FROM `smes_microgrid`.`device_type` T
LEFT JOIN `smes_microgrid`.`device_class` C ON T.device_class_id = C.id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_read_command` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_read_command`(IN variable_id INT)
BEGIN

SELECT  V.id as variableId,
		V.name as variableName,
		C.format_string as commandFormatString,
        C.id as commandId,
        C.command_protocol_id as protocolId,
        C.command_type_id as commandTypeId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
		CP.name as protocolName,
		CT.name as commandTypeName
FROM variable as V 
INNER JOIN command 			as C ON C.id = V.get_command_id
INNER JOIN device 			as D ON D.id = V.device_id
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE V.id = variable_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_read_commands` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_read_commands`()
BEGIN

SELECT 
		C.format_string as commandFormatString,  -- for first version we assume there will be 1 command per device, but later many commands
        C.id as commandId, 
        C.name as commandName,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
        CP.name as protocolName,
		CT.name as commandTypeName,
		GROUP_CONCAT(V.id) as variableIds,  -- for first version we assume all varables of the device expected to be returned by the read command
		GROUP_CONCAT(V.name) as variableNames
FROM device as D  
INNER JOIN command as C ON C.device_id = D.id
INNER JOIN variable as V ON D.id = V.device_id
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE D.is_connected = 1
GROUP BY C.id  -- or b y D.id assuming that 1 device has 1 command only
ORDER BY D.id, V.id;

/* Put it back later when we resolve device concurrency problem
SELECT  V.id as variableId,
		V.name as variableName,
		C.format_string as commandFormatString,
        C.id as commandId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber
FROM variable as V 
INNER JOIN command as C ON C.id = V.get_command_id
INNER JOIN device as D ON D.id = V.device_id
ORDER BY D.id;
*/


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_units` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_units`()
BEGIN

SELECT `variable_unit`.`id` as id,
    `variable_unit`.`code` as code,
    `variable_unit`.`name` as name,
    `variable_unit`.`description` as description
FROM `smes_microgrid`.`variable_unit`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_variable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_variable`(IN variableId INT)
BEGIN

SELECT V.`id` as id,
    V.`device_id` as deviceId,
    V.`name` as name,
    V.`description` as description,
    V.`unit_id` as unitID,
    U.code as unitCode,
    V.`updating_duration` as updatingDuration,
    V.`set_command_id` as setCommandID,
    V.`get_command_id` as getCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = variableId
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_variables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_variables`(IN device_id INT)
BEGIN

SELECT V.`id` as id,
    V.`device_id` as deviceId,
    V.`name` as name,
    V.`description` as description,
    V.`unit_id` as unitID,
    U.code as unitCode,
    V.`updating_duration` as updatingDuration,
    V.`set_command_id` as setCommandID,
    V.`get_command_id` as getCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.device_id = device_id 
ORDER BY V.id
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_error` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_error`(IN sp_name VARCHAR(255))
BEGIN
GET DIAGNOSTICS @cno = NUMBER;
	GET DIAGNOSTICS CONDITION @cno 	@sqlstate = RETURNED_SQLSTATE, 
									@errno = MYSQL_ERRNO, 
									@text = MESSAGE_TEXT;
 
	CALL smes_microgrid.write_log('ERROR', @sqlstate, @errno, CONNECTION_ID(), CURRENT_USER(), sp_name, @text);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_info`(IN sp_name VARCHAR(255), IN message VARCHAR(255))
BEGIN
	CALL smes_microgrid.write_log('INFO', '00111', NULL, CONNECTION_ID(), CURRENT_USER(), sp_name, message);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `parse_variables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `parse_variables`(IN table_list VARCHAR(255))
BEGIN

-- Error handler for situation when try to delete temp table that does not exists.
-- Don't like it but seems that MySQL doesn't have "is exist" function for temporary tables
DECLARE CONTINUE HANDLER FOR 1051 BEGIN END;

	# Count the number of valiable in the list
    SET @table_stub = REPLACE(@table_list,',','');
    SET @array_count = LENGTH(@table_list) - LENGTH(@table_stub) + 1;


-- CALL check_table_existence('VARIDs');
-- IF @table_exists THEN DROP TEMPORARY TABLE VARIDs;

DROP TEMPORARY TABLE VARIDs; -- If table doesn't exist then go to continue handler and continue with next statement

CREATE TEMPORARY TABLE VARIDs (
    variable_id INT 
);

     # Loop through list of tables, creating each table
    SET @x = 0;
    label1: LOOP
    	   
        SET @sql = CONCAT('SELECT ELT(',@x,',',@table_list,') INTO @tb');
        PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;
        
        INSERT INTO VARIDs(variable_id) VALUES(@tb);
 
		SET @x= @x + 1;     
		IF @x < @array_count THEN ITERATE label1; END IF;
		LEAVE label1;
		
    END LOOP label1;
    
    SELECT * from VARIDs;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_command` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_command`(IN command_id INT, 
														  IN name VARCHAR(45), 
                                                          IN description VARCHAR(255), 
														  IN format_string VARCHAR(255),
														  IN protocol_id TINYINT, 		-- default = 90
                                                          IN command_type_id TINYINT, 	-- default = 90                                                         
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
	`format_string` = format_string,
    `command_protocol_id` = command_protocol_id,
    `command_type_id` = command_type_id
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
    
   -- Note: this SP returns command information without references variables. Use a separate call to get_command_variables(@cmd_id) to get variables as well.
   SELECT C.`id` as id,
    C.`name` as name,
    C.`description` as description,
    C.`format_string` as formatString,
    C.`device_id` as deviceId,
    CP.name as protocolName,
	CT.name as commandTypeName
	FROM `smes_microgrid`.`command` as C
	INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
	INNER JOIN command_type 	as CT ON CT.id = C.command_type_id    
	WHERE C.id = command_id 
	;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_device` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_device`(  IN id INT,
									IN device_type_id TINYINT,
									IN name VARCHAR(255),
									IN description VARCHAR(255),
									IN microgrid_id TINYINT,

									IN vendor VARCHAR(100),
									IN model VARCHAR(100),
									IN location VARCHAR(100),
									IN ip_adress VARCHAR(255),
									IN port_number VARCHAR(10),
									IN bus_id TINYINT,
									IN is_programmable BIT,
									IN is_connected BIT,
                                    IN comment VARCHAR(255),
									IN readCommand VARCHAR(255))
BEGIN

-- General error handler for any SQL exception
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN	
-- If some part of loading wasn't successful, continue with next steps but log the problem
	CALL smes_microgrid.log_error('smes_microgrid.update_device');
    ROLLBACK; -- NOTE: Rollback statement should come AFTER Get Diagnostics  (that is inside log_error sp)
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: An error occurred when UPDATING A DEVICE';
END;

START TRANSACTION;	

-- Log the start of excecution
	CALL smes_microgrid.log_info('smes_microgrid.update_device', CONCAT('Start device update ,ID= ', id));
-- End of Logging

	-- Note - COALESCE takes first non-null value. it means, using it we can't set value to NULL (that is OK for now as we can set empty string for all the string columns)
	UPDATE smes_microgrid.device as D
	SET 
	`device_type_id` = COALESCE(device_type_id, D.device_type_id) ,
	`name` = COALESCE(name, D.name) ,
	`description` = COALESCE( description, D.description) ,
	`microgrid_id` = COALESCE( microgrid_id , D.microgrid_id),

	`vendor` = COALESCE( vendor, D.vendor),
	`model` = COALESCE( model, D.model),
	`location` = COALESCE(location , D.location),
	`ip_adress` = COALESCE(ip_adress , D.ip_adress),
	`port_number` = COALESCE( port_number, D.port_number),
	`bus_id` = COALESCE(bus_id , D.bus_id),
	`is_programmable` = COALESCE( is_programmable, D.is_programmable),
	`is_connected` = COALESCE( is_connected, D.is_connected),
    `comment` = COALESCE(comment, D.comment)
	WHERE D.id = id;



	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_device', 'Device Updated, New values are: TODO');
	-- End of Logging

	-- Log the start of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_device', CONCAT('Start Adding new COMMAND to Device with DeviceID =', id, ' Values Are: Command= ', readCommand));
	-- End of Logging

	DELETE FROM  `smes_microgrid`.`command` WHERE device_id = id; -- remove previous command if exists before adding a new one
	INSERT INTO `smes_microgrid`.`command`( `name`,
											`description`,
											`format_string`,
											`device_id`)
	VALUES 								(   CONCAT('Read all for ', name),
											CONCAT('Command that reads all the variables of device ', name, 'in one communication request'),
                                            readCommand,
                                            id
										);	
	
   -- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_command', CONCAT('Command Added to Device ID=', id, ' New command ID is: ', LAST_INSERT_ID()));
	-- End of Logging
    
	COMMIT;  

    SELECT D.`id` as id,
    D.`device_type_id` as typeID,
	 DT.`name` as typeName,
     DC.`id` as classId,
     DC.`name` as className,
    D.`name` as name,
    D.`description` as description,
    D.`microgrid_id` as microgridId,
     M.`name` as microgridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as vendor,
    D.`model` as model,
    D.`location` as location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as portNumber,
    D.`bus_id` as busID,
    B.name as busName,
    D.`is_programmable` as isProgrammable,
    D.`is_connected` as isConnected,
    D.`comment` as comment,
    C.format_string as readCommand,
    C.id as readCommandId
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
LEFT JOIN command as C ON C.device_id = D.id
LEFT JOIN bus as B on B.id = D.bus_id
WHERE D.id=id
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_variable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
	U.code as unitCode,
    V.`updating_duration` as updatingDuration,
    V.`set_command_id` as setCommandID,
    V.`get_command_id` as getCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = variable_id; 
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `write_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-06  9:05:57
