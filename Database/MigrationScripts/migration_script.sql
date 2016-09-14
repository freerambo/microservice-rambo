-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: smes_microgrid
-- Source Schemata: smes_microgrid
-- Created: Wed Sep 14 17:06:56 2016
-- Workbench Version: 6.3.7
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema smes_microgrid
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `smes_microgrid` ;
CREATE SCHEMA IF NOT EXISTS `smes_microgrid` ;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.bus
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`bus` (
  `id` TINYINT(4) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.command
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`command` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `format_string` VARCHAR(255) NULL DEFAULT NULL,
  `device_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_device_command_idx` (`device_id` ASC),
  CONSTRAINT `fk_device_command`
    FOREIGN KEY (`device_id`)
    REFERENCES `smes_microgrid`.`device` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.command_device_variable
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`command_device_variable` (
  `command_id` INT(11) NOT NULL,
  `variable_id` INT(11) NOT NULL,
  `parameter_type_id` TINYINT(4) NOT NULL,
  PRIMARY KEY (`command_id`, `variable_id`, `parameter_type_id`),
  INDEX `fk_command_param_type_idx` (`parameter_type_id` ASC),
  INDEX `fk_command_variable_idx` (`variable_id` ASC),
  CONSTRAINT `fk_command_param_type`
    FOREIGN KEY (`parameter_type_id`)
    REFERENCES `smes_microgrid`.`parameter_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_command_variable`
    FOREIGN KEY (`variable_id`)
    REFERENCES `smes_microgrid`.`variable` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_command_variable_cmd`
    FOREIGN KEY (`command_id`)
    REFERENCES `smes_microgrid`.`command` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.device
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`device` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `device_type_id` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `microgrid_id` TINYINT(4) NULL DEFAULT NULL,
  `scl_file(ICD)` VARCHAR(255) NULL DEFAULT NULL COMMENT 'This is SCL file',
  `vendor` VARCHAR(100) NULL DEFAULT NULL,
  `model` VARCHAR(100) NULL DEFAULT NULL,
  `location` VARCHAR(100) NULL DEFAULT NULL,
  `ip_adress` VARCHAR(255) NULL DEFAULT NULL,
  `port_number` VARCHAR(10) NULL DEFAULT NULL,
  `bus_id` TINYINT(4) NULL DEFAULT NULL,
  `is_programmable` BIT(1) NULL DEFAULT NULL,
  `is_connected` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_device_microgrid_1` (`microgrid_id` ASC),
  INDEX `fk_device_device_type_1` (`device_type_id` ASC),
  INDEX `fk_device_bus_idx` (`bus_id` ASC),
  CONSTRAINT `fk_device_bus`
    FOREIGN KEY (`bus_id`)
    REFERENCES `smes_microgrid`.`bus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_device_type_1`
    FOREIGN KEY (`device_type_id`)
    REFERENCES `smes_microgrid`.`device_type` (`id`),
  CONSTRAINT `fk_device_microgrid_1`
    FOREIGN KEY (`microgrid_id`)
    REFERENCES `smes_microgrid`.`microgrid` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.device_class
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`device_class` (
  `ID` INT(11) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.device_type
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`device_type` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `device_class_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_device_type_device_class_1` (`device_class_id` ASC),
  CONSTRAINT `fk_device_type_device_class_1`
    FOREIGN KEY (`device_class_id`)
    REFERENCES `smes_microgrid`.`device_class` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.device_variable
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`device_variable` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `device_id` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `unit_id` INT(11) NULL DEFAULT NULL,
  `updating_duration` INT(255) NULL DEFAULT NULL,
  `set_command_id` INT(11) NULL DEFAULT NULL,
  `get_command_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_device_variable_variable` (`unit_id` ASC),
  INDEX `fk_device_variable_device_idx` (`device_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
ROW_FORMAT = DYNAMIC;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.log
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`log` (
  `msg_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `level` CHAR(7) NOT NULL DEFAULT 'INFO',
  `code` SMALLINT(6) NULL DEFAULT NULL,
  `sqlstate` CHAR(10) NULL DEFAULT NULL,
  `message` VARCHAR(250) NULL DEFAULT NULL,
  `process_id` INT(11) NULL DEFAULT NULL,
  `procedure` VARCHAR(50) NULL DEFAULT NULL,
  `user` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `index_timestamp` (`process_id` ASC, `msg_timestamp` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.microgrid
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`microgrid` (
  `ID` TINYINT(4) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `microgrid_type_id` INT(11) NULL DEFAULT NULL,
  `scl_file(SSD)` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_microgrid_microgrid_type_1` (`microgrid_type_id` ASC),
  CONSTRAINT `fk_microgrid_microgrid_type_1`
    FOREIGN KEY (`microgrid_type_id`)
    REFERENCES `smes_microgrid`.`microgrid_type` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.microgrid_type
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`microgrid_type` (
  `ID` INT(11) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.parameter_type
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`parameter_type` (
  `id` TINYINT(4) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.translation
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`translation` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 107
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.variable
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`variable` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `device_id` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `unit_id` INT(11) NULL DEFAULT NULL,
  `updating_duration` INT(255) NULL DEFAULT NULL,
  `set_command_id` INT(11) NULL DEFAULT NULL,
  `get_command_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_variable_variable` (`unit_id` ASC),
  INDEX `fk_variable_device_idx` (`device_id` ASC),
  CONSTRAINT `fk_variable_device`
    FOREIGN KEY (`device_id`)
    REFERENCES `smes_microgrid`.`device` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
ROW_FORMAT = DYNAMIC;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.variable_unit
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`variable_unit` (
  `id` INT(11) NOT NULL,
  `code` VARCHAR(255) NULL DEFAULT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_variable_unit_device_variable_1`
    FOREIGN KEY (`id`)
    REFERENCES `smes_microgrid`.`device_variable` (`unit_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
ROW_FORMAT = DYNAMIC;

-- ----------------------------------------------------------------------------
-- Table smes_microgrid.variable_value
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `smes_microgrid`.`variable_value` (
  `timestamp` DATETIME NOT NULL,
  `variable_id` INT(11) NOT NULL,
  `value` DECIMAL(65,0) NULL DEFAULT NULL,
  INDEX `fk_variable_value_variable_1` (`variable_id` ASC),
  CONSTRAINT `fk_variable_value_variable_1`
    FOREIGN KEY (`variable_id`)
    REFERENCES `smes_microgrid`.`variable` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
ROW_FORMAT = DYNAMIC;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.add_command
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_command`(IN device_id INT, IN name VARCHAR(45), IN description VARCHAR(255), 
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
    
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.add_device
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
IN is_connected BIT
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
						`is_connected`)
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
						is_connected
						);

	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.add_device', CONCAT('Device Added, New device ID is: ', LAST_INSERT_ID()));
	-- End of Logging

	COMMIT;  
    
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.add_variable
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
    
SELECT V.`id` as ID,
    V.`device_id` as DeviceID,
    V.`name` as Name,
    V.`description` as Description,
    V.`unit_id` as UnitID,
    V.`updating_duration` as UpdatingDuration,
    V.`set_command_id` as SetCommandID,
    V.`get_command_id` as GetCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = LAST_INSERT_ID(); 

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.check_table_existence
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.doiterate
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `doiterate`(p1 INT)
BEGIN
  label1: LOOP
    SET p1 = p1 + 1;
    IF p1 < 10 THEN ITERATE label1; END IF;
    LEAVE label1;
  END LOOP label1;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.get_buses
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_buses`()
BEGIN

SELECT id as ID, name as Name, description as Description 
FROM `smes_microgrid`.`bus`;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.get_device
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device`(IN id INT)
BEGIN

SELECT D.`id` as ID,
    D.`device_type_id` as TypeID,
	 DT.`name` as TypeName,
     DC.`id` as ClassID,
     DC.`name` as ClassName,
    D.`name` as Name,
    D.`description` as Description,
    D.`microgrid_id` as MicrogridID,
     M.`name` as MicrogridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as Vendor,
    D.`model` as Model,
    D.`location` as Location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as PortNumber,
    D.`bus_id` as BusID,
    D.`is_programmable` as IsProgrammable,
    D.`is_connected` as IsConnected
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
WHERE D.id=id
;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.get_devices
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices`()
BEGIN

SELECT D.`id` as ID,
    D.`device_type_id` as TypeID,
	 DT.`name` as TypeName,
     DC.`id` as ClassID,
     DC.`name` as ClassName,
    D.`name` as Name,
    D.`description` as Description,
    D.`microgrid_id` as MicrogridID,
     M.`name` as MicrogridName,
    -- `device`.`scl_file(ICD)` as SCLFile,
    D.`vendor` as Vendor,
    D.`model` as Model,
    D.`location` as Location,
    D.`ip_adress` as IPAdress,
    D.`port_number` as PortNumber,
    D.`bus_id` as BusID,
    D.`is_programmable` as IsProgrammable,
    D.`is_connected` as IsConnected
FROM `smes_microgrid`.`device` AS D
LEFT JOIN device_type AS DT ON D.device_type_id  = DT.id
LEFT JOIN device_class AS DC ON DT.device_class_id = DC.id
LEFT JOIN microgrid AS M ON M.id= D.`microgrid_id`
;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.get_device_types
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_device_types`()
BEGIN

SELECT T.id as TypeID, T.name as TypeName, T.description as TypeDescription, C.id as ClassID, C.Name as ClassName, C.Description as ClassDescription
FROM `smes_microgrid`.`device_type` T
LEFT JOIN `smes_microgrid`.`device_class` C ON T.device_class_id = C.id;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.get_units
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_units`()
BEGIN

SELECT `variable_unit`.`id` as ID,
    `variable_unit`.`code` as 'Code',
    `variable_unit`.`name` as 'Name',
    `variable_unit`.`description` as 'Description'
FROM `smes_microgrid`.`variable_unit`;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.get_variables
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_variables`(IN device_id INT)
BEGIN

SELECT V.`id` as ID,
    V.`device_id` as DeviceID,
    V.`name` as Name,
    V.`description` as Description,
    V.`unit_id` as UnitID,
    V.`updating_duration` as UpdatingDuration,
    V.`set_command_id` as SetCommandID,
    V.`get_command_id` as GetCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.device_id = device_id 
;

END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.log_error
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_error`(IN sp_name VARCHAR(255))
BEGIN
GET DIAGNOSTICS @cno = NUMBER;
	GET DIAGNOSTICS CONDITION @cno 	@sqlstate = RETURNED_SQLSTATE, 
									@errno = MYSQL_ERRNO, 
									@text = MESSAGE_TEXT;
 
	CALL smes_microgrid.write_log('ERROR', @sqlstate, @errno, CONNECTION_ID(), CURRENT_USER(), sp_name, @text);
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.log_info
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_info`(IN sp_name VARCHAR(255), IN message VARCHAR(255))
BEGIN
	CALL smes_microgrid.write_log('INFO', '00111', NULL, CONNECTION_ID(), CURRENT_USER(), sp_name, message);
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.parse_variables
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
    
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.update_device
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
									IN is_connected BIT)
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
	`is_connected` = COALESCE( is_connected, D.is_connected) 
	WHERE D.id = id;



	-- Log the end of excecution
		CALL smes_microgrid.log_info('smes_microgrid.update_device', 'Device Updated, New values are: TODO');
	-- End of Logging

	COMMIT;  


END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.update_variable
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
    
SELECT V.`id` as ID,
    V.`device_id` as DeviceID,
    V.`name` as Name,
    V.`description` as Description,
    V.`unit_id` as UnitID,
    V.`updating_duration` as UpdatingDuration,
    V.`set_command_id` as SetCommandID,
    V.`get_command_id` as GetCommandID
FROM `smes_microgrid`.variable AS V
LEFT JOIN `smes_microgrid`.variable_unit AS U ON U.id = V.unit_id
WHERE V.id = variable_id; 
    
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine smes_microgrid.write_log
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `smes_microgrid`$$
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
END$$

DELIMITER ;
SET FOREIGN_KEY_CHECKS = 1;
