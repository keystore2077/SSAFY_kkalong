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
-- Table structure for table `closet`
--

DROP TABLE IF EXISTS `closet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `closet` (
  `closet_seq` int NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `closet_name` varchar(40) NOT NULL COMMENT '옷장 이름',
  `closet_img_name` varchar(70) NOT NULL COMMENT '옷장 사진 파일 이름(closet_소유자아이디_올린시간_무작위난수6자리)',
  `closet_reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 날짜',
  `is_closet_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '삭제여부',
  `closet_del_date` datetime DEFAULT NULL COMMENT '삭제일시',
  `member_seq` int NOT NULL COMMENT '소유한 회원 인덱스',
  PRIMARY KEY (`closet_seq`),
  KEY `FK_member_TO_closet_1` (`member_seq`),
  CONSTRAINT `FK_member_TO_closet_1` FOREIGN KEY (`member_seq`) REFERENCES `member` (`member_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `closet`
--

LOCK TABLES `closet` WRITE;
/*!40000 ALTER TABLE `closet` DISABLE KEYS */;
INSERT INTO `closet` VALUES (1,'옷장태스트','태스트','2023-11-06 02:40:55',1,NULL,28),(2,'옷장태스트','string','2023-11-06 15:11:08',1,NULL,26),(10,'String','closet_3dtest123456_231106_215956_556060.jpg','2023-11-06 21:59:56',1,'2023-11-12 17:35:50',29),(11,'MyCloset','closet_3dtest123456_231108_114804_446254.png','2023-11-08 11:48:08',1,'2023-11-12 17:32:47',29),(12,'나만의 옷','closet_2dtest123456_231109_153912_770421.png','2023-11-09 15:39:16',0,NULL,28),(13,'movemovedd','closet_ssafy_231110_120004_218533.png','2023-11-10 12:00:08',1,'2023-11-16 15:53:40',30),(14,'옷장11','closet_3dtest123456_231110_171220_180101.png','2023-11-10 15:00:48',1,'2023-11-15 14:07:03',29),(15,'3류 듀얼리스트','closet_ssafy_231110_161423_185432.png','2023-11-10 16:14:26',1,'2023-11-16 15:55:11',30),(16,'승영아제','closet_3dtest123456_231113_093426_360576.png','2023-11-13 09:34:29',0,NULL,29),(17,'ddd','closet_2dtest123456_231113_105700_675340.png','2023-11-13 10:57:03',0,NULL,28),(18,'gd','closet_ssafy_231113_144622_265752.png','2023-11-13 14:46:25',1,'2023-11-13 15:55:09',30),(19,'gd','closet_ssafy_231113_155649_692370.png','2023-11-13 15:56:53',1,'2023-11-13 16:37:03',30),(20,'d','closet_ssafy_231113_171332_008209.png','2023-11-13 17:13:36',1,'2023-11-13 19:44:17',30),(21,'dd','closet_ssafy_231113_171414_425117.png','2023-11-13 17:14:17',1,'2023-11-13 17:16:38',30),(22,'kkk','closet_ssafy_231115_092309_569721.png','2023-11-15 09:23:12',1,'2023-11-16 10:43:20',30),(23,'dfgs','closet_ssafy_231115_093458_580114.png','2023-11-15 09:35:01',1,'2023-11-16 10:42:13',30),(24,'t n','closet_ssafy_231115_093529_505698.png','2023-11-15 09:35:32',1,'2023-11-16 10:42:09',30),(25,'rrrf','closet_ssafy_231115_095649_328687.png','2023-11-15 09:56:52',1,'2023-11-16 10:42:05',30),(26,'RRRR','closet_ssafy_231115_115047_275442.png','2023-11-15 11:50:50',1,'2023-11-16 10:42:00',30),(27,'셀프','closet_kkalong105_231115_135515_935635.png','2023-11-15 13:55:19',1,'2023-11-15 15:20:23',56),(28,'test옷장','closet_test1234_231115_165946_101702.png','2023-11-15 16:59:50',0,NULL,61),(29,'옷짱','closet_ssafy_231115_172959_622659.png','2023-11-15 17:30:07',0,NULL,30),(30,'1','closet_ssafy_231115_173021_620550.png','2023-11-15 17:30:24',1,'2023-11-16 10:41:55',30),(31,'1','closet_ssafy_231115_173034_124851.png','2023-11-15 17:30:41',1,'2023-11-16 11:25:20',30),(32,'테스트','closet_onestore2_231116_093205_937410.png','2023-11-16 09:32:17',0,NULL,59),(33,'테스트','closet_asdf1234_231116_101345_675807.png','2023-11-16 10:13:51',0,NULL,62),(34,'jlh','closet_ssafy_231116_104350_247976.png','2023-11-16 10:43:53',1,'2023-11-16 11:24:08',30),(35,'쥐옷장','closet_testtest1_231116_105149_522540.png','2023-11-16 10:51:57',0,NULL,77),(36,'강기','closet_testtest1_231116_105443_957854.png','2023-11-16 10:54:49',0,NULL,77),(37,'plz','closet_ssafy_231116_112425_704243.png','2023-11-16 11:24:28',1,'2023-11-16 11:25:04',30),(38,'gg','closet_ssafy_231116_112607_462028.png','2023-11-16 11:26:10',1,'2023-11-16 11:28:37',30),(39,'ang','closet_ssafy_231116_112902_006422.png','2023-11-16 11:29:05',1,'2023-11-16 15:43:38',30),(40,'1234t','closet_ssafy_231116_114547_973588.png','2023-11-16 11:45:50',1,'2023-11-16 15:50:40',30),(41,'옷 보관상자','closet_kkalong105_231116_151330_245823.png','2023-11-16 15:13:33',0,NULL,56),(42,'안방 수납장','closet_kkalong105_231116_151522_942969.png','2023-11-16 15:15:26',0,NULL,56),(43,'거실 옷장','closet_kkalong105_231116_151625_939631.png','2023-11-16 15:16:28',1,'2023-11-16 15:17:04',56),(44,'안방 옷장','closet_kkalong105_231116_151653_292047.png','2023-11-16 15:16:56',0,NULL,56),(45,'dasf','closet_ssafy_231116_155101_054166.png','2023-11-16 15:54:20',0,NULL,30),(46,'dasf','closet_ssafy_231116_155123_037567.png','2023-11-16 15:54:20',0,NULL,30),(47,'dasf','closet_ssafy_231116_155101_262605.png','2023-11-16 15:54:20',0,NULL,30),(48,'asd','closet_ssafy_231116_155238_706685.png','2023-11-16 15:54:20',0,NULL,30),(49,'옷장등록test','closet_test1234_231116_154849_661922.png','2023-11-16 15:54:20',1,'2023-11-16 17:01:45',61),(50,'지워도됨','closet_test1234_231116_154204_017345.png','2023-11-16 15:54:20',1,'2023-11-16 17:01:51',61),(51,'ㄱㄷㄱㄷㄱ','closet_kkalong105_231117_094715_687466.png','2023-11-17 09:47:23',0,NULL,56);
/*!40000 ALTER TABLE `closet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 10:00:36
