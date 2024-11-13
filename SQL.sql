-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for qbcoreframework_336051
CREATE DATABASE IF NOT EXISTS `qbcoreframework_336051` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `qbcoreframework_336051`;

-- Dumping structure for table qbcoreframework_336051.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.apartments: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.bank_accounts
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_balance` int(11) NOT NULL DEFAULT 0,
  `account_type` enum('shared','job','gang') NOT NULL,
  `users` longtext DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.bank_accounts: ~20 rows (approximately)
INSERT INTO `bank_accounts` (`id`, `citizenid`, `account_name`, `account_balance`, `account_type`, `users`) VALUES
	(1, NULL, 'mechanic2', 0, 'job', '[]'),
	(2, NULL, 'unemployed', 0, 'job', '[]'),
	(3, NULL, 'garbage', 0, 'job', '[]'),
	(4, NULL, 'lawyer', 0, 'job', '[]'),
	(5, NULL, 'bus', 0, 'job', '[]'),
	(6, NULL, 'taxi', 0, 'job', '[]'),
	(7, NULL, 'vineyard', 0, 'job', '[]'),
	(8, NULL, 'mechanic', 0, 'job', '[]'),
	(9, NULL, 'beeker', 0, 'job', '[]'),
	(10, NULL, 'police', 0, 'job', '[]'),
	(11, NULL, 'tow', 0, 'job', '[]'),
	(12, NULL, 'ambulance', 0, 'job', '[]'),
	(13, NULL, 'hotdog', 0, 'job', '[]'),
	(14, NULL, 'mechanic3', 0, 'job', '[]'),
	(15, NULL, 'reporter', 0, 'job', '[]'),
	(16, NULL, 'bennys', 0, 'job', '[]'),
	(17, NULL, 'realestate', 0, 'job', '[]'),
	(18, NULL, 'judge', 0, 'job', '[]'),
	(19, NULL, 'trucker', 0, 'job', '[]'),
	(20, NULL, 'cardealer', 0, 'job', '[]');

-- Dumping structure for table qbcoreframework_336051.bank_statements
CREATE TABLE IF NOT EXISTS `bank_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT 'checking',
  `amount` int(11) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `statement_type` enum('deposit','withdraw') DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.bank_statements: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.bans: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table qbcoreframework_336051.crypto: ~0 rows (approximately)
INSERT INTO `crypto` (`crypto`, `worth`, `history`) VALUES
	('qbit', 1020, '[{"NewWorth":1016,"PreviousWorth":1018},{"NewWorth":1016,"PreviousWorth":1018},{"NewWorth":1016,"PreviousWorth":1018},{"NewWorth":1020,"PreviousWorth":1016}]');

