DROP TABLE IF EXISTS `patient_info`;

create table `patient_info`(
    `patient_id`  varchar(10) NOT NULL,
    `sex` varchar(10),
    `age` int,
    `province` varchar(20),
	`city` varchar(20),
	`infection_case` varchar(100),
    primary key (`patient_id`)
);

load data local infile './covid/patient_info.csv'
into table patient_info
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `search_trend`;

create table `search_trend`(
    `date` date NOT NULL,
    `cold` float,
    `flu` float,
    `pneumonia` float,
	`coronavirus` float,
    primary key (`date`)
);

load data local infile './covid/search_trend.csv'
into table search_trend
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `time`;

create table `time`(
    `date` date NOT NULL,
    `test` int,
    `negative` int,
    `confirmed` int,
	`released` int,
	`deceased` int,
    primary key (`date`)
);

load data local infile './covid/time.csv'
into table time
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `time_age`;

create table `time_age`(
    `date` date NOT NULL,
    `age` int NOT NULL,
	`confirmed` int,
	`deceased` int,
    primary key (`date`, `age`)
);

load data local infile './covid/time_age.csv'
into table time_age
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `time_gender`;

create table `time_gender`(
    `date` date NOT NULL,
    `sex` varchar(10) NOT NULL,
	`confirmed` int,
	`deceased` int,
    primary key (`date`, `sex`)
);

load data local infile './covid/time_gender.csv'
into table time_gender
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `time_province`;

create table `time_province`(
    `date` date NOT NULL,
    `province` varchar(20) NOT NULL,
	`confirmed` int,
	`released` int,
	`deceased` int,
    primary key (`date`, `province`)
);

load data local infile './covid/time_province.csv'
into table time_province
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `region`;

create table `region`(
    `code` int NOT NULL,
    `province` varchar(20),
	`city` varchar(20),
	`elementary_school_count` int,
	`kindergarten_count` int,
	`university_count` int,
	`elderly_population_ratio` float,
	`elderly_alone_ratio` float,
	`nursing_home_count` int,
    primary key (`code`)
);

load data local infile './covid/region.csv'
into table region
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

DROP TABLE IF EXISTS `weather`;

create table `weather`(
    `code` int NOT NULL,
    `date` date NOT NULL,
	`avg_temp` float,
	`most_wind_direction` int,
	`avg_relative_humidity` float,
    primary key (`code`, `date`),
	FOREIGN KEY (`code`) REFERENCES `region`(`code`) 
);

load data local infile './covid/weather.csv'
into table weather
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

