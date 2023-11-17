-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: k9c105.p.ssafy.io    Database: kkalong
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `chat_room`
--

DROP TABLE IF EXISTS `chat_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_room` (
  `chat_room_seq` int NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `chat_room_latest_log` varchar(100) DEFAULT NULL COMMENT '마지막 채팅 내용',
  `chat_room_latest_date` datetime DEFAULT NULL COMMENT '마지막 채팅 보낸 일시',
  `member_fir_seq` int NOT NULL COMMENT '채팅 요청한 사용자 인덱스',
  `member_sec_seq` int NOT NULL COMMENT '채팅 요청 받은 사용자 인덱스',
  PRIMARY KEY (`chat_room_seq`),
  KEY `FK_member_TO_chat_room_1` (`member_fir_seq`),
  KEY `FK_member_TO_chat_room_2` (`member_sec_seq`),
  CONSTRAINT `FK_member_TO_chat_room_1` FOREIGN KEY (`member_fir_seq`) REFERENCES `member` (`member_seq`),
  CONSTRAINT `FK_member_TO_chat_room_2` FOREIGN KEY (`member_sec_seq`) REFERENCES `member` (`member_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_room`
--

LOCK TABLES `chat_room` WRITE;
/*!40000 ALTER TABLE `chat_room` DISABLE KEYS */;
INSERT INTO `chat_room` VALUES (1,'','2023-11-13 16:30:57',28,41),(2,'','2023-11-13 16:46:31',28,42),(3,'','2023-11-14 11:09:52',28,30),(4,'','2023-11-14 16:12:39',26,27);
/*!40000 ALTER TABLE `chat_room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 10:00:38
