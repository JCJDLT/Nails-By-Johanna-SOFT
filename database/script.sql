-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: nails_by_johanna
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `id_user` int NOT NULL,
  `id_state` int NOT NULL,
  `id_nails` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user_idx` (`id_user`),
  KEY `id_nails_idx` (`id_nails`),
  KEY `id_state_idx` (`id_state`),
  CONSTRAINT `id_nails` FOREIGN KEY (`id_nails`) REFERENCES `nails` (`id`),
  CONSTRAINT `id_state` FOREIGN KEY (`id_state`) REFERENCES `appointment_state` (`id`),
  CONSTRAINT `id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (61,'2023-04-13','12:00:00','13:59:00',1,2,1),(62,'2023-04-13','10:00:00','11:59:00',1,2,2),(63,'2023-04-13','10:00:00','11:59:00',53,2,2),(69,'2023-04-08','08:00:00','09:59:00',53,3,5),(71,'2023-04-04','16:00:00','17:59:00',53,3,2),(72,'2023-04-06','14:00:00','09:59:00',1,3,5),(74,'2023-04-06','16:00:00','19:59:00',53,2,3),(75,'2023-04-06','18:00:00','17:59:00',53,3,5),(76,'2023-04-08','16:00:00','17:59:00',53,3,1),(77,'2023-03-08','16:00:00','17:59:00',53,2,1),(78,'2023-03-08','16:00:00','17:59:00',53,3,1),(79,'2023-04-29','08:00:00','09:59:00',1,3,2),(80,'2023-04-26','08:00:00','09:59:00',53,3,3),(81,'2023-04-14','08:00:00','09:59:00',30,2,1),(82,'2023-04-14','18:00:00','19:59:00',30,2,4),(83,'2023-04-15','08:00:00','09:59:00',30,3,1),(84,'2023-04-15','18:00:00','19:59:00',30,3,5),(85,'2023-05-03','08:00:00','09:59:00',1,3,3),(86,'2023-04-05','08:00:00','09:59:00',1,3,3),(87,'2023-05-05','08:00:00','09:59:00',1,3,1),(88,'2023-05-08','16:00:00','17:59:00',1,3,1),(89,'2023-05-11','12:00:00','13:59:00',1,1,3),(90,'2023-05-12','08:00:00','09:59:00',1,1,1);
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_state`
--

DROP TABLE IF EXISTS `appointment_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `state` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_state`
--

LOCK TABLES `appointment_state` WRITE;
/*!40000 ALTER TABLE `appointment_state` DISABLE KEYS */;
INSERT INTO `appointment_state` VALUES (1,'pendiente'),(2,'realizada'),(3,'cancelada');
/*!40000 ALTER TABLE `appointment_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nails`
--

DROP TABLE IF EXISTS `nails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nails`
--

LOCK TABLES `nails` WRITE;
/*!40000 ALTER TABLE `nails` DISABLE KEYS */;
INSERT INTO `nails` VALUES (1,'polygel','80000'),(2,'acrilico','65000'),(3,'pressOn','70000'),(4,'semipermanente','50000'),(5,'tradicional','40000');
/*!40000 ALTER TABLE `nails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pqr`
--

DROP TABLE IF EXISTS `pqr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pqr` (
  `idpqr` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(240) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpqr`),
  KEY `id_user_idx` (`id_user`),
  CONSTRAINT `id_user_pqr` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pqr`
--

LOCK TABLES `pqr` WRITE;
/*!40000 ALTER TABLE `pqr` DISABLE KEYS */;
INSERT INTO `pqr` VALUES (1,'Tengo un problema al registrar la citaTengo un problema al registrar la citaTengo un problema al registrar la citaTengo un problema al registrar la citaTengo un problema al registrar la cita','revisada',1,'2023-04-13','Financiero'),(2,'A','revisada',30,'2023-04-13','Personal'),(3,'Esto es una prueba tecnica','revisada',1,'2023-05-04','tecnico'),(4,'Tengo un problema personal','revisada',6,'2023-05-04','Personal'),(5,'Problema personal PT','revisada',6,'2023-05-05','Personal'),(6,'Me deben plata','revisada',30,'2023-05-05','Financiero'),(7,'qqqqq','revisada',1,'2023-05-05','Financiero');
/*!40000 ALTER TABLE `pqr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('6YJCMW7stYLIPOhSSFj4ueyIa4ZJ40Ew',1683837852,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":1},\"flash\":{}}'),('7kcYs2NUYtz7zBGPCmo4dB_Lku63e_Qu',1683837920,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":1},\"flash\":{}}'),('_wqYO2g_ym0mC2i280eIdbM6fR9Cawg_',1683838334,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),('z1HYVf1JpogIV3kDl19r2y7tz608vxj_',1683838334,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  `id_rol` int NOT NULL,
  `phone` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  KEY `idRol_idx` (`id_rol`),
  CONSTRAINT `idRol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Juan Camilo Jaramillo De La Torre','jcjdlt@hotmail.com','$2a$10$aiExEu.gQG0wi9TLB5y1pOmOp33M9u3kkBeO0b.5/9kehZx5yyNuq',1,3107870502),(6,'Johanna De La Torre Rivera','johanna@gmail.com','$2a$10$zcCvRp5Ugvvrdp9dQbwWG.54l8TpNujZ.bFcYCr7XESgYnjyGDR.6',2,3107870501),(30,'maria jose','maria@gmail.com','$2a$10$aiExEu.gQG0wi9TLB5y1pOmOp33M9u3kkBeO0b.5/9kehZx5yyNuq',2,1233123212),(36,'Parra','parra@gmail.com','$2a$10$b6AdjuQ30Ic0Q/7qqJQWfOJ89IKovtqqLKvdLtsEbsb/S6MjZqkYu',2,1234345431),(38,'Emerson','emerson@gmail.com','$2a$10$K3Ta0Lavkh4CdgF1pJvGdunO9fBkrfdBvC/MmAwNPOYE5bu.rQnG2',2,1233212312),(53,'Prueba correo','prueba@hotmail.com','$2a$10$CIpcjt8a/mIzs.1.JaqL..A.pC3XPXmZPYxIMrcjAcc.CO/cltGbW',2,1232134565);
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

-- Dump completed on 2023-05-10 16:40:04