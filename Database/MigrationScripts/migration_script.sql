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
-- Table structure for table `bus`
--

DROP TABLE IF EXISTS `bus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bus` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus`
--

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` VALUES (1,'AC Bus 1','desc1'),(2,'DC Bus 1','desc2');
/*!40000 ALTER TABLE `bus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `format_string` varchar(255) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `command_type_id` tinyint(4) NOT NULL DEFAULT '90',
  `command_protocol_id` tinyint(4) NOT NULL DEFAULT '90',
  PRIMARY KEY (`id`),
  KEY `fk_device_command_idx` (`device_id`),
  KEY `fk_command_type_idx` (`command_type_id`),
  KEY `fk_command_protocol_idx` (`command_protocol_id`),
  CONSTRAINT `fk_command_protocol` FOREIGN KEY (`command_protocol_id`) REFERENCES `command_protocol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_command_type` FOREIGN KEY (`command_type_id`) REFERENCES `command_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_command` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
INSERT INTO `command` VALUES (17,'Read all for AC Load Chroma 63804','Command that reads all the variables of device AC Load Chroma 63804in one communication request','MEAS:CURR?;FREQ?;POW?;RES?;VOLT?;TIME:HOLD?;TRAN?;:MODE?;:LOAD?\\n',30,90,90),(18,'Read all for DC Load Chroma 63211','Command that reads all the variables of device DC Load Chroma 63211in one communication request','MEAS:VOLT?;CURR?;POW?;RES?;:LOAD?;:MODE?',31,90,90),(19,'Read all for AC Source AMETEK  bps75','Command that reads all the variables of device AC Source AMETEK  bps75in one communication request','MEAS:VOLT?;CURR?;POW?;FREQ?;:MEAS:POW:APP?;:MEAS:CURR:AMPL:MAX?;:MEAS:POW:PFAC?;:VOLT:RANG?;:CURR?;:VOLT?;:MODE?;:OUTP?',32,90,90),(20,'SwitchOnDevice30','','CMD HERE',30,11,20),(21,'SwitchOFFDevice30','','OFF CMD HERE 2',30,12,20);
/*!40000 ALTER TABLE `command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command_device_variable`
--

DROP TABLE IF EXISTS `command_device_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_device_variable` (
  `command_id` int(11) NOT NULL,
  `variable_id` int(11) NOT NULL,
  `parameter_type_id` tinyint(4) NOT NULL,
  PRIMARY KEY (`command_id`,`variable_id`,`parameter_type_id`),
  KEY `fk_command_param_type_idx` (`parameter_type_id`),
  KEY `fk_command_variable_idx` (`variable_id`),
  CONSTRAINT `fk_command_param_type` FOREIGN KEY (`parameter_type_id`) REFERENCES `parameter_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_command_variable` FOREIGN KEY (`variable_id`) REFERENCES `variable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_command_variable_cmd` FOREIGN KEY (`command_id`) REFERENCES `command` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command_device_variable`
--

LOCK TABLES `command_device_variable` WRITE;
/*!40000 ALTER TABLE `command_device_variable` DISABLE KEYS */;
INSERT INTO `command_device_variable` VALUES (7,5,1),(20,24,1),(21,24,1),(7,5,2),(20,24,2),(21,24,2);
/*!40000 ALTER TABLE `command_device_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command_protocol`
--

DROP TABLE IF EXISTS `command_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_protocol` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command_protocol`
--

LOCK TABLES `command_protocol` WRITE;
/*!40000 ALTER TABLE `command_protocol` DISABLE KEYS */;
INSERT INTO `command_protocol` VALUES (10,'TCP/IP','NPort communication'),(11,'Web Socket','Communication through websocket'),(12,'Web Service','API call'),(20,'URL','Redirect to URL'),(90,'Other',NULL);
/*!40000 ALTER TABLE `command_protocol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command_type`
--

DROP TABLE IF EXISTS `command_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_type` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command_type`
--

LOCK TABLES `command_type` WRITE;
/*!40000 ALTER TABLE `command_type` DISABLE KEYS */;
INSERT INTO `command_type` VALUES (10,'Read','Read all values from device'),(11,'Switch ON',NULL),(12,'Switch OFF',NULL),(90,'Other',NULL);
/*!40000 ALTER TABLE `command_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `microgrid_id` tinyint(4) DEFAULT NULL,
  `scl_file(ICD)` varchar(255) DEFAULT NULL COMMENT 'This is SCL file',
  `vendor` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `ip_adress` varchar(255) DEFAULT NULL,
  `port_number` varchar(10) DEFAULT NULL,
  `bus_id` tinyint(4) DEFAULT NULL,
  `is_programmable` bit(1) DEFAULT NULL,
  `is_connected` bit(1) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_device_microgrid_1` (`microgrid_id`),
  KEY `fk_device_device_type_1` (`device_type_id`),
  KEY `fk_device_bus_idx` (`bus_id`),
  CONSTRAINT `fk_device_bus` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_device_type_1` FOREIGN KEY (`device_type_id`) REFERENCES `device_type` (`id`),
  CONSTRAINT `fk_device_microgrid_1` FOREIGN KEY (`microgrid_id`) REFERENCES `microgrid` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (30,3,'AC Load Chroma 63804','AC Load device at lvl 5 lab',1,NULL,'Chroma','Chroma 63804','ERIAN Lab lvl 5','192.168.127.107','4001',1,'','\0',NULL),(31,4,'DC Load Chroma 63211','DC Load at lvl 5 Lab',1,NULL,'Chroma','Chroma 63211','lvl 5 lab','192.168.127.121','4001',2,'','',NULL),(32,1,'AC Source AMETEK  bps75','AC SOurce at the lab',1,NULL,'AMETEK','bps75','ERIAN lab lvl 5','192.168.127.106','4001',1,'\0','\0',NULL);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_class`
--

DROP TABLE IF EXISTS `device_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_class` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_class`
--

LOCK TABLES `device_class` WRITE;
/*!40000 ALTER TABLE `device_class` DISABLE KEYS */;
INSERT INTO `device_class` VALUES (1,'Load','any load'),(2,'Source','any converter'),(3,'Storage','Battery etc.'),(4,'Converter','any converter');
/*!40000 ALTER TABLE `device_class` ENABLE KEYS */;
UNLOCK TABLES;

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
 1 AS `latestValue`,
 1 AS `switchOnCommandId`,
 1 AS `switchOnCommandName`,
 1 AS `switchOnCommand`,
 1 AS `switchOnCommandProtocolId`,
 1 AS `switchOffCommandId`,
 1 AS `switchOfCommandName`,
 1 AS `switchOffCommand`,
 1 AS `switchOffCommandProtocolId`,
 1 AS `URL_On`,
 1 AS `URL_OFF`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `device_type`
--

DROP TABLE IF EXISTS `device_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `device_class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_device_type_device_class_1` (`device_class_id`),
  CONSTRAINT `fk_device_type_device_class_1` FOREIGN KEY (`device_class_id`) REFERENCES `device_class` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_type`
--

