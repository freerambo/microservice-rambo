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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(2,2,'Load 2','test Update Load 2 top Load 2device',1,NULL,'Sasha\'s','Model S2','somewhere 2','127.34.5646.12','3030upd2',2,'','',NULL),(3,1,'API call add 3',NULL,1,NULL,'vendor3','Model3','location3','some IP 3','2002',1,'','\0',NULL),(4,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(5,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(6,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(7,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(8,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(9,2,'Load UPD1','test UPDATE Load ',1,NULL,'Vendor upd','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(10,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(11,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(12,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(13,2,'Load 12','test INSERT Load ',1,NULL,'Vendor','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(14,2,'Load 12','test INSERT Load ',1,NULL,'Vendor','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(15,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(16,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(17,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(18,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(19,2,'Load 2','test Update Load 2 top Load 2device',1,NULL,'UPD3','Model S2','somewhere 2','127.34.5646.12','3030upd2',2,'','',NULL),(20,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(21,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(22,4,'chroma_63211_dc_load','DC LOAD chroma_63211_dc_load',1,NULL,'chroma','chroma_63211','Lab at level 5','172.21.76.125','3030',2,'','',NULL),(23,4,'chroma_63211_dc_load','DC LOAD chroma_63211_dc_load',1,NULL,'chroma','chroma_63211','Lab at level 5','172.21.76.125','3030',2,'','',NULL),(24,4,'chroma_63211_dc_load','DC LOAD chroma_63211_dc_load',1,NULL,'chroma','chroma_63211','Lab at level 5','172.21.76.125','3030',2,'','',NULL),(25,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(26,4,'cSashastest1','DC LOAD chroma_63211_dc_load',1,NULL,'chroma','chroma_63211','Lab at level 5','172.21.76.125','3030',2,'','',NULL),(27,4,'cSashastestUPD1','DC LOAD chroma_63211_dc_load',1,NULL,'chroma','chroma_63211','Lab at level 5','172.21.76.125','3030',2,'','',NULL),(28,2,'Load 11','test Update Load 1 top Load 1deviceUpdated',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL),(29,2,'Load 11','test Update Load 1 top Load 1device',1,NULL,'Vendor 1','Model 1','somewhere 1','127.34.1111','3011',1,'','\0',NULL);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-26 15:33:15
