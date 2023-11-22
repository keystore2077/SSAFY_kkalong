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
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_seq` int NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `tag` varchar(40) NOT NULL COMMENT '태그명',
  PRIMARY KEY (`tag_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'string'),(2,'string1'),(3,'string2'),(4,'긴바지'),(5,'보라'),(6,'긴팔'),(7,'깔'),(8,'깔끔'),(9,'베이지'),(10,'ssafy'),(11,'티셔츠'),(12,'여름옷'),(13,'분홍'),(14,'ff'),(15,'dual'),(16,'d'),(17,'ppap'),(18,'hhh'),(19,'ssimo'),(20,'asdf'),(21,'sss'),(22,'asdfplz'),(23,'hkgcdplz'),(24,'dsag'),(25,'asfd'),(26,'asf'),(27,'fdsa'),(28,'ee'),(29,'dd'),(30,'vg'),(31,'cgg'),(32,'sg'),(33,'test1'),(34,'test2'),(35,'test3'),(36,'test4'),(37,'ㅣ'),(38,'ㅣㅣㅣ'),(39,'ㄱ'),(40,'sinuk'),(41,'test5'),(42,'청'),(43,'자켓'),(44,'봄옷'),(45,'가을'),(46,'겅정'),(47,'겨울'),(48,'반팔'),(49,'나시'),(50,'힌옷'),(51,'봄'),(52,'반팔 원피스'),(53,'갈'),(54,'흰색'),(55,'여름'),(56,'양말'),(57,'모자'),(58,'배낭'),(59,'베이직'),(60,'니트'),(61,'주황색'),(62,'맨투맨'),(63,'호랑이'),(64,'반팔 '),(65,'초록'),(66,'1'),(67,'가을옷'),(68,'ㅋ'),(69,'ㅃ');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 10:00:31
