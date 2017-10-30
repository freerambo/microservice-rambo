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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
INSERT INTO `command` VALUES (17,'Read all for AC Load Chroma 63804','Command that reads all the variables of device AC Load Chroma 63804in one communication request','MEAS:CURR?;FREQ?;POW?;RES?;VOLT?;TIME:HOLD?;TRAN?;:MODE?;:LOAD?\\n',30,90,90),(18,'Read all for DC Load Chroma 63211','Command that reads all the variables of device DC Load Chroma 63211in one communication request','MEAS:VOLT?;CURR?;POW?;RES?;:LOAD?;:MODE?',31,90,90),(19,'Read all for AC Source AMETEK  bps75','Command that reads all the variables of device AC Source AMETEK  bps75in one communication request','MEAS:VOLT?;CURR?;POW?;FREQ?;:MEAS:POW:APP?;:MEAS:CURR:AMPL:MAX?;:MEAS:POW:PFAC?;:VOLT:RANG?;:CURR?;:VOLT?;:MODE?;:OUTP?',32,90,90);
/*!40000 ALTER TABLE `command` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-06  9:05:57
