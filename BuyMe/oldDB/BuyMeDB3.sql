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
  `auction_id` int NOT NULL,
  `auction_title` varchar(30) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `increment` double NOT NULL,
  `auction_description` varchar(50) DEFAULT NULL,
  `min_sale_price` double DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`auction_id`),
  KEY `email` (`email`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE,
  CONSTRAINT `auction_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
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
INSERT INTO `category` VALUES ('asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('test',NULL,'d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s',NULL,NULL,NULL,NULL),('test1',NULL,'a','b','c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

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
  `item_id` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `name` (`name`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`name`) REFERENCES `category` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-03 16:30:00
