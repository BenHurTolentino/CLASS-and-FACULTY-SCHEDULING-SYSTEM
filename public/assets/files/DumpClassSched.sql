-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dbclassscheduler
-- ------------------------------------------------------
-- Server version	5.7.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tblaccounts`
--

DROP TABLE IF EXISTS `tblaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblaccounts` (
  `strAccountID` varchar(10) NOT NULL,
  `strAccUsername` varchar(45) NOT NULL,
  `strAccPassword` varchar(45) NOT NULL,
  `strAFacultyID` varchar(15) NOT NULL,
  `enumAccType` enum('admin','user') NOT NULL,
  PRIMARY KEY (`strAccountID`),
  KEY `fk_tblaccounts_1_idx` (`strAFacultyID`),
  CONSTRAINT `fk_tblaccounts_1` FOREIGN KEY (`strAFacultyID`) REFERENCES `tblfaculty` (`strFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaccounts`
--

LOCK TABLES `tblaccounts` WRITE;
/*!40000 ALTER TABLE `tblaccounts` DISABLE KEYS */;
INSERT INTO `tblaccounts` VALUES ('S-0001-0','admin','123','FA-00001','admin');
/*!40000 ALTER TABLE `tblaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblclass`
--

DROP TABLE IF EXISTS `tblclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblclass` (
  `strClassID` varchar(10) NOT NULL,
  `strClassName` varchar(15) NOT NULL,
  PRIMARY KEY (`strClassID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblclass`
--

LOCK TABLES `tblclass` WRITE;
/*!40000 ALTER TABLE `tblclass` DISABLE KEYS */;
INSERT INTO `tblclass` VALUES ('CLS-001','BSIT 1-1');
/*!40000 ALTER TABLE `tblclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblclasssched`
--

DROP TABLE IF EXISTS `tblclasssched`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblclasssched` (
  `strClassSchedID` varchar(10) NOT NULL,
  `strCSRoomID` varchar(10) NOT NULL,
  `strCSSubjID` varchar(10) NOT NULL,
  `strCSFacultyID` varchar(15) NOT NULL,
  `strCSClassID` varchar(10) NOT NULL,
  `tmCSStart` time NOT NULL,
  `tmCSEnd` time NOT NULL,
  `enumCSDay` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL,
  `bolActive` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`strClassSchedID`),
  KEY `fk_rooms_idx` (`strCSRoomID`),
  KEY `fk_subject_idx` (`strCSSubjID`),
  KEY `fk_faculty_idx` (`strCSFacultyID`),
  KEY `fk_class_idx` (`strCSClassID`),
  CONSTRAINT `fk_class` FOREIGN KEY (`strCSClassID`) REFERENCES `tblclass` (`strClassID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_faculty` FOREIGN KEY (`strCSFacultyID`) REFERENCES `tblfaculty` (`strFacultyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rooms` FOREIGN KEY (`strCSRoomID`) REFERENCES `tblrooms` (`strRoomID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subjects` FOREIGN KEY (`strCSSubjID`) REFERENCES `tblsubjects` (`strSubjectID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblclasssched`
--

LOCK TABLES `tblclasssched` WRITE;
/*!40000 ALTER TABLE `tblclasssched` DISABLE KEYS */;
INSERT INTO `tblclasssched` VALUES ('CS-0001','R-0001','COMP-1013','FA-00001','CLS-001','07:30:00','10:30:00','monday',0);
/*!40000 ALTER TABLE `tblclasssched` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblemptype`
--

DROP TABLE IF EXISTS `tblemptype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblemptype` (
  `strEmpTypeID` varchar(10) NOT NULL,
  `strEmpTypeDesc` varchar(50) NOT NULL,
  PRIMARY KEY (`strEmpTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblemptype`
--

LOCK TABLES `tblemptype` WRITE;
/*!40000 ALTER TABLE `tblemptype` DISABLE KEYS */;
INSERT INTO `tblemptype` VALUES ('Emp-0001','Full Time'),('Emp-0002','Part Time');
/*!40000 ALTER TABLE `tblemptype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfaculty`
--

DROP TABLE IF EXISTS `tblfaculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblfaculty` (
  `strFacultyID` varchar(15) NOT NULL,
  `strFacultyFname` varchar(30) NOT NULL,
  `strFacultyMname` varchar(20) DEFAULT NULL,
  `strFacultyLname` varchar(30) NOT NULL,
  `strFEmpTypeID` varchar(10) NOT NULL,
  PRIMARY KEY (`strFacultyID`),
  UNIQUE KEY `strFacultyID_UNIQUE` (`strFacultyID`),
  KEY `fk_emptype_idx` (`strFEmpTypeID`),
  CONSTRAINT `fk_emptype` FOREIGN KEY (`strFEmpTypeID`) REFERENCES `tblemptype` (`strEmpTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfaculty`
--

LOCK TABLES `tblfaculty` WRITE;
/*!40000 ALTER TABLE `tblfaculty` DISABLE KEYS */;
INSERT INTO `tblfaculty` VALUES ('FA-00001','Ben','Grita','Tolentino','Emp-0001');
/*!40000 ALTER TABLE `tblfaculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblrooms`
--

DROP TABLE IF EXISTS `tblrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblrooms` (
  `strRoomID` varchar(10) NOT NULL,
  `strRoomName` varchar(45) NOT NULL,
  PRIMARY KEY (`strRoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblrooms`
--

LOCK TABLES `tblrooms` WRITE;
/*!40000 ALTER TABLE `tblrooms` DISABLE KEYS */;
INSERT INTO `tblrooms` VALUES ('R-0001','E-408');
/*!40000 ALTER TABLE `tblrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsubjects`
--

DROP TABLE IF EXISTS `tblsubjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsubjects` (
  `strSubjectID` varchar(10) NOT NULL,
  `strSubjectDesc` varchar(60) NOT NULL,
  `intSubjUnits` int(11) DEFAULT NULL,
  PRIMARY KEY (`strSubjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsubjects`
--

LOCK TABLES `tblsubjects` WRITE;
/*!40000 ALTER TABLE `tblsubjects` DISABLE KEYS */;
INSERT INTO `tblsubjects` VALUES ('COMP-1013','Programming 1',3);
/*!40000 ALTER TABLE `tblsubjects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-04 16:45:16
