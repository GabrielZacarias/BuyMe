CREATE DATABASE  IF NOT EXISTS `BuyMe`;
USE `BuyMe`;

DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `auction`;
DROP TABLE IF EXISTS `bids_on`;
DROP TABLE IF EXISTS `item`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `interested_in`;

CREATE TABLE `users` (
  `email` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `isAdmin` tinyint DEFAULT '0',
  `isRep` tinyint DEFAULT '0',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB;

CREATE TABLE `auction` (
  `auction_id` INT NOT NULL,
  `auction_title` varchar(30) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `increment` float8 NOT NULL,
  `auction_description` varchar(50) DEFAULT NULL,
  `min_sale_price` float8,
  `email` varchar(30) NOT NULL,
  `item_id` INT NOT NULL,
  PRIMARY KEY (`auction_id`),
  FOREIGN KEY (`email`) REFERENCES users(`email`) ON DELETE CASCADE,
  FOREIGN KEY (`item_id`) REFERENCES item(`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `bids_on` (
  `auction_id` INT NOT NULL,
  `email` varchar(30) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `amount` float8 NOT NULL,
  `is_automatic` tinyint DEFAULT '0',
  `auto_bid_max` float8 NOT NULL,
  `did_win` tinyint DEFAULT '0',
  PRIMARY KEY (`auction_id`, `email`, `time_stamp`),
  FOREIGN KEY (`auction_id`) REFERENCES auction(`auction_id`) ON DELETE CASCADE,
  FOREIGN KEY (`email`) REFERENCES users(`email`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `item` (
  `item_id` INT NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  FOREIGN KEY (`name`) REFERENCES category(`name`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `category` (
  `name` varchar(30) NOT NULL,
  `subcategory_of` varchar(30) NOT NULL,
  PRIMARY KEY (`name`),
  FOREIGN KEY (`subcategory_of`) REFERENCES category(`name`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `interested_in` (
  `category_name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`category_name`, `email`),
  FOREIGN KEY (`category_name`) REFERENCES category(`name`) ON DELETE CASCADE,
   FOREIGN KEY (`email`) REFERENCES users(`email`) ON DELETE CASCADE
) ENGINE=InnoDB;


-- LOCK TABLES `users` WRITE;
-- INSERT INTO `users` VALUES ('admin@buyme','password','Admin Name','123 Ban Hammer Dr. Mod Town, NJ 07123',1,0),('null@name','password',NULL,'address',0,0),('rep@buyme','password','Reps Name','123 Helpful Rd. Custie Town, NJ 07567',0,1),('seth@test','password','Seth','123 Home',0,0);
-- UNLOCK TABLES;

-- select * from auction;