DROP TABLE IF EXISTS `houselocations`;
CREATE TABLE `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `houseID` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` text DEFAULT NULL,
  `garage` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `mlo` text DEFAULT NULL,
  `ipl` text DEFAULT NULL,
  `garageShell` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `player_houses`;
CREATE TABLE `player_houses` (
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `insideId` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` LONGTEXT DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `houseID` varchar(50) DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  `decorateStash` text DEFAULT NULL,
  `charge` text DEFAULT NULL,
  `credit` varchar(50) DEFAULT NULL,
  `creditPrice` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`house`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `house_plants`;
CREATE TABLE `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
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
) ENGINE=InnoDB AUTO_INCREMENT=7123 DEFAULT CHARSET=utf8mb4;

ALTER TABLE `users` ADD IF NOT EXISTS `inside` VARCHAR(100);
ALTER TABLE `houselocations` ADD IF NOT EXISTS `houseID` varchar(50) DEFAULT NULL;
ALTER TABLE `player_houses` ADD IF NOT EXISTS `houseID` varchar(50) DEFAULT NULL;
ALTER TABLE `player_houses` ADD IF NOT EXISTS `timer` int NULL DEFAULT '0';
ALTER TABLE `player_houses` CONVERT TO CHARACTER SET `utf8mb4` COLLATE `utf8mb4_general_ci`;

INSERT IGNORE INTO  `addon_inventory` (name, label, shared) VALUES
  ('property', 'Property', 0)
;

INSERT IGNORE INTO  `addon_account` (name, label, shared) VALUES
  ('property', 'Property', 0)
;

INSERT IGNORE INTO  `datastore` (name, label, shared) VALUES
  ('property', 'Property', 0)
;

INSERT IGNORE INTO  `addon_account` (name, label, shared) VALUES
  ('society_realestate','Real estate agent',1)
;

INSERT IGNORE INTO  `jobs` (name, label) VALUES
  ('realestate','Real estate agent')
;

INSERT IGNORE INTO  `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('realestate',0,'rookie','Rookie',10,'{}','{}'),
  ('realestate',1,'seller','Seller',25,'{}','{}'),
  ('realestate',2,'manager','Manager',40,'{}','{}'),
  ('realestate',3,'boss','Boss',0,'{}','{}')
;

ALTER TABLE
    `player_houses` DROP PRIMARY KEY;

ALTER TABLE
    `player_houses`
ADD
    IF NOT EXISTS `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;