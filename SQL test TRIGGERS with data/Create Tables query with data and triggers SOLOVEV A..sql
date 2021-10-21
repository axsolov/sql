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
-- Table structure for table `shop1`
--

DROP TABLE IF EXISTS `shop1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop1` (
  `ShopID` int NOT NULL,
  `GoodsID` int NOT NULL,
  `Price` float NOT NULL,
  `UpdateDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ShopID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop1`
--

LOCK TABLES `shop1` WRITE;
/*!40000 ALTER TABLE `shop1` DISABLE KEYS */;
INSERT INTO `shop1` VALUES (2,3,23,'2021-08-25 11:32:27'),(3,4,33.08,'2021-08-25 11:32:27');
/*!40000 ALTER TABLE `shop1` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_shop1_price_insert` AFTER INSERT ON `shop1` FOR EACH ROW BEGIN 
	CASE WHEN NEW.ShopID NOT IN (SELECT ShopID FROM shopglobal) THEN
	INSERT INTO shopglobal values (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP, 'shop1');
    ELSE 
    BEGIN
    END;
END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_shop1_price_update` AFTER UPDATE ON `shop1` FOR EACH ROW BEGIN 
	CASE 
		WHEN 
			NEW.ShopID IN (SELECT ShopID FROM shopglobal) AND NEW.Price <> (SELECT Price FROM shopglobal WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shopglobal SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
		ELSE 
			BEGIN
			END;
	END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_shop1_price_delete` AFTER DELETE ON `shop1` FOR EACH ROW BEGIN 
	CASE 
			WHEN 
				OLD.ShopID IN (SELECT ShopID
				FROM shopglobal
				WHERE ShopID)
			THEN
        DELETE FROM shopglobal WHERE ShopID IN (OLD.ShopID);
        ELSE
			BEGIN
			END;
END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shop2`
--

DROP TABLE IF EXISTS `shop2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop2` (
  `ShopID` int NOT NULL,
  `GoodsID` int NOT NULL,
  `Price` float NOT NULL,
  `UpdateDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ShopID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop2`
--

LOCK TABLES `shop2` WRITE;
/*!40000 ALTER TABLE `shop2` DISABLE KEYS */;
INSERT INTO `shop2` VALUES (1,1,12.53,'2021-08-25 11:32:27'),(4,2,25.7,'2021-08-25 11:32:27'),(5,5,33,'2021-08-25 11:32:27');
/*!40000 ALTER TABLE `shop2` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_shop2_price_insert` AFTER INSERT ON `shop2` FOR EACH ROW BEGIN 
	CASE 
		WHEN 
			NEW.ShopID NOT IN (SELECT ShopID FROM shopglobal) 
		THEN
			INSERT INTO shopglobal values (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP, 'shop2');
	ELSE 
		BEGIN
		END;
	END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_shop2_price_update` AFTER UPDATE ON `shop2` FOR EACH ROW BEGIN 
	CASE 
		WHEN 
			NEW.ShopID IN (SELECT ShopID FROM shopglobal) AND NEW.Price <> (SELECT Price FROM shopglobal WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shopglobal SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
		ELSE 
			BEGIN
			END;
	END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_shop2_price_delete` AFTER DELETE ON `shop2` FOR EACH ROW BEGIN 
	CASE 
			WHEN 
				OLD.ShopID IN (SELECT ShopID
				FROM shopglobal
				WHERE ShopID)
			THEN
        DELETE FROM shopglobal WHERE ShopID IN (OLD.ShopID);
        ELSE
			BEGIN
			END;
END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shopglobal`
--

DROP TABLE IF EXISTS `shopglobal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopglobal` (
  `ShopID` int NOT NULL,
  `GoodsID` int NOT NULL,
  `Price` float NOT NULL,
  `UpdateDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Region` varchar(5) NOT NULL,
  PRIMARY KEY (`ShopID`),
  UNIQUE KEY `GoodsID` (`GoodsID`),
  CONSTRAINT `chk_shop` CHECK ((`Region` in (_utf8mb4'Shop1',_utf8mb4'Shop2')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopglobal`
--

LOCK TABLES `shopglobal` WRITE;
/*!40000 ALTER TABLE `shopglobal` DISABLE KEYS */;
INSERT INTO `shopglobal` VALUES (1,1,12.53,'2021-08-25 11:32:27','shop2'),(2,3,23,'2021-08-25 11:32:27','shop1'),(3,4,33.08,'2021-08-25 11:32:27','shop1'),(4,2,25.7,'2021-08-25 11:32:27','shop2'),(5,5,33,'2021-08-25 11:32:27','shop2');
/*!40000 ALTER TABLE `shopglobal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_global_price_insert` AFTER INSERT ON `shopglobal` FOR EACH ROW BEGIN
	CASE 
		WHEN 
			NEW.Region = 'Shop1' AND NEW.ShopID NOT IN (SELECT ShopID FROM shop1) 
        THEN
			INSERT INTO shop1 (ShopID, GoodsID, Price, UpdateDateTime)
				VALUES (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP);
				
		WHEN 
			  NEW.Region = 'Shop2' AND NEW.ShopID NOT IN (SELECT ShopID FROM shop2)
		THEN
			INSERT INTO shop2 (ShopID, GoodsID, Price, UpdateDateTime)
				VALUES (NEW.ShopID, NEW.GoodsID, NEW.Price, CURRENT_TIMESTAMP);
	ELSE
		BEGIN
		END;
    END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_global_price_update` AFTER UPDATE ON `shopglobal` FOR EACH ROW BEGIN
	CASE 
		WHEN 
			NEW.region = 'shop1' AND NEW.Price <> (SELECT Price FROM shop1 WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shop1 SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
            UPDATE shopglobal SET UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
    	WHEN 
			NEW.region = 'shop2' AND NEW.Price <> (SELECT Price FROM shop2 WHERE ShopID = NEW.ShopID)
		THEN
			UPDATE shop2 SET Price = NEW.Price, UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
			UPDATE shopglobal SET UpdateDateTime = CURRENT_TIMESTAMP WHERE ShopID = NEW.ShopID;
        ELSE
			BEGIN
			END;
	END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_global_price_delete` AFTER DELETE ON `shopglobal` FOR EACH ROW BEGIN
	Case when OLD.region = 'shop1' AND OLD.ShopID IN (Select shopid from shop1) THEN
		DELETE FROM shop1 WHERE ShopID = OLD.ShopID; 
    	when OLD.region = 'shop2' AND OLD.ShopID IN (Select shopid from shop2) THEN
		DELETE FROM shop2 WHERE ShopID = OLD.ShopID; 
        ELSE
        BEGIN
        END;
	END Case;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'test'
--
/*!50003 DROP PROCEDURE IF EXISTS `ShopsSyncProced` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShopsSyncProced`()
BEGIN
	CASE 
		WHEN 
			EXISTS(SELECT ShopID FROM shop_history WHERE Operation IN ('D1','D2')) 
				THEN
			DELETE FROM shopglobal WHERE ShopID IN (SELECT ShopID FROM shop_history WHERE Operation IN ('D1','D2'));
			
			DELETE FROM shop_history WHERE Operation IN ('D1','D2');
		When 
			EXISTS(SELECT ShopID FROM shop_history WHERE Operation ='I1') 
				THEN
			INSERT INTO shopglobal (ShopID, GoodsID, Price, UpdateDateTime, Region) 
			SELECT ShopID, GoodsID, Price, UpdateDateTime, 'Shop1' FROM shop_history WHERE Operation ='I1';
			
			DELETE FROM shop_history WHERE Operation = 'I1';
		When 
			EXISTS(SELECT ShopID FROM shop_history WHERE Operation ='I2') 
				THEN
			INSERT INTO shopglobal (ShopID, GoodsID, Price, UpdateDateTime, Region) 
			SELECT ShopID, GoodsID, Price, UpdateDateTime, 'Shop2' FROM shop_history WHERE Operation ='I2';
			
			DELETE FROM shop_history WHERE Operation = 'I2';
		When 
			EXISTS(SELECT ShopID FROM shop_history WHERE Operation ='U1') 
				THEN
			UPDATE shopglobal  JOIN shop_history ON shop_history.ShopID = shopglobal.ShopID  
            SET shopglobal.Price = shop_history.Price WHERE Operation ='U1';
		
			DELETE FROM shop_history WHERE Operation ='U1';
		When 
			EXISTS(SELECT ShopID FROM shop_history WHERE Operation ='U2') 
				THEN
			UPDATE shopglobal  JOIN shop_history ON shop_history.ShopID = shopglobal.ShopID  
            SET shopglobal.Price = shop_history.Price WHERE Operation ='U2';
		
			DELETE FROM shop_history WHERE Operation ='U2';
    ELSE
			BEGIN
			END;
    END CASE; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-25 18:33:26
