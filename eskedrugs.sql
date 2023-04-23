-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table esxeske.eske_drugzones
CREATE TABLE IF NOT EXISTS `eske_drugzones` (
  `zone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `owner` mediumtext NOT NULL,
  `gangs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table esxeske.eske_drugzones: ~89 rows (approximately)
INSERT INTO `eske_drugzones` (`zone`, `owner`, `gangs`) VALUES
	('AIRP', '', '{}'),
	('ALAMO', '', '{}'),
	('ALTA', '', '{}'),
	('ARMYB', '', '{}'),
	('BANHAMC', '', '{}'),
	('BANNING', '', '{}'),
	('BEACH', '', '{}'),
	('BHAMCA', '', '{}'),
	('BRADP', '', '{}'),
	('BRADT', '', '{}'),
	('BURTON', '', '{}'),
	('CALAFB', '', '{}'),
	('CANNY', '', '{}'),
	('CCREAK', '', '{}'),
	('CHAMH', '', '{}'),
	('CHIL', '', '{}'),
	('CHU', '', '{}'),
	('CMSW', '', '{}'),
	('CYPRE', '', '{}'),
	('DAVIS', '', '{}'),
	('DELBE', '', '{}'),
	('DELPE', '', '{}'),
	('DELSOL', '', '{}'),
	('DESRT', '', '{}'),
	('DOWNT', '', '{}'),
	('DTVINE', '', '{}'),
	('EAST_V', '', '{}'),
	('EBURO', '', '{}'),
	('ELGORL', '', '{}'),
	('ELYSIAN', '', '{}'),
	('GALFISH', '', '{}'),
	('GOLF', '', '{}'),
	('GRAPES', '', '{}'),
	('GREATC', '', '{}'),
	('HARMO', '', '{}'),
	('HAWICK', '', '{}'),
	('HORS', '', '{}'),
	('HUMLAB', '', '{}'),
	('JAIL', '', '{}'),
	('KOREAT', '', '{}'),
	('LACT', '', '{}'),
	('LAGO', '', '{}'),
	('LDAM', '', '{}'),
	('LEGSQU', '', '{}'),
	('LMESA', '', '{}'),
	('LOSPUER', '', '{}'),
	('MIRR', '', '{}'),
	('MORN', '', '{}'),
	('MOVIE', '', '{}'),
	('MITCHIL', '', '{}'),
	('MTGORDO', '', '{}'),
	('MTJOSE', '', '{}'),
	('MURRI', '', '{}'),
	('NCHU', '', '{}'),
	('NOOSE', '', '{}'),
	('OCEANA', '', '{}'),
	('PALCOV', '', '{}'),
	('PALETO', '', '{}'),
	('PALFOR', '', '{}'),
	('PALHIGH', '', '{}'),
	('PALMPOW', '', '{}'),
	('PBLUFF', '', '{}'),
	('PBOX', '', '{}'),
	('PROCOB', '', '{}'),
	('RANCHO', '', '{}'),
	('RGLEN', '', '{}'),
	('RICHM', '', '{}'),
	('ROCKF', '', '{}'),
	('RTRAK', '', '{}'),
	('SANAND', '', '{}'),
	('SANCHIA', '', '{}'),
	('SANDY', '', '{}'),
	('SKID', '', '{}'),
	('SLAB', '', '{}'),
	('STAD', '', '{}'),
	('STRAW', '', '{}'),
	('TATAMO', '', '{}'),
	('TERMINA', '', '{}'),
	('TEXTI', '', '{}'),
	('TONGVAH', '', '{}'),
	('TONGVAV', '', '{}'),
	('VCANA', '', '{}'),
	('VESP', '', '{}'),
	('VINE', '', '{}'),
	('WINDF', '', '{}'),
	('WVINE', '', '{}'),
	('ZANVUDO', '', '{}'),
	('ZP_ORT', '', '{}'),
	('ZP_UAR', '', '{}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
