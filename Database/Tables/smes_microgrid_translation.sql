-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 172.21.76.125    Database: smes_microgrid
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-05 15:04:22
