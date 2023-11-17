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
-- Table structure for table `fashion`
--

DROP TABLE IF EXISTS `fashion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fashion` (
  `fashion_seq` int NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `fashion_name` varchar(40) NOT NULL COMMENT '코디이름',
  `fashion_img_name` varchar(70) NOT NULL COMMENT '파일 이름 (fashion_소유자아이디_올린시간_무작위6자리난수.)',
  `is_ai` tinyint NOT NULL COMMENT '(1- ai사진, 0- 실제사진)',
  `fashion_reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '저장한 날짜',
  `is_fashion_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '삭제여부',
  `fashion_del_date` datetime DEFAULT NULL COMMENT '삭제 일시',
  `member_seq` int NOT NULL COMMENT '소유회원 인덱스',
  `is_fashion_private` tinyint(1) NOT NULL,
  PRIMARY KEY (`fashion_seq`),
  KEY `FK_member_TO_fashion_1` (`member_seq`),
  CONSTRAINT `FK_member_TO_fashion_1` FOREIGN KEY (`member_seq`) REFERENCES `member` (`member_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fashion`
--

LOCK TABLES `fashion` WRITE;
/*!40000 ALTER TABLE `fashion` DISABLE KEYS */;
INSERT INTO `fashion` VALUES (5,'테스트','fashion_dahaetest0_231105_144213_842105.jpg',1,'2023-11-05 14:42:14',0,NULL,26,1),(6,'테스트','fashion_dahaetest0_231105_152421_822820.jpg',1,'2023-11-05 15:24:21',0,NULL,26,1),(7,'테스트','fashion_dahaetest0_231105_170411_350486.jpg',1,'2023-11-05 17:04:12',0,NULL,26,1),(8,'테스트','fashion_dahaetest0_231105_170436_057376.jpg',1,'2023-11-05 17:04:37',0,NULL,26,0),(9,'테스트','fashion_dahaetest0_231105_170437_114798.jpg',1,'2023-11-05 17:04:38',0,NULL,26,0),(10,'테스트','fashion_dahaetest0_231105_144213_842105.jpg',1,'2023-11-10 02:37:59',0,NULL,30,0),(11,'테스트2','fashion_dahaetest0_231105_144213_842105.jpg',1,'2023-11-10 02:38:14',0,NULL,30,0),(12,'테스트3','fashion_dahaetest0_231105_144213_842105.jpg',1,'2023-11-10 02:38:15',0,NULL,30,1),(13,'테스트4','fashion_dahaetest0_231105_144213_842105.jpg',1,'2023-11-10 02:45:31',0,NULL,30,1),(14,'테스트5','fashion_dahaetest0_231105_144213_842105.jpg',1,'2023-11-10 02:45:33',0,NULL,30,1),(15,'가가','fashion_ssafy_231114_103236_373150',1,'2023-11-14 10:32:51',1,NULL,30,0),(16,'코디다','fashion_ssafy_231114_103512_637427',1,'2023-11-14 10:35:48',1,NULL,30,1),(17,'기기','fashion_ssafy_231114_103835_335743',1,'2023-11-14 10:38:46',1,NULL,30,0),(18,'코니','fashion_ssafy_231114_105046_481437',1,'2023-11-14 10:50:57',1,NULL,30,0),(19,'코니','fashion_ssafy_231114_105046_481437',1,'2023-11-14 10:51:24',1,NULL,30,0),(20,'공개','fashion_ssafy_231114_110808_291620',1,'2023-11-14 11:08:18',1,NULL,30,1),(21,'흑','fashion_ssafy_231114_111117_235269',1,'2023-11-14 11:11:23',1,NULL,30,0),(22,'dkdkdk','fashion_ssafy_231114_115134_634974.jpg',1,'2023-11-14 11:51:45',0,NULL,30,0),(23,'iii','fashion_ssafy_231114_140512_774238.jpg',1,'2023-11-14 14:05:21',0,NULL,30,1),(24,'qq','fashion_ssafy_231114_175034_984032.jpg',1,'2023-11-14 17:50:45',0,NULL,30,0),(25,'콬','fashion_ssafy_231115_170356_744763.jpg',1,'2023-11-15 17:04:05',0,NULL,30,0),(26,'이','fashion_ssafy_231115_170438_958827.jpg',1,'2023-11-15 17:04:45',0,NULL,30,1),(27,'oo','fashion_ssafy_231116_090829_095700.jpg',1,'2023-11-16 09:08:57',0,NULL,30,1),(28,'드','fashion_ssafy_231116_095132_522482.jpg',1,'2023-11-16 09:51:37',0,NULL,30,1),(29,'qqq','fashion_ssafy_231116_110116_797223.jpg',1,'2023-11-16 11:02:23',0,NULL,30,1),(30,'zhzh','fashion_ssafy_231116_112402_210721.jpg',1,'2023-11-16 11:24:52',0,NULL,30,1),(31,'이게뭐야','fashion_2dtest123456_231116_112406_401954.jpg',1,'2023-11-16 11:25:40',0,NULL,28,1),(32,'yyy','fashion_ssafy_231116_113355_781361.jpg',1,'2023-11-16 11:34:32',0,NULL,30,1),(33,'yyy','fashion_ssafy_231116_113355_781361.jpg',1,'2023-11-16 11:35:09',0,NULL,30,1),(34,'테스트','fashion_test1234_231116_115143_756022.jpg',1,'2023-11-16 11:51:54',1,'2023-11-16 07:41:40',61,0),(35,'디','fashion_ssafy_231116_121200_553040.jpg',1,'2023-11-16 12:12:55',0,NULL,30,1),(36,'기','fashion_ssafy_231116_121801_036857.jpg',1,'2023-11-16 12:18:06',0,NULL,30,1),(37,'기','fashion_ssafy_231116_130749_640244.jpg',1,'2023-11-16 13:07:55',0,NULL,30,1),(38,'그그','fashion_ssafy_231116_132245_904691.jpg',1,'2023-11-16 13:22:57',0,NULL,30,1),(39,'디','fashion_ssafy_231116_135101_956867.jpg',1,'2023-11-16 13:51:08',0,NULL,30,1),(40,'대','fashion_ssafy_231116_141653_450393.jpg',1,'2023-11-16 14:17:20',0,NULL,30,1),(41,'test1','fashion_test1234_231116_144907_646812.jpg',1,'2023-11-16 14:49:26',1,'2023-11-16 07:41:40',61,0),(42,'test1','fashion_test1234_231116_144938_354505.jpg',1,'2023-11-16 14:49:46',1,'2023-11-16 07:41:40',61,0),(43,'test1','fashion_test1234_231116_145107_615945.jpg',1,'2023-11-16 14:51:28',1,'2023-11-16 07:41:40',61,0),(44,'test1','fashion_test1234_231116_145215_484399.jpg',1,'2023-11-16 14:52:32',1,'2023-11-16 07:41:40',61,0),(45,'test1','fashion_test1234_231116_145357_068598.jpg',1,'2023-11-16 14:54:07',1,'2023-11-16 07:41:40',61,0),(46,'test1','fashion_test1234_231116_145453_284252.jpg',1,'2023-11-16 14:55:05',1,'2023-11-16 07:41:40',61,0),(47,'zzz','fashion_dahaetest0_231116_161910_630734.jpg',1,'2023-11-16 16:19:44',0,NULL,26,0),(48,'ppp','fashion_dahaetest0_231116_163310_529835.jpg',1,'2023-11-16 16:34:23',0,NULL,26,0),(49,'노란나시1','fashion_test1234_231116_163750_198396.jpg',1,'2023-11-16 16:38:03',0,NULL,61,0),(50,'노란나시2','fashion_test1234_231116_163836_790860.jpg',1,'2023-11-16 16:38:50',0,NULL,61,0),(51,'노란나시3','fashion_test1234_231116_163916_400374.jpg',1,'2023-11-16 16:39:27',0,NULL,61,0),(52,'노란나시4','fashion_test1234_231116_164203_329611.jpg',1,'2023-11-16 16:42:17',0,NULL,61,0),(53,'pperope','fashion_dahaetest0_231116_164312_114198.jpg',1,'2023-11-16 16:44:11',0,NULL,26,1),(54,'땡땡나시1','fashion_test1234_231116_164650_742143.jpg',1,'2023-11-16 16:47:10',0,NULL,61,0),(55,'땡땡나시2','fashion_test1234_231116_164731_015822.jpg',1,'2023-11-16 16:47:42',0,NULL,61,0),(56,'땡땡나시3','fashion_test1234_231116_164812_370067.jpg',1,'2023-11-16 16:48:26',0,NULL,61,0),(57,'땡땡나시4','fashion_test1234_231116_164846_870558.jpg',1,'2023-11-16 16:49:02',0,NULL,61,0),(58,'sdfsdf','fashion_dahaetest0_231116_171049_273247.jpg',1,'2023-11-16 17:23:31',0,NULL,26,1),(59,'zheltk','fashion_dahaetest0_231116_175028_804711.jpg',1,'2023-11-16 17:50:38',0,NULL,26,1),(60,'맨투맨 찰칵','fashion_kkalong105_231116_201905_565235.jpg',1,'2023-11-16 20:19:56',0,NULL,56,0),(61,'노랑노랑','fashion_kkalong105_231116_203149_952417.jpg',1,'2023-11-16 20:32:19',0,NULL,56,1),(62,'test','fashion_test1234_231116_211856_942549.jpg',1,'2023-11-16 21:19:17',0,NULL,61,1),(63,'짠','fashion_kkalong105_231117_090557_693800.jpg',1,'2023-11-17 09:06:29',0,NULL,56,1),(64,'땡땡이','fashion_kkalong105_231117_091309_613415.jpg',1,'2023-11-17 09:15:13',0,NULL,56,1),(65,'ᆢ','fashion_kkalong105_231117_093755_472152.jpg',1,'2023-11-17 09:39:04',0,NULL,56,1),(66,'x','fashion_onestore2_231117_095847_948077.jpg',1,'2023-11-17 09:58:56',0,NULL,59,0);
/*!40000 ALTER TABLE `fashion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 10:00:35
