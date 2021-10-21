-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: test
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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_age` tinyint NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,20,'2021-06-23 07:44:27'),(2,21,'2021-06-23 07:44:43'),(3,24,'2021-06-23 07:45:14'),(4,34,'2020-06-23 07:45:24'),(5,44,'2021-06-23 07:45:27'),(6,64,'2021-06-23 07:45:30'),(7,54,'2021-06-23 07:45:34'),(8,55,'2020-06-23 07:45:37'),(9,26,'2021-06-23 07:45:42'),(10,26,'2021-06-23 07:46:10'),(11,36,'2021-06-23 07:46:14'),(12,46,'2021-06-23 07:46:30'),(13,44,'2021-06-23 07:46:33'),(14,24,'2021-06-23 07:46:36'),(15,24,'2021-06-23 07:46:37'),(16,54,'2021-06-23 07:46:40'),(17,34,'2021-06-23 07:46:43');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_types`
--

DROP TABLE IF EXISTS `merchant_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_types` (
  `merchant_type_id` int NOT NULL AUTO_INCREMENT,
  `merchant_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`merchant_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_types`
--

LOCK TABLES `merchant_types` WRITE;
/*!40000 ALTER TABLE `merchant_types` DISABLE KEYS */;
INSERT INTO `merchant_types` VALUES (1,'Магазин'),(2,'АЗС'),(3,'ТЦ'),(4,'Онлайн');
/*!40000 ALTER TABLE `merchant_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchants`
--

DROP TABLE IF EXISTS `merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchants` (
  `merchant_id` int NOT NULL AUTO_INCREMENT,
  `merchant_region` varchar(255) DEFAULT NULL,
  `merchant_type_id` int NOT NULL,
  `create_dt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`merchant_id`),
  KEY `fk_merchants_merchant_types1_idx` (`merchant_type_id`),
  CONSTRAINT `fk_merchants_merchant_types1` FOREIGN KEY (`merchant_type_id`) REFERENCES `merchant_types` (`merchant_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchants`
--

LOCK TABLES `merchants` WRITE;
/*!40000 ALTER TABLE `merchants` DISABLE KEYS */;
INSERT INTO `merchants` VALUES (1,'Красноярский край',1,'2021-06-23 07:53:09'),(2,'Волгоград',2,'2020-06-23 07:53:09'),(3,'Воронеж',3,'2021-06-23 07:53:09'),(4,'Москва',4,'2021-06-23 07:53:09'),(5,'Питер',1,'2020-06-23 07:53:09'),(6,'Калуга',4,'2021-06-23 07:53:09');
/*!40000 ALTER TABLE `merchants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone2`
--

DROP TABLE IF EXISTS `phone2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone2`
--

LOCK TABLES `phone2` WRITE;
/*!40000 ALTER TABLE `phone2` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `rfm`
--

DROP TABLE IF EXISTS `rfm`;
/*!50001 DROP VIEW IF EXISTS `rfm`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rfm` AS SELECT 
 1 AS `customer_id`,
 1 AS `trans_value`,
 1 AS `count_t`,
 1 AS `max_trans`,
 1 AS `last_trans`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `st_tasks`
--

DROP TABLE IF EXISTS `st_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_tasks` (
  `key_id` int NOT NULL AUTO_INCREMENT,
  `assignee` int NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_tasks`
--

LOCK TABLES `st_tasks` WRITE;
/*!40000 ALTER TABLE `st_tasks` DISABLE KEYS */;
INSERT INTO `st_tasks` VALUES (1,3,'open','2021-05-06 17:00:00','2020-05-04 17:00:00'),(2,1,'open','2021-01-07 17:00:00','2021-01-04 17:00:00'),(3,2,'closed','2021-02-08 17:00:00','2021-02-04 17:00:00'),(4,2,'verifying','2021-06-04 17:00:00','2021-06-04 17:00:00'),(5,2,'open','2020-06-05 17:00:00','2020-06-04 17:00:00'),(6,1,'closed','2021-06-05 17:00:00','2021-06-04 17:00:00'),(7,3,'closed','2021-04-05 17:00:00','2021-04-04 17:00:00'),(8,3,'on support side','2021-06-04 17:00:00','2021-06-04 17:00:00'),(10,1,'open','2021-05-06 17:00:00','2021-01-06 17:00:00'),(11,1,'open','2021-02-14 17:00:00','2021-02-06 17:00:00');
/*!40000 ALTER TABLE `st_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_tasks2`
--

DROP TABLE IF EXISTS `st_tasks2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `st_tasks2` (
  `key_id` int NOT NULL,
  `assignee` int NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `upd` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_tasks2`
--

LOCK TABLES `st_tasks2` WRITE;
/*!40000 ALTER TABLE `st_tasks2` DISABLE KEYS */;
INSERT INTO `st_tasks2` VALUES (1,3,'open','2021-05-06 17:00:00','2020-05-04 17:00:00','2021-06-24 19:14:01'),(10,2,'open','2021-05-06 17:00:00','2021-01-06 17:00:00','2021-06-24 19:14:01');
/*!40000 ALTER TABLE `st_tasks2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transactions_id` int NOT NULL AUTO_INCREMENT,
  `merchant_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `transactions_sum` int DEFAULT NULL,
  `transactions_dttm` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transactions_id`),
  KEY `fk_transactions_customers_idx` (`customer_id`),
  KEY `fk_transactions_merchants1_idx` (`merchant_id`),
  CONSTRAINT `fk_transactions_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_transactions_merchants1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,1,500,'2020-06-23 07:56:38'),(2,2,4,600,'2020-06-23 07:56:38'),(3,3,2,400,'2020-11-23 07:56:38'),(4,4,6,500,'2021-06-23 07:56:38'),(5,5,4,200,'2020-06-23 07:56:38'),(6,6,3,100,'2021-02-23 07:56:38'),(7,4,6,1000,'2020-12-23 07:56:38'),(8,3,7,800,'2021-02-23 07:56:38'),(9,1,8,200,'2021-03-23 07:56:38'),(10,1,9,555,'2021-02-23 07:56:38'),(11,2,10,655,'2021-01-23 07:56:38'),(12,3,11,600,'2021-01-23 07:56:38'),(13,3,12,900,'2021-05-23 07:56:38'),(14,5,13,200,'2021-06-23 07:56:38'),(15,6,15,100,'2021-01-23 07:56:38'),(16,4,17,150,'2021-06-23 07:56:38'),(17,4,15,250,'2021-06-23 07:56:38'),(18,3,15,360,'2021-06-23 07:56:38'),(19,4,11,670,'2021-05-23 07:56:38'),(20,2,1,240,'2021-03-23 09:56:38'),(21,3,1,105,'2021-02-23 07:56:38'),(22,5,2,150,'2020-02-13 07:26:38'),(23,1,6,150,'2020-06-23 07:26:38'),(24,5,3,250,'2020-06-23 07:56:38'),(25,5,4,900,'2020-06-23 07:56:38');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `rfm`
--

/*!50001 DROP VIEW IF EXISTS `rfm`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rfm` AS select `a`.`customer_id` AS `customer_id`,sum(`a`.`transactions_sum`) AS `trans_value`,count(distinct `a`.`transactions_id`) AS `count_t`,`a`.`max_trans` AS `max_trans`,`a`.`last_trans` AS `last_trans` from (select `transactions`.`transactions_id` AS `transactions_id`,`transactions`.`merchant_id` AS `merchant_id`,`transactions`.`customer_id` AS `customer_id`,`transactions`.`transactions_sum` AS `transactions_sum`,`transactions`.`transactions_dttm` AS `transactions_dttm`,max(`transactions`.`transactions_dttm`) OVER (PARTITION BY `transactions`.`customer_id` )  AS `last_trans`,max(`transactions`.`transactions_sum`) OVER (PARTITION BY `transactions`.`customer_id` )  AS `max_trans` from `transactions`) `a` group by `a`.`customer_id` */;
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
