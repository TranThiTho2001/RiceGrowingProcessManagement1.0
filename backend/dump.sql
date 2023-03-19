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
# SCHEMA DUMP FOR TABLE: arableland
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `arableland` (
  `ArableLand_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ArableLand_location` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Soil_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ArableLand_area` float NOT NULL,
  `ArableLand_owner` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ArableLand_id`),
  KEY `fk_soil` (`Soil_id`),
  CONSTRAINT `fk_soil` FOREIGN KEY (`Soil_id`) REFERENCES `soil` (`Soil_id`)
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
  `EpidemicsClassification_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Epidemic_id`),
  KEY `fk_EpidemicsClassification_Epidemics` (`EpidemicsClassification_id`),
  CONSTRAINT `fk_EpidemicsClassification_Epidemics` FOREIGN KEY (`EpidemicsClassification_id`) REFERENCES `epidemicsclassification` (`EpidemicsClassification_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: epidemicsclassification
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `epidemicsclassification` (
  `EpidemicsClassification_id` char(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `EpidemicsClassification_name` varchar(70) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`EpidemicsClassification_id`)
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
  `Fertilizer_description` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
  `Fertilizer_uses` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 35 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: images
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `images` (
  `Image_id` int NOT NULL AUTO_INCREMENT,
  `Image_date` datetime(6) DEFAULT NULL,
  `Image_link` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Image_id`),
  KEY `fk_image_cropinformation` (`RiceCropInformation_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 61 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

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
  `Pesticide_description` varchar(1000) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Pesticide_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: productivitypredictionresults
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `productivitypredictionresults` (
  `RiceCropInformation_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ProductivityPredictionResults_id` char(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `ProductivityPredictionResults_date` date NOT NULL,
  `ProductivityPredictionResults_Value` float NOT NULL,
  PRIMARY KEY (`ProductivityPredictionResults_id`),
  KEY `fk_idx` (`ProductivityPredictionResults_Value`),
  KEY `fk` (`RiceCropInformation_id`),
  CONSTRAINT `fk` FOREIGN KEY (`RiceCropInformation_id`) REFERENCES `ricecropinformation` (`RiceCropInformation_id`)
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA1',
    '2023-05-03',
    '2023-05-04',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    0
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA2',
    '2023-03-01',
    '2023-03-16',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    1
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA3',
    '2023-03-08',
    '2023-03-15',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000002',
    1
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA1',
    '2023-02-08',
    '2023-03-10',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    2
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA2',
    '2023-02-10',
    NULL,
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    2
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA3',
    '2023-03-11',
    '2023-03-16',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000002',
    2
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
    `ActivityDetails_times`
  )
VALUES
  (
    'RCI0000004',
    'OA1',
    '2023-03-25',
    '2023-03-27',
    NULL,
    NULL,
    NULL,
    'EE000003',
    'DS000001',
    3
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: arableland
# ------------------------------------------------------------

INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000001',
    'Sóc Trăng',
    'SL00000001',
    10000,
    'Trần Văn Anh'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000002',
    'Cần Thơ',
    'SL00000005',
    10,
    'Phan Văn A'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000003',
    'Hậu Giang',
    'SL00000003',
    10,
    'Phan Văn A'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000004',
    'An Giang',
    'SL00000005',
    30,
    'Trần Văn Thanh'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000005',
    'An Giang',
    'SL00000002',
    30,
    'Phan Văn A'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000006',
    'An Giang',
    'SL00000002',
    50,
    'Phan Văn G'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000007',
    'Trà Vinh',
    'SL00000002',
    30,
    'Phan Văn A'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000008',
    'Long An',
    'SL00000002',
    50,
    'Phan Thanh An'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000009',
    'Cà Mau',
    'SL00000002',
    100,
    'Trần Khánh Vân'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000010',
    'Sóc Trăng',
    'SL00000002',
    20,
    'Nguyễn Thanh Điền'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000011',
    'Hậu Giang',
    'SL00000001',
    16,
    'Võ Hoàng Anh'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000012',
    'Vĩnh Long',
    'SL00000001',
    32,
    'Lê Văn Hùng'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000013',
    'Cần Thơ',
    'SL00000005',
    24,
    'Thái Thanh Anh'
  );
INSERT INTO
  `arableland` (
    `ArableLand_id`,
    `ArableLand_location`,
    `Soil_id`,
    `ArableLand_area`,
    `ArableLand_owner`
  )
VALUES
  (
    'AL00000014',
    'Tiền Giang',
    'SL00000004',
    10,
    'Phan Văn A'
  );

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
    `Employee_email`
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
    'thob1906774@student.ctu.edu.vn'
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
    `Employee_email`
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
    'thob1906774@student.ctu.edu.vn'
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
    `Employee_email`
  )
VALUES
  (
    'EE000003',
    '02',
    'Võ Văn Hùng',
    'Nam',
    'Kỹ sư công nghệ thông tin',
    '0777888995',
    'Sóc Trăng',
    '123456788',
    '$2a$08$MzPU1xpCdiPklGiQaD7WxOld0j56/4c04NR4v56onEw8C2/4/TI0W',
    '1995-12-04',
    'thob1906774@student.ctu.edu.vn'
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
    `Employee_email`
  )
VALUES
  (
    'EE000005',
    '03',
    'Trần Thị Thơ',
    'Nữ',
    'Kỹ sư phần mềm',
    '0916985183',
    'Cù Lao Dung',
    '123456786',
    '$2a$08$/3SUR9ia4gf2WubhwO8Qz.qwRBFQ4HXJYI7dbyroPPTyYMsbyyFuS',
    '2023-02-04',
    'tranthitho09052001@gmail.com'
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
    `Employee_email`
  )
VALUES
  (
    'EE000010',
    '01',
    'Trần Thị Thơ',
    'Nữ',
    'Kỹ sư ',
    '0916985183',
    'Cù Lao Dung',
    '123456789013',
    '$2a$08$ASYsqiK0LoBvpP43tA7meOTnbdBhazgvp4rXW.A0JkKgkD1lHN1Di',
    '2023-03-10',
    'tranthitho09052001@gmail.com'
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
    `EpidemicsClassification_id`
  )
VALUES
  (
    'EC00000001',
    'Bệnh Khô vằn',
    'Triệu chứng vết bệnh ban đầu  trên cây lúa là những đốm hình bầu dục, màu xám trắng ở bẹ lá gần gốc lúa. Khi nấm tấn công lên lá thì vết bệnh không còn hình dạng nhất định mà loang lổ như hình vằn da hổ',
    'Quanh năm',
    'Nấm này phát sinh phát triển mạnh nhất khi cây lúa xanh tốt, gieo cấy dày, ruộng thấp trũng; thời tiết ấm áp, có nắng mưa xen kẽ.',
    'Làm bông bị lép, lửng',
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
    `EpidemicsClassification_id`
  )
VALUES
  (
    'EC00000002',
    'Rầy nâu',
    NULL,
    'Quanh năm',
    'Sống quanh gốc lúa ngay phần bẹ lá, phía trên mặt nước. Việc sử dụng quá mức urê và phân bón nitơ và thuốc sâu có thể dẫn đến bùng phát rầy nâu bằng cách tăng khả năng sinh sản của chúng, và bằng cách giảm các thiên địch của rầy nâu. Khí hậu ấm nóng, ẩm độ cao, mưa nắng xen kẽ và cấy nhiều giống nhiễm rầy thường phát sinh gây hại nặng',
    'Tác hại trực tiếp của rầy nâu là chích hút nhựa, làm cho cây lúa suy yếu, phát triển kém, lá vàng úa, rụi dần và khô héo đi gọi là “cháy rầy”. Tác hại gián tiếp của rầy nâu là truyền các bệnh siêu vi khuẩn cho lúa như bệnh lúa cỏ, lùn xoắn lá, vàng lùn. Rầy nâu nhỏ truyền bệnh lùn sọc đen',
    'ECC00001'
  );
INSERT INTO
  `epidemic` (
    `Epidemic_id`,
    `Epidemic_name`,
    `Epidemic_indication`,
    `Epidemic_timeOfDevelopment`,
    `Epidemic_developmentEnvironment`,
    `Epidemic_Harm`,
    `EpidemicsClassification_id`
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
    `EpidemicsClassification_id`
  )
VALUES
  (
    'EC00000005',
    'Lùn xoắn lá',
    'Triệu chứng vết bệnh ban đầu  trên cây lúa là những đốm hình bầu dục, màu xám trắng ở bẹ lá gần gốc lúa. Khi nấm tấn công lên lá thì vết bệnh không còn hình dạng nhất định mà loang lổ như hình vằn da hổ',
    'Quanh năm',
    'Nấm này phát sinh phát triển mạnh nhất khi cây lúa xanh tốt, gieo cấy dày, ruộng thấp trũng; thời tiết ấm áp, có nắng mưa xen kẽ.',
    'Làm bông bị lép, lửng',
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
    `EpidemicsClassification_id`
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
    `EpidemicsClassification_id`
  )
VALUES
  (
    'EC00000007',
    'cds',
    NULL,
    'cdsa',
    'cdsa',
    'cdsa',
    'ECC00002'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: epidemicsclassification
# ------------------------------------------------------------

INSERT INTO
  `epidemicsclassification` (
    `EpidemicsClassification_id`,
    `EpidemicsClassification_name`
  )
VALUES
  ('ECC00001', 'Côn trùng');
INSERT INTO
  `epidemicsclassification` (
    `EpidemicsClassification_id`,
    `EpidemicsClassification_name`
  )
VALUES
  ('ECC00002', 'Dịch bệnh');
INSERT INTO
  `epidemicsclassification` (
    `EpidemicsClassification_id`,
    `EpidemicsClassification_name`
  )
VALUES
  ('ECC00003', 'Nấm hại');
INSERT INTO
  `epidemicsclassification` (
    `EpidemicsClassification_id`,
    `EpidemicsClassification_name`
  )
VALUES
  ('ECC00004', 'Sâu hại');

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
    `EpidemicTimes_times`
  )
VALUES
  (
    '2023-05-03',
    '2023-05-04',
    NULL,
    NULL,
    NULL,
    'RCI0000001',
    'EC00000001',
    'DS000001',
    'EE000002',
    1
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
    `EpidemicTimes_times`
  )
VALUES
  (
    '2023-02-19',
    '2023-02-24',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000001',
    'DS000001',
    'EE000003',
    1
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
    `EpidemicTimes_times`
  )
VALUES
  (
    '2023-02-17',
    '2023-02-26',
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000002',
    'DS000002',
    'EE000003',
    2
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
    `EpidemicTimes_times`
  )
VALUES
  (
    '2023-03-16',
    NULL,
    NULL,
    NULL,
    NULL,
    'RCI0000004',
    'EC00000005',
    'DS000003',
    'EE000003',
    3
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
    `EpidemicTimes_times`
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
    1
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
    `EpidemicTimes_times`
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
    2
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fertilizer
# ------------------------------------------------------------

INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000001',
    'Phân bón NPK BigOne Lúa F2',
    'CÔNG TY CỔ PHẦN PHÂN BÓN HÀ LAN',
    '',
    ''
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000002',
    'NPK Hà Lan 20-0-10+TE',
    'Công ty cổ phần phân bón Hà Lan',
    '',
    ''
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000003',
    'NPK 16-16-8 Cà Mau',
    'Tập đoàn dầu khí quốc gia Việt Nam - Công ty cổ phần phân bón dầu khí Cà Mau',
    '',
    ''
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000004',
    'NPK 16-16-8 Phú Mỹ',
    'Công ty cổ phần phân bón và hóa chất dầu khí miền Bắc',
    '',
    ''
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000005',
    'NPK ĐẦU TRÂU 16-16-8+13S',
    'Công ty cổ phần phân bón Bình Điền',
    '- Đạm tổng số (Nts): 16%;\n- Lân hữu hiệu (P2O5hh): 16%;\n- Kali hữu hiệu (K2Ohh): 8%;\n- Lưu huỳnh (S): 13%;\n- Độ ẩm : ≤2,5%',
    '- Tăng sinh trưởng, phát triển và sức chống chịu điều kiện bất thuận.\n- Tăng năng suất, chất lượng nông sản và lợi nhuận.\n- Cải thiện độ phì nhiêu của đất.'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000006',
    'Phân bón SUPE LÂN Long Thành',
    'Công ty cổ phần phân bón miền Nam',
    '',
    ''
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000007',
    'Phân bón hữu cơ HUMIX',
    'Công ty cổ phần hữu cơ DAITO',
    '',
    ''
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000008',
    'Phân bón hữu cơ vi sinh BIOCARE 2 DTOGNFIT 2',
    'Công ty cổ phần Đại Thành',
    '- Chất hữu cơ: 45%\n- pH h2O: 5\n- Độ ẩm: 5%',
    'Phân bón hữu cơ vi sinh BIOCARE 2 DTOGNFIT 2 bổ sung sản phẩm từ các nguồn hữu cơ tự nhiên và dinh dưỡng hữu cơ cô đặc từ quá trình lên men nhiều sinh vật có ích: Bacillus sp, Trichodema, … giúp cây hấp thụ nhanh các chất dinh dưỡng để cải tạo đất và phòng nấm bệnh.'
  );
INSERT INTO
  `fertilizer` (
    `Fertilizer_id`,
    `Fertilizer_name`,
    `Fertilizer_supplier`,
    `Fertilizer_description`,
    `Fertilizer_uses`
  )
VALUES
  (
    'FR00000009',
    'NPK 28-8-6+TE (Chuyên dùng cho lúa)',
    'Công Ty cổ phần Phân bón Bình Điền',
    'Đạm: 28%; Lân; 8%; Kali: 6%; Độ ẩm: 2.5',
    'Thích hợp cho các giống lúa ngắn ngày. Giúp lúa non tăng trưởng nhanh, đẻ nhánh khoè. Giúp lúa có đòng to, trổ thoát, năng suất cao. Phù hợp cho các loại đất vùng ĐBSCL.'
  );

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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000002',
    'DS000001',
    'EE000003',
    1,
    20,
    '2023-03-03',
    '2023-03-05',
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000006',
    'DS000003',
    'EE000003',
    2,
    12,
    '2023-03-11',
    '2023-03-11',
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
    `FertilizerTimes_precipitation`
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
    '2023-02-17',
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
    `FertilizerTimes_precipitation`
  )
VALUES
  (
    'RCI0000008',
    'FR00000007',
    'DS000004',
    'EE000002',
    3,
    10,
    '2023-03-09',
    '2023-03-09',
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
    `FertilizerTimes_precipitation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000001',
    'DS000002',
    'EE000003',
    4,
    10,
    '2023-02-17',
    '2023-02-25',
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
  )
