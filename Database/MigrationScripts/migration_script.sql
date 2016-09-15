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
  PRIMARY KEY (`id`),
  KEY `fk_device_command_idx` (`device_id`),
  CONSTRAINT `fk_device_command` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
INSERT INTO `command` VALUES (1,'CMD1','test Add cmd SP1','VOL {0}, CUR {1}, VOL1{2}',1),(2,'CMD1','test Add cmd SP1','VOL {0}, CUR {1}, VOL1{2}',1),(3,'CMD1','test Add cmd SP1','VOL {0}, CUR {1}, VOL1{2}',1),(4,'CMD1','test Add cmd SP1','VOL {0}, CUR {1}, VOL1{2}',1);
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
INSERT INTO `command_device_variable` VALUES (4,1,1),(4,4,1),(4,5,1),(4,1,2),(4,4,2),(4,5,2);
/*!40000 ALTER TABLE `command_device_variable` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `fk_device_microgrid_1` (`microgrid_id`),
  KEY `fk_device_device_type_1` (`device_type_id`),
  KEY `fk_device_bus_idx` (`bus_id`),
  CONSTRAINT `fk_device_bus` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_device_type_1` FOREIGN KEY (`device_type_id`) REFERENCES `device_type` (`id`),
  CONSTRAINT `fk_device_microgrid_1` FOREIGN KEY (`microgrid_id`) REFERENCES `microgrid` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(2,2,'Load 2','test Update Load 2 top Load 2device',1,NULL,'Sasha\'s','Model S2','somewhere 2','127.34.5646.12','3030upd2',2,'',''),(3,1,'API call add 3',NULL,1,NULL,'vendor3','Model3','location3','some IP 3','2002',1,'','\0'),(4,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(5,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(6,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(7,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(8,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(9,2,'Load UPD1','test UPDATE Load ',1,NULL,'Vendor upd','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(10,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(11,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(12,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(13,2,'Load 12','test INSERT Load ',1,NULL,'Vendor','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(14,2,'Load 12','test INSERT Load ',1,NULL,'Vendor','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(15,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(16,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(17,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(18,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0'),(19,2,'Load 2','test Update Load 2 top Load 2device',1,NULL,'UPD3','Model S2','somewhere 2','127.34.5646.12','3030upd2',2,'','');
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
INSERT INTO `log` VALUES ('2016-09-06 05:49:43','INFO',NULL,'00111','Start device update ,ID= 1',5,'smes_microgrid.update_device','root@localhost'),('2016-09-06 05:49:43','INFO',NULL,'00111','Device Updated, New values are: TODO',5,'smes_microgrid.update_device','root@localhost'),('2016-09-06 06:00:26','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:00:26','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:00:26','INFO',NULL,'00111','Device Added, New device ID is: 2',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:05:48','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:05:48','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:13','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:13','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:21','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 06:10:21','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 07:32:02','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =4 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:32:02','INFO',NULL,'00111','Variable Added to Device ID=4 New variable ID is: 2',5,NULL,'root@localhost'),('2016-09-06 07:34:23','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =4 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:34:23','ERROR',NULL,NULL,NULL,5,'smes_microgrid.add_device','root@localhost'),('2016-09-06 07:34:55','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:34:55','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 4',5,NULL,'root@localhost'),('2016-09-06 07:35:27','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:35:27','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 5',5,NULL,'root@localhost'),('2016-09-06 07:35:36','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:35:36','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 6',5,NULL,'root@localhost'),('2016-09-06 07:45:00','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =2 Values Are:  TODO',5,'smes_microgrid.add_variable','root@localhost'),('2016-09-06 07:45:00','INFO',NULL,'00111','Variable Added to Device ID=2 New variable ID is: 7',5,NULL,'root@localhost'),('2016-09-06 07:57:30','ERROR',NULL,NULL,NULL,5,'smes_microgrid.update_variable','root@localhost'),('2016-09-06 09:00:44','ERROR',NULL,NULL,NULL,5,'smes_microgrid.update_variable','root@localhost'),('2016-09-06 09:05:35','INFO',NULL,'00111','Start UPDATING VARIABLE for Device with VariableID =6 Values Are:  TODO',5,'smes_microgrid.update_variable','root@localhost'),('2016-09-06 09:05:35','INFO',NULL,'00111','Variable Updated , VariableID=6',5,'smes_microgrid.update_variable','root@localhost'),('2016-09-09 05:19:14','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100, 101,202,303,404, , , ',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:19:14','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:20:23','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100, 101,202,303,404, , , ',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:20:23','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:14','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100,101,202,303,404,,,',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:14','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:51','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100,101,202,303,404,,',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:24:51','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:49:32','INFO',NULL,'00111','smes_microgrid.parse_id_list, id_list=1,3,5,9,100, 101,202,303,404',3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-09 05:49:32','ERROR',NULL,NULL,NULL,3,'smes_microgrid.parse_id_list','root@localhost'),('2016-09-13 08:35:19','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',28,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:35:19','INFO',NULL,'00111','Device Added, New device ID is: 3',28,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:12','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',31,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:12','INFO',NULL,'00111','Device Added, New device ID is: 4',31,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:53','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',32,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:43:53','INFO',NULL,'00111','Device Added, New device ID is: 5',32,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:47:45','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',37,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:47:45','INFO',NULL,'00111','Device Added, New device ID is: 6',37,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:55:40','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',40,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:55:40','INFO',NULL,'00111','Device Added, New device ID is: 7',40,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:57:04','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',41,'smes_microgrid.add_device','root@localhost'),('2016-09-13 08:57:04','INFO',NULL,'00111','Device Added, New device ID is: 8',41,'smes_microgrid.add_device','root@localhost'),('2016-09-14 03:13:54','INFO',NULL,'00111','Start Adding new VARIABLE to Device with DeviceID =1 Values Are:  TODO',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-14 03:13:54','INFO',NULL,'00111','Variable Added to Device ID=1 New variable ID is: 8',3,'smes_microgrid.add_variable','root@localhost'),('2016-09-14 07:50:58','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:50:58','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:50:58','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:51:59','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:51:59','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 2',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:51:59','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:54:10','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:54:10','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 3',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:54:10','ERROR',NULL,NULL,NULL,3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:55:51','INFO',NULL,'00111','Start Adding new COMMAND to Device with DeviceID =1 Values Are: Name= CMD1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:55:51','INFO',NULL,'00111','Command Added to Device ID=1 New command ID is: 4',3,'smes_microgrid.add_command','root@localhost'),('2016-09-14 07:55:51','INFO',NULL,'00111','Added INPUT and OUTPUT variables to the Command:4 Device ID is: 1',3,'smes_microgrid.add_command','root@localhost'),('2016-09-15 00:54:45','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',51,'smes_microgrid.add_device','root@localhost'),('2016-09-15 00:54:45','INFO',NULL,'00111','Device Added, New device ID is: 9',51,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:02:12','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',52,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:02:13','INFO',NULL,'00111','Device Added, New device ID is: 10',52,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:04:05','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',53,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:04:05','INFO',NULL,'00111','Device Added, New device ID is: 11',53,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:06:50','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',54,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:06:50','INFO',NULL,'00111','Device Added, New device ID is: 12',54,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:09:38','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:09:38','INFO',NULL,'00111','Device Added, New device ID is: 13',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:37','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:37','INFO',NULL,'00111','Device Added, New device ID is: 14',3,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:46','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',55,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:13:46','INFO',NULL,'00111','Device Added, New device ID is: 15',55,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:14:10','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',56,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:14:10','INFO',NULL,'00111','Device Added, New device ID is: 16',56,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:17:07','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',58,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:17:07','INFO',NULL,'00111','Device Added, New device ID is: 17',58,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:17:38','INFO',NULL,'00111','Start device update ,ID= 1',59,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:17:38','INFO',NULL,'00111','Device Updated, New values are: TODO',59,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:19:49','INFO',NULL,'00111','Start device update ,ID= 9',3,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:19:49','INFO',NULL,'00111','Device Updated, New values are: TODO',3,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:20:18','INFO',NULL,'00111','Start device update ,ID= 1',60,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:20:18','INFO',NULL,'00111','Device Updated, New values are: TODO',60,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:38:20','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',61,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:38:20','INFO',NULL,'00111','Device Added, New device ID is: 18',61,'smes_microgrid.add_device','root@localhost'),('2016-09-15 01:40:04','INFO',NULL,'00111','Start device update ,ID= 1',62,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:40:04','INFO',NULL,'00111','Device Updated, New values are: TODO',62,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:42:27','INFO',NULL,'00111','Start device update ,ID= 1',63,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:42:27','INFO',NULL,'00111','Device Updated, New values are: TODO',63,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:53:23','INFO',NULL,'00111','Start device update ,ID= 1',64,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:53:23','INFO',NULL,'00111','Device Updated, New values are: TODO',64,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:54:54','INFO',NULL,'00111','Start device update ,ID= 1',65,'smes_microgrid.update_device','root@localhost'),('2016-09-15 01:54:54','INFO',NULL,'00111','Device Updated, New values are: TODO',65,'smes_microgrid.update_device','root@localhost'),('2016-09-15 02:02:09','INFO',NULL,'00111','Start Adding new device, Values Are:  TODO',66,'smes_microgrid.add_device','root@localhost'),('2016-09-15 02:02:10','INFO',NULL,'00111','Device Added, New device ID is: 19',66,'smes_microgrid.add_device','root@localhost'),('2016-09-15 02:03:15','INFO',NULL,'00111','Start device update ,ID= 19',67,'smes_microgrid.update_device','root@localhost'),('2016-09-15 02:03:15','INFO',NULL,'00111','Device Updated, New values are: TODO',67,'smes_microgrid.update_device','root@localhost');
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
  CONSTRAINT `fk_variable_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` VALUES (1,1,'var1','test add SP1',1,NULL,NULL,NULL),(4,1,'var2','test add SP1',1,NULL,NULL,NULL),(5,1,'var2','test add SP1',1,NULL,NULL,NULL),(6,1,'VAR6','Var 6 desc',1,100,NULL,NULL),(7,2,'var22','test add SP1',1,NULL,NULL,NULL),(8,1,'Var5','desc 5',1,2,NULL,NULL);
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
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_variable_unit_device_variable_1` FOREIGN KEY (`id`) REFERENCES `device_variable` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable_unit`
--

LOCK TABLES `variable_unit` WRITE;
/*!40000 ALTER TABLE `variable_unit` DISABLE KEYS */;
INSERT INTO `variable_unit` VALUES (1,'kWh','Power','power in kWh'),(2,'A','Energy','energy in A'),(3,'V','Voltage','volt');
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
  `value` decimal(65,0) DEFAULT NULL,
  KEY `fk_variable_value_variable_1` (`variable_id`) USING BTREE,
  CONSTRAINT `fk_variable_value_variable_1` FOREIGN KEY (`variable_id`) REFERENCES `variable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable_value`
--

LOCK TABLES `variable_value` WRITE;
/*!40000 ALTER TABLE `variable_value` DISABLE KEYS */;
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
    -- CALL smes_microgrid.get_device(LAST_INSERT_ID());
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
WHERE D.id=LAST_INSERT_ID()
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

SELECT id as ID, name as Name, description as Description 
FROM `smes_microgrid`.`bus`;

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

SELECT T.id as TypeID, T.name as TypeName, T.description as TypeDescription, C.id as ClassID, C.Name as ClassName, C.Description as ClassDescription
FROM `smes_microgrid`.`device_type` T
LEFT JOIN `smes_microgrid`.`device_class` C ON T.device_class_id = C.id;

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

SELECT `variable_unit`.`id` as ID,
    `variable_unit`.`code` as 'Code',
    `variable_unit`.`name` as 'Name',
    `variable_unit`.`description` as 'Description'
FROM `smes_microgrid`.`variable_unit`;

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

-- Dump completed on 2016-09-15 10:11:08