LOCK TABLES `device_type` WRITE;
/*!40000 ALTER TABLE `device_type` DISABLE KEYS */;
INSERT INTO `device_type` VALUES (1,'AC Source','ac source desc',2),(2,'DC source',NULL,2),(3,'AC Load',NULL,1),(4,'DC Load',NULL,1),(5,'PV battery',NULL,3),(6,'Lion battery',NULL,3),(7,'Some battery',NULL,3),(8,'DC/DC converter',NULL,4),(9,'AC/AC COnverter',NULL,4),(10,'BIC Converter',NULL,4);
/*!40000 ALTER TABLE `device_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_variable`
--

DROP TABLE IF EXISTS `device_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_variable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `updating_duration` int(255) DEFAULT NULL,
  `set_command_id` int(11) DEFAULT NULL,
  `get_command_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_device_variable_variable` (`unit_id`) USING BTREE,
  KEY `fk_device_variable_device_idx` (`device_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_variable`
--

LOCK TABLES `device_variable` WRITE;
/*!40000 ALTER TABLE `device_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `msg_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `level` char(7) NOT NULL DEFAULT 'INFO',
  `code` smallint(6) DEFAULT NULL,
  `sqlstate` char(10) DEFAULT NULL,
  `message` varchar(250) DEFAULT NULL,
  `process_id` int(11) DEFAULT NULL,
  `procedure` varchar(50) DEFAULT NULL,
  `user` varchar(45) DEFAULT NULL,
  KEY `index_timestamp` (`process_id`,`msg_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES ('2016-09-06 05:49:43','INFO',NULL,'00111','Start device update ,ID= 1',5,'smes_microgrid.update_device','root@localhost'),('2016-09-06 05:49:43','INFO',NULL,'00111','Device Updated, New values are: TODO',5,'smes_microgrid.update_device','root@localhost'),('2016-09-06 06:00:26','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:00:26','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:00:26','INFO',NULL,'00111','Device Added, New device ID is: 2',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:05:48','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:05:48','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:13','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:13','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:21','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:21','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 07:32:02','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =4 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:32:02','INFO',NULL,'00111','Variable Added to Device ID=4 New variable ID is: 2',5,NULL,'root@localhost'),('2016-09-06 07:34:23','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =4 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:34:23','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 07:34:55','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:34:55','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 4',5,NULL,'root@localhost'),('2016-09-06 07:35:27','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:35:27','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 5',5,NULL,'root@localhost'),('2016-09-06 07:35:36','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:35:36','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 6',5,NULL,'root@localhost'),('2016-09-06 07:45:00','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =2 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:45:00','INFO',NULL,'00111','Variable Added to Device ID=2 New variable ID is: 7',5,NULL,'root@localhost'),('2016-09-06 07:57:30','ERROR',NULL,NULL,NULL,5,'smes_microgrid.update_variable','root@localhost'),('2016-09-06 09:00:44','ERROR',NULL,NULL,NULL,5,'smes_microgrid.update_variable','root@localhost'),('2016-09-06 09:05:35','INFO',NULL,'00111','Start UPDATING VARIABLE for Device with VariableID =6 Values Are:  TODO',5,'smes_microgrid.update_variable','root@localhost'),('2016-09-06 09:05:35','INFO',NULL,'00111','Variable Updated , VariableID=6',5,'smes_microgrid.update_variable','root@localhost'),('2016-09-09 05:19:14','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100, 101,202,303,404, , , ',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:19:14','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:20:23','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100, 101,202,303,404, , , ',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:20:23','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:14','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100,101,202,303,404,,,',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:14','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:51','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100,101,202,303,404,,',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:51','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:49:32','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100, 101,202,303,404',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:49:32','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-13 08:35:19','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',28,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:35:19','INFO',NULL,'00111','Device Added, New device ID is: 3',28,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:12','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',31,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:12','INFO',NULL,'00111','Device Added, New device ID is: 4',31,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:53','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',32,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:53','INFO',NULL,'00111','Device Added, New device ID is: 5',32,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:47:45','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',37,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:47:45','INFO',NULL,'00111','Device Added, New device ID is: 6',37,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:55:40','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',40,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:55:40','INFO',NULL,'00111','Device Added, New device ID is: 7',40,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:57:04','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',41,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:57:04','INFO',NULL,'00111','Device Added, New device ID is: 8',41,'smes_microgrid.add_device','root@localhost'),('2016-09-14 03:13:54','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-14 03:13:54','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 8',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-14 07:50:58','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:50:58','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:50:58','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:51:59','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:51:59','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 2',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:51:59','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:54:10','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:54:10','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 3',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:54:10','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:55:51','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:55:51','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 4',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:55:51','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:4 Device ID is: 1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-15 00:54:45','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',51,'smes_microgrid.add_device','root@localhost'),('2016-09-15 00:54:45','INFO',NULL,'00111','Device Added, New device ID is: 9',51,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:02:12','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',52,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:02:13','INFO',NULL,'00111','Device Added, New device ID is: 10',52,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:04:05','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',53,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:04:05','INFO',NULL,'00111','Device Added, New device ID is: 11',53,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:06:50','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',54,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:06:50','INFO',NULL,'00111','Device Added, New device ID is: 12',54,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:09:38','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:09:38','INFO',NULL,'00111','Device Added, New device ID is: 13',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:37','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:37','INFO',NULL,'00111','Device Added, New device ID is: 14',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:46','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',55,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:46','INFO',NULL,'00111','Device Added, New device ID is: 15',55,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:14:10','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',56,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:14:10','INFO',NULL,'00111','Device Added, New device ID is: 16',56,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:17:07','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',58,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:17:07','INFO',NULL,'00111','Device Added, New device ID is: 17',58,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:17:38','INFO',NULL,'00111','Start device update ,ID= 1',59,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:17:38','INFO',NULL,'00111','Device Updated, New values are: TODO',59,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:19:49','INFO',NULL,'00111','Start device update ,ID= 9',3,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:19:49','INFO',NULL,'00111','Device Updated, New values are: TODO',3,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:20:18','INFO',NULL,'00111','Start device update ,ID= 1',60,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:20:18','INFO',NULL,'00111','Device Updated, New values are: TODO',60,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:38:20','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',61,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:38:20','INFO',NULL,'00111','Device Added, New device ID is: 18',61,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:40:04','INFO',NULL,'00111','Start device update ,ID= 1',62,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:40:04','INFO',NULL,'00111','Device Updated, New values are: TODO',62,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:42:27','INFO',NULL,'00111','Start device update ,ID= 1',63,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:42:27','INFO',NULL,'00111','Device Updated, New values are: TODO',63,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:53:23','INFO',NULL,'00111','Start device update ,ID= 1',64,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:53:23','INFO',NULL,'00111','Device Updated, New values are: TODO',64,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:54:54','INFO',NULL,'00111','Start device update ,ID= 1',65,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:54:54','INFO',NULL,'00111','Device Updated, New values are: TODO',65,'smes_microgrid.update_device','root@localhost'),('2016-09-15 02:02:09','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',66,'smes_microgrid.add_device','root@localhost'),('2016-09-15 02:02:10','INFO',NULL,'00111','Device Added, New device ID is: 19',66,'smes_microgrid.add_device','root@localhost'),('2016-09-15 02:03:15','INFO',NULL,'00111','Start device update ,ID= 19',67,'smes_microgrid.update_device','root@localhost'),('2016-09-15 02:03:15','INFO',NULL,'00111','Device Updated, New values are: TODO',67,'smes_microgrid.update_device','root@localhost'),('2016-09-15 03:33:14','ERROR',NULL,NULL,NULL,49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:34:03','INFO',NULL,'00111','Start Updateing COMMAND to with CommandID =4 Values Are: Name= CMD1-UPD1',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:03','INFO',NULL,'00111','Command Updated, CommandID=4 New Values are: Name =CMD1-UPD1 , Description=Test UPD CMD1 , Format String=VOL {0}, CUR {1}, VOL1{2}',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:03','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:4',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:30','INFO',NULL,'00111','Start Updateing COMMAND to with CommandID =4 Values Are: Name= CMD1-UPD1',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:30','INFO',NULL,'00111','Command Updated, CommandID=4 New Values are: Name =CMD1-UPD1 , Description=Test UPD CMD2 , Format String=VOL2 {0}, CUR {1}, VOL1{2}',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:30','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:4',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:56','INFO',NULL,'00111','Start Updateing COMMAND to with CommandID =4 Values Are: Name= CMD1-UPD1',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:56','INFO',NULL,'00111','Command Updated, CommandID=4 New Values are: Name =CMD1-UPD1 , Description=Test UPD CMD2 , Format String=VOL2 {0}, CUR {1}, VOL1{2}',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:34:56','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:4',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:39:24','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= NewCMD 1',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:39:24','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 5',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:39:24','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:5 Device ID is: 1',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:05','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= NewCMD 2',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:05','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 6',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:06','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:6 Device ID is: 1',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:06','ERROR',NULL,NULL,NULL,49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:48','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= NewCMD 2',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:48','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 7',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:46:49','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:7 Device ID is: 1',49,'smes_microgrid.add_command','root@localhost'),('2016-09-15 03:48:46','INFO',NULL,'00111','Start Updateing COMMAND to with CommandID =7 Values Are: Name= CMD1-UPD3',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:48:46','INFO',NULL,'00111','Command Updated, CommandID=7 New Values are: Name =CMD1-UPD3 , Description=Test UPD CMD3 , Format String=VOL2 {0}, CUR {1}, VOL1{2}',49,'smes_microgrid.update_command','root@localhost'),('2016-09-15 03:48:46','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:7',49,'smes_microgrid.update_command','root@localhost'),('2016-09-19 09:18:12','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',21,'smes_microgrid.add_device','root@localhost'),('2016-09-19 09:18:12','INFO',NULL,'00111','Device Added, New device ID is: 20',21,'smes_microgrid.add_device','root@localhost'),('2016-09-19 09:18:16','INFO',NULL,'00111','Start device update ,ID= 19',22,'smes_microgrid.update_device','root@localhost'),('2016-09-19 09:18:16','INFO',NULL,'00111','Device Updated, New values are: TODO',22,'smes_microgrid.update_device','root@localhost'),('2016-09-19 09:18:27','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',24,'smes_microgrid.add_device','root@localhost'),('2016-09-19 09:18:27','INFO',NULL,'00111','Device Added, New device ID is: 21',24,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:06:42','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:06:42','INFO',NULL,'00111','Device Added, New device ID is: 22',3,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:09:23','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:09:23','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 9',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:09:23','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:09:23','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 10',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:09:23','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:09:23','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 11',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Device Added, New device ID is: 23',3,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 12',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 13',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:21:56','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:21:57','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 14',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Device Added, New device ID is: 24',3,'smes_microgrid.add_device','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 15',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 16',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =22 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 03:23:01','INFO',NULL,'00111','Variable Added to Device ID=22 New variable ID is: 17',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 06:47:06','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =22 Values Are: Name= GetVoltage',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Command Added to Device ID=22 New command ID is: 8',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:8 Device ID is: 22',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =22 Values Are: Name= GetCurrent',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Command Added to Device ID=22 New command ID is: 9',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:9 Device ID is: 22',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =22 Values Are: Name= GetPower',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Command Added to Device ID=22 New command ID is: 10',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 06:47:07','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:10 Device ID is: 22',3,'smes_microgrid.add_command','root@localhost'),('2016-09-20 09:09:22','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =9 Values Are:  Timestamp = 2016-06-30 09:22:20 Value = 10.100000',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-20 09:10:00','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =9 Values Are:  Timestamp = 2016-06-30 09:22:25 Value = 10.110000',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-22 03:40:51','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',20,'smes_microgrid.add_device','root@localhost'),('2016-09-22 03:40:51','INFO',NULL,'00111','Device Added, New device ID is: 25',20,'smes_microgrid.add_device','root@localhost'),('2016-09-22 03:40:51','ERROR',NULL,NULL,NULL,20,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:47:14','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:47:14','INFO',NULL,'00111','Device Added, New device ID is: 26',3,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:47:14','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:49:32','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:49:32','INFO',NULL,'00111','Device Added, New device ID is: 27',3,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:49:32','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =27 Values Are: Command= SOME CMD;',3,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:49:32','INFO',NULL,'00111','Command Added to Device ID=27 New command ID is: 12',3,'smes_microgrid.add_command','root@localhost'),('2016-09-22 05:50:38','INFO',NULL,'00111','Start device update ,ID= 27',3,'smes_microgrid.update_device','root@localhost'),('2016-09-22 05:50:38','INFO',NULL,'00111','Device Updated, New values are: TODO',3,'smes_microgrid.update_device','root@localhost'),('2016-09-22 05:50:38','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =27 Values Are: Command= SOME CMDUPD;',3,'smes_microgrid.update_device','root@localhost'),('2016-09-22 05:50:38','INFO',NULL,'00111','Command Added to Device ID=27 New command ID is: 13',3,'smes_microgrid.add_command','root@localhost'),('2016-09-22 05:51:02','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',29,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:51:02','INFO',NULL,'00111','Device Added, New device ID is: 28',29,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:51:02','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =28 Values Are: Command= Test COMMAND FORMAT INSERT',29,'smes_microgrid.add_device','root@localhost'),('2016-09-22 05:51:02','INFO',NULL,'00111','Command Added to Device ID=28 New command ID is: 14',29,'smes_microgrid.add_command','root@localhost'),('2016-09-22 05:51:26','INFO',NULL,'00111','Start device update ,ID= 28',30,'smes_microgrid.update_device','root@localhost'),('2016-09-22 05:51:26','INFO',NULL,'00111','Device Updated, New values are: TODO',30,'smes_microgrid.update_device','root@localhost'),('2016-09-22 05:51:26','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =28 Values Are: Command= Test COMMAND FORMAT UPDATE',30,'smes_microgrid.update_device','root@localhost'),('2016-09-22 05:51:26','INFO',NULL,'00111','Command Added to Device ID=28 New command ID is: 15',30,'smes_microgrid.add_command','root@localhost'),('2016-09-22 06:17:04','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',53,'smes_microgrid.add_device','root@localhost'),('2016-09-22 06:17:04','INFO',NULL,'00111','Device Added, New device ID is: 29',53,'smes_microgrid.add_device','root@localhost'),('2016-09-22 06:17:04','INFO',NULL,'00111',NULL,53,'smes_microgrid.add_device','root@localhost'),('2016-09-22 06:17:04','INFO',NULL,'00111','Command Added to Device ID=29 New command ID is: 16',53,'smes_microgrid.add_command','root@localhost'),('2016-09-22 13:49:33','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 13:50:13','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 13:58:53','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 13:59:04','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 13:59:05','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 13:59:37','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 14:00:30','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-22 14:05:53','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-23 04:52:18','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =26 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-23 04:52:18','INFO',NULL,'00111','Variable Added to Device ID=26 New variable ID is: 15',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-23 04:52:18','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =26 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-23 04:52:18','INFO',NULL,'00111','Variable Added to Device ID=26 New variable ID is: 16',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-23 04:52:18','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =26 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-23 04:52:18','INFO',NULL,'00111','Variable Added to Device ID=26 New variable ID is: 17',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-23 05:32:57','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-26 09:39:48','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-26 09:39:53','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-26 09:41:03','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-26 09:41:21','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-09-26 09:41:41','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data','root@localhost'),('2016-10-04 03:40:06','INFO',NULL,'00111','Start device update ,ID= 1',304,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:07','INFO',NULL,'00111','Device Updated, New values are: TODO',304,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:07','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL1{2}',304,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:07','ERROR',NULL,NULL,NULL,304,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:14','ERROR',NULL,NULL,NULL,308,'smes_microgrid.get_device_data','root@localhost'),('2016-10-04 03:40:14','ERROR',NULL,NULL,NULL,309,'smes_microgrid.get_device_data','root@localhost'),('2016-10-04 03:40:22','INFO',NULL,'00111','Start device update ,ID= 1',315,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:22','INFO',NULL,'00111','Device Updated, New values are: TODO',315,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:22','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL1{2}',315,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:22','ERROR',NULL,NULL,NULL,315,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:39','INFO',NULL,'00111','Start device update ,ID= 6',326,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:39','INFO',NULL,'00111','Device Updated, New values are: TODO',326,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:39','INFO',NULL,'00111',NULL,326,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:39','INFO',NULL,'00111','Command Added to Device ID=6 New command ID is: 17',326,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:40:52','INFO',NULL,'00111','Start device update ,ID= 1',334,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:52','INFO',NULL,'00111','Device Updated, New values are: TODO',334,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:52','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL1{2}',334,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:40:52','ERROR',NULL,NULL,NULL,334,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:41:55','INFO',NULL,'00111','Start device update ,ID= 2',348,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:41:56','INFO',NULL,'00111','Device Updated, New values are: TODO',348,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:41:56','INFO',NULL,'00111',NULL,348,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:41:56','INFO',NULL,'00111','Command Added to Device ID=2 New command ID is: 18',348,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:42:38','INFO',NULL,'00111','Start device update ,ID= 5',359,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:42:38','INFO',NULL,'00111','Device Updated, New values are: TODO',359,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:42:38','INFO',NULL,'00111',NULL,359,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:42:39','INFO',NULL,'00111','Command Added to Device ID=5 New command ID is: 19',359,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:44:48','INFO',NULL,'00111','Start device update ,ID= 9',379,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:44:48','INFO',NULL,'00111','Device Updated, New values are: TODO',379,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:44:48','INFO',NULL,'00111',NULL,379,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:44:48','INFO',NULL,'00111','Command Added to Device ID=9 New command ID is: 20',379,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:45:01','INFO',NULL,'00111','Start device update ,ID= 9',390,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:45:01','INFO',NULL,'00111','Device Updated, New values are: TODO',390,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:45:01','INFO',NULL,'00111',NULL,390,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:45:01','INFO',NULL,'00111','Command Added to Device ID=9 New command ID is: 21',390,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:48:24','INFO',NULL,'00111','Start device update ,ID= 1',403,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:48:24','INFO',NULL,'00111','Device Updated, New values are: TODO',403,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:48:24','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL1{2}',403,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:48:25','ERROR',NULL,NULL,NULL,403,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:43','INFO',NULL,'00111','Start device update ,ID= 1',410,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:43','INFO',NULL,'00111','Device Updated, New values are: TODO',410,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:43','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL1{2}',410,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:44','ERROR',NULL,NULL,NULL,410,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:49','INFO',NULL,'00111','Start device update ,ID= 5',411,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:50','INFO',NULL,'00111','Device Updated, New values are: TODO',411,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:50','INFO',NULL,'00111',NULL,411,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:50:50','INFO',NULL,'00111','Command Added to Device ID=5 New command ID is: 22',411,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:51:02','INFO',NULL,'00111','Start device update ,ID= 5',418,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:51:02','INFO',NULL,'00111','Device Updated, New values are: TODO',418,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:51:02','INFO',NULL,'00111',NULL,418,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:51:02','INFO',NULL,'00111','Command Added to Device ID=5 New command ID is: 23',418,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:51:21','INFO',NULL,'00111','Start device update ,ID= 5',422,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:51:21','INFO',NULL,'00111','Device Updated, New values are: TODO',422,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:51:21','INFO',NULL,'00111',NULL,422,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:51:22','INFO',NULL,'00111','Command Added to Device ID=5 New command ID is: 24',422,'smes_microgrid.add_command','root@localhost'),('2016-10-04 03:53:10','INFO',NULL,'00111','Start device update ,ID= 1',438,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:53:10','INFO',NULL,'00111','Device Updated, New values are: TODO',438,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:53:10','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL1{2}',438,'smes_microgrid.update_device','root@localhost'),('2016-10-04 03:53:10','ERROR',NULL,NULL,NULL,438,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:02:53','INFO',NULL,'00111','Start device update ,ID= 2',480,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:02:53','INFO',NULL,'00111','Device Updated, New values are: TODO',480,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:02:53','INFO',NULL,'00111',NULL,480,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:02:54','INFO',NULL,'00111','Command Added to Device ID=2 New command ID is: 25',480,'smes_microgrid.add_command','root@localhost'),('2016-10-04 04:06:24','ERROR',NULL,NULL,NULL,500,'smes_microgrid.get_device_data','root@localhost'),('2016-10-04 04:06:24','ERROR',NULL,NULL,NULL,502,'smes_microgrid.get_device_data','root@localhost'),('2016-10-04 04:06:51','INFO',NULL,'00111','Start device update ,ID= 1',508,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:06:52','INFO',NULL,'00111','Device Updated, New values are: TODO',508,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:06:52','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',508,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:06:52','ERROR',NULL,NULL,NULL,508,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:17','INFO',NULL,'00111','Start device update ,ID= 1',511,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:17','INFO',NULL,'00111','Device Updated, New values are: TODO',511,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:17','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',511,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:18','ERROR',NULL,NULL,NULL,511,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:20','INFO',NULL,'00111','Start device update ,ID= 1',512,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:20','INFO',NULL,'00111','Device Updated, New values are: TODO',512,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:20','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',512,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:08:20','ERROR',NULL,NULL,NULL,512,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:12:41','INFO',NULL,'00111','Start device update ,ID= 1',525,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:12:41','INFO',NULL,'00111','Device Updated, New values are: TODO',525,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:12:41','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',525,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:12:42','ERROR',NULL,NULL,NULL,525,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:13:01','INFO',NULL,'00111','Start device update ,ID= 1',532,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:13:01','INFO',NULL,'00111','Device Updated, New values are: TODO',532,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:13:01','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',532,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:13:01','ERROR',NULL,NULL,NULL,532,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:24:56','INFO',NULL,'00111','Start device update ,ID= 1',536,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:24:56','INFO',NULL,'00111','Device Updated, New values are: TODO',536,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:24:56','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',536,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:24:57','ERROR',NULL,NULL,NULL,536,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:01','INFO',NULL,'00111','Start device update ,ID= 2',537,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:01','INFO',NULL,'00111','Device Updated, New values are: TODO',537,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:01','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =2 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',537,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:02','INFO',NULL,'00111','Command Added to Device ID=2 New command ID is: 26',537,'smes_microgrid.add_command','root@localhost'),('2016-10-04 04:25:06','INFO',NULL,'00111','Start device update ,ID= 1',538,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:06','INFO',NULL,'00111','Device Updated, New values are: TODO',538,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:06','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Command= VOL {0}, CUR {1}, VOL{2}',538,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:25:07','ERROR',NULL,NULL,NULL,538,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:29:02','INFO',NULL,'00111','Start device update ,ID= 22',554,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:29:02','INFO',NULL,'00111','Device Updated, New values are: TODO',554,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:29:02','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =22 Values Are: Command= MEAS:VOLT?;\n',554,'smes_microgrid.update_device','root@localhost'),('2016-10-04 04:29:02','INFO',NULL,'00111','Command Added to Device ID=22 New command ID is: 27',554,'smes_microgrid.add_command','root@localhost'),('2016-10-05 01:08:25','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',667,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:08:25','INFO',NULL,'00111','Device Added, New device ID is: 30',667,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:08:25','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =30 Values Are: Command= MEAS:CURR?;FREQ?;POW?;RES?;VOLT?;TIME:HOLD?;TRAN?;:MODE?;:LOAD?\\n',667,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:08:25','INFO',NULL,'00111','Command Added to Device ID=30 New command ID is: 17',667,'smes_microgrid.add_command','root@localhost'),('2016-10-05 01:12:54','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =30 Values Are:  TODO',671,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:12:54','INFO',NULL,'00111','Variable Added to Device ID=30 New variable ID is: 18',671,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:13:09','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =30 Values Are:  TODO',672,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:13:09','INFO',NULL,'00111','Variable Added to Device ID=30 New variable ID is: 19',672,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:25:44','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',688,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:25:45','INFO',NULL,'00111','Device Added, New device ID is: 31',688,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:25:45','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =31 Values Are: Command= MEAS:VOLT?;CURR?;POW?;RES?;:LOAD?;:MODE?',688,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:25:45','INFO',NULL,'00111','Command Added to Device ID=31 New command ID is: 18',688,'smes_microgrid.add_command','root@localhost'),('2016-10-05 01:26:40','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =31 Values Are:  TODO',692,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:26:40','INFO',NULL,'00111','Variable Added to Device ID=31 New variable ID is: 20',692,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:27:03','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =31 Values Are:  TODO',693,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:27:03','INFO',NULL,'00111','Variable Added to Device ID=31 New variable ID is: 21',693,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:27:16','INFO',NULL,'00111','Start UPDATING VARIABLE for Device with VariableID =21 Values Are:  TODO',695,'smes_microgrid.update_variable','root@localhost'),('2016-10-05 01:27:16','INFO',NULL,'00111','Variable Updated , VariableID=21',695,'smes_microgrid.update_variable','root@localhost'),('2016-10-05 01:36:52','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',709,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:36:52','INFO',NULL,'00111','Device Added, New device ID is: 32',709,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:36:52','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =32 Values Are: Command= MEAS:VOLT?;CURR?;POW?;FREQ?;:MEAS:POW:APP?;:MEAS:CURR:AMPL:MAX?;:MEAS:POW:PFAC?;:VOLT:RANG?;:CURR?;:VOLT?;:MODE?;:OUTP?',709,'smes_microgrid.add_device','root@localhost'),('2016-10-05 01:36:52','INFO',NULL,'00111','Command Added to Device ID=32 New command ID is: 19',709,'smes_microgrid.add_command','root@localhost'),('2016-10-05 01:37:50','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =32 Values Are:  TODO',713,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:37:50','INFO',NULL,'00111','Variable Added to Device ID=32 New variable ID is: 22',713,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:38:14','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =32 Values Are:  TODO',714,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 01:38:15','INFO',NULL,'00111','Variable Added to Device ID=32 New variable ID is: 23',714,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:02:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:02:42 Value = 0.000000',722,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:02:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:02:42 Value = 0.000000',723,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:03:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:03:12 Value = 0.000000',734,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:03:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:03:12 Value = 0.000000',737,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:03:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:03:43 Value = 0.000000',747,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:03:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:03:43 Value = 0.000000',748,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:04:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:04:13 Value = 0.000000',756,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:04:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:04:13 Value = 0.000000',757,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:04:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:04:43 Value = 0.000000',760,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:04:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:04:43 Value = 0.000000',761,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:05:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:05:13 Value = 0.000000',772,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:05:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:05:13 Value = 0.000000',773,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:05:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:05:42 Value = 0.000000',776,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:05:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:05:42 Value = 0.000000',777,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:06:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:06:12 Value = 0.000000',779,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:06:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:06:12 Value = 0.000000',780,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:06:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:06:42 Value = 0.000000',791,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:06:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:06:42 Value = 0.000000',792,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:07:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:07:12 Value = 0.000000',794,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:07:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:07:12 Value = 0.000000',795,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:07:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:07:42 Value = 0.000000',797,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:07:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:07:42 Value = 0.000000',798,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:08:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:08:12 Value = 0.000000',800,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:08:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:08:12 Value = 0.000000',801,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:08:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:08:42 Value = 0.000000',804,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:08:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:08:42 Value = 0.000000',805,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:09:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:09:12 Value = 0.000000',810,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:09:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:09:12 Value = 0.000000',811,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:09:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:09:42 Value = 0.000000',815,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:09:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:09:42 Value = 0.000000',816,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:10:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:10:12 Value = 0.000000',819,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:10:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:10:12 Value = 0.000000',820,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:10:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:10:42 Value = 0.000000',822,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:10:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:10:42 Value = 0.000000',823,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:11:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:11:12 Value = 10.093000',829,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:11:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:11:12 Value = 0.000000',830,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:11:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:11:42 Value = 10.062000',832,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:11:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:11:42 Value = 0.000000',833,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:12:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:12:12 Value = 10.062000',839,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:12:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:12:12 Value = 0.000000',840,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:12:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:12:42 Value = 10.093000',845,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:12:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:12:42 Value = 0.004680',846,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:13:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:13:12 Value = 10.062000',850,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:13:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:13:12 Value = 0.000000',851,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:13:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:13:42 Value = 10.093000',853,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:13:42','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:13:42 Value = 0.000000',854,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:14:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =21 Values Are:  Timestamp = 2016-10-05 10:14:12 Value = 10.031000',856,'smes_microgrid.add_variable','root@localhost'),('2016-10-05 02:14:12','INFO',NULL,'00111','Start Adding new VARIABLE_Value with VariableID =20 Values Are:  Timestamp = 2016-10-05 10:14:12 Value = 0.000000',857,'smes_microgrid.add_variable','root@localhost'),('2016-10-06 08:55:35','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =30 Values Are: Name= SwitchOnDevice30',3,'smes_microgrid.add_command','root@localhost'),('2016-10-06 08:55:35','INFO',NULL,'00111','Command Added to Device ID=30 New command ID is: 20',3,'smes_microgrid.add_command','root@localhost'),('2016-10-06 08:55:35','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:20 Device ID is: 30',3,'smes_microgrid.add_command','root@localhost'),('2016-10-06 08:56:05','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =30 Values Are: Name= SwitchOFFDevice30',3,'smes_microgrid.add_command','root@localhost'),('2016-10-06 08:56:05','INFO',NULL,'00111','Command Added to Device ID=30 New command ID is: 21',3,'smes_microgrid.add_command','root@localhost'),('2016-10-06 08:56:05','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:21 Device ID is: 30',3,'smes_microgrid.add_command','root@localhost'),('2016-10-06 09:12:40','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data_latest','root@localhost'),('2016-10-06 09:14:28','ERROR',NULL,NULL,NULL,3,'smes_microgrid.get_device_data_latest','root@localhost');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `microgrid`
--

DROP TABLE IF EXISTS `microgrid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `microgrid` (
  `ID` tinyint(4) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `microgrid_type_id` int(11) DEFAULT NULL,
  `scl_file(SSD)` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_microgrid_microgrid_type_1` (`microgrid_type_id`),
  CONSTRAINT `fk_microgrid_microgrid_type_1` FOREIGN KEY (`microgrid_type_id`) REFERENCES `microgrid_type` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `microgrid`
--

LOCK TABLES `microgrid` WRITE;
/*!40000 ALTER TABLE `microgrid` DISABLE KEYS */;
INSERT INTO `microgrid` VALUES (1,'Lab Level 5 Microgrid','THis is microgrid at level 5 lab, ERIAN, NTU',1,NULL);
/*!40000 ALTER TABLE `microgrid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `microgrid_type`
--

DROP TABLE IF EXISTS `microgrid_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `microgrid_type` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `microgrid_type`
--

LOCK TABLES `microgrid_type` WRITE;
/*!40000 ALTER TABLE `microgrid_type` DISABLE KEYS */;
INSERT INTO `microgrid_type` VALUES (1,'Microgrid type  1','TBD');
/*!40000 ALTER TABLE `microgrid_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameter_type`
--

DROP TABLE IF EXISTS `parameter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parameter_type` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameter_type`
--

LOCK TABLES `parameter_type` WRITE;
/*!40000 ALTER TABLE `parameter_type` DISABLE KEYS */;
INSERT INTO `parameter_type` VALUES (1,'Inpit Param','input to command'),(2,'Output','output of the command');
/*!40000 ALTER TABLE `parameter_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `status_on_off_commands`
--

DROP TABLE IF EXISTS `status_on_off_commands`;
/*!50001 DROP VIEW IF EXISTS `status_on_off_commands`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `status_on_off_commands` AS SELECT 
 1 AS `statusVariableId`,
 1 AS `statusVariableName`,
 1 AS `switchOnCommandId`,
 1 AS `switchOnCommandName`,
 1 AS `switchOnCommand`,
 1 AS `switchOnCommandProtocolId`,
 1 AS `switchOffCommandId`,
 1 AS `switchOfCommandName`,
 1 AS `switchOffCommand`,
 1 AS `switchOffCommandProtocolId`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `translation`
--

DROP TABLE IF EXISTS `translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translation`
--

LOCK TABLES `translation` WRITE;
/*!40000 ALTER TABLE `translation` DISABLE KEYS */;
INSERT INTO `translation` VALUES (1,'Acc','Accumulated '),(2,'Act ','Active, activated '),(3,'Algn',' Alignment '),(4,'Alt ','Altitude '),(5,'Amb ','Ambient '),(6,'Arr ','Array '),(7,'Aval ','Available '),(8,'Azi ','Azimuth '),(9,'Bas',' Base'),(10,'Bck','Backup'),(11,'Bnd ','Band'),(12,'Cal','Calorie, caloric '),(13,'Cct','Circuit '),(14,'Cmpl','Complete, completed '),(15,'Cmut','Commute, commutator '),(16,'Cnfg','Configuration'),(17,'Cntt','Contractual'),(18,'Con','Constant'),(19,'Conn','Connected, connections'),(20,'Conv','Conversion, converted'),(21,'Cool','Coolant'),(22,'Cost','Cost'),(23,'Csmp','Consumption, consumed'),(24,'Day','Day'),(25,'Db','Deadband'),(26,'Dc ','Direct current'),(27,'Dct','Direct'),(28,'DCV','DC voltage'),(29,'Deg','Degrees'),(30,'Dep','Dependent'),(31,'DER','Distributed energy resource'),(32,'Dff','Diffuse'),(33,'Drt','Derate'),(34,'Drv','Drive'),(35,'ECP','Electrical connection point'),(36,'Efc','Efficiency'),(37,'El','Elevation'),(38,'Em','Emission'),(39,'Emg','Emergency'),(40,'Encl','Enclosure'),(41,'Eng','Engine'),(42,'Est','Estimated'),(43,'ExIm','Export/import'),(44,'Exp','Export'),(45,'Forc','Forced'),(46,'Fuel','Fuel'),(47,'Fx','Fixed'),(48,'Gov','Governor'),(49,'Heat','Heat'),(50,'Hor','Horizontal'),(51,'Hr','Hour'),(52,'Hyd','Hydrogen (suggested in addition to H2)'),(53,'Id','Identity'),(54,'Imp','Import'),(55,'Ind','Independent'),(56,'Inert','Inertia'),(57,'lnf','Information'),(58,'Insol','Insolation'),(59,'Isld','Islanded'),(60,'Iso','Isolation'),(61,'Maint','Maintenance'),(62,'Man','Manual'),(63,'Mat','Material'),(64,'MduI','Module'),(65,'Mgt','Management'),(66,'Mrk','Market'),(67,'ObI','Obligation'),(68,'Off','Off'),(69,'On','On'),(70,'Ox','Oxidant'),(71,'Oxy','Oxygen'),(72,'Pan','Panel'),(73,'PCC','Point of common coupling'),(74,'Perm','Permission'),(75,'Pk','Peak'),(76,'Plnt','Plant, facility'),(77,'Proc','Process'),(78,'Pv','Photovoltaics'),(79,'Qud','Quad'),(80,'Rad','Radiation'),(81,'Ramp','Ramp'),(82,'Rdy','Ready'),(83,'Reg','Regulation'),(84,'Rng','Range'),(85,'Rsv','Reserve'),(86,'Schd','Schedule '),(87,'Self','Self'),(88,'Ser','Series, serial'),(89,'Slp','Sleep'),(90,'Snw','Snow'),(91,'Srt','Short'),(92,'Stab','Stabilizer'),(93,'Stp','Step'),(94,'Thrm','Thermal'),(95,'Tilt','Tilt'),(96,'Tm','Time'),(97,'Trk','Track'),(98,'Tur','Turbine'),(99,'Unld','Unload'),(100,'Util','Utility'),(101,'Vbr','Vibration'),(102,'Ver','Vertical'),(103,'Volm','Volume'),(104,'Wtr','Water (suggested in addition to H20 )'),(105,'Wup','Wake up'),(106,'Xsec','Cross-section');
/*!40000 ALTER TABLE `translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `updating_duration` int(255) DEFAULT NULL,
  `set_command_id` int(11) DEFAULT NULL,
  `get_command_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_variable_variable` (`unit_id`) USING BTREE,
  KEY `fk_variable_device_idx` (`device_id`) USING BTREE,
  CONSTRAINT `fk_variable_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_variable_unit` FOREIGN KEY (`unit_id`) REFERENCES `variable_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` VALUES (18,30,'Current','Current value',2,10,NULL,NULL),(19,30,'Voltage','Voltage value',3,10,NULL,NULL),(20,31,'Voltage','Voltage reading from the device',3,10,NULL,NULL),(21,31,'Current','Current reading from the device',2,10,0,0),(22,32,'Current','current value',2,10,NULL,NULL),(23,32,'Voltage','current Voltage',3,10,NULL,NULL),(24,30,'DeviceStatus','DeviceStatus ON or OFF',50,10,NULL,NULL),(25,31,'Ch1Status','Status ON/OFF channel 1',50,10,NULL,NULL),(26,31,'Ch2Status','Status ON/OFF channel 2',50,10,NULL,NULL);
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable_unit`
--

DROP TABLE IF EXISTS `variable_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_unit` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable_unit`
--

LOCK TABLES `variable_unit` WRITE;
/*!40000 ALTER TABLE `variable_unit` DISABLE KEYS */;
INSERT INTO `variable_unit` VALUES (1,'kWh','Power','power in kWh'),(2,'A','Energy','energy in A'),(3,'V','Voltage','volt'),(50,'Status','Status','');
/*!40000 ALTER TABLE `variable_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable_value`
--

DROP TABLE IF EXISTS `variable_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_value` (
  `timestamp` datetime NOT NULL,
  `variable_id` int(11) NOT NULL,
  `value` decimal(59,6) DEFAULT NULL,
  KEY `fk_variable_value_variable_1` (`variable_id`) USING BTREE,
  CONSTRAINT `fk_variable_value_variable_1` FOREIGN KEY (`variable_id`) REFERENCES `variable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable_value`
--

LOCK TABLES `variable_value` WRITE;
/*!40000 ALTER TABLE `variable_value` DISABLE KEYS */;
INSERT INTO `variable_value` VALUES ('2016-10-05 10:02:42',20,0.000000),('2016-10-05 10:02:42',21,0.000000),('2016-10-05 10:03:12',20,0.000000),('2016-10-05 10:03:12',21,0.000000),('2016-10-05 10:03:43',20,0.000000),('2016-10-05 10:03:43',21,0.000000),('2016-10-05 10:04:13',20,0.000000),('2016-10-05 10:04:13',21,0.000000),('2016-10-05 10:04:43',20,0.000000),('2016-10-05 10:04:43',21,0.000000),('2016-10-05 10:05:13',20,0.000000),('2016-10-05 10:05:13',21,0.000000),('2016-10-05 10:05:42',20,0.000000),('2016-10-05 10:05:42',21,0.000000),('2016-10-05 10:06:12',20,0.000000),('2016-10-05 10:06:12',21,0.000000),('2016-10-05 10:06:42',21,0.000000),('2016-10-05 10:06:42',20,0.000000),('2016-10-05 10:07:12',21,0.000000),('2016-10-05 10:07:12',20,0.000000),('2016-10-05 10:07:42',21,0.000000),('2016-10-05 10:07:42',20,0.000000),('2016-10-05 10:08:12',21,0.000000),('2016-10-05 10:08:12',20,0.000000),('2016-10-05 10:08:42',20,0.000000),('2016-10-05 10:08:42',21,0.000000),('2016-10-05 10:09:12',20,0.000000),('2016-10-05 10:09:12',21,0.000000),('2016-10-05 10:09:42',21,0.000000),('2016-10-05 10:09:42',20,0.000000),('2016-10-05 10:10:12',20,0.000000),('2016-10-05 10:10:12',21,0.000000),('2016-10-05 10:10:42',21,0.000000),('2016-10-05 10:10:42',20,0.000000),('2016-10-05 10:11:12',21,10.093000),('2016-10-05 10:11:12',20,0.000000),('2016-10-05 10:11:42',20,10.062000),('2016-10-05 10:11:42',21,0.000000),('2016-10-05 10:12:12',21,10.062000),('2016-10-05 10:12:12',20,0.000000),('2016-10-05 10:12:42',21,10.093000),('2016-10-05 10:12:42',20,0.004680),('2016-10-05 10:13:12',21,10.062000),('2016-10-05 10:13:12',20,0.000000),('2016-10-05 10:13:42',21,10.093000),('2016-10-05 10:13:42',20,0.000000),('2016-10-05 10:14:12',21,10.031000),('2016-10-05 10:14:12',20,0.000000),('2016-10-05 10:14:12',18,3.440000),('2016-10-05 10:14:12',19,4.550000),('2016-10-05 10:19:12',18,6.600000),('2016-10-05 10:19:12',19,5.440000);
/*!40000 ALTER TABLE `variable_value` ENABLE KEYS */;
UNLOCK TABLES;

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
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
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
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
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
FROM `smes_microgrid`.`command_type`;

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
/*!50003 DROP PROCEDURE IF EXISTS `get_devices_data_latest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices_data_latest`()
BEGIN

-- This is important as the MySQL default setting is 1024!
SET SESSION group_concat_max_len = 500000;

SELECT CONCAT('{"Devices" : [', GROUP_CONCAT(CONCAT('{"DeviceId":"', deviceId, '", "DeviceName":"', deviceName, '", "Variables":[', list, ']}')), ']}') as jsonStr 
FROM 
(SELECT
  deviceId, deviceName,
  GROUP_CONCAT(CONCAT('{"VariableId":"', VariableId, '", "VariableName":"', VariableName, '", "LatestValue":"', IFNULL(latestValue, ''),'", "ValueTimestamp":"', IFNULL(valueTimestamp, ''),
  '", "URL_ON":"', URL_On,
  '", "URL_OFF":"', URL_Off,
  '", "IsSwitcher":"', CASE WHEN switchOnCommandId IS NOT NULL  
								THEN 1 ELSE 0 
						END,
  '", "IsLink":"', CASE WHEN URL_On ='' AND   URL_OFF = ''
								THEN 0 ELSE 1 
						END,                        
  '"}')) list
FROM
  smes_microgrid.device_data_view
GROUP BY
   deviceId, deviceName
   ) as LV;

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
/*!50003 DROP PROCEDURE IF EXISTS `get_device_data_latest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
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
		CP.id as protocolId,
		CP.name as protocolName,
		CT.id as commandTypeId,
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
/*!50003 DROP PROCEDURE IF EXISTS `get_switch_OFF_command` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_switch_OFF_command`(IN device_id INT, IN variable_id INT)
BEGIN

-- SELECT * FROM smes_microgrid.command_type;

-- 10	Read	Read all values from device
-- 11	Switch ON	
-- 12	Switch OFF	
-- 90	Other	


SELECT  
		C.format_string as commandFormatString,
        C.id as commandId,
        C.name as commandName,
        C.command_protocol_id as protocolId,
        C.command_type_id as commandTypeId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
		CP.id as protocolId,
		CP.name as protocolName,
		CT.id as commandTypeId,
		CT.name as commandTypeName,
        CDV.variable_id as statusVariableId,
        V.name as statusVariableName
FROM device 			as D 
INNER JOIN command 			as C ON C.device_id = D.id
INNER JOIN command_device_variable CDV ON CDV.command_id = C.id AND CDV.variable_id = variable_id 
INNER JOIN variable V ON V.id = variable_id 
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE D.id = device_id AND CT.id = 12 -- Command type 11 is 'Switch On'
LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_switch_ON_command` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_switch_ON_command`(IN device_id INT, IN variable_id INT)
BEGIN

-- Parameter variable_id used to return switchON command when there are more than one CHANNELS
-- Channel_1_Status is one variable with some ON/OFF commands,
-- Channel_2_Status is another variable with some ON/OFF commands


-- SELECT * FROM smes_microgrid.command_type;

-- 10	Read	Read all values from device
-- 11	Switch ON	
-- 12	Switch OFF	
-- 90	Other	


SELECT  C.format_string as commandFormatString,
        C.id as commandId,
        C.name as commandName,
        C.command_protocol_id as protocolId,
        C.command_type_id as commandTypeId,
        D.id as deviceId,
        D.ip_adress as IPAdress,
        D.port_number as portNumber,
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
	CT.name as commandTypeName,
    CDV.variable_id as statusVariableId,
    V.name as statusVariableName 
FROM device 			as D 
INNER JOIN command 			as C ON C.device_id = D.id
INNER JOIN command_device_variable CDV ON CDV.command_id = C.id AND CDV.variable_id = variable_id 
INNER JOIN variable V ON V.id = variable_id 
INNER JOIN command_protocol as CP ON CP.id = C.command_protocol_id
INNER JOIN command_type 	as CT ON CT.id = C.command_type_id
WHERE D.id = device_id  AND CT.id = 11 -- Command type 11 is 'Switch On'
LIMIT 1;  

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
    CP.id as protocolId,
    CP.name as protocolName,
    CT.id as commandTypeId,
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
/*!50001 VIEW `device_data_view` AS select distinct `d`.`id` AS `deviceId`,`d`.`name` AS `deviceName`,`v`.`name` AS `VariableName`,`v`.`id` AS `variableId`,`vv`.`timestamp` AS `valueTimestamp`,`vv`.`value` AS `latestValue`,`onoff`.`switchOnCommandId` AS `switchOnCommandId`,`onoff`.`switchOnCommandName` AS `switchOnCommandName`,`onoff`.`switchOnCommand` AS `switchOnCommand`,`onoff`.`switchOnCommandProtocolId` AS `switchOnCommandProtocolId`,`onoff`.`switchOffCommandId` AS `switchOffCommandId`,`onoff`.`switchOfCommandName` AS `switchOfCommandName`,`onoff`.`switchOffCommand` AS `switchOffCommand`,`onoff`.`switchOffCommandProtocolId` AS `switchOffCommandProtocolId`,(case when (`onoff`.`switchOnCommandProtocolId` = 20) then `onoff`.`switchOnCommand` else '' end) AS `URL_On`,(case when (`onoff`.`switchOffCommandProtocolId` = 20) then `onoff`.`switchOffCommand` else '' end) AS `URL_OFF` from (((((`smes_microgrid`.`device` `d` join `smes_microgrid`.`variable` `v` on((`v`.`device_id` = `d`.`id`))) left join (select max(`smes_microgrid`.`variable_value`.`timestamp`) AS `latestTimestamp`,`smes_microgrid`.`variable_value`.`variable_id` AS `variable_id` from `smes_microgrid`.`variable_value` group by `smes_microgrid`.`variable_value`.`variable_id`) `latestvv` on((`latestvv`.`variable_id` = `v`.`id`))) left join `smes_microgrid`.`variable_value` `vv` on(((`vv`.`variable_id` = `latestvv`.`variable_id`) and (`vv`.`timestamp` = `latestvv`.`latestTimestamp`)))) left join `smes_microgrid`.`command_device_variable` `cdv` on(((`cdv`.`variable_id` = `v`.`id`) and (`v`.`unit_id` = 50)))) left join `smes_microgrid`.`status_on_off_commands` `onoff` on((`onoff`.`statusVariableId` = `cdv`.`variable_id`))) order by `d`.`id`,`v`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `status_on_off_commands`
--

/*!50001 DROP VIEW IF EXISTS `status_on_off_commands`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `status_on_off_commands` AS select `v`.`id` AS `statusVariableId`,`v`.`name` AS `statusVariableName`,max(`onoff`.`switchOnCommandId`) AS `switchOnCommandId`,max(`onoff`.`switchOnCommandName`) AS `switchOnCommandName`,max(`onoff`.`switchOnCommand`) AS `switchOnCommand`,max(`onoff`.`switchOnCommandProtocolId`) AS `switchOnCommandProtocolId`,max(`onoff`.`switchOffCommandId`) AS `switchOffCommandId`,max(`onoff`.`switchOfCommandName`) AS `switchOfCommandName`,max(`onoff`.`switchOffCommand`) AS `switchOffCommand`,max(`onoff`.`switchOffCommandProtocolId`) AS `switchOffCommandProtocolId` from (`smes_microgrid`.`variable` `v` left join (select `c_on`.`id` AS `switchOnCommandId`,`c_on`.`name` AS `switchOnCommandName`,`c_on`.`format_string` AS `switchOnCommand`,`c_on`.`command_protocol_id` AS `switchOnCommandProtocolId`,NULL AS `switchOffCommandId`,NULL AS `switchOfCommandName`,NULL AS `switchOffCommand`,NULL AS `switchOffCommandProtocolId`,`cdv`.`variable_id` AS `variable_id` from (`smes_microgrid`.`command` `c_on` left join `smes_microgrid`.`command_device_variable` `cdv` on((`cdv`.`command_id` = `c_on`.`id`))) where ((`c_on`.`id` = `cdv`.`command_id`) and (`c_on`.`command_type_id` = 11)) union all select NULL AS `switchOnCommandId`,NULL AS `switchOnCommandName`,NULL AS `switchOnCommand`,NULL AS `switchOnCommandProtocolId`,`c_off`.`id` AS `switchOffCommandId`,`c_off`.`name` AS `switchOfCommandName`,`c_off`.`format_string` AS `switchOffCommand`,`c_off`.`command_protocol_id` AS `switchOffCommandProtocolId`,`cdv`.`variable_id` AS `variableId` from (`smes_microgrid`.`command` `c_off` left join `smes_microgrid`.`command_device_variable` `cdv` on((`cdv`.`command_id` = `c_off`.`id`))) where ((`c_off`.`id` = `cdv`.`command_id`) and (`c_off`.`command_type_id` = 12))) `onoff` on((`v`.`id` = `onoff`.`variable_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-07 18:02:55
