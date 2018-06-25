DROP TABLE IF EXISTS `tweets`;
CREATE TABLE `tweets` (
	`id` BIGINT UNSIGNED AUTO_INCREMENT,
	`user_name` VARCHAR(64),
	`content` VARCHAR(255),
	`deleted` TINYINT(1) NOT NULL DEFAULT 0,
	`created` DATETIME NOT NULL,
	`modified` DATETIME NOT NULL,
	`tweet` TEXT,
	PRIMARY KEY(`id`),
	KEY(`user_name`),
	KEY(`deleted`),
	KEY(`created`),
	KEY(`modified`)
) DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS politicians;
create table politicians (
epid int unsigned,
country varchar(32),
first_name varchar(64),
last_name varchar(64),
email varchar(255),
birthdate date,
gender varchar(1),
eugroup varchar(32),
party varchar(255),
phone varchar(32),
office varchar(32),
committee varchar(255),
substitute varchar(255),
delegation varchar(255),
screen_name varchar(64),
tttpid varchar(32),
since date,
twitter_id bigint(20) unsigned,
  `profile_image_url` varchar(200) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `followers_count` int(10) unsigned DEFAULT NULL,
  `friends_count` int(10) unsigned DEFAULT NULL,
  `statuses_count` int(10) unsigned DEFAULT NULL,
status smallint UNSIGNED default 1
) DEFAULT CHARSET=UTF8;

/*
  `user_id` bigint(20) unsigned NOT NULL,
  `screen_name` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `profile_image_url` varchar(200) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `followers_count` int(10) unsigned DEFAULT NULL,
  `friends_count` int(10) unsigned DEFAULT NULL,
  `statuses_count` int(10) unsigned DEFAULT NULL,
  `time_zone` varchar(40) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
*/

# load data infile "/tmp/meps.csv" into table politicians columns terminated by ',' OPTIONALLY ENCLOSED BY '"' OPTIONALLY ENCLOSED BY '"'ignore 1 lines