-- Dumping structure for table qbcoreframework_336051.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.crypto_transactions: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.dealers: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(1) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(4) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.houselocations: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` int(11) DEFAULT 1,
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.house_plants: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.inventories
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `items` longtext DEFAULT '[]',
  PRIMARY KEY (`identifier`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.inventories: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.lapraces: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.occasion_vehicles: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.ox_inventory
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table qbcoreframework_336051.ox_inventory: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.phone_gallery
CREATE TABLE IF NOT EXISTS `phone_gallery` (
  `citizenid` varchar(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.phone_gallery: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.phone_invoices: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.phone_messages: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `firstName` varchar(25) DEFAULT NULL,
  `lastName` varchar(25) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `url` text DEFAULT NULL,
  `picture` varchar(512) DEFAULT './img/default.png',
  `tweetId` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.phone_tweets: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.players: ~1 rows (approximately)
INSERT INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`) VALUES
	(1, 'HMK76260', 1, 'license:a045ed84bc7b147ab67442c4be4c70a4bb7d0ad5', 'DEV Dx', '{"bank":5000,"cash":500,"crypto":0}', '{"nationality":"Bangladesh","cid":1,"firstname":"Mr","lastname":"Dx","gender":0,"birthdate":"05/11/1991","account":"US08QBCore3024832454","phone":"2987770666"}', '{"label":"Civilian","name":"unemployed","payment":10,"isboss":false,"onduty":false,"type":"none","grade":{"name":"Freelancer","isboss":false,"level":0}}', '{"label":"No Gang","name":"none","isboss":false,"grade":{"name":"Unaffiliated","isboss":false,"level":0}}', '{"x":170.4791259765625,"y":-878.7296752929688,"z":30.5604248046875}', '{"hunger":70.59999999999998,"armor":0,"stress":0,"inside":{"apartment":[]},"tracker":false,"rep":[],"bloodtype":"B-","licences":{"business":false,"weapon":false,"driver":true},"injail":0,"ishandcuffed":false,"fingerprint":"ti303y61EqY3157","inlaststand":false,"callsign":"NO CALLSIGN","phone":[],"walletid":"QB-59933033","status":[],"phonedata":{"InstalledApps":[],"SerialNumber":58352969},"thirst":73.40000000000002,"isdead":false,"jailitems":[],"criminalrecord":{"hasRecord":false}}', '[{"name":"driver_license","metadata":{"type":"Class C Driver License","lastname":"Dx","firstname":"Mr","birthdate":"05/11/1991"},"slot":1,"count":1},{"name":"phone","slot":2,"count":1},{"name":"id_card","metadata":{"gender":0,"firstname":"Mr","citizenid":"HMK76260","lastname":"Dx","nationality":"Bangladesh","birthdate":"05/11/1991"},"slot":3,"count":1},{"name":"money","slot":4,"count":500}]', '2024-11-13 13:06:26');

-- Dumping structure for table qbcoreframework_336051.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.playerskins: ~0 rows (approximately)
INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(1, 'HMK76260', '1885233650', '{"hat":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"mask":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"vest":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"beard":{"defaultTexture":1,"texture":1,"defaultItem":-1,"item":-1},"t-shirt":{"defaultTexture":0,"texture":0,"defaultItem":1,"item":1},"eye_opening":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"face":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"jaw_bone_width":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"ear":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"watch":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"cheek_2":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"chimp_bone_lenght":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"blush":{"defaultTexture":1,"texture":1,"defaultItem":-1,"item":-1},"cheek_1":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"nose_3":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"decals":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"pants":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"facemix":{"defaultShapeMix":0.0,"shapeMix":0,"defaultSkinMix":0.0,"skinMix":0},"glass":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"accessory":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"nose_5":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"bag":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"cheek_3":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"moles":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"neck_thikness":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"chimp_hole":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"eyebrows":{"defaultTexture":1,"texture":1,"defaultItem":-1,"item":-1},"chimp_bone_width":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"eye_color":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"chimp_bone_lowering":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"nose_2":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"face2":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"eyebrown_forward":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"arms":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"lips_thickness":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"torso2":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"shoes":{"defaultTexture":0,"texture":0,"defaultItem":1,"item":1},"hair":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"ageing":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"nose_4":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"jaw_bone_back_lenght":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"makeup":{"defaultTexture":1,"texture":1,"defaultItem":-1,"item":-1},"nose_1":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"nose_0":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0},"bracelet":{"defaultTexture":0,"texture":0,"defaultItem":-1,"item":-1},"lipstick":{"defaultTexture":1,"texture":1,"defaultItem":-1,"item":-1},"eyebrown_high":{"defaultTexture":0,"texture":0,"defaultItem":0,"item":0}}', 1);

-- Dumping structure for table qbcoreframework_336051.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.player_contacts: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(11) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.player_houses: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.player_mails: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `outfitId` (`outfitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.player_outfits: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(11) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(8) NOT NULL,
  `fakeplate` varchar(8) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `paymentamount` int(11) NOT NULL DEFAULT 0,
  `paymentsleft` int(11) NOT NULL DEFAULT 0,
  `financetime` int(11) NOT NULL DEFAULT 0,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.player_vehicles: ~0 rows (approximately)

-- Dumping structure for table qbcoreframework_336051.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table qbcoreframework_336051.player_warns: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