VALUES
  (
    'RCI0000004',
    'FR00000005',
    'DS000002',
    'EE000003',
    8,
    20,
    '2023-03-15',
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
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
    `FertilizerTimes_precipitation`
  )
VALUES
  (
    'RCI0000001',
    'FR00000001',
    'DS000001',
    'EE000003',
    23,
    10,
    '2023-02-22',
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

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: images
# ------------------------------------------------------------

INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    42,
    '2023-01-27 14:33:44.000000',
    'image_1677483224267_Rice7.png',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    43,
    '2023-01-27 14:41:47.000000',
    'image_1677483707198_Rice7.png',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    44,
    '2023-01-28 13:05:22.000000',
    'image_1677564322045_Rice6.jpg',
    'RCI0000008'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    45,
    '2023-01-28 13:05:36.000000',
    'image_1677564336573_Rice2.png',
    'RCI0000010'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    46,
    '2023-01-28 13:05:47.000000',
    'image_1677564347533_rice5.png',
    'RCI0000011'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    47,
    '2023-01-28 13:16:13.000000',
    'image_1677564973808_Rice6.jpg',
    'RCI0000002'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    48,
    '2023-01-28 13:16:24.000000',
    'image_1677564984621_Rice12.jpg',
    'RCI0000001'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    49,
    '2023-01-28 13:16:35.000000',
    'image_1677564995828_Rice10.jpg',
    'RCI0000013'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    50,
    '2023-01-28 13:16:47.000000',
    'image_1677565007924_Rice13.jpg',
    'RCI0000012'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    51,
    '2023-01-28 14:31:10.000000',
    'image_1677569470219_Rice12.jpg',
    'RCI0000010'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    52,
    '2023-01-28 14:31:32.000000',
    'image_1677569492566_Rice10.jpg',
    'RCI0000011'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    53,
    '2023-01-28 14:34:13.000000',
    'image_1677569653529_Rice7.png',
    'RCI0000010'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    54,
    '2023-01-28 15:21:38.000000',
    'image_1677572498484_Rice14.jpg',
    'RCI0000002'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    55,
    '2023-01-28 16:07:08.000000',
    'image_1677575228503_image_1677569470219_Rice12.jpg',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    56,
    '2023-01-28 18:33:18.000000',
    'image_1677583998748_image_1677565007924_Rice13.jpg',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    57,
    '2023-01-28 18:34:09.000000',
    'image_1677584049825_image_1677569470219_Rice12.jpg',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    58,
    '2023-01-28 18:56:00.000000',
    'image_1677585360113_image_1677565007924_Rice13.jpg',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    59,
    '2023-02-05 11:59:54.000000',
    'image_1677992394695_Rice8.jpg',
    'RCI0000004'
  );
