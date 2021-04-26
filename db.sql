-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: BuyMe
-- ------------------------------------------------------
-- Server version	8.0.23
unlock tables;
drop database if exists BuyMe;
create database if not exists BuyMe;
use BuyMe;

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
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alertid` int NOT NULL AUTO_INCREMENT,
  `user` varchar(30) DEFAULT NULL,
  `message` varchar(300) DEFAULT NULL,
  `auction_id` int DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `isRead` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`alertid`),
  KEY `user` (`user`),
  KEY `FK_auction_id` (`auction_id`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`email`),
  CONSTRAINT `FK_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,'seth2@test','You have been outbid!',5,'2021-04-09 14:56:59',0),(2,'seth2@test','You have been outbid!',5,'2021-04-09 16:16:39',0),(3,'seth2@test','You have been outbid!',5,'2021-04-09 16:16:39',0),(4,'seth3@test','You have been outbid!',5,'2021-04-09 16:17:55',0);
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES (5,'seth@test','[USED] Civic','2021-04-09 12:33:00','2021-04-30 12:32:00',500,100,'pickup only',1000,12);
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
  `increment` int DEFAULT '0',
  `auto_bid_max` double NOT NULL,
  `did_win` tinyint DEFAULT '0',
  PRIMARY KEY (`auction_id`,`email`,`time_stamp`),
  KEY `email` (`email`),
  CONSTRAINT `bids_on_ibfk_1` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE CASCADE,
  CONSTRAINT `bids_on_ibfk_2` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `bids_on` WRITE;
