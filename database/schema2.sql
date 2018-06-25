-- MySQL dump 10.16  Distrib 10.1.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: politwoops
-- ------------------------------------------------------
-- Server version	10.1.29-MariaDB-6

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `deleted_tweets`
--

DROP TABLE IF EXISTS `deleted_tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_tweets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `tweet` text,
  `politician_id` int(11) DEFAULT NULL,
  `retweeted_id` bigint(20) DEFAULT NULL,
  `retweeted_content` varchar(255) DEFAULT NULL,
  `retweeted_user_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_name` (`user_name`),
  KEY `deleted` (`deleted`),
  KEY `created` (`created`),
  KEY `modified` (`modified`)
) ENGINE=InnoDB AUTO_INCREMENT=1008773439518400513 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `politicians`
--

DROP TABLE IF EXISTS `politicians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `politicians` (
  `epid` int(10) unsigned DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `eugroup` varchar(32) DEFAULT NULL,
  `party` varchar(255) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `office` varchar(32) DEFAULT NULL,
  `committee` varchar(255) DEFAULT NULL,
  `substitute` varchar(255) DEFAULT NULL,
  `delegation` varchar(255) DEFAULT NULL,
  `screen_name` varchar(64) DEFAULT NULL,
  `tttpid` varchar(32) DEFAULT NULL,
  `since` date DEFAULT NULL,
  `twitter_id` bigint(20) unsigned DEFAULT NULL,
  `profile_image_url` varchar(200) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `followers_count` int(10) unsigned DEFAULT NULL,
  `friends_count` int(10) unsigned DEFAULT NULL,
  `statuses_count` int(10) unsigned DEFAULT NULL,
  `status` smallint(5) unsigned DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tweets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `tweet` text,
  `politician_id` int(11) DEFAULT NULL,
  `retweeted_id` bigint(20) DEFAULT NULL,
  `retweeted_content` varchar(255) DEFAULT NULL,
  `retweeted_user_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_name` (`user_name`),
  KEY `deleted` (`deleted`),
  KEY `created` (`created`),
  KEY `modified` (`modified`)
) ENGINE=InnoDB AUTO_INCREMENT=1008773439518400513 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-18 20:48:45
