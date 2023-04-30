/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: activitydetails
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `activitydetails` (
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `OtherActivities_id` char(15) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ActivityDetails_startDate` date DEFAULT NULL,
  `ActivityDetails_endDate` date DEFAULT NULL,
  `ActivityDetails_temperature` float DEFAULT NULL,
  `ActivityDetails_humidity` float DEFAULT NULL,
  `ActivityDetails_precipitation` float DEFAULT NULL,
  `Employee_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `DevelopmentStage_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ActivityDetails_times` int NOT NULL,
  `ActivityDetails_windSpeed` float DEFAULT NULL,
  `ActivityDetails_solarRadiation` float DEFAULT NULL,
  PRIMARY KEY (
  `RiceCropInformation_id`,
  `ActivityDetails_times`,
  `OtherActivities_id`
  ),
  KEY `fk_ActivityDetail_employee` (`Employee_id`),
  KEY `fk_ActivityDetail_developmentStage` (`DevelopmentStage_id`),
  KEY `OtherActivities_id` (`OtherActivities_id`),
  CONSTRAINT `fk_ActivityDetail_developmentStage` FOREIGN KEY (`DevelopmentStage_id`) REFERENCES `developmentstage` (`DevelopmentStage_id`),
  CONSTRAINT `fk_ActivityDetail_employee` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`),
  CONSTRAINT `fk_ActivityDetail_RiceCropInformation` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`),
  CONSTRAINT `OtherActivities_id` FOREIGN KEY (`OtherActivities_id`) REFERENCES `otheractivities` (`OtherActivities_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: algorithm
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `algorithm` (
  `Algorithm_id` int NOT NULL,
  `Algorithm_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Algorithm_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: arableland
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `arableland` (
  `ArableLand_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ArableLand_location` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Soil_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ArableLand_area` float NOT NULL,
  `ArableLand_owner` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ArableLand_latitude` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArableLand_longitude` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Province_id` int NOT NULL,
  PRIMARY KEY (`ArableLand_id`),
  KEY `fk_soil` (`Soil_id`),
  KEY `fk_province` (`Province_id`),
  CONSTRAINT `fk_province` FOREIGN KEY (`Province_id`) REFERENCES `province` (`Province_id`),
  CONSTRAINT `fk_soil` FOREIGN KEY (`Soil_id`) REFERENCES `soil` (`Soil_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: backup
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `backup` (
  `Backup_link` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Backup_id` int NOT NULL AUTO_INCREMENT,
  `Backup_date` datetime NOT NULL,
  PRIMARY KEY (`Backup_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: contain
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `contain` (
  `Fertilizer_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Nutrient_id` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Contain_percent` float NOT NULL,
  PRIMARY KEY (`Fertilizer_id`, `Nutrient_id`),
  KEY `fk_fertilizer_contain` (`Fertilizer_id`),
  KEY `fk_nutrient_contain` (`Nutrient_id`),
  CONSTRAINT `fk_fertilizer_contain` FOREIGN KEY (`Fertilizer_id`) REFERENCES `fertilizer` (`Fertilizer_id`),
  CONSTRAINT `fk_nutrient_contain` FOREIGN KEY (`Nutrient_id`) REFERENCES `nutrient` (`Nutrient_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: crop
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `crop` (
  `Crop_id` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Crop_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Crop_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: developmentstage
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `developmentstage` (
  `DevelopmentStage_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `DevelopmentStage_name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`DevelopmentStage_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employee
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employee` (
  `Employee_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Role_id` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_name` varchar(40) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_sex` char(3) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_major` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_phoneNumber` char(12) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_address` varchar(300) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_identityCardNumber` char(12) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_birthDate` date NOT NULL,
  `Employee_email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_lockAccount` int NOT NULL,
  PRIMARY KEY (`Employee_id`),
  KEY `fk_employee_role` (`Role_id`),
  CONSTRAINT `fk_employee_role` FOREIGN KEY (`Role_id`) REFERENCES `role` (`Role_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: epidemic
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `epidemic` (
  `Epidemic_id` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Epidemic_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Epidemic_indication` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Epidemic_timeOfDevelopment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Epidemic_developmentEnvironment` varchar(500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `Epidemic_Harm` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
  `EpidemicClassification_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Epidemic_id`),
  KEY `g` (`EpidemicClassification_id`),
  CONSTRAINT `g` FOREIGN KEY (`EpidemicClassification_id`) REFERENCES `epidemicclassification` (`EpidemicClassification_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: epidemicclassification
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `epidemicclassification` (
  `EpidemicClassification_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `EpidemicClassification_name` varchar(40) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`EpidemicClassification_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: epidemictimes
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `epidemictimes` (
  `EpidemicTimes_startDate` date NOT NULL,
  `EpidemicTimes_endDate` date DEFAULT NULL,
  `EpidemicTimes_temperature` float DEFAULT NULL,
  `EpidemicTimes_humidity` float DEFAULT NULL,
  `EpidemicTimes_precipitation` float DEFAULT NULL,
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Epidemic_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `DevelopmentStage_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `EpidemicTimes_times` int NOT NULL,
  `EpidemicTimes_windSpeed` float DEFAULT NULL,
  `EpidemicTimes_solarRadiation` float DEFAULT NULL,
  KEY `fk_Epidemicstime_RiceCropInformation` (`RiceCropInformation_id`),
  KEY `fk_Epidemicstimes_DevelopmentStage` (`DevelopmentStage_id`),
  KEY `fk_Epidemictimes_employee` (`Employee_id`),
  KEY `fk_Epidemicstimes_Epidemics` (`Epidemic_id`),
  CONSTRAINT `fk_Epidemicstime_RiceCropInformation` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`),
  CONSTRAINT `fk_Epidemicstimes_DevelopmentStage` FOREIGN KEY (`DevelopmentStage_id`) REFERENCES `developmentstage` (`DevelopmentStage_id`),
  CONSTRAINT `fk_Epidemicstimes_Epidemics` FOREIGN KEY (`Epidemic_id`) REFERENCES `epidemic` (`Epidemic_id`),
  CONSTRAINT `fk_Epidemictimes_employee` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: fertilizer
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `fertilizer` (
  `Fertilizer_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Fertilizer_name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Fertilizer_supplier` varchar(300) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Fertilizer_uses` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Fertilizer_directionsForUse` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Fertilizer_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: fertilizertimes
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `fertilizertimes` (
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Fertilizer_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `DevelopmentStage_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_id` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `FertilizerTimes_times` int NOT NULL,
  `FertilizerTimes_amount` float DEFAULT NULL,
  `FertilizerTimes_startDate` date NOT NULL,
  `FertilizerTimes_endDate` date DEFAULT NULL,
  `FertilizerTimes_temperature` float DEFAULT NULL,
  `FertilizerTimes_humidity` float DEFAULT NULL,
  `FertilizerTimes_precipitation` float DEFAULT NULL,
  `FertilizerTimes_windSpeed` float DEFAULT NULL,
  `FertilizerTimes_solarRadiation` float DEFAULT NULL,
  PRIMARY KEY (
  `FertilizerTimes_times`,
  `Fertilizer_id`,
  `RiceCropInformation_id`
  ),
  KEY `fk_FertilizerTimes_RiceCropInformation` (`RiceCropInformation_id`),
  KEY `fk_FertilizerTimes_Fertilizer` (`Fertilizer_id`),
  KEY `fk_FertilizerTimes_DevelopmentStage` (`DevelopmentStage_id`),
  KEY `fk_FertilizerTimes_Employee` (`Employee_id`),
  CONSTRAINT `fk_FertilizerTimes_DevelopmentStage` FOREIGN KEY (`DevelopmentStage_id`) REFERENCES `developmentstage` (`DevelopmentStage_id`),
  CONSTRAINT `fk_FertilizerTimes_Employee` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`),
  CONSTRAINT `fk_FertilizerTimes_Fertilizer` FOREIGN KEY (`Fertilizer_id`) REFERENCES `fertilizer` (`Fertilizer_id`),
  CONSTRAINT `fk_FertilizerTimes_RiceCropInformation` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: image
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `image` (
  `Image_link` varchar(255) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 52 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: images
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `images` (
  `Image_id` int NOT NULL AUTO_INCREMENT,
  `Image_date` datetime(6) DEFAULT NULL,
  `Image_link` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Image_location` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Image_id`),
  KEY `fk_image_cropinformation` (`RiceCropInformation_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 75 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: monitor
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `monitor` (
  `Employee_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Employee_id`, `RiceCropInformation_id`),
  KEY `fk_idx` (`RiceCropInformation_id`),
  CONSTRAINT `fk_cropinformation` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`),
  CONSTRAINT `fk_employee` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: nutrient
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `nutrient` (
  `Nutrient_id` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Nutrient_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Nutrient_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: nutrientinfertilizer
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `nutrientinfertilizer` (
  `NutrientInFertilizer_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `NutrientInFertilizer_name` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`NutrientInFertilizer_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: otheractivities
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `otheractivities` (
  `OtherActivities_id` char(15) COLLATE utf8mb3_unicode_ci NOT NULL,
  `OtherActivities_name` varchar(300) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`OtherActivities_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pesticide
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `pesticide` (
  `Pesticide_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Pesticide_name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Pesticide_supplier` varchar(500) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Pesticide_uses` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Pesticide_directionsForUse` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Pesticide_component` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Pesticide_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: prediction
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `prediction` (
  `Prediction_id` int NOT NULL AUTO_INCREMENT,
  `Prediction_date` datetime(6) NOT NULL,
  `Prediction_yield` float NOT NULL,
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Prediction_precipitation` float NOT NULL,
  `Prediction_temperature` float NOT NULL,
  `Prediction_humitidity` float NOT NULL,
  `Prediction_windSpeed` float NOT NULL,
  `Prediction_solarRadiation` float NOT NULL,
  `Algorithm_id` int NOT NULL,
  `Prediction_N` float NOT NULL,
  `Prediction_P` float NOT NULL,
  `Prediction_K` float NOT NULL,
  PRIMARY KEY (`Prediction_id`),
  KEY `fk_RiceCropInformation_Prediction` (`RiceCropInformation_id`)
  /*!80000 INVISIBLE */,
  KEY `fk_Algorithm_prediction_idx` (`Algorithm_id`),
  CONSTRAINT `fk_Algorithm_prediction` FOREIGN KEY (`Algorithm_id`) REFERENCES `algorithm` (`Algorithm_id`),
  CONSTRAINT `fk_RiceCropInformation_Prediction` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 137 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: province
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `province` (
  `Province_id` int NOT NULL,
  `Province_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Province_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ricecropinformation
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ricecropinformation` (
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Seed_id` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RiceCropInformation_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RiceCropInformation_sowingDate` date DEFAULT NULL,
  `RiceCropInformation_harvestDate` date DEFAULT NULL,
  `RiceCropInformation_yield` float DEFAULT NULL,
  `Crop_id` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ArableLand_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`RiceCropInformation_id`),
  KEY `fk_seed_idx` (`Seed_id`),
  KEY `fk_crop_idx` (`Crop_id`),
  KEY `fik_ArableLand` (`ArableLand_id`),
  CONSTRAINT `fik_ArableLand` FOREIGN KEY (`ArableLand_id`) REFERENCES `arableland` (`ArableLand_id`),
  CONSTRAINT `fk_crop` FOREIGN KEY (`Crop_id`) REFERENCES `crop` (`Crop_id`),
  CONSTRAINT `fk_seed` FOREIGN KEY (`Seed_id`) REFERENCES `seed` (`Seed_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: role
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `role` (
  `Role_id` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Role_name` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Role_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: seed
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `seed` (
  `Seed_id` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Seed_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Seed_characteristic` varchar(500) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Seed_supplier` varchar(300) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Seed_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sensor
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sensor` (
  `Sensor_id` int NOT NULL,
  `Sensor_location` varchar(200) NOT NULL,
  `SensorGroup_id` int NOT NULL,
  PRIMARY KEY (`Sensor_id`),
  KEY `fk_sensorgroup_sensor_idx` (`SensorGroup_id`),
  CONSTRAINT `fk_sensorgroup_sensor` FOREIGN KEY (`SensorGroup_id`) REFERENCES `sensorgroup` (`SensorGroup_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sensorgroup
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sensorgroup` (
  `SensorGroup_id` int NOT NULL,
  PRIMARY KEY (`SensorGroup_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: soil
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `soil` (
  `Soil_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Soil_name` varchar(70) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Soil_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sprayingtimes
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sprayingtimes` (
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Pesticide_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `DevelopmentStage_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Employee_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `SprayingTimes_times` int NOT NULL,
  `SprayingTimes_amount` float NOT NULL,
  `SprayingTimes_startDate` date NOT NULL,
  `SprayingTimes_endDate` date DEFAULT NULL,
  `SprayingTimes_temperature` float DEFAULT NULL,
  `SprayingTimes_humidity` float DEFAULT NULL,
  `SprayingTimes_precipitation` float DEFAULT NULL,
  `SprayingTimes_windSpeed` float DEFAULT NULL,
  `SprayingTimes_solarRadiation` float DEFAULT NULL,
  PRIMARY KEY (
  `RiceCropInformation_id`,
  `Pesticide_id`,
  `SprayingTimes_times`
  ),
  KEY `fk_SprayingTime_Pesticide_id` (`Pesticide_id`),
  KEY `fk_SpriayingTime_DevelopmentStage` (`DevelopmentStage_id`),
  KEY `fk_SprayingTimes_employee` (`Employee_id`),
  CONSTRAINT `fk_SprayingTime_Pesticide_id` FOREIGN KEY (`Pesticide_id`) REFERENCES `pesticide` (`Pesticide_id`),
  CONSTRAINT `fk_SprayingTimes_employee` FOREIGN KEY (`Employee_id`) REFERENCES `employee` (`Employee_id`),
  CONSTRAINT `fk_SprayingTimes_RiceCropInformation` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`),
  CONSTRAINT `fk_SpriayingTime_DevelopmentStage` FOREIGN KEY (`DevelopmentStage_id`) REFERENCES `developmentstage` (`DevelopmentStage_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: treatment
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `treatment` (
  `Pesticide_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Epidemic_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Pesticide_id`, `Epidemic_id`),
  KEY `fk_Epidemic-Treatment` (`Epidemic_id`),
  CONSTRAINT `fk_Epidemic-Treatment` FOREIGN KEY (`Epidemic_id`) REFERENCES `epidemic` (`Epidemic_id`),
  CONSTRAINT `fk_Pesticide_Treatment` FOREIGN KEY (`Pesticide_id`) REFERENCES `pesticide` (`Pesticide_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: activitydetails
# ------------------------------------------------------------

INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000001',
    'OA00000001',
    '2023-04-18',
    '2023-04-19',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000001',
    '2023-04-05',
    '2023-04-05',
    29.1,
    77.54,
    1.6,
    'EE000003',
    'DS000009',
    1,
    12,
    21.88
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000003',
    '2023-03-08',
    '2023-03-15',
    27.19,
    61.68,
    0,
    'EE000003',
    'DS000002',
    1,
    13.29,
    23.3
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000004',
    '2023-04-30',
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000006',
    '2023-04-01',
    '2023-04-02',
    29.45,
    69.58,
    0,
    'EE000003',
    'DS000002',
    1,
    10.2,
    23.22
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000007',
    '2023-04-20',
    '2023-04-21',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000004',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000008',
    '2023-05-01',
    '2023-05-02',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000008',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000001',
    '2023-02-08',
    '2023-03-10',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000002',
    '2023-02-10',
    NULL,
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000003',
    '2023-03-11',
    '2023-03-16',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000002',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000006',
    '2023-03-02',
    '2023-03-02',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000003',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000007',
    '2023-04-30',
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000007',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000001',
    '2023-04-30',
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000007',
    3,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000002',
    '2023-04-01',
    '2023-04-04',
    28.88,
    75.39,
    5,
    'EE000003',
    'DS000002',
    3,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000003',
    '2023-04-30',
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000007',
    3,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000001',
    '2023-05-01',
    '2023-05-02',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000008',
    4,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000002',
    '2023-04-30',
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000007',
    4,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'OA00000003',
    '2023-04-29',
    '2023-04-29',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000003',
    4,
    NULL,
    NULL
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'OA00000001',
    '2023-04-08',
    '2023-04-10',
    28.73,
    74.33,
    2.4,
    'EE000003',
    'DS000002',
    1,
    15.43,
    21.29
  );
INSERT INTO
  `activitydetails` (
    `RiceCropInformation_id`,
    `OtherActivities_id`,
    `ActivityDetails_startDate`,
    `ActivityDetails_endDate`,
    `ActivityDetails_temperature`,
    `ActivityDetails_humidity`,
    `ActivityDetails_precipitation`,
    `Employee_id`,
    `DevelopmentStage_id`,
    `ActivityDetails_times`,
    `ActivityDetails_windSpeed`,
    `ActivityDetails_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'OA00000003',
    '2023-04-09',
    '2023-04-15',
    29.16,
    76.43,
    7.5,
    'EE000003',
    'DS000001',
    1,
    12.81,
    20.37
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: algorithm
# ------------------------------------------------------------

INSERT INTO
  `algorithm` (`Algorithm_id`, `Algorithm_name`)
VALUES
  (1, 'Hồi quy tuyến tính');
INSERT INTO
  `algorithm` (`Algorithm_id`, `Algorithm_name`)
VALUES
  (2, 'Rừng ngẫu nhiên');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: arableland
# ------------------------------------------------------------

INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000001',
    'Sóc Trăng',
    'SL00000001',
    10000,
    'Trần Văn Anh',
    '9.6096988',
    '105.9061378',
    2
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000002',
    'Cần Thơ',
    'SL00000005',
    10,
    'Phan Văn A',
    '9.5751822',
    '106.1938306',
    4
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000003',
    'Hậu Giang',
    'SL00000003',
    10,
    'Phan Văn A',
    '9.7885396',
    '105.4716723',
    3
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000004',
    'An Giang',
    'SL00000005',
    30,
    'Trần Văn Thanh',
    '10.5991939',
    '104.9330377',
    9
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000005',
    'An Giang',
    'SL00000002',
    30,
    'Phan Văn A',
    '10.5991939',
    '104.9330377',
    9
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000006',
    'An Giang',
    'SL00000002',
    50,
    'Phan Văn G',
    '10.5991939',
    '104.9330377',
    9
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000007',
    'Trà Vinh',
    'SL00000002',
    30,
    'Phan Văn A',
    '9.9514489',
    '106.3097506',
    6
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000008',
    'Sóc Trăng',
    'SL00000002',
    50,
    'Phan Thanh An',
    '9.6096988',
    '105.9061378',
    2
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000009',
    'Sóc Trăng',
    'SL00000002',
    100,
    'Trần Khánh Vân',
    '9.5751822',
    '106.1938306',
    2
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000010',
    'Sóc Trăng',
    'SL00000002',
    20,
    'Nguyễn Thanh Điền',
    '9.5751822',
    '106.1938306',
    2
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000011',
    'Hậu Giang',
    'SL00000001',
    16,
    'Võ Hoàng Anh',
    '9.7885396',
    '105.4716723',
    3
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000012',
    'Vĩnh Long',
    'SL00000001',
    32,
    'Lê Văn Hùng',
    '10.1072148',
    '105.8457582',
    7
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000013',
    'Cần Thơ',
    'SL00000002',
    24,
    'Thái Thanh Anh',
    '10.1230032',
    '105.3917753',
    4
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000014',
    'Tiền Giang',
    'SL00000004',
    10,
    'Phan Văn A',
    '10.3880824',
    '106.0296741',
    10
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`,
    `ArableLand_latitude`,
    `ArableLand_longitude`,
    `Province_id`
  )
VALUES
  (
    'AL00000015',
    'tedszf',
    'SL00000001',
    10,
    're',
    '9.6575',
    '105.678',
    3
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: backup
# ------------------------------------------------------------

INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    '../frontend/backup/ricegrowingprocessmanagementdatabase1682820780896.sql',
    1,
    '2023-04-30 09:13:00'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    '../frontend/backup/ricegrowingprocessmanagementdatabase1682822288686.sql',
    2,
    '2023-04-30 09:38:08'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682826214749.sql',
    3,
    '2023-04-30 10:43:34'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682826293857.sql',
    4,
    '2023-04-30 10:44:53'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682826312350.sql',
    5,
    '2023-04-30 10:45:12'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682829714160.sql',
    6,
    '2023-04-30 11:41:54'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830050287.sql',
    7,
    '2023-04-30 11:47:30'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830143109.sql',
    8,
    '2023-04-30 11:49:03'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830164252.sql',
    9,
    '2023-04-30 11:49:24'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830236004.sql',
    10,
    '2023-04-30 11:50:36'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830272803.sql',
    11,
    '2023-04-30 11:51:12'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830303751.sql',
    12,
    '2023-04-30 11:51:43'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830339925.sql',
    13,
    '2023-04-30 11:52:19'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830398054.sql',
    14,
    '2023-04-30 11:53:18'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830412155.sql',
    15,
    '2023-04-30 11:53:32'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830470249.sql',
    16,
    '2023-04-30 11:54:30'
  );
INSERT INTO
  `backup` (`Backup_link`, `Backup_id`, `Backup_date`)
VALUES
  (
    'backup_1682830574376.sql',
    17,
    '2023-04-30 11:56:14'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: contain
# ------------------------------------------------------------

INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000001', 'K', 6);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000001', 'N', 20);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000001', 'P', 18);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000001', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000002', 'K', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000002', 'N', 20);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000002', 'P', 10);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000002', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000003', 'K', 8);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000003', 'N', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000003', 'P', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000003', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000004', 'K', 8);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000004', 'N', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000004', 'P', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000004', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000005', 'K', 8);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000005', 'N', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000005', 'P', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000005', 'Y', 13);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000006', 'K', 16);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000006', 'N', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000006', 'P', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000006', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000007', 'K', 6);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000007', 'N', 22);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000007', 'P', 12);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000007', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000008', 'K', 20);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000008', 'N', 20);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000008', 'P', 20);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000008', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000009', 'K', 6);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000009', 'N', 28);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000009', 'P', 8);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000009', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000010', 'K', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000010', 'N', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000010', 'P', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000010', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000011', 'K', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000011', 'N', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000011', 'P', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000011', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000012', 'K', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000012', 'N', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000012', 'P', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000012', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000013', 'K', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000013', 'N', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000013', 'P', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000013', 'Y', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000014', 'K', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000014', 'N', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000014', 'P', 0);
INSERT INTO
  `contain` (`Fertilizer_id`, `Nutrient_id`, `Contain_percent`)
VALUES
  ('FR00000014', 'Y', 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: crop
# ------------------------------------------------------------

INSERT INTO
  `crop` (`Crop_id`, `Crop_name`)
VALUES
  ('C00001', 'Đông Xuân');
INSERT INTO
  `crop` (`Crop_id`, `Crop_name`)
VALUES
  ('C00002', 'Hè Thu');
INSERT INTO
  `crop` (`Crop_id`, `Crop_name`)
VALUES
  ('C00003', 'Vụ Mùa');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: developmentstage
# ------------------------------------------------------------

INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000001', 'Giai đoạn trương hạt');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000002', 'Giai đoạn hạt nảy mầm');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000003', 'Giai đoạn đẻ nhánh');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000004', 'Gian đoạn phát triển lóng thân');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000005', 'Giai đoạn phân hoá hoa');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000006', 'Giai đoạn trỗ bông');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000007', 'Giai đoạn nở hoa thụ phấn, thụ tinh');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000008', 'Giai đoạn hạt chín sữa');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000009', 'Giai đoạn hạt chín sáp');
INSERT INTO
  `developmentstage` (`DevelopmentStage_id`, `DevelopmentStage_name`)
VALUES
  ('DS000010', 'Giai đoạn hạt chín hoàn toàn');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employee
# ------------------------------------------------------------

INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000001',
    '01',
    'Trần Anh Thư',
    'Nữ',
    'Quản trị hệ thống',
    '0777888989',
    'Cà Mau',
    '123456789012',
    '$2a$08$Lio0nqFZyJE9rtiQvVPUf.sReBYtbEuJY2rl7W7sSK7GotPyFQZ.G',
    '2023-02-21',
    'thob1906774@student.ctu.edu.vn',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000002',
    '03',
    'Võ Vũ Duy Thanh',
    'Nam',
    'Nông nghiệp',
    '0777888945',
    'Vĩnh Long',
    '123456789015',
    '$2a$08$DH6fuf0b2sRD035Quq4QpOc9aPLAyl690bqXobKvJS1NqBgyBPyNy',
    '1980-05-09',
    'thob1906774@student.ctu.edu.vn',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000003',
    '02',
    'Võ Văn Hướng',
    'Nam',
    'Kỹ sư công nghệ thông tin',
    '0777888995',
    'Sóc Trăng',
    '123456788',
    '$2a$08$MzPU1xpCdiPklGiQaD7WxOld0j56/4c04NR4v56onEw8C2/4/TI0W',
    '1995-12-04',
    'thob1906774@student.ctu.edu.vn',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000005',
    '01',
    'Trần Thị Thơ',
    'Nữ',
    'Kỹ sư phần mềm',
    '0916985183',
    'Cù Lao Dung',
    '123456786',
    '$2a$08$/3SUR9ia4gf2WubhwO8Qz.qwRBFQ4HXJYI7dbyroPPTyYMsbyyFuS',
    '2023-02-04',
    'tranthitho09052001@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000006',
    '02',
    'Phan Thanh Anh',
    'Nữ',
    'Kỹ sư nông nghiệp',
    '0916985183',
    'Hẻm 2, Đường Nguyễn Văn Linh, phường Hưng Lợi, quận Ninh Kiều, Thành phố Cần Thơ',
    '012345778',
    '$2a$08$SWoZWB0eeDrLmw7DzvjriuUHVq2c39IbIsB5Xte4RbLnu0GTyJzbe',
    '2001-04-13',
    'ptanh@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000010',
    '02',
    'Trần Thị Thơ',
    'Nữ',
    'Kỹ sư ',
    '0916985183',
    'Cù Lao Dung',
    '123456789013',
    '$2a$08$ASYsqiK0LoBvpP43tA7meOTnbdBhazgvp4rXW.A0JkKgkD1lHN1Di',
    '2023-03-10',
    'tranthitho09052001@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000011',
    '03',
    'Phạm Đăng Khoa',
    'Nam',
    'Kỹ sư nông nghiệp',
    '0916985188',
    'Phường An Khánh, quận ninh Kiêu, thành phố Cần Thơ',
    '012345677899',
    '$2a$08$MtjW53d0fbso1KmoN5cz6eEKn1wm/z.14HFCzwq8YZToIf8apuDY.',
    '1985-02-21',
    'pdkhoa@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000012',
    '03',
    'Phạm Khánh Vân',
    'Nữ',
    'Kỹ sư phần mềm',
    '0916985186',
    'Phường An Hòa, quận Ninh Kiều, Thành phố Cần Thơ',
    '122356786754',
    '$2a$08$o5M9r34/0/opzb/ALDwEyuFAGQ0taiZpTKpwZnRa4V4qDCOx0rYVa',
    '2023-04-06',
    'tranthitho09052001@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000013',
    '03',
    'Lê Minh Anh',
    'Nam',
    'Kỹ sư nông nghiệp',
    '0916985190',
    'Phường An Khánh, quận ninh Kiêu, thành phố Cần Thơ',
    '014566778233',
    '$2a$08$6rZLeWrmrQW8FAN2OHz4L.kdus09C0a9SV9vH4dQ8BGUrhgk.xxTm',
    '1995-04-29',
    'lmanh@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000014',
    '03',
    'Phan Khánh An',
    'Nam',
    'Kỹ sư nông nghiệp',
    '0916985183',
    'Huyện Kế Sách, tỉnh Sóc Trăng',
    '123456789014',
    '$2a$08$8zihL79dIkZCCBzucieGreLtT2XN1cfFIOje4xWjgntlQZjDaaU1O',
    '1985-04-20',
    'pkan@gnail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000015',
    '03',
    'Nguyễn Thanh Anh',
    'Nữ',
    'Kỹ sư nông nghiệp',
    '0916985190',
    'Phường An Khánh, quận ninh Kiều, TP. Cần Thơ',
    '123456789018',
    '$2a$08$yUvzC6cM8/1OhLi3NQBWiOqtgF9aza60q3RRPrMKyMVfFUb493mIy',
    '1992-04-21',
    'ntanh@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000016',
    '01',
    'Trần Như Ngọc',
    'Nữ',
    'Kỹ sư phần mềm',
    '0916985183',
    'Ấp An Nghiệp, An Thạnh 3, Cù Lao Dung Sóc Trăng',
    '123456789012',
    '$2a$08$BViGZwj20JjBDN8civnsFe1LJYaMqbw.zJxa.xvJW3iL12m5PRnMW',
    '2001-04-29',
    'tnhungoc@gmail.com',
    1
  );
INSERT INTO
  `employee` (
    `Employee_id`,
    `Role_id`,
    `Employee_name`,
    `Employee_sex`,
    `Employee_major`,
    `Employee_phoneNumber`,
    `Employee_address`,
    `Employee_identityCardNumber`,
    `Employee_password`,
    `Employee_birthDate`,
    `Employee_email`,
    `Employee_lockAccount`
  )
VALUES
  (
    'EE000017',
    '02',
    'Nguyễn Văn An',
    'Nam',
    'Kỹ sư nông nghiệp',
    '0916985190',
    '142 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ',
    '123456789014',
    '$2a$08$u.OES3Inyc0..iCJPw77v.R5FICYXeameKET5ITdQjKjAJxOayG1i',
    '1986-02-28',
    'nvanan@gamil.com',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: epidemic
# ------------------------------------------------------------

INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicClassification_id`
  )
VALUES
  (
    'EC00000001',
    'Bệnh khô vằn',
    'Triệu chứng vết bệnh ban đầu  trên cây lúa là những đốm hình bầu dục, màu xám trắng ở bẹ lá gần gốc lúa. Khi nấm tấn công lên lá thì vết bệnh không còn hình dạng nhất định mà loang lổ như hình vằn da hổ',
    'Quanh năm',
    'Nấm này phát sinh phát triển mạnh nhất khi cây lúa xanh tốt, gieo cấy dày, ruộng thấp trũng; thời tiết ấm áp, có nắng mưa xen kẽ.',
    'Làm bông bị lép, lửng',
    'ECC00002'
  );
INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicClassification_id`
  )
VALUES
  (
    'EC00000002',
    'Rầy nâu',
    NULL,
    'Quanh năm',
    'Sống quanh gốc lúa ngay phần bẹ lá, phía trên mặt nước. Việc sử dụng quá mức urê và phân bón nitơ và thuốc sâu có thể dẫn đến bùng phát rầy nâu bằng cách tăng khả năng sinh sản của chúng, và bằng cách giảm các thiên địch của rầy nâu. Khí hậu ấm nóng, ẩm độ cao, mưa nắng xen kẽ và cấy nhiều giống nhiễm rầy thường phát sinh gây hại nặng',
    'Tác hại trực tiếp của rầy nâu là chích hút nhựa, làm cho cây lúa suy yếu, phát triển kém, lá vàng úa, rụi dần và khô héo đi gọi là “cháy rầy”. Tác hại gián tiếp của rầy nâu là truyền các bệnh siêu vi khuẩn cho lúa như bệnh lúa cỏ, lùn xoắn lá, vàng lùn. Rầy nâu nhỏ truyền bệnh lùn sọc đen',
    'ECC00003'
  );
INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicClassification_id`
  )
VALUES
  (
    'EC00000003',
    'Sâu đục thân bướm 2 chấm hại lúa',
    NULL,
    'Quanh năm',
    'Điều kiện nhiệt độ ấm nóng và ẩm độ cao thích hợp cho sâu phát sinh gây hại.',
    'Sâu non xâm nhập vào bẹ lá vào thân cắt đứt đường vận chuyển dinh dưỡng làm dảnh vô hiệu và bông bạclàm bông lúa bị lép hoàn toàn, trong khi các lá bên dưới của chồi vẫn còn xanh',
    'ECC00004'
  );
INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicClassification_id`
  )
VALUES
  (
    'EC00000005',
    'Lùn xoắn lá',
    'Triệu chứng vết bệnh ban đầu  trên cây lúa là những đốm hình bầu dục, màu xám trắng ở bẹ lá gần gốc lúa. Khi nấm tấn công lên lá thì vết bệnh không còn hình dạng nhất định mà loang lổ như hình vằn da hổ',
    'Quanh năm',
    'Nấm này phát sinh phát triển mạnh nhất khi cây lúa xanh tốt, gieo cấy dày, ruộng thấp trũng; thời tiết ấm áp, có nắng mưa xen kẽ.',
    'Làm bông bị lép, lửng',
    'ECC00002'
  );
INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicClassification_id`
  )
VALUES
  (
    'EC00000006',
    'Bệnh đạo ôn(bệnh cháy lá)',
    'Nấm có thể tấn công ở mọi bộ phận của cây lúa nhưng nhiều nhất là ở phiến lá. Trên lá, vết bệnh lúc đầu nhỏ màu nâu, sau phát triển thành vết bệnh điển hình có dạng hình mắt én, hai đầu hẹp, giữa phình ra có màu xám tro. Chung quanh vết bệnh có viền nâu rõ rệt, ngoài viền nâu thường có một quầng vàng',
    'Quanh năm',
    'Bệnh xuất hiện và phát triển mạnh trong điều kiện độ ẩm cao, sương mù nhiều, ruộng thiếu nước và bón nhiều phân đạm, sạ cấy quá dày',
    'Nấm có thể tấn công ở mọi bộ phận của cây lúa nhưng nhiều nhất là ở phiến lá. Trên lá, vết bệnh lúc đầu nhỏ màu nâu, sau phát triển thành vết bệnh điển hình có dạng hình mắt én, hai đầu hẹp, giữa phình ra có màu xám tro. Chung quanh vết bệnh có viền nâu rõ rệt, ngoài viền nâu thường có một quầng vàng. Nhiều vết bệnh liên kết lại làm cả lá lúa bị cháy khô. Bệnh cũng xuất hiện trên các đốt thân làm gãy ngang thân lúa hoặc trên cổ bông (bệnh khô cổ bông) làm tắt nghẽn mạch dẫn nhựa nuôi hạt, bông lúa bị gãy, hạt bị lép và lững',
    'ECC00002'
  );
INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicClassification_id`
  )
VALUES
  (
    'EC00000007',
    'cds',
    NULL,
    'cdsa',
    'cdsa',
    'cdsa',
    'ECC00004'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: epidemicclassification
# ------------------------------------------------------------

INSERT INTO
  `epidemicclassification` (
    `EpidemicClassification_id`,
    `EpidemicClassification_name`
  )
VALUES
  ('ECC00001', 'Côn trùng');
INSERT INTO
  `epidemicclassification` (
    `EpidemicClassification_id`,
    `EpidemicClassification_name`
  )
VALUES
  ('ECC00002', 'Dịch bệnh');
INSERT INTO
  `epidemicclassification` (
    `EpidemicClassification_id`,
    `EpidemicClassification_name`
  )
VALUES
  ('ECC00003', 'Nấm hại');
INSERT INTO
  `epidemicclassification` (
    `EpidemicClassification_id`,
    `EpidemicClassification_name`
  )
VALUES
  ('ECC00004', 'Sâu bệnh');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: epidemictimes
# ------------------------------------------------------------

INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-01',
    '2023-04-02',
    27.8,
    77.79,
    0.9,
    'RCI0000001',
    'EC00000001',
    'DS000001',
    'EE000003',
    1,
    14.1,
    21.63
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-02-19',
    '2023-02-24',
    27.23,
    73.69,
    6.4,
    'RCI0000004',
    'EC00000001',
    'DS000001',
    'EE000003',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-02-17',
    '2023-02-26',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000006',
    'DS000002',
    'EE000003',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-03-16',
    '2023-03-17',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000002',
    'DS000003',
    'EE000003',
    3,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-03-02',
    '2023-03-19',
    NULL,
    NULL,
    NULL,
    'RCI0000010',
    'EC00000006',
    'DS000002',
    'EE000003',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-03-18',
    '2023-03-18',
    NULL,
    NULL,
    NULL,
    'RCI0000010',
    'EC00000002',
    'DS000006',
    'EE000003',
    2,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-01',
    '2023-04-05',
    28.92,
    75.81,
    6.6,
    'RCI0000004',
    'EC00000003',
    'DS000003',
    'EE000003',
    4,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-05',
    '2023-04-06',
    28.4,
    78,
    1.2,
    'RCI0000001',
    'EC00000002',
    'DS000001',
    'EE000003',
    2,
    12.9,
    20.41
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-07',
    '2023-04-07',
    29,
    74.54,
    0,
    'RCI0000001',
    'EC00000001',
    'DS000002',
    'EE000003',
    3,
    14.3,
    20.76
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-09',
    '2023-04-16',
    29.13,
    76.9,
    9.3,
    'RCI0000008',
    'EC00000001',
    'DS000001',
    'EE000003',
    1,
    13.79,
    20.51
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-25',
    NULL,
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000002',
    'DS000001',
    'EE000003',
    5,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-03-16',
    '2023-04-02',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000006',
    'DS000004',
    'EE000003',
    6,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-21',
    '2023-03-24',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000003',
    'DS000005',
    'EE000003',
    7,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-03-30',
    '2023-03-29',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000001',
    'DS000005',
    'EE000003',
    8,
    NULL,
    NULL
  );
INSERT INTO
  `epidemictimes` (
    `EpidemicTimes_startDate`,
    `EpidemicTimes_endDate`,
    `EpidemicTimes_temperature`,
    `EpidemicTimes_humidity`,
    `EpidemicTimes_precipitation`,
    `RiceCropInformation_id`,
    `Epidemic_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `EpidemicTimes_times`,
    `EpidemicTimes_windSpeed`,
    `EpidemicTimes_solarRadiation`
  )
VALUES
  (
    '2023-04-06',
    '2023-04-07',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000002',
    'DS000006',
    'EE000003',
    9,
    NULL,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fertilizer
# ------------------------------------------------------------

INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000001',
    'Phân bón NPK BigOne Lúa F2',
    'CÔNG TY CỔ PHẦN PHÂN BÓN HÀ LAN',
    'Giúp cây lúc to đòng, cứng cây, giảm tình trạng ngã đổ.  Bổ sung Đạm (N), Lân (P2O5) giúp bông lúa dài, hạt đều, chắc. Cung cấp trung vi lượng và siêu vi lượng (Molyden, Coban) giúp cây  sinh trưởng phát triển mạnh mẽ hơn. Sau khi sử dụng cây trồng sẽ chống chiệu sâu bệnh tốt hơn.',
    'jytr'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000002',
    'NPK Hà Lan 20-0-10+TE',
    'Công ty cổ phần phân bón Hà Lan',
    'Sử dụng được cho đa dạng cây trồng nhằm tăng năng suất, hiệu quả trồng cây. Tăng cường phát triển hệ rễ giúp cây cứng cáp, lá xanh và hạn chế tối đa khả năng đổ ngã. Bổ sung đầy đủ các chất dinh dưỡng mà cây trồng cần. Hạn chế sâu bệnh và ảnh hưởng từ sự thay đổi thời tiết.',
    'j6yj'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000003',
    'NPK 16-16-8 Cà Mau',
    'Tập đoàn dầu khí quốc gia Việt Nam - Công ty cổ phần phân bón dầu khí Cà Mau',
    'Cung cấp các chất dinh dưỡng cần thiết một cách cân đối và hợp lý cho các loại cây trồng. Cải tạo và tăng độ phì nhiêu cho đất, giúp cây trồng giữ ẩm, chịu hạn, chịu rét, tăng khả năng chống chịu sâu bệnh. Phát huy tối ta các yếu tố khoáng Đa-trung_vi lượng, giúp cây trồng hấp thụ nhanh các chất dinh dưỡng. Kích thích bộ rễ, bộ lá phát triển mạnh, cây sinh trưởng tốt, tăng tỉ lệ ra hoa kết quả, nâng cao năng suất cây trồng và giá trị nông sản.',
    't545'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000004',
    'NPK 16-16-8 Phú Mỹ',
    'Công ty cổ phần phân bón và hóa chất dầu khí miền Bắc',
    'b d',
    'bfdx'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000005',
    'NPK ĐẦU TRÂU 16-16-8+13S',
    'Công ty cổ phần phân bón Bình Điền',
    '- Tăng sinh trưởng, phát triển và sức chống chịu điều kiện bất thuận.\n- Tăng năng suất, chất lượng nông sản và lợi nhuận.\n- Cải thiện độ phì nhiêu của đất.',
    'gr'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000006',
    'Phân bón SUPE LÂN Long Thành',
    'Công ty cổ phần phân bón miền Nam',
    'Supe Lân Long Thành goài Lân còn có vôi, Lưu Huỳnh, Silic có tác dụng khử chua đất, hạ phèn, giúp cây trồng phát triển bộ rễ, kích thích sự phân hoá mầm hoa, sai bông chắc hạt.',
    'Bón 250-500 kg/ha/vụ'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000007',
    'NPK Na Uy lúa đẻ nhánh',
    'Công ty cổ phần bón Na Uy',
    'Phân bón NPK phức hợp chứa đầy đủ các loại dưỡng chất. Phân bón NPK NA UY phức hợp  có bổ sung vi lượng dưỡng chất Đạm, Lân, Kali và bổ sung trung vi lượng Bo, Cu, Zn, Mn,Mg,S, một dưỡng chất thiết yếu để nâng cao năng suất, chất lượng cây trồng.sản phẩm này phù hợp cho các tất cả các loại cây trồng giai đoạn cây, con, kinh doanh nuôi trái củ, quả non, giai đoạn làm bông.',
    'Bón 50kg/ha/Vụ'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000008',
    'Phân Bón Lá NPK 20-20-20+TE Kích Chồi Và Lá Growmore All Purpose Lọ 100 Gram',
    'Công ty TNHH Growmore Việt Nam',
    'Sử dụng được cho tất cả giai đoạn sinh trưởng và phát triển của cây trồng. Dạng bột hòa tan, dễ sử dụng và hiệu quả cao. Làm tăng khả năng sinh trưởng và phát triển của cây trồng. Tăng sức đề kháng và tăng khả năng chống chịu sâu bệnh hại.',
    'Tiến hành pha 5 - 10 gram phân bón NPK all purpose 20-20-20 vào bình xịt hoặc bình tưới chứa 8 lít nước sạch. Khuấy thật đều hỗn hợp trên để phân bón hoàn toàn trong nước. Tiến hành phun thật đều lên cây trồng, phun đều 2 mặt lá hoặc tưới vào gốc cây trồng.'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  (
    'FR00000009',
    'NPK 28-8-6+TE (Chuyên dùng cho lúa)',
    'Công Ty cổ phần Phân bón Bình Điền',
    'Thích hợp cho các giống lúa ngắn ngày. Giúp lúa non tăng trưởng nhanh, đẻ nhánh khoè. Giúp lúa có đòng to, trổ thoát, năng suất cao. Phù hợp cho các loại đất vùng ĐBSCL.',
    '7-10 ngày sau sạ: 100kg/ha. 18-22 ngày sau sạ: 100-150kg/ha. Đón đòng: 80-100kg/ha.'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  ('FR00000010', 'tt', 'tt', 'tt', 'tt');
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  ('FR00000011', 'f', 'f', 'f', 'f');
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  ('FR00000012', 'h', 'h', 'h', 'h');
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  ('FR00000013', '3', '3', '3', '3');
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_uses`,
    `Fertilizer_directionsForUse`
  )
VALUES
  ('FR00000014', '5', '5', '5', '5');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fertilizertimes
# ------------------------------------------------------------

INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000001',
    'FR00000001',
    'DS000001',
    'EE000002',
    1,
    40,
    '2023-05-03',
    '2023-05-01',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000002',
    'FR00000001',
    'DS000002',
    'EE000003',
    1,
    150,
    '2023-04-06',
    '2023-04-15',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000003',
    'EE000003',
    1,
    12,
    '2023-03-16',
    '2023-03-16',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000002',
    'DS000002',
    'EE000003',
    1,
    129,
    '2023-03-02',
    '2023-03-05',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000017',
    'FR00000004',
    'DS000002',
    'EE000003',
    1,
    30,
    '2023-04-13',
    '2023-04-15',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000002',
    'FR00000005',
    'DS000002',
    'EE000003',
    1,
    130,
    '2023-04-06',
    '2023-04-15',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000011',
    'FR00000005',
    'DS000002',
    'EE000003',
    1,
    30,
    '2023-04-16',
    '2023-04-16',
    27.9,
    83.04,
    3.7,
    18.1,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000011',
    'FR00000007',
    'DS000002',
    'EE000003',
    1,
    20,
    '2023-04-16',
    '2023-04-16',
    27.9,
    83.04,
    3.7,
    18.1,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000002',
    'FR00000001',
    'DS000009',
    'EE000003',
    2,
    100,
    '2023-04-19',
    '2023-04-19',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000001',
    'FR00000002',
    'DS000001',
    'EE000003',
    2,
    10,
    '2023-02-25',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000001',
    'EE000003',
    2,
    10,
    '2023-02-16',
    '2023-02-17',
    27.45,
    65.46,
    1,
    11.75,
    23.14
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000006',
    'DS000003',
    'EE000002',
    2,
    30,
    '2023-03-11',
    '2023-03-11',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000001',
    'FR00000001',
    'DS000001',
    'EE000003',
    3,
    11,
    '2023-02-22',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000001',
    'EE000003',
    3,
    12,
    '2023-02-16',
    '2023-02-16',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000002',
    'FR00000005',
    'DS000004',
    'EE000003',
    3,
    100,
    '2023-04-11',
    '2023-04-13',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000007',
    'DS000004',
    'EE000003',
    3,
    100,
    '2023-03-09',
    '2023-03-09',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000002',
    'EE000003',
    4,
    10,
    '2023-02-18',
    '2023-02-19',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000001',
    'DS000002',
    'EE000003',
    4,
    98,
    '2023-04-14',
    '2023-04-15',
    29.35,
    78.85,
    4.6,
    12.65,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000002',
    'DS000002',
    'EE000003',
    4,
    80,
    '2023-04-13',
    '2023-04-15',
    29.35,
    78.85,
    4.6,
    12.65,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000002',
    'FR00000009',
    'DS000008',
    'EE000003',
    4,
    160,
    '2023-04-15',
    '2023-04-16',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000002',
    'EE000003',
    5,
    12,
    '2023-03-03',
    '2023-03-01',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000003',
    'DS000001',
    'EE000003',
    5,
    110,
    '2023-04-15',
    '2023-04-09',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000002',
    'EE000003',
    6,
    10,
    '2023-03-26',
    '2023-03-28',
    29.33,
    71.82,
    0.1,
    11.7,
    23.3
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000002',
    'EE000003',
    7,
    40,
    '2023-03-26',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000002',
    'EE000003',
    8,
    40,
    '2023-03-15',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000002',
    'EE000003',
    9,
    10,
    '2023-03-12',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000003',
    'DS000002',
    'EE000003',
    9,
    20,
    '2023-03-12',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000003',
    'DS000007',
    'EE000003',
    10,
    30,
    '2023-03-11',
    '2023-03-11',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000007',
    'EE000003',
    11,
    20,
    '2023-03-18',
    '2023-03-18',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000003',
    'DS000007',
    'EE000003',
    11,
    30,
    '2023-03-18',
    '2023-03-18',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000009',
    'EE000003',
    12,
    0,
    '2023-03-17',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000009',
    'EE000003',
    13,
    25,
    '2023-03-17',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000002',
    'EE000003',
    14,
    10,
    '2023-04-06',
    NULL,
    NULL,
    12,
    323,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000007',
    'EE000003',
    15,
    10,
    '2023-04-01',
    '2023-04-04',
    NULL,
    75.3854,
    5,
    11.275,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000002',
    'DS000005',
    'EE000003',
    16,
    50,
    '2023-04-01',
    '2023-04-04',
    28.875,
    75.3854,
    5,
    11.275,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000001',
    'EE000003',
    17,
    40,
    '2023-04-12',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `fertilizertimes` (
    `RiceCropInformation_id`,
    `Fertilizer_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `FertilizerTimes_times`,
    `FertilizerTimes_amount`,
    `FertilizerTimes_startDate`,
    `FertilizerTimes_endDate`,
    `FertilizerTimes_temperature`,
    `FertilizerTimes_humidity`,
    `FertilizerTimes_precipitation`,
    `FertilizerTimes_windSpeed`,
    `FertilizerTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000005',
    'DS000006',
    'EE000003',
    18,
    50,
    '2023-04-26',
    '2023-04-27',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: image
# ------------------------------------------------------------

INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677483224267_Rice7.png', 16);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677483707198_Rice7.png', 17);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677564322045_Rice6.jpg', 18);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677564336573_Rice2.png', 19);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677564347533_rice5.png', 20);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677564973808_Rice6.jpg', 21);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677564984621_Rice12.jpg', 22);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677564995828_Rice10.jpg', 23);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677565007924_Rice13.jpg', 24);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677569470219_Rice12.jpg', 25);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677569492566_Rice10.jpg', 26);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677569653529_Rice7.png', 27);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677572498484_Rice14.jpg', 28);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1677575228503_image_1677569470219_Rice12.jpg',
    29
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1677583998748_image_1677565007924_Rice13.jpg',
    30
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1677584049825_image_1677569470219_Rice12.jpg',
    31
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1677585360113_image_1677565007924_Rice13.jpg',
    32
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677992394695_Rice8.jpg', 33);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1677993837001_Rice10.jpg', 34);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1680752291932_Rice12.jpg', 35);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1680752370100_Rice14.jpg', 36);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1680753100242_Rice10.jpg', 37);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1680753420914_Rice6.jpg', 38);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1680835800520_Rice10.jpg', 39);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681373511247_Rice14.jpg', 40);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1681390561220_image_1680835800520_Rice10.jpg',
    41
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681390793115_image.jpg', 42);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681565380697_tham-dong.jpg', 43);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681565511625_tham-dong.jpg', 44);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681574178035_Rice8.jpg', 45);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1681577925115_image_1677992394695_Rice8.jpg',
    46
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681621101727_Rice14.jpg', 47);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1681621114195_image_1677564995828_Rice10.jpg',
    48
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1681621137079_image_1680752291932_Rice12.jpg',
    49
  );
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  ('image_1681802356935_saubenh.png', 50);
INSERT INTO
  `image` (`Image_link`, `id`)
VALUES
  (
    'image_1681876202613_image_1677483707198_Rice7.png',
    51
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: images
# ------------------------------------------------------------

INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    44,
    '2023-01-28 13:05:22.000000',
    'image_1677564322045_Rice6.jpg',
    'RCI0000008',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    45,
    '2023-01-28 13:05:36.000000',
    'image_1677564336573_Rice2.png',
    'RCI0000010',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    46,
    '2023-01-28 13:05:47.000000',
    'image_1677564347533_rice5.png',
    'RCI0000011',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    47,
    '2023-01-28 13:16:13.000000',
    'image_1677564973808_Rice6.jpg',
    'RCI0000002',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    48,
    '2023-01-28 13:16:24.000000',
    'image_1677564984621_Rice12.jpg',
    'RCI0000001',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    49,
    '2023-01-28 13:16:35.000000',
    'image_1677564995828_Rice10.jpg',
    'RCI0000013',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    50,
    '2023-01-28 13:16:47.000000',
    'image_1677565007924_Rice13.jpg',
    'RCI0000012',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    51,
    '2023-01-28 14:31:10.000000',
    'image_1677569470219_Rice12.jpg',
    'RCI0000010',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    52,
    '2023-01-28 14:31:32.000000',
    'image_1677569492566_Rice10.jpg',
    'RCI0000011',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    53,
    '2023-01-28 14:34:13.000000',
    'image_1677569653529_Rice7.png',
    'RCI0000010',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    54,
    '2023-01-28 15:21:38.000000',
    'image_1677572498484_Rice14.jpg',
    'RCI0000002',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    57,
    '2023-01-28 18:34:09.000000',
    'image_1677584049825_image_1677569470219_Rice12.jpg',
    'RCI0000004',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    60,
    '2023-02-05 12:23:57.000000',
    'image_1677993837001_Rice10.jpg',
    'RCI0000004',
    ''
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    62,
    '2023-04-06 10:57:00.000000',
    'image_1680753420914_Rice6.jpg',
    'RCI0000004',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    64,
    '2023-04-13 03:11:51.000000',
    'image_1681373511247_Rice14.jpg',
    'RCI0000001',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    65,
    '2023-04-13 07:56:01.000000',
    'image_1681390561220_image_1680835800520_Rice10.jpg',
    'RCI0000001',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    66,
    '2023-04-13 07:59:53.000000',
    'image_1681390793115_image.jpg',
    'RCI0000004',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    67,
    '2023-04-15 08:31:51.000000',
    'image_1681565511625_tham-dong.jpg',
    'RCI0000001',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    70,
    '2023-04-16 11:58:21.000000',
    'image_1681621101727_Rice14.jpg',
    'RCI0000011',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    71,
    '2023-04-16 11:58:34.000000',
    'image_1681621114195_image_1677564995828_Rice10.jpg',
    'RCI0000011',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    72,
    '2023-04-16 11:58:57.000000',
    'image_1681621137079_image_1680752291932_Rice12.jpg',
    'RCI0000011',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    73,
    '2023-04-18 02:19:17.000000',
    'image_1681802356935_saubenh.png',
    'RCI0000004',
    NULL
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`,
    `Image_location`
  )
VALUES
  (
    74,
    '2023-04-19 10:50:02.000000',
    'image_1681876202613_image_1677483707198_Rice7.png',
    'RCI0000001',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: monitor
# ------------------------------------------------------------

INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000001');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000005', 'RCI0000001');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000002');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000006', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000011', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000012', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000013', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000014', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000015', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000017', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000002', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000005', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000006', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000011', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000012', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000013', 'RCI0000008');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000010');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000011');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000006', 'RCI0000011');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000012', 'RCI0000011');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000012');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000013');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000014');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000015');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000016');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000017');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: nutrient
# ------------------------------------------------------------

INSERT INTO
  `nutrient` (`Nutrient_id`, `Nutrient_name`)
VALUES
  ('K', 'Kali');
INSERT INTO
  `nutrient` (`Nutrient_id`, `Nutrient_name`)
VALUES
  ('N', 'Đạm');
INSERT INTO
  `nutrient` (`Nutrient_id`, `Nutrient_name`)
VALUES
  ('P', 'Lân');
INSERT INTO
  `nutrient` (`Nutrient_id`, `Nutrient_name`)
VALUES
  ('Y', 'Khác');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: nutrientinfertilizer
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: otheractivities
# ------------------------------------------------------------

INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000001', 'Bơm nước vào ruộng');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000002', 'Bơm nước ra ruộng');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000003', 'Làm cỏ');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000004', 'Phơi đất');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000005', 'Gieo hạt');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000006', 'Dặm mạ');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000007', 'Nạo vét, Đào mương');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000008', 'Xới đất');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000009', 'ty');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000010', ' xz');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000011', ' xzds');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000012', 'cd');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000013', 'cdwq');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA00000016', 'fef');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA14', 'tt');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA15', 'tt');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pesticide
# ------------------------------------------------------------

INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000001',
    'Chess 50WG',
    'Công ty TNHH Syngenta Việt Nam',
    'Ches 50WG tác động làm ngăn cản sự di chuyển và chích hút ở côn trùng thông qua quá trình can thiệp vào sự tương tác giữa các dây thần kinh điều khiển cơ,dẫn đến rối loạn và mất khả năng di chuyển đặc biệt là ở chân sau. Đồng thời, ngăn cản việc đưa vòi chích hút vaofmoo thực vật, gây hiện tượng ngán ăn, cuối cùng côn trùng bị chết vì đói.',
    'gf',
    'gf'
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000002',
    'Butyl 10wp',
    'Công ty cổ phần bảo vệ thực vật Sài Gòn',
    'BUTYL 10 WP là loại thuốc đặc trị rầy nâu trên lúa, chè. Thuốc có tác dụng ức chế sự hình thành chất chitin làm rầy non không lột xác được mà chết. Thuốc còn làm rầy trưởng thành đẻ ít trứng, trứng không nở được do đó hạn chế rất nhiều rầy non lứa sau, ngoài ra hiệu lực của thuốc còn kéo dài 15 - 20 ngày.',
    'tufmtdkktiyf',
    'kutf'
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000003',
    'Filia 52.5 SE',
    'sdws',
    'Thuốc đặc trị đạo ôn đột phá với thành phần hoạt chất lý tưởng giúp phòng và diệt sạch bệnh đạo ôn, cho lúa cứng cây, đứng lá, đỡ lo đổ ngã',
    'ig',
    'imdmytd'
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000004',
    'Agrilife 100SL',
    'Côn ty cổ phần đầu tư Hợp Trí',
    'AgriLife 100SL có thành phần gồm các acid hữu cơ (ascorbic acid, citric acid, lactic acid). Thuốc có phổ tác dụng rộng diệt trừ hiệu quả nhiều loại vi khuẩn và nấm gây hại trên nhiều loại cây trồng.\nAgriLife 100SL có tác dụng tiếp xúc, lưu dẫn mạnh, được cây hấp thụ nhanh chóng ngay sau khi phun thuốc và phân tán đều khắp các mô cây để ức chế hoạt động hệ thống men tế bào vi khuẩn và làm biến dạng vỏ tế bào của bào tử, sợi nấm nên làm khô nhanh vết bệnh và ngăn chặn khả năng lây lan của vi khuẩn, giúp cây phục hồi nhanh chóng.\nAgriLife 100SL còn giúp cây sản sinh hoạt chất Phytoalexin làm tăng tính đề kháng với bệnh hại.',
    ',g',
    'jg'
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000005',
    'VISEN 20SC',
    'Côn ty cổ phần thuốc sát trùng Việt Nam',
    'VISEN 20SC là thuốc trừ bệnh vi khuẩn chứa hoạt chất Saisentong thuộc thế hệ mới và thông minh nhất hiện nay.\nVISEN 20SC có tính lưu dẫn cực mạnh, thấm sâu nhanh vào trong cây ngay sau khi phun thuốc và di chuyển – phân tán đều khắp trong các mô cây. Được cây hấp thụ rất nhanh nên ít bị rửa trôi do mưa.\nVISEN 20SC có hiệu lực cao, tác dụng phòng trừ bệnh nhanh, triệt để và hiệu lực kéo dài.\nVISEN 20SC có tác dụng phổ rộng, phòng trừ hữu hiệu các loại bệnh do các nhóm vi khuẩn gây hại như Erwinia, Xanthomonas và Pseudomonas gây thối nhũn, héo xanh, cháy lá… đặc biệt là bệnh cháy bìa lá (bạc lá) hại lúa do Xanthomonas oryzae.',
    '',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000006',
    'Chevin 5SC',
    'Công ty cổ phân NICOTEX',
    'Đặc trị bệnh khô vằn, lem lép hạt hại lúa; rỉ sắt hại cà phê; vàng rụng lá hại cao su; ghẻ sẹo hại cam; thán thư, phấn trắng hại xoài.',
    '',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000007',
    'Butyl 400SC',
    'Công ty cổ phân bảo vệ thực vật Sài Gòn',
    'Butyl 400SC là thuốc trừ rầy thuộc nhóm điều tiết sinh trưởng côn trùng, ức chế hình thành chất kitin, làm rầy non không lột xác được mà chết, rầy trưởng thành không đẻ trứng. Hiệu quả trừ rầy kéo dài trên 20 ngày. Không hại các loài thiên địch, rất ít độc với người và tôm cá, rất phù hợp với chương trình quản lý dịch hại tổng hợp IPM. Có thể pha chung với các loại thuốc trừ sâu bệnh khác, trừ thuốc có gốc đồng và có tính kiềm cao (như dung dịch Bordeaux)... Pha xong phun ngay.',
    '',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000008',
    'DuponTMprevathon 5SC',
    'Công ty Du Pont Việt Nam',
    'Thuốc trừ sâu Dupont Prevathon 5SC là thuốc trừ sâu thế hệ mới. Sâu ngừng ăn ngay khi trúng thuốc. Phun 1 lần diệt cả sâu cuốn lá và sâu đục thân.',
    '',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  ('PE00000009', 'cdw', 'cưdq', 'a', 'bẻ', 'ebgre');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  ('PE00000010', 'fef', 'dcsa', 'cssa', ' e', 'ge');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000011',
    'Beam 75WP',
    'Công ty cổ phần khử trùng Việt Nam',
    'Thuốc đặc trị bệnh đạo ôn (đạo ôn lá, đạo ôn cổ bông). Dưỡng cây, giúp lúa sinh trưởng tốt hơn, năng suất cao hơn, hạt chắc sáng hơn, ít bị gãy nát khi xay',
    '',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000012',
    'CDS',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)',
    'd',
    '',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000015',
    'gtr',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)',
    'bt',
    'dq',
    'cq'
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  ('PE00000016', 'bf', 'bds', 'bds', 'bfs', 'bs');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_uses`,
    `Pesticide_directionsForUse`,
    `Pesticide_component`
  )
VALUES
  (
    'PE00000017',
    'Tho',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)',
    'FEW',
    'FEW',
    'fef'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: prediction
# ------------------------------------------------------------

INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    91,
    '2023-04-22 09:32:53.000000',
    6108.88,
    'RCI0000001',
    133.7,
    26.49,
    77.22,
    17.35,
    20.26,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    92,
    '2023-04-22 09:33:48.000000',
    5221.21,
    'RCI0000002',
    24.6,
    27.16,
    75.23,
    22.36,
    23.16,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    93,
    '2023-04-22 09:34:07.000000',
    7083.73,
    'RCI0000004',
    58.9,
    28.42,
    69.03,
    11.82,
    22.56,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    94,
    '2023-04-22 09:34:18.000000',
    7086.46,
    'RCI0000006',
    70.3,
    28.33,
    69.47,
    11.79,
    22.31,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    95,
    '2023-04-22 09:34:30.000000',
    5935.19,
    'RCI0000008',
    61.2,
    26.9,
    75.69,
    18.4,
    21.63,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    96,
    '2023-04-22 09:34:47.000000',
    5300.24,
    'RCI0000009',
    24.6,
    27.17,
    75.07,
    22.29,
    23.2,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    97,
    '2023-04-22 09:34:58.000000',
    6697.46,
    'RCI0000011',
    99.6,
    27.33,
    72.55,
    14.51,
    21.14,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    98,
    '2023-04-22 09:35:22.000000',
    6566.5,
    'RCI0000012',
    133.5,
    26.74,
    75.75,
    13.7,
    19.96,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    99,
    '2023-04-22 09:35:33.000000',
    6913.62,
    'RCI0000013',
    56,
    27.89,
    70.13,
    13.47,
    22,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    100,
    '2023-04-22 09:35:47.000000',
    5903.17,
    'RCI0000014',
    55.7,
    27,
    75.27,
    18.46,
    22.05,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    101,
    '2023-04-22 09:50:23.000000',
    5925.88,
    'RCI0000017',
    48.3,
    27.16,
    75.03,
    18.37,
    22.39,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    104,
    '2023-04-22 09:53:53.000000',
    6535.85,
    'RCI0000016',
    79.4,
    27.34,
    73.42,
    15.01,
    21.66,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    105,
    '2023-04-22 20:50:04.000000',
    6108.88,
    'RCI0000001',
    133.7,
    26.49,
    77.22,
    17.35,
    20.26,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    106,
    '2023-04-22 20:53:06.000000',
    7086.46,
    'RCI0000006',
    70.3,
    28.33,
    69.47,
    11.79,
    22.31,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    107,
    '2023-04-23 14:02:39.000000',
    7085.54,
    'RCI0000004',
    60.3,
    28.45,
    69.08,
    11.83,
    22.61,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    109,
    '2023-04-23 14:13:33.000000',
    7085.54,
    'RCI0000004',
    60.3,
    28.45,
    69.08,
    11.83,
    22.61,
    2,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    110,
    '2023-04-23 14:15:29.000000',
    7092.43,
    'RCI0000006',
    71.7,
    28.37,
    69.52,
    11.8,
    22.36,
    2,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    111,
    '2023-04-24 19:28:17.000000',
    5253.84,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    112,
    '2023-04-24 22:37:09.000000',
    5253.84,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    5.6,
    8.8,
    11.2
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    113,
    '2023-04-24 23:03:34.000000',
    582.509,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    5.6,
    8.8,
    11.2
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    114,
    '2023-04-24 23:06:59.000000',
    582.509,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    3.2,
    1.6,
    3.2
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    115,
    '2023-04-24 23:23:09.000000',
    582.509,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    116,
    '2023-04-24 23:24:19.000000',
    6626.98,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    117,
    '2023-04-24 23:31:17.000000',
    6403.69,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    118,
    '2023-04-24 23:32:00.000000',
    5253.84,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    2,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    119,
    '2023-04-24 23:34:26.000000',
    6403.69,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    120,
    '2023-04-24 23:34:32.000000',
    6403.69,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    121,
    '2023-04-24 23:40:21.000000',
    6403.69,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    122,
    '2023-04-24 23:43:51.000000',
    6403.69,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    123,
    '2023-04-24 23:47:29.000000',
    6403.69,
    'RCI0000002',
    28.3,
    27.21,
    75.34,
    22.21,
    23.19,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    124,
    '2023-04-24 23:48:47.000000',
    3833.68,
    'RCI0000004',
    58.3,
    28.49,
    69.05,
    11.78,
    22.62,
    1,
    75.8,
    54.06,
    17.32
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    125,
    '2023-04-25 00:28:10.000000',
    139.827,
    'RCI0000009',
    28.3,
    27.27,
    75.16,
    22.09,
    23.26,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    126,
    '2023-04-25 00:37:41.000000',
    2216,
    'RCI0000001',
    140,
    26.57,
    77.15,
    17.3,
    20.32,
    2,
    4.2,
    2.98,
    0.66
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    127,
    '2023-04-25 00:38:15.000000',
    6140,
    'RCI0000002',
    28.3,
    27.25,
    75.31,
    22.16,
    23.22,
    2,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    128,
    '2023-04-25 00:38:33.000000',
    6408.15,
    'RCI0000002',
    28.3,
    27.25,
    75.31,
    22.16,
    23.22,
    1,
    131.6,
    94.6,
    43
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    129,
    '2023-04-25 00:47:20.000000',
    286.26,
    'RCI0000006',
    69.7,
    28.44,
    69.42,
    11.73,
    22.43,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    130,
    '2023-04-25 00:48:09.000000',
    2345,
    'RCI0000006',
    69.7,
    28.44,
    69.42,
    11.73,
    22.43,
    2,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    131,
    '2023-04-25 00:48:57.000000',
    3610,
    'RCI0000004',
    58.3,
    28.53,
    68.99,
    11.75,
    22.67,
    2,
    75.8,
    54.06,
    17.32
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    132,
    '2023-04-25 00:49:27.000000',
    286.26,
    'RCI0000006',
    69.7,
    28.44,
    69.42,
    11.73,
    22.43,
    1,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    133,
    '2023-04-25 00:49:44.000000',
    2345,
    'RCI0000006',
    69.7,
    28.44,
    69.42,
    11.73,
    22.43,
    2,
    0,
    0,
    0
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    134,
    '2023-04-25 00:51:27.000000',
    4444,
    'RCI0000008',
    67.5,
    26.99,
    75.65,
    18.3,
    21.67,
    2,
    101,
    68.14,
    25.48
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    135,
    '2023-04-25 00:51:45.000000',
    4798.27,
    'RCI0000008',
    67.5,
    26.99,
    75.65,
    18.3,
    21.67,
    1,
    101,
    68.14,
    25.48
  );
INSERT INTO
  `prediction` (
    `Prediction_id`,
    `Prediction_date`,
    `Prediction_yield`,
    `RiceCropInformation_id`,
    `Prediction_precipitation`,
    `Prediction_temperature`,
    `Prediction_humitidity`,
    `Prediction_windSpeed`,
    `Prediction_solarRadiation`,
    `Algorithm_id`,
    `Prediction_N`,
    `Prediction_P`,
    `Prediction_K`
  )
VALUES
  (
    136,
    '2023-04-28 16:19:07.000000',
    3761.37,
    'RCI0000004',
    75.1,
    28.54,
    69.2,
    11.66,
    22.69,
    1,
    75,
    53.02,
    13.24
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: province
# ------------------------------------------------------------

INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (1, 'Bạc Liêu');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (2, 'Sóc Trăng');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (3, 'Hậu Giang');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (4, 'Cần Thơ');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (5, 'Kiên Giang');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (6, 'Trà Vinh');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (7, 'Vĩnh Long');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (8, 'Đồng Tháp');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (9, 'An Giang');
INSERT INTO
  `province` (`Province_id`, `Province_name`)
VALUES
  (10, 'Tiền Giang');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ricecropinformation
# ------------------------------------------------------------

INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000001',
    'SD00000001',
    'Vụ hè thu năm 2023',
    '2022-12-28',
    '2023-05-02',
    5055,
    'C00001',
    'AL00000001'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000002',
    'SD00000001',
    'Vụ Hè Thu năm 2023',
    '2023-02-08',
    '2023-05-02',
    4086,
    'C00002',
    'AL00000002'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000003',
    'SD00000001',
    'Vụ Hè Thu năm 2023',
    NULL,
    NULL,
    5686,
    'C00002',
    'AL00000003'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000004',
    'SD00000001',
    'Vụ Hè Thu năm 2023',
    '2023-02-22',
    NULL,
    0,
    'C00002',
    'AL00000004'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000005',
    'SD00000001',
    'Vụ Đông Xuân 2022',
    NULL,
    NULL,
    NULL,
    'C00001',
    'AL00000005'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000006',
    'SD00000001',
    'Vụ Đông Xuân 2023',
    '2023-02-19',
    NULL,
    73.2,
    'C00001',
    'AL00000006'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000007',
    'SD00000001',
    'VỤ Đông Xuân 2023',
    '2023-02-26',
    NULL,
    NULL,
    'C00001',
    'AL00000007'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000008',
    'SD00000001',
    'Vụ Mùa 2022',
    '2023-01-20',
    NULL,
    NULL,
    'C00003',
    'AL00000008'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000009',
    'SD00000002',
    'Vụ Đông Xuân 2022',
    '2023-02-10',
    NULL,
    23.6,
    'C00001',
    'AL00000009'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000010',
    'SD00000003',
    'Vụ Đông Xuân 2022',
    '2023-02-26',
    NULL,
    NULL,
    'C00001',
    'AL00000010'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000011',
    'SD00000001',
    'Vụ mùa 2023',
    '2023-01-31',
    NULL,
    NULL,
    'C00003',
    'AL00000011'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000012',
    'SD00000003',
    'Vụ mùa 2022',
    '2023-01-06',
    NULL,
    NULL,
    'C00003',
    'AL00000012'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000013',
    'SD00000002',
    'Vụ Đông Xuân 2023',
    '2023-02-17',
    NULL,
    NULL,
    'C00001',
    'AL00000013'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000014',
    'SD00000002',
    'Vụ Đông Xuân 2023',
    '2023-01-29',
    '2023-04-17',
    5879,
    'C00001',
    'AL00000001'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000015',
    'SD00000002',
    'Vụ Đông Xuân 2023',
    '2023-01-24',
    '2023-04-17',
    6024,
    'C00001',
    'AL00000001'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000016',
    'SD00000001',
    'Vụ Mùa 2022',
    '2023-02-08',
    NULL,
    NULL,
    'C00003',
    'AL00000015'
  );
INSERT INTO
  `ricecropinformation` (
    `RiceCropInformation_id`,
    `Seed_id`,
    `RiceCropInformation_name`,
    `RiceCropInformation_sowingDate`,
    `RiceCropInformation_harvestDate`,
    `RiceCropInformation_yield`,
    `Crop_id`,
    `ArableLand_id`
  )
VALUES
  (
    'RCI0000017',
    'SD00000008',
    'KT223',
    '2023-02-07',
    NULL,
    NULL,
    'C00002',
    'AL00000001'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: role
# ------------------------------------------------------------

INSERT INTO
  `role` (`Role_id`, `Role_name`)
VALUES
  ('01', 'Quản trị viên');
INSERT INTO
  `role` (`Role_id`, `Role_name`)
VALUES
  ('02', 'Chuyên gia');
INSERT INTO
  `role` (`Role_id`, `Role_name`)
VALUES
  ('03', 'Nhân viên');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: seed
# ------------------------------------------------------------

INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000001',
    'ST25',
    'Giống lúa ST25 là giống lúa thuộc dòng thơm, có tính chịu mặn tốt, chống được nhiều bệnh hại và có phổ thích nghi rộng. Có thể gieo cấy 2 vụ trong năm, thời gian mỗi vụ từ 95-105 ngày. Cây lúa cao khoảng 100cm, hình dáng cao đẹp, ưa thâm canh và đẻ nhánh khá tốt, bông to nhiều hạt. Năng suất trung bình đạt từ 6,5- 7,0 tấn/ha, thâm canh cao có thể đạt trên 7,0 tấn/ha.',
    ' Doanh nghiệp tư nhân Hồ Quang Trí '
  );
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000002',
    'Giống lúa thuần năng suất chất lượng VNR20',
    'Chiều cao cây 95 - 100 cm, lá đòng hơi to bản, đứng, đẻ nhánh khỏe, tập trung, gọn khóm. Giống VNR20 thấp cây chống đổ tốt, chịu thâm canh, chống chịu trung bình với một số sâu bệnh hại chính, phạm vi thích ứng rộng. Năng suất trung bình 7,0- 7,5 tấn/ha, thâm canh đạt 8,0- 8,5 tấn/ha. ',
    'Công ty cổ phần tập đoàn giống cây trồng Việt Nam'
  );
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000003',
    'OM8017',
    'Chiều cao cây 100 - 110 cm, chống đổ khá, đẻ nhánh khỏe, dạng hình đẹp, lá đòng thẳng, trỗ bông tập trung; bông to, chiều dài của bông 25 - 26 cm, hạt thon dài, khối lượng 1000 hạt 26 - 27 gam. Chịu phèn và mặn khá, kháng rầy nâu và bệnh vàng lùn khá, chống chịu bệnh đạo ôn lá trung bình. Năng suất đạt 6,5 - 7,0 tấn/ha, thâm canh tốt đạt 7,5 - 8,0 tấn/ha.',
    ' Công ty CP Tập đoàn ThaiBinh Seed'
  );
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000004',
    ' Đài Thơm 8',
    'Chiều cao cây 95 - 100 cm, đẻ nhánh khỏe. Bộ lá đứng, xanh, hạt thon dài, màu vàng sáng. Chống chịu trung bình với một số loại sâu bệnh hại chính, chịu thâm canh, cứng cây chống đổ tốt. Gạo trong không bạc bụng, cơm trắng bóng, dẻo, thơm, vị đậm. Khối lượng 1000 hạt 23 - 24 gram, hạt gạo dài 6,7 mm, tỷ lệ D/R = 3,32, hàm lượng amylose thấp 16,29%. Năng suất trung bình 6,5 - 7,0 tấn/ha, thâm canh tốt đạt 8,0 - 9,0 tấn/ha.',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)'
  );
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000007',
    'OM 4900',
    'Chiều cao cây 95 - 105 cm, bông to đùm, cứng cây, ít đổ ngã. Thích nghi rộng, chịu phèn nhẹ. Thích hợp Đông Xuân, Hè Thu. Hạt Gạo dài trong, cơm mềm, thơm nhẹ.  Năng suất trung bình 6,0 - 8,0 tấn/ha. ',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)'
  );
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000008',
    'Giống lúa lai F1 KC06-1',
    'Chiều cao cây 90 - 105 cm, hạt dài, trong, bóng, không bạc bụng, cơm mềm, dẻo, thơm nhẹ, vị ngọt. Thích nghi rộng, chịu phèn, úng. Đẻ nhánh khỏe, cứng cây, Chống chịu sâu bệnh tốt, chống chịu đạo ôn tốt. Thích hợp: Đông Xuân, Hè Thu, Thu Đông. Năng suất bình quân từ 8,0-10 tấn/ha. ',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)'
  );
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  ('SD00000009', 'sac', 'cds', 'ca');
INSERT INTO
  `seed` (
    `Seed_id`,
    `Seed_name`,
    `Seed_characteristic`,
    `Seed_supplier`
  )
VALUES
  (
    'SD00000010',
    'Giống lúa thuần năng suất chất lượng VNR88',
    'Chiều cao cây 105-110 cm, bộ lá phẳng, hơi mỏng lá, bông to, xếp hạt trung bình, hạt hơi bầu, màu nâu nhạt, mỏ hạt thẳng, Chống chịu trung bình một số loài sâu bệnh hại chính, phạm vi thích ứng rộng. Năng suất trung bình 7,0-7,5 tấn/ha, thâm canh tốt có thể đạt 8,0-8,5 tấn/ha. Khối lượng 1000 hạt 23 - 24 g. ',
    'Công ty TNHH Lúa gạo Việt Nam (VINARICE)'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sensor
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sensorgroup
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: soil
# ------------------------------------------------------------

INSERT INTO
  `soil` (`Soil_id`, `Soil_name`)
VALUES
  ('SL00000001', 'Đất phù sa ven sông');
INSERT INTO
  `soil` (`Soil_id`, `Soil_name`)
VALUES
  ('SL00000002', 'Đất phù sa xa xông');
INSERT INTO
  `soil` (`Soil_id`, `Soil_name`)
VALUES
  ('SL00000003', 'Đất nhiễm phèn');
INSERT INTO
  `soil` (`Soil_id`, `Soil_name`)
VALUES
  ('SL00000004', 'Đất nhiễm mặn');
INSERT INTO
  `soil` (`Soil_id`, `Soil_name`)
VALUES
  ('SL00000005', 'Đất nhiễm mặn + phèn');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sprayingtimes
# ------------------------------------------------------------

INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000001',
    'PE00000001',
    'DS000001',
    'EE000002',
    1,
    20,
    '2023-05-03',
    '2023-05-05',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000001',
    'DS000002',
    'EE000003',
    1,
    15,
    '2023-02-26',
    '2023-02-26',
    27.2,
    54.42,
    0,
    24.9,
    24.59
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000001',
    'DS000006',
    'EE000003',
    2,
    40,
    '2023-03-18',
    '2023-03-21',
    28.93,
    68.56,
    0,
    11.3,
    22.78
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000001',
    'DS000004',
    'EE000003',
    3,
    20,
    '2023-03-27',
    '2023-03-29',
    29.3333,
    72.1111,
    0.3,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000001',
    'DS000005',
    'EE000003',
    4,
    10,
    '2023-04-01',
    '2023-04-05',
    28.92,
    75.82,
    6.6,
    11.42,
    21.64
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000001',
    'DS000006',
    'EE000003',
    5,
    50,
    '2023-04-28',
    '2023-04-29',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000002',
    'DS000006',
    'EE000003',
    2,
    80,
    '2023-03-18',
    '2023-03-22',
    28.96,
    69.74,
    0,
    11.88,
    22.87
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000002',
    'DS000004',
    'EE000003',
    3,
    10,
    '2023-03-27',
    '2023-03-29',
    29.3333,
    72.1111,
    0.3,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000003',
    'DS000007',
    'EE000003',
    6,
    40,
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000006',
    'DS000008',
    'EE000003',
    7,
    40,
    '2023-04-28',
    '2023-04-29',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000011',
    'DS000005',
    'EE000003',
    4,
    30,
    '2023-04-01',
    '2023-04-05',
    28.92,
    75.82,
    6.6,
    11.42,
    21.64
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000004',
    'PE00000011',
    'DS000008',
    'EE000003',
    8,
    70,
    '2023-04-29',
    '2023-04-30',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000001',
    'DS000003',
    'EE000003',
    1,
    1000,
    '2023-03-18',
    '2023-03-19',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000001',
    'DS000002',
    'EE000003',
    2,
    12,
    '2023-03-18',
    '2023-03-20',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000001',
    'DS000005',
    'EE000003',
    3,
    12,
    '2023-03-17',
    '2023-03-17',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000001',
    'DS000001',
    'EE000003',
    4,
    40,
    '2023-04-16',
    '2023-04-16',
    28.7,
    81.08,
    2.6,
    14.6,
    17.5
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000004',
    'DS000001',
    'EE000003',
    4,
    20,
    '2023-04-16',
    '2023-04-16',
    28.7,
    81.08,
    2.6,
    14.6,
    17.5
  );
INSERT INTO
  `sprayingtimes` (
    `RiceCropInformation_id`,
    `Pesticide_id`,
    `DevelopmentStage_id`,
    `Employee_id`,
    `SprayingTimes_times`,
    `SprayingTimes_amount`,
    `SprayingTimes_startDate`,
    `SprayingTimes_endDate`,
    `SprayingTimes_temperature`,
    `SprayingTimes_humidity`,
    `SprayingTimes_precipitation`,
    `SprayingTimes_windSpeed`,
    `SprayingTimes_solarRadiation`
  )
VALUES
  (
    'RCI0000017',
    'PE00000006',
    'DS000002',
    'EE000003',
    1,
    3,
    '2023-04-15',
    '2023-04-16',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: treatment
# ------------------------------------------------------------

INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000003', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000006', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000002', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000007', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000009', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000017', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000002', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000008', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000009', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000012', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000017', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000016', 'EC00000005');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000017', 'EC00000005');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000001', 'EC00000006');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000004', 'EC00000006');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000005', 'EC00000006');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000011', 'EC00000006');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000009', 'EC00000007');

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
