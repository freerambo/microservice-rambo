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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` VALUES (1,1,'var1','test add SP1',1,NULL,NULL,NULL),(4,1,'var2','test add SP1',1,NULL,NULL,NULL),(5,1,'var2','test add SP1',1,NULL,NULL,NULL),(6,1,'VAR6','Var 6 desc',1,100,NULL,NULL),(7,2,'var22','test add SP1',1,NULL,NULL,NULL),(8,1,'Var5','desc 5',1,2,NULL,NULL),(9,22,'Voltage','Voltage',1,5,NULL,8),(10,22,'Current','Current',1,5,NULL,9),(11,22,'Power','Power',3,5,NULL,10),(12,24,'Voltage','Voltage',1,5,NULL,8),(13,24,'Current','Current',1,5,NULL,9),(14,24,'Power','Power',3,5,NULL,10),(15,26,'Voltage','Voltage of the device',3,10,NULL,NULL),(16,26,'Current','Current of the device',2,10,NULL,NULL),(17,26,'Power','Power',1,10,NULL,NULL);
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-30 10:48:33
