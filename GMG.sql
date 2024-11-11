CREATE DATABASE  IF NOT EXISTS `gmg` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gmg`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: gmg
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int NOT NULL,
  `Nome` varchar(89) NOT NULL,
  `CPF` varchar(11) NOT NULL,
  `Idade` int NOT NULL,
  `RG` varchar(10) NOT NULL,
  `Nascimento` date NOT NULL,
  `EstadoCivil` varchar(20) NOT NULL,
  `Nacionalidade` varchar(20) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `idCliente_UNIQUE` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Matheus da Silva Santos','36596803899',20,'52319322','2004-03-09','Solteiro','Brasileiro'),(2,'Guilherme Dias','365121233',25,'52334552','2000-07-12','Casado','Brasileiro'),(3,'Gustavo Dias','523234173',21,'52334552','2001-07-12','Namorando','Brasileiro'),(4,'Junior Paes','52312123488',23,'5233455266','2002-06-22','Solteiro','Brasileiro');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contas` (
  `IDConta` int NOT NULL AUTO_INCREMENT,
  `Agencia` int NOT NULL,
  `Numero` varchar(45) NOT NULL,
  `TipoConta` varchar(45) NOT NULL,
  `Saldo` decimal(10,0) DEFAULT NULL,
  `DataAbertura` datetime NOT NULL,
  `TipoOperacao` varchar(25) DEFAULT NULL,
  `Conta_idCliente` int NOT NULL,
  PRIMARY KEY (`IDConta`),
  UNIQUE KEY `IDConta_UNIQUE` (`IDConta`),
  KEY `Cliente_idCliente_idx` (`Conta_idCliente`),
  CONSTRAINT `Conta_idCliente` FOREIGN KEY (`Conta_idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contas`
--

LOCK TABLES `contas` WRITE;
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
INSERT INTO `contas` VALUES (1,22,'2323','Salario',6190,'2024-11-09 00:00:00',NULL,1),(2,22,'5433','Salario',12870,'2024-11-09 00:00:00',NULL,2),(3,22,'8923','Poupanca',7100,'2024-11-09 00:00:00',NULL,3),(4,22,'5433','Poupanca',8100,'2024-11-09 00:00:00',NULL,2),(5,22,'8923','Poupanca',0,'2024-11-09 00:00:00',NULL,4);
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `PosDeposito` AFTER UPDATE ON `contas` FOR EACH ROW BEGIN
    IF NEW.TipoOperacao = 'deposito' THEN
        INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
        VALUES (NEW.Saldo - OLD.Saldo, NOW(), NEW.IDConta, NEW.IDConta, NEW.IDConta);
    END IF;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `PosSaque` AFTER UPDATE ON `contas` FOR EACH ROW BEGIN
    IF NEW.TipoOperacao = 'saque' THEN
        INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
        VALUES (OLD.Saldo - NEW.Saldo, NOW(), NEW.IDConta, NEW.IDConta, NEW.IDConta);
    END IF;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `SaldoNulo` AFTER UPDATE ON `contas` FOR EACH ROW BEGIN
    IF NEW.Saldo < OLD.Saldo THEN
        IF NEW.Saldo < 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente para realizar o saque';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `contato`
--

DROP TABLE IF EXISTS `contato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contato` (
  `idContato` int NOT NULL AUTO_INCREMENT,
  `Telefone` int NOT NULL,
  `Email` varchar(80) NOT NULL,
  `Contato_idCliente` int NOT NULL,
  PRIMARY KEY (`idContato`),
  UNIQUE KEY `idContato_UNIQUE` (`idContato`),
  KEY `Cliente_idCliente_idx` (`Contato_idCliente`),
  CONSTRAINT `Contato_idCliente` FOREIGN KEY (`Contato_idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contato`
--

LOCK TABLES `contato` WRITE;
/*!40000 ALTER TABLE `contato` DISABLE KEYS */;
/*!40000 ALTER TABLE `contato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimo` (
  `idEmprestimo` int NOT NULL AUTO_INCREMENT,
  `Valor` float NOT NULL,
  `DataEmp` datetime NOT NULL,
  `TaxaJuro` float DEFAULT NULL,
  `Emp_idConta` int NOT NULL,
  `Emp_idCliente` int NOT NULL,
  PRIMARY KEY (`idEmprestimo`),
  KEY `Emp_idConta_idx` (`Emp_idConta`),
  KEY `Emp_idCliente_idx` (`Emp_idCliente`),
  CONSTRAINT `Emp_idCliente` FOREIGN KEY (`Emp_idCliente`) REFERENCES `cliente` (`idCliente`),
  CONSTRAINT `Emp_idConta` FOREIGN KEY (`Emp_idConta`) REFERENCES `contas` (`IDConta`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
INSERT INTO `emprestimo` VALUES (1,5000,'2024-11-09 17:56:32',0.05,1,1),(2,5000,'2024-11-09 17:57:21',0.05,1,1),(3,2000,'2024-11-10 22:11:38',0.02,4,2),(4,2000,'2024-11-10 22:12:31',0.02,2,2),(5,2000,'2024-11-10 22:12:56',0.02,2,2),(6,2000,'2024-11-10 22:13:18',0.02,2,2),(7,2000,'2024-11-10 22:13:32',0.02,2,4),(8,2000,'2024-11-10 22:13:55',0.02,4,2),(9,2000,'2024-11-10 22:19:08',0.02,4,2),(10,2000,'2024-11-10 22:19:30',0.02,2,4),(11,2000,'2024-11-10 22:23:33',0.02,4,2);
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `IDEndereco` int NOT NULL AUTO_INCREMENT,
  `CEP` int NOT NULL,
  `Numero` int NOT NULL,
  `Rua` varchar(80) NOT NULL,
  `Bairro` varchar(80) NOT NULL,
  `Cidade` varchar(80) NOT NULL,
  `Estado` varchar(80) NOT NULL,
  `Complemento` varchar(45) NOT NULL,
  `Endereco_idCliente` int NOT NULL,
  PRIMARY KEY (`IDEndereco`),
  UNIQUE KEY `IDEndereco_UNIQUE` (`IDEndereco`),
  KEY `Cliente_idCliente_idx` (`Endereco_idCliente`),
  CONSTRAINT `Endereco_idCliente` FOREIGN KEY (`Endereco_idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicotran`
--

DROP TABLE IF EXISTS `historicotran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historicotran` (
  `idHistoricoTran` int NOT NULL AUTO_INCREMENT,
  `Data` datetime NOT NULL,
  `Hist_idConta` int NOT NULL,
  `Hist_idCliente` int NOT NULL,
  PRIMARY KEY (`idHistoricoTran`),
  UNIQUE KEY `idHistoricoTran_UNIQUE` (`idHistoricoTran`),
  KEY `Hist_idConta_idx` (`Hist_idConta`),
  KEY `Hist_idCliente_idx` (`Hist_idCliente`),
  CONSTRAINT `Hist_idCliente` FOREIGN KEY (`Hist_idCliente`) REFERENCES `cliente` (`idCliente`),
  CONSTRAINT `Hist_idConta` FOREIGN KEY (`Hist_idConta`) REFERENCES `contas` (`IDConta`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historicotran`
--

LOCK TABLES `historicotran` WRITE;
/*!40000 ALTER TABLE `historicotran` DISABLE KEYS */;
INSERT INTO `historicotran` VALUES (1,'2024-11-09 17:48:19',2,2),(2,'2024-11-09 17:49:07',1,1),(3,'2024-11-09 17:49:07',1,1),(4,'2024-11-09 17:56:32',1,1),(5,'2024-11-09 17:57:21',1,1),(6,'2024-11-10 18:15:36',1,1),(7,'2024-11-10 18:15:52',1,1),(8,'2024-11-10 18:18:59',1,1),(9,'2024-11-10 19:41:06',1,1),(10,'2024-11-10 19:46:02',1,1),(11,'2024-11-10 20:16:10',2,2),(12,'2024-11-10 20:23:11',1,1),(14,'2024-11-10 20:29:54',1,1),(15,'2024-11-10 20:32:44',1,1),(17,'2024-11-10 20:39:26',1,1),(18,'2024-11-10 20:42:01',2,2),(19,'2024-11-10 20:57:41',2,2),(20,'2024-11-10 20:58:12',2,2),(22,'2024-11-10 21:04:16',1,1),(23,'2024-11-10 21:37:43',4,4),(24,'2024-11-10 21:59:58',4,4);
/*!40000 ALTER TABLE `historicotran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacoes`
--

DROP TABLE IF EXISTS `transacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacoes` (
  `idTransacoes` int NOT NULL AUTO_INCREMENT,
  `ValorTransacao` float NOT NULL,
  `DataTransacao` datetime NOT NULL,
  `ContaOrigem` int NOT NULL,
  `ContaDestino` int NOT NULL,
  `Conta_idConta` int NOT NULL,
  PRIMARY KEY (`idTransacoes`),
  UNIQUE KEY `idTransacoes_UNIQUE` (`idTransacoes`),
  KEY `Conta_idConta_idx` (`Conta_idConta`),
  CONSTRAINT `Conta_idConta` FOREIGN KEY (`Conta_idConta`) REFERENCES `contas` (`IDConta`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacoes`
--

LOCK TABLES `transacoes` WRITE;
/*!40000 ALTER TABLE `transacoes` DISABLE KEYS */;
INSERT INTO `transacoes` VALUES (1,330,'2024-11-09 17:41:15',2,2,2),(2,330,'2024-11-09 17:41:17',2,2,2),(3,-300,'2024-11-09 17:41:49',1,1,1),(4,300,'2024-11-09 17:41:49',1,2,1),(5,330,'2024-11-09 17:48:19',2,2,2),(6,-300,'2024-11-09 17:49:07',1,1,1),(7,300,'2024-11-09 17:49:07',1,2,1),(8,5000,'2024-11-09 17:56:32',1,1,1),(9,5000,'2024-11-09 17:57:21',1,1,1),(10,500,'2024-11-10 18:15:36',1,1,1),(11,600,'2024-11-10 18:15:52',1,1,1),(12,400,'2024-11-10 18:18:59',1,2,1),(13,300,'2024-11-10 19:41:06',1,4,1),(14,300,'2024-11-10 19:46:02',1,3,1),(15,300,'2024-11-10 20:16:10',2,4,2),(16,2200,'2024-11-10 20:23:11',1,3,1),(18,2200,'2024-11-10 20:29:54',1,3,1),(19,3000,'2024-11-10 20:32:44',1,1,1),(21,2200,'2024-11-10 20:39:26',1,3,1),(22,330,'2024-11-10 20:42:01',2,2,2),(23,330,'2024-11-10 20:57:41',2,2,2),(24,300,'2024-11-10 20:58:12',2,2,2),(26,200,'2024-11-10 21:04:16',1,3,1),(27,0,'2024-11-10 21:37:43',4,4,4),(28,200,'2024-11-10 21:59:58',4,1,4);
/*!40000 ALTER TABLE `transacoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepoisDaTransacao` AFTER INSERT ON `transacoes` FOR EACH ROW BEGIN
    INSERT INTO HistoricoTran (Data, Hist_idConta, Hist_idCliente)
    VALUES (NEW.DataTransacao, NEW.ContaOrigem, NEW.Conta_idConta);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'gmg'
--
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarSaldo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarSaldo`(
    IN p_ContaID INT
)
BEGIN
    SELECT Saldo FROM Contas WHERE IDConta = p_ContaID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Depositar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Depositar`(
    IN p_ContaID INT,
    IN p_Valor DECIMAL(10,2)
)
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;
    UPDATE Contas
    SET Saldo = Saldo + p_Valor,
        TipoOperacao = 'deposito'
    WHERE IDConta = p_ContaID;
    COMMIT;
    
    UPDATE Contas
	SET TipoOperacao = NULL
	WHERE IDConta = p_ContaID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RealizarEmprestimo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RealizarEmprestimo`(
    IN p_ContaID INT,
    IN p_ClienteID INT,
    IN p_Valor DECIMAL(10,2),
    IN p_TaxaJuro FLOAT
)
BEGIN
    DECLARE p_DataEmp DATETIME;
    DECLARE p_ContaExists INT;
    DECLARE p_ClienteExists INT;
    DECLARE p_ProprietarioExists INT;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET p_DataEmp = NOW();

    START TRANSACTION;

    SELECT COUNT(*) INTO p_ContaExists FROM Contas WHERE IDConta = p_ContaID;

    SELECT COUNT(*) INTO p_ClienteExists FROM Cliente WHERE idCliente = p_ClienteID;

    SELECT COUNT(*) INTO p_ProprietarioExists FROM Contas WHERE IDConta = p_ContaID AND Conta_idCliente = p_ClienteID;

    IF p_ContaExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta inexistente';
    ELSEIF p_ClienteExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente inexistente';
    ELSEIF p_ProprietarioExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não é o proprietário da conta';
    ELSE
        INSERT INTO Emprestimo (Valor, DataEmp, TaxaJuro, Emp_idConta, Emp_idCliente)
        VALUES (p_Valor, p_DataEmp, p_TaxaJuro, p_ContaID, p_ClienteID);

        UPDATE Contas
        SET Saldo = Saldo + p_Valor
        WHERE IDConta = p_ContaID;

        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Sacar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sacar`(
    IN p_ContaID INT,
    IN p_Valor DECIMAL(10,2)
)
BEGIN
    DECLARE p_SaldoAtual DECIMAL(10,2);
    
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;
    SELECT Saldo INTO p_SaldoAtual FROM Contas WHERE IDConta = p_ContaID;

    IF p_SaldoAtual >= p_Valor THEN
        UPDATE Contas
        SET Saldo = Saldo - p_Valor,
            TipoOperacao = 'saque'
        WHERE IDConta = p_ContaID;
        COMMIT;
        
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;
    
    UPDATE Contas
	SET TipoOperacao = NULL
	WHERE IDConta = p_ContaID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Transferir` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transferir`(
    IN p_ContaOrigem INT,
    IN p_ContaDestino INT,
    IN p_Valor DECIMAL(10,2)
)
BEGIN
    DECLARE p_SaldoOrigem DECIMAL(10,2);
    DECLARE p_DataTransacao DATETIME;
    DECLARE p_ContaDestinoExists INT;

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    SET p_DataTransacao = NOW();

    START TRANSACTION;

    SELECT COUNT(*) INTO p_ContaDestinoExists FROM Contas WHERE IDConta = p_ContaDestino;
    
    IF p_ContaDestinoExists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Conta inexistente';
    ELSE

        SELECT Saldo INTO p_SaldoOrigem FROM Contas WHERE IDConta = p_ContaOrigem;

        IF p_SaldoOrigem >= p_Valor THEN

            UPDATE Contas
            SET Saldo = Saldo - p_Valor
            WHERE IDConta = p_ContaOrigem;

            UPDATE Contas
            SET Saldo = Saldo + p_Valor
            WHERE IDConta = p_ContaDestino;

            INSERT INTO Transacoes (ValorTransacao, DataTransacao, ContaOrigem, ContaDestino, Conta_idConta)
            VALUES (p_Valor, p_DataTransacao, p_ContaOrigem, p_ContaDestino, p_ContaOrigem);

        ELSE
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
        END IF;
    END IF;
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

-- Dump completed on 2024-11-10 22:34:13