INSERT INTO
  `images` (
    `Image_id`,
    `Image_date`,
    `Image_link`,
    `RiceCropInformation_id`
  )
VALUES
  (
    60,
    '2023-02-05 12:23:57.000000',
    'image_1677993837001_Rice10.jpg',
    'RCI0000004'
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
  ('EE000003', 'RCI0000002');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000001', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000002', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000005', 'RCI0000004');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000010', 'RCI0000004');
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
  ('EE000003', 'RCI0000010');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000011');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000012');
INSERT INTO
  `monitor` (`Employee_id`, `RiceCropInformation_id`)
VALUES
  ('EE000003', 'RCI0000013');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: nutrientinfertilizer
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: otheractivities
# ------------------------------------------------------------

INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA1', 'Bơm nước vào ruộng');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA2', 'Bơm nước ra ruộng');
INSERT INTO
  `otheractivities` (`OtherActivities_id`, `OtherActivities_name`)
VALUES
  ('OA3', 'Làm cỏ');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pesticide
# ------------------------------------------------------------

INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  (
    'PE00000001',
    'Chess 50WG',
    'Công ty TNHH Syngenta Việt Nam',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  (
    'PE00000002',
    'Butyl 10wp',
    'Công ty cổ phần bảo vệ thực vật Sài Gòn',
    ''
  );
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000003', 'htrht', 'sdws', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000004', 'gewa', 'grearg', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000005', 'bfdf', 'bfda', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000006', 'fef', 'cong ty ', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000007', 'fef', 'gsa', 'mgtf');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000008', 'fa', 'fthnf', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000009', 'cdw', 'cưdq', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  ('PE00000010', 'fef', 'dcsa', '');
INSERT INTO
  `pesticide` (
    `Pesticide_id`,
    `Pesticide_name`,
    `Pesticide_supplier`,
    `Pesticide_description`
  )
VALUES
  (
    'PE00000011',
    'Beam 75WP',
    'Công ty cổ phần khử trùng Việt Nam',
    'Thuốc đặc trị bệnh đạo ôn (đạo ôn lá, đạo ôn cổ bông). Dưỡng cây, giúp lúa sinh trưởng tốt hơn, năng suất cao hơn, hạt chắc sáng hơn, ít bị gãy nát khi xay'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: productivitypredictionresults
# ------------------------------------------------------------


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
    '2023-05-02',
    '2023-05-02',
    50.5,
    'C00002',
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
    'Hè Thu năm 2023',
    '2023-02-26',
    '2023-05-02',
    40.8,
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
    'Hè Thu năm 2023',
    NULL,
    NULL,
    56.8,
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
    'Hè Thu năm 2023',
    '2023-02-26',
    NULL,
    60.4,
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
    'Trần Thị Thơ',
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
    'ThoTho',
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
    'Trần Thị Thơ',
    NULL,
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
    '2023-02-26',
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
    '2023-02-25',
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
    '2022-10-17',
    '2023-04-17',
    50.8,
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
    '2022-04-17',
    '2022-09-17',
    47.3,
    'C00001',
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
    'Giống lúa ST25 là giống lúa thuộc dòng thơm, có tính chịu mặn tốt, chống được nhiều bệnh hại và có phổ thích nghi rộng. Có thể gieo cấy 2 vụ trong năm, thời gian mỗi vụ từ 95-105 ngày. Cây lúa cao khoảng 100cm, hình dáng cao đẹp, ưa thâm canh và đẻ nhánh khá tốt, bông to nhiều hạt.',
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
    'VNR20',
    'Chiều cao cây 95 - 100 cm, lá đòng hơi to bản, đứng, đẻ nhánh khỏe, tập trung, gọn khóm. Giống VNR20 thấp cây chống đổ tốt, chịu thâm canh, chống chịu trung bình với một số sâu bệnh hại chính, phạm vi thích ứng rộng.',
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
    'Chiều cao cây 100 - 110 cm, chống đổ khá, đẻ nhánh khỏe, dạng hình đẹp, lá đòng thẳng, trỗ bông tập trung; bông to, chiều dài của bông 25 - 26 cm, hạt thon dài, khối lượng 1000 hạt 26 - 27 gam. Chịu phèn và mặn khá, kháng rầy nâu và bệnh vàng lùn khá, chống chịu bệnh đạo ôn lá trung bình.',
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
  ('SD00000007', 'fcdes', 'vsđg', 'vds');

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
    `SprayingTimes_precipitation`
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
    `SprayingTimes_precipitation`
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
    `SprayingTimes_precipitation`
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
    `SprayingTimes_precipitation`
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
    `SprayingTimes_precipitation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000001',
    'DS000003',
    'EE000003',
    1,
    1000,
    '2023-03-19',
    '2023-03-19',
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
    `SprayingTimes_precipitation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000001',
    'DS000002',
    'EE000003',
    2,
    10,
    '2023-03-18',
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
    `SprayingTimes_precipitation`
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
    `SprayingTimes_precipitation`
  )
VALUES
  (
    'RCI0000008',
    'PE00000002',
    'DS000003',
    'EE000002',
    2,
    2000,
    '2023-03-17',
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
  ('PE00000001', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000004', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000005', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000006', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000008', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000010', 'EC00000001');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000002', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000004', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000005', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000006', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000009', 'EC00000002');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000001', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000003', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000004', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000006', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000007', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000008', 'EC00000003');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000003', 'EC00000005');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000004', 'EC00000005');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000005', 'EC00000005');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000006', 'EC00000005');
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
  ('PE00000006', 'EC00000006');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000008', 'EC00000006');
INSERT INTO
  `treatment` (`Pesticide_id`, `Epidemic_id`)
VALUES
  ('PE00000011', 'EC00000006');

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