/*!40000 ALTER TABLE `bids_on` DISABLE KEYS */;
INSERT INTO `bids_on` VALUES (5,'seth2@test','2021-04-09 14:42:58',900,0,0, 900,0),(5,'seth2@test','2021-04-09 14:56:59',1000,0,0,1000,0),(5,'seth2@test','2021-04-09 16:15:55',1300,0,0,1300,0),(5,'seth3@test','2021-04-09 16:16:39',1400,0,0,1400,0);
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
INSERT INTO `category` VALUES ('Car',NULL,'Make','Model','Year','Miles','Cylinders','Trim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('Engine','Car','Miles','Cylinders',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (11,'Honda Civic','Used','Car','Honda','Civic','2012','100,000','4','LX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'Honda Civic','Used','Car','Honda','Civic','2012','120000','4','LX',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `interested_in`
--

DROP TABLE IF EXISTS `interested_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interested_in` (
  `item_id` int NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`item_id`,`email`),
  KEY `email` (`email`),
  CONSTRAINT `interested_in_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE,
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
INSERT INTO `users` VALUES ('admin@buyme','password','Admin Name','123 Ban Hammer Dr. Mod Town, NJ 07123',1,0),('null@name','password',NULL,'address',0,0),('rep@buyme','password','Reps Name','123 Helpful Rd. Custie Town, NJ 07567',0,1),('seth@test','password','Seth','123 Home',0,0),('seth2@test','password','Seth2','seth2',0,0),('seth3@test','password','S','S',0,0);
INSERT INTO `users` VALUES ('test@gmail.com', 'pass', 'Test Smith', 'Rutgers Ct NJ', 0, 0), ('test2@gmail.com', 'pass', 'Test2 Smith', 'Rutgers Ct NJ', 0, 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
`questionId` INT AUTO_INCREMENT,  
  `email` varchar(40) NOT NULL,
  `question` varchar(200) DEFAULT NULL,
  `answer` varchar(200) DEFAULT NULL,
  FOREIGN KEY (`email`) REFERENCES users(`email`)
    ON DELETE CASCADE,
  PRIMARY KEY (`questionId`)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` (`email`) VALUES ('seth@test');
INSERT INTO `questions` (`email`) VALUES ('seth2@test');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
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

INSERT INTO users VALUES
('brenton@test', '1234', 'Brenton B', '1234 Lane', 0, 0);

INSERT INTO category VALUES 
('Computer Part',NULL,'Manufacturer','Model',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('CPU','Computer Part','Cores','Threads','Base Clock Rate','Max Turbo Clock Rate','Cache Size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('GPU','Computer Part','Core Clock Speed','Memory Clock Speed','Memory',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('RAM','Computer Part','Memory','Type','Frequency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO item VALUES 
(13,'Corsair Dominator Platinum RGB','New','RAM','Corsair','Dominator Platinum','32GB','DDR4','3200MHz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(14,'G.Skill Trident Z Neo','New','RAM','G.Skill','Trident Z Neo','32GB','DDR4','3600MHz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(15,'G.Skill Trident Z Royal','New','RAM','G.Skill','Trident Z Royal','16GB','DDR4','4000MHz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(16,'G.Skill Ripjaws V','New','RAM','G.Skill','Ripjaws V','16GB','DDR4','2400MHz',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(17,'NVIDIA STG-2000','New','GPU','NVIDIA','NV1','12MHz','75MHz','4MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(18,'NVIDIA Riva 128','New','GPU','NVIDIA','NV3','100MHz','100MHz','4MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(19,'NVIDIA GeForce3 Ti200','New','GPU','NVIDIA','NV20','175MHz','200MHz','64MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20,'NVIDIA GeForce3','New','GPU','NVIDIA','NV20','200MHz','230MHz','64MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(21,'NVIDIA GeForce FX 5100','New','GPU','NVIDIA','NV34','200MHz','166MHz','128MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(22,'NVIDIA Quadro K510M','New','GPU','NVIDIA','GK208','850MHz','1200MHz','1024MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(23,'NVIDIA Quadro K51100M','New','GPU','NVIDIA','GK107','716MHz','716MHz','1400MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(24,'AMD Radeon RX 550','New','GPU','AMD','RX550-4G D5','1071MHz','6000MHz','4GB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(25,'AMD Radeon Vega Pro 16','New','GPU','AMD','Vega 12 XLA','300MHz','2400MHz','4GB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(26,'AMD Radeon Pro WX 4150','New','GPU','AMD','Polaris 11','1000MHz','7000MHz','4GB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(27,'Intel Ice Lake Core i7','New','CPU','Intel','i7-1068NG7','4','8','2.3GHz','4.1GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(28,'Intel Ice Lake Core i7','New','CPU','Intel','i7-1065G7','4','8','1.3GHz','3.9GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(29,'Intel Ice Lake Core i7','New','CPU','Intel','i7-1060NG7','4','8','1.2GHz','3.8GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30,'Intel Ice Lake Core i7','New','CPU','Intel','i7-1060G7','4','8','1.0GHz','3.8GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(31,'Intel Ice Lake Core i5','New','CPU','Intel','i5-1038NG7','4','8','2.0GHz','3.8GHz','6MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(32,'Intel Ice Lake Core i5','New','CPU','Intel','i5-1035G7','4','8','1.2GHz','3.7GHz','6MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(33,'Intel Ice Lake Core i5','New','CPU','Intel','i5-1035G1','4','8','1.1GHz','3.7GHz','6MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(34,'Intel Ice Lake Core i5','New','CPU','Intel','i5-1030NG7','4','8','1.0GHz','3.6GHz','6MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(35,'AMD Ryzen 7 4700U','New','CPU','AMD','Ryzen 7 4700U','8','8','2.0GHz','4.1GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(36,'AMD Ryzen 7 4800U','New','CPU','AMD','Ryzen 7 4700U','8','16','1.8GHz','4.2GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(37,'AMD Ryzen 7 4500U','New','CPU','AMD','Ryzen 7 4500U','6','6','2.3GHz','4.0GHz','8MB',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO auction VALUES 
(6,'brenton@test','AMD Ryzen 4000 Series','2021-04-09 12:33:00','2021-05-30 12:32:00',1000,100,'pickup only',1000,37),
(12,'brenton@test','Cool G.Skill RAM stick','2021-04-09 12:33:00','2021-05-30 12:32:00',1000,100,'pickup only',1000,15),
(11,'brenton@test','Icy Intel CPU','2021-04-09 12:33:00','2021-07-02 12:32:00',2000,100,'pickup only',2000,27);
-- Dump completed on 2021-04-09 16:21:53
