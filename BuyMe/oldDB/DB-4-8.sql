CREATE DATABASE  IF NOT EXISTS `BuyMe` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `BuyMe`;
-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: BuyMe
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auction_id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(30) NOT NULL,
  `auction_title` varchar(30) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `start_price` double NOT NULL,
  `increment` double NOT NULL,
  `auction_description` varchar(50) DEFAULT NULL,
  `min_sale_price` double DEFAULT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`auction_id`),
  KEY `email` (`user_email`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE CASCADE,
  CONSTRAINT `auction_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES (1,'seth@test','a','2021-04-06 17:45:56','2021-04-07 16:44:00',1.23,0.11,'a',100,6),(2,'seth@test','a','2021-04-06 17:46:45','2021-04-07 16:44:00',1.23,0.11,'a',100,7),(3,'seth@test','[USED] Stolen engine','2021-04-06 20:05:09','2021-04-13 20:04:00',500,25,'pickup only',1000,9),(4,'seth@test','asdf','2021-04-06 21:50:41','2021-04-15 21:50:00',100,20,'asdf',10000,10);
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids_on`
--

DROP TABLE IF EXISTS `bids_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids_on` (
  `auction_id` int NOT NULL,
  `email` varchar(30) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `amount` double NOT NULL,
  `is_automatic` tinyint DEFAULT '0',
  `auto_bid_max` double NOT NULL,
  `did_win` tinyint DEFAULT '0',
  PRIMARY KEY (`auction_id`,`email`,`time_stamp`),
  KEY `email` (`email`),
  CONSTRAINT `bids_on_ibfk_1` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE CASCADE,
  CONSTRAINT `bids_on_ibfk_2` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids_on`
--

LOCK TABLES `bids_on` WRITE;
/*!40000 ALTER TABLE `bids_on` DISABLE KEYS */;
INSERT INTO `bids_on` VALUES (3,'seth@test','2021-04-06 21:42:25',25,0,0,0),(3,'seth@test','2021-04-06 21:43:12',125,0,0,0),(3,'seth@test','2021-04-06 21:43:21',200,0,0,0),(3,'seth@test','2021-04-13 20:04:00',100,0,0,0);
/*!40000 ALTER TABLE `bids_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `name` varchar(30) NOT NULL,
  `subcategory_of` varchar(30) DEFAULT NULL,
  `spec1` varchar(20) DEFAULT NULL,
  `spec2` varchar(20) DEFAULT NULL,
  `spec3` varchar(20) DEFAULT NULL,
  `spec4` varchar(20) DEFAULT NULL,
  `spec5` varchar(20) DEFAULT NULL,
  `spec6` varchar(20) DEFAULT NULL,
  `spec7` varchar(20) DEFAULT NULL,
  `spec8` varchar(20) DEFAULT NULL,
  `spec9` varchar(20) DEFAULT NULL,
  `spec10` varchar(20) DEFAULT NULL,
  `spec11` varchar(20) DEFAULT NULL,
  `spec12` varchar(20) DEFAULT NULL,
  `spec13` varchar(20) DEFAULT NULL,
  `spec14` varchar(20) DEFAULT NULL,
  `spec15` varchar(20) DEFAULT NULL,
  `spec16` varchar(20) DEFAULT NULL,
  `spec17` varchar(20) DEFAULT NULL,
  `spec18` varchar(20) DEFAULT NULL,
  `spec19` varchar(20) DEFAULT NULL,
  `spec20` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `subcategory_of` (`subcategory_of`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`subcategory_of`) REFERENCES `category` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('Car',NULL,'Color','Doors','Trim','Miles',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('Engine','Car','Miles','Cylinders',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('SubTest','test','a','b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('test',NULL,'d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s',NULL,NULL,NULL,NULL),('test1',NULL,'a','b','c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `category_specs`
--

DROP TABLE IF EXISTS `category_specs`;
/*!50001 DROP VIEW IF EXISTS `category_specs`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `category_specs` AS SELECT 
 1 AS `spec1`,
 1 AS `spec2`,
 1 AS `spec3`,
 1 AS `spec4`,
 1 AS `spec5`,
 1 AS `spec6`,
 1 AS `spec7`,
 1 AS `spec8`,
 1 AS `spec9`,
 1 AS `spec10`,
 1 AS `spec11`,
 1 AS `spec12`,
 1 AS `spec13`,
 1 AS `spec14`,
 1 AS `spec15`,
 1 AS `spec16`,
 1 AS `spec17`,
 1 AS `spec18`,
 1 AS `spec19`,
 1 AS `spec20`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `interested_in`
--

DROP TABLE IF EXISTS `interested_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interested_in` (
  `category_name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`category_name`,`email`),
  KEY `email` (`email`),
  CONSTRAINT `interested_in_ibfk_1` FOREIGN KEY (`category_name`) REFERENCES `category` (`name`) ON DELETE CASCADE,
  CONSTRAINT `interested_in_ibfk_2` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interested_in`
--

LOCK TABLES `interested_in` WRITE;
/*!40000 ALTER TABLE `interested_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `interested_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(30) DEFAULT NULL,
  `category_name` varchar(30) NOT NULL,
  `spec1` varchar(20) DEFAULT NULL,
  `spec2` varchar(20) DEFAULT NULL,
  `spec3` varchar(20) DEFAULT NULL,
  `spec4` varchar(20) DEFAULT NULL,
  `spec5` varchar(20) DEFAULT NULL,
  `spec6` varchar(20) DEFAULT NULL,
  `spec7` varchar(20) DEFAULT NULL,
  `spec8` varchar(20) DEFAULT NULL,
  `spec9` varchar(20) DEFAULT NULL,
  `spec10` varchar(20) DEFAULT NULL,
  `spec11` varchar(20) DEFAULT NULL,
  `spec12` varchar(20) DEFAULT NULL,
  `spec13` varchar(20) DEFAULT NULL,
  `spec14` varchar(20) DEFAULT NULL,
  `spec15` varchar(20) DEFAULT NULL,
  `spec16` varchar(20) DEFAULT NULL,
  `spec17` varchar(20) DEFAULT NULL,
  `spec18` varchar(20) DEFAULT NULL,
  `spec19` varchar(20) DEFAULT NULL,
  `spec20` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `category_name` (`category_name`),
  KEY `name` (`name`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`category_name`) REFERENCES `category` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'a','a','test1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'a','a','test1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Test2','A','asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Test2','A','asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Test2','A','asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Test2','A','asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'Test2','A','asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'Car','car car','test1','hi','hello','how are you',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Honda civic','Low miles','Engine','15','4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'a','a','Car','White','4','a little','1000000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `item_specs`
--

DROP TABLE IF EXISTS `item_specs`;
/*!50001 DROP VIEW IF EXISTS `item_specs`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `item_specs` AS SELECT 
 1 AS `spec1`,
 1 AS `spec2`,
 1 AS `spec3`,
 1 AS `spec4`,
 1 AS `spec5`,
 1 AS `spec6`,
 1 AS `spec7`,
 1 AS `spec8`,
 1 AS `spec9`,
 1 AS `spec10`,
 1 AS `spec11`,
 1 AS `spec12`,
 1 AS `spec13`,
 1 AS `spec14`,
 1 AS `spec15`,
 1 AS `spec16`,
 1 AS `spec17`,
 1 AS `spec18`,
 1 AS `spec19`,
 1 AS `spec20`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `email` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `isAdmin` tinyint DEFAULT '0',
  `isRep` tinyint DEFAULT '0',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin@buyme','password','Admin Name','123 Ban Hammer Dr. Mod Town, NJ 07123',1,0),('null@name','password',NULL,'address',0,0),('rep@buyme','password','Reps Name','123 Helpful Rd. Custie Town, NJ 07567',0,1),('seth@test','password','Seth','123 Home',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `category_specs`
--

/*!50001 DROP VIEW IF EXISTS `category_specs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `category_specs` AS select `category`.`spec1` AS `spec1`,`category`.`spec2` AS `spec2`,`category`.`spec3` AS `spec3`,`category`.`spec4` AS `spec4`,`category`.`spec5` AS `spec5`,`category`.`spec6` AS `spec6`,`category`.`spec7` AS `spec7`,`category`.`spec8` AS `spec8`,`category`.`spec9` AS `spec9`,`category`.`spec10` AS `spec10`,`category`.`spec11` AS `spec11`,`category`.`spec12` AS `spec12`,`category`.`spec13` AS `spec13`,`category`.`spec14` AS `spec14`,`category`.`spec15` AS `spec15`,`category`.`spec16` AS `spec16`,`category`.`spec17` AS `spec17`,`category`.`spec18` AS `spec18`,`category`.`spec19` AS `spec19`,`category`.`spec20` AS `spec20` from `category` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `item_specs`
--

/*!50001 DROP VIEW IF EXISTS `item_specs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `item_specs` AS select `item`.`spec1` AS `spec1`,`item`.`spec2` AS `spec2`,`item`.`spec3` AS `spec3`,`item`.`spec4` AS `spec4`,`item`.`spec5` AS `spec5`,`item`.`spec6` AS `spec6`,`item`.`spec7` AS `spec7`,`item`.`spec8` AS `spec8`,`item`.`spec9` AS `spec9`,`item`.`spec10` AS `spec10`,`item`.`spec11` AS `spec11`,`item`.`spec12` AS `spec12`,`item`.`spec13` AS `spec13`,`item`.`spec14` AS `spec14`,`item`.`spec15` AS `spec15`,`item`.`spec16` AS `spec16`,`item`.`spec17` AS `spec17`,`item`.`spec18` AS `spec18`,`item`.`spec19` AS `spec19`,`item`.`spec20` AS `spec20` from `item` */;
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

-- Dump completed on 2021-04-08 11:43:42
