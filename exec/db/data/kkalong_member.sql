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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_seq` int NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `member_nickname` varchar(20) NOT NULL COMMENT '닉네임',
  `member_id` varchar(20) NOT NULL COMMENT '아이디',
  `member_pw` varchar(100) NOT NULL COMMENT '비밀번호',
  `member_mail` varchar(40) NOT NULL COMMENT '이메일',
  `member_phone` varchar(11) DEFAULT NULL COMMENT '전화번호',
  `member_gender` char(1) DEFAULT NULL COMMENT '성별(M-남자, F - 여자)',
  `member_birth_year` smallint DEFAULT NULL COMMENT '생년',
  `member_reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '회원가입 일시',
  `is_member_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '회원 탈퇴 여부',
  `member_withdrawn_date` datetime DEFAULT NULL COMMENT '탈퇴일',
  PRIMARY KEY (`member_seq`),
  UNIQUE KEY `member_id_UNIQUE` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (20,'가가~~','string','$2a$10$gV2VOpZoKFUlcNiGY4hPDuZ8wSNnbHYdyhMpa1GLRW3UeqDYwxbgC','string','','\0',0,'2023-11-01 16:26:48',0,NULL),(21,'string123','asd123','$2a$10$6Om.F0Emp3OhXBOpOfiJnOoWYMOTPpW74D7O9aczgFyxcURiL7QYO','string@ssafy.com','','',0,'2023-11-02 13:53:52',0,NULL),(23,'test123','string123','$2a$10$E4REUFy7oejleVW6jiRX/ep9.aJ2DKqOFKEiYyctI5DQgbzlWnBke','string@ssafy.com','','',0,'2023-11-02 15:05:05',0,NULL),(24,'ssafy1','ssafy1','$2a$10$T0cwQJIFcPgVun1PTLN0Xe4S1mP0YHImJ6c3dLHIPmmhDyKWfx/u6','ssafy1@ssafy.com','','\0',0,'2023-11-03 14:31:27',0,NULL),(25,'_','ssafy123456','$2a$10$FJg6aVmQkb3c7bcQSkzldubfBv5zf8dN9buE4xsanaVhWegAdFxAa','string@naber.com','01045674567','F',2023,'2023-11-03 16:08:15',1,'2023-11-03 17:42:33'),(26,'건들지마세요','dahaetest0','$2a$10$5ogUC6Pfoy.B8oP8/3h7kuhZsho0qeqb.7CeBrp3Y144dDGYR/3ce','dahaetest0@ssafy.com','','\0',0,'2023-11-04 15:50:20',0,NULL),(27,'dtest1','dtest123456','$2a$10$14T1sg4GmkPphs9UthwhOuOIbBJm/uOYWV25syygAJdGBCR21Cx4G','string@ssafy.com','','\0',0,'2023-11-04 16:31:30',0,NULL),(28,'dtest2','2dtest123456','$2a$10$IpN5r.f4bDUekohSSo/cEup8VskUMefb.h5qEQY2EzkETtrW59nEm','string@ssafy.com','','\0',0,'2023-11-04 16:31:50',0,NULL),(29,'dtest3','3dtest123456','$2a$10$NQ4GU4kdjiYZuAei52kTG.ukpjPuC3UKuHspZo.2tEnbec.2KvnNq','string@ssafy.com','','\0',0,'2023-11-04 16:32:02',0,NULL),(30,'씅수신다','ssafy','$2a$10$RAWgbvYyPzf4F3.kN6y8IeLBKMcq0pPzyIWHbX9.MqcbQMVureGS2','tsmich@naver.com','01080245688','M',2000,'2023-11-07 10:50:14',0,NULL),(31,'ssafy12','ssafy12','$2a$10$I2Pw5vCT2uX1Ga5H7/IiwOn0h0.NmOCWkeakEUcdURE2iEREmtTxu','ssafy12@gmail.com','','\0',0,'2023-11-08 14:19:30',0,NULL),(32,'ssafy11','ssafy11','$2a$10$xCCtmngblP/UjobbJ629S.FVx6oo3O8UEExJ.CdqgndYg/690msrK','ssafy11@gmail.com','','\0',0,'2023-11-08 14:55:17',0,NULL),(33,'ssafy13','ssafy13','$2a$10$y3xqps7Nr2Qyg9tNuhWcdOTxJWbt4rl4011WhgBCTZzHz90rB5Gay','ssafy13@gmail.com','','\0',0,'2023-11-08 15:03:37',0,NULL),(34,'ssafy14','ssafy14','$2a$10$sbmsKaiXQMM7K4rVecah9urMr2JIDpcgjx8iHNW2o2PjQNqtvNUiu','ssafy14@gmail.com','','\0',0,'2023-11-08 15:05:41',0,NULL),(35,'황도복수아','ssafy15','$2a$10$QixXlZ6tUo49q46e4oPwYutOARY75NYbY1p/ViIC.5UOy4NWygm9a','ssafy15@gmail.com','','\0',0,'2023-11-08 15:06:54',0,NULL),(36,'양!수완지구','ssafy16','$2a$10$/iome52z9OFu8pV4Rfr7f.7Hp3Daxym.WoHi/bUfOjFVMasbZptgi','ssafy16@gmail.com','','\0',0,'2023-11-08 15:09:06',0,NULL),(37,'김승 영 촤!','ssafy17','$2a$10$bDi46vMTeb0fZ5nl7FGnZeQygebOBwWq4KTut/ONB7.DFcTZ58SqC','ssafy17@gmail.com','','\0',0,'2023-11-08 15:51:14',0,NULL),(38,'이승퉤','ssafy18','$2a$10$h07C3ZiRzDMTumUldjLi1.CzHJ22Cp2CfE4j9osKYO7i9ZfA0zMSu','ssafy18@gmail.com','','\0',0,'2023-11-08 15:52:18',0,NULL),(39,'Tmddk','ssaff','$2a$10$3ZvhCSlsuh7ecAZnuxhxJ.3kfgE2gLgLNVmO.TS1wEx7eEkSfytTS','sdfs@naver.com','','\0',0,'2023-11-08 16:12:40',0,NULL),(40,'ssafy20','ssafy20','$2a$10$P4uVfMrgWGvTnG9nso5YWOP3z.03yhJN6pKDjx.iikYZm27P4dkDK','ssafy20@gmail.com','','\0',0,'2023-11-09 09:45:47',0,NULL),(41,'ssafy21','ssafy21','$2a$10$Wp5jTKNQRAhuzJsUsSLsI.wB9QjbYingNEzPQY70.2WcWhA1CgPDe','ssafy21@gmail.com','','\0',0,'2023-11-09 09:46:53',0,NULL),(42,'ssafy22','ssafy22','$2a$10$4MaJdDrpW7yPh.MGGnUbQuWvLPrWgOiw79e5daVOFVofanmauj3VO','ssafy22@gmail.com','','\0',0,'2023-11-09 09:52:16',0,NULL),(43,'스수','ssafy0','$2a$10$MFnoryhjo0t8PQHATWgS6OJYmlqHiTZO6NjmkgzlOCmPjrDdtwBOW','sjdj@naver.com','','\0',0,'2023-11-09 09:58:30',0,NULL),(44,'ssafy23','ssafy23','$2a$10$AUhT.DTrYDYCZVK7DKIsMOMTqJDaOmCVTT2ZAyK2GnNjqGphD9.0K','ssafy23@gmail.com','','\0',0,'2023-11-09 10:10:39',0,NULL),(45,'ssafy24','ssafy24','$2a$10$FfziFsRjZeh58g04e4s46OYzIkqd.l44MayNoWdRzoz2l/unayXwa','ssafy24@gmail.com','','\0',0,'2023-11-09 10:28:15',0,NULL),(46,'_','ssafy30','$2a$10$Fr7IqdqUxniPfaBgwuClre/r8/tNjacCoSbGuGbbnqwnLVbpI0yaK','ssafy30@gmail.com','','\0',0,'2023-11-09 13:58:01',1,'2023-11-09 14:25:24'),(47,'_','ssafy32','$2a$10$v7ue12kZUkLYyqDosHTn6uEWUpnjJmyaGp8PRj8YDMwp74LdufNEy','ssafy32@gmail.com','','\0',0,'2023-11-09 14:34:15',1,'2023-11-09 14:35:01'),(54,'_','ssafy333','$2a$10$WFi89ldZxm0MTketU03vquz8DhLKGTIDnOlYnmgzIBPwLAKJOyfbO','ssafy333@gmail.com','','\0',0,'2023-11-12 15:36:14',1,'2023-11-16 11:45:06'),(55,'ssafy334','ssafy334','$2a$10$st1ZCZovyjcIa6.MOrkcI.D.xPoGA6s2r2T7MQjDUYrlFw0CaKrFK','ssafy334@gmail.com','','\0',0,'2023-11-12 15:39:44',0,NULL),(56,'깔롱','kkalong105','$2a$10$mzmR2GMkpMgPYg6NasfSjONb9jM0hN7jRTOU0pU9tLTnA9C9uqhoK','kkalong105@gmail.com','','\0',0,'2023-11-14 10:25:06',0,NULL),(57,'승수','ssafy00','$2a$10$QKT7DTzgbkkN8arUcy.4COq8tR04UQLdayN8YsYxnZFVHe22yMmKm','djdd@nabe.com','','\0',0,'2023-11-14 11:17:16',0,NULL),(58,'원스토어','onestore1','$2a$10$xmiimNvHqy.gcnSWmKIKhe557SbwHLFj6rO7pOFu2uSRgG4vAAYzy','onestore9818@gmail.com','','\0',0,'2023-11-14 17:41:04',0,NULL),(59,'원스토오','onestore2','$2a$10$0uIED9OrDMzWisJFrgtf7OpD9bWzZ1O0OEnDsRKPGQc8Ak3B9LxP6','onestore9818@gmail.com','','\0',0,'2023-11-15 13:32:21',0,NULL),(60,'ddffgghh','ddffgghh','$2a$10$HHrnyr3FYUJP9w/n64uk0egeNhWRCs3qM68YqYBjG3vemTvLqN3fW','ddffgghh@bbb.com','','\0',0,'2023-11-15 14:57:33',0,NULL),(61,'강신데렐라','test1234','$2a$10$HBsLnEsDqFuJKK8VaHO/8OI9yesuXM0AgBpDV.ITHn7jEEnGJJnE2','bs007bsk@naver.com','01068645850','M',1997,'2023-11-15 16:56:38',0,NULL),(62,'asd','asdf1234','$2a$10$WKISKs56Xkd71FhbTTIzketv5dRuE4q5QN648rZghTsBkWEPiqmP6','aaa@ss.com','01010103131','\0',0,'2023-11-16 10:12:55',0,NULL),(63,'_','testtest','$2a$10$7I9ef.f2cB/YIE2ziSn4xORRHfEAIxHkB0pp3cv3lA0a88PpQNRDC','mstkang@gmail.com','','\0',0,'2023-11-16 10:36:05',1,'2023-11-16 10:40:23'),(77,'강컨','testtest1','$2a$10$a.e/r1AtulkGYea2HqZYt.2CWUvzL9AieapbKeZec2gsMhMsn2sA6','mstkang@gmail.com','','\0',0,'2023-11-16 10:49:08',0,NULL),(78,'_','zxczxc123','$2a$10$so1.B2GNN8hjZ.XSwwFyI.2rJaLB4RAJT6XoENBakzw6ZzxALkrxy','zxczxc123@ssafy.com','','M',0,'2023-11-16 11:31:09',1,'2023-11-16 11:31:58'),(79,'김싸피','qwer1234','$2a$10$DLnmWXYbD4i398k6La5DPOa3xRLCP49Vyh9arbii929m8u7MdEOf.','qwer1234@ssafy.com','','\0',0,'2023-11-16 11:34:01',0,NULL),(80,'ssafy44','ssafy44','$2a$10$bLiu7cQuvawS1PNOkQXZM.kik0RX6NOKluIqrSHocfE4RPSZ1GqUO','ssafy44@gmail.com','01012341234','F',1990,'2023-11-16 12:07:02',0,NULL),(81,'ssafy45','ssafy45','$2a$10$GbxzaaHTWdJqlwoYLbNYoe2PZ0Ki.I1F079F0CoRNw5et7wX3vHrq','ssafy45@gmail.com','01012341234','\0',0,'2023-11-16 12:08:01',0,NULL),(82,'ssafy46','ssafy46','$2a$10$Qw0pqsxtye23MPkAIRyOW.GgIxm.HZM2t1U6TYZA9dOWL5wGmH7.y','ssafy46@gmail.com','01012341234','\0',1990,'2023-11-16 12:09:00',0,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-17 10:00:39
