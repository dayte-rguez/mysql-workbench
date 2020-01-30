-- MySQL Workbench Synchronization
-- Generated: 2020-01-30 13:19
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: drodr

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `testcrm`.`people` (
  `people_id` INT(11) NOT NULL AUTO_INCREMENT,
  `people_first` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Holds contact first name',
  `people_last` VARCHAR(45) NULL DEFAULT NULL,
  `people_dob` DATETIME NULL DEFAULT NULL COMMENT 'Holds contact date of birth',
  `people_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The timestamp when this record was modified or updated',
  `people_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The timestamp when this record was created',
  `people_sex` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Possible values:\nM = Male\nF = Female',
  PRIMARY KEY (`people_id`),
  INDEX `idx_first` (`people_first` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `testcrm`.`company` (
  `company_id` INT(11) NOT NULL,
  `company_name` VARCHAR(45) NULL DEFAULT NULL,
  `company_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `company_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_id`),
  INDEX `name` (`company_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `testcrm`.`company_has_people` (
  `company_has_people_id` INT(11) NOT NULL AUTO_INCREMENT,
  `company_company_id` INT(11) NOT NULL,
  `people_people_id` INT(11) NOT NULL,
  PRIMARY KEY (`company_has_people_id`, `company_company_id`, `people_people_id`),
  INDEX `fk_company_has_people_company_idx` (`company_company_id` ASC) VISIBLE,
  INDEX `fk_company_has_people_people1_idx` (`people_people_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_has_people_company`
    FOREIGN KEY (`company_company_id`)
    REFERENCES `testcrm`.`company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_has_people_people1`
    FOREIGN KEY (`people_people_id`)
    REFERENCES `testcrm`.`people` (`people_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `testcrm`.`address` (
  `address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `address_street` VARCHAR(45) NULL DEFAULT NULL,
  `address_suite` VARCHAR(45) NULL DEFAULT NULL,
  `address_city` VARCHAR(45) NULL DEFAULT NULL,
  `address_state` VARCHAR(2) NULL DEFAULT NULL,
  `address_zip` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `idx_zip` (`address_zip` ASC) INVISIBLE,
  INDEX `idx_city` (`address_city` ASC) INVISIBLE,
  INDEX `idx_state` (`address_state` ASC) INVISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `testcrm`.`company_has_address` (
  `company_has_address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `company_company_id` INT(11) NOT NULL,
  `address_address_id` INT(11) NOT NULL,
  PRIMARY KEY (`company_has_address_id`, `company_company_id`),
  INDEX `fk_company_has_address_company1_idx` (`company_company_id` ASC) VISIBLE,
  INDEX `fk_company_has_address_address1_idx` (`address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_has_address_company1`
    FOREIGN KEY (`company_company_id`)
    REFERENCES `testcrm`.`company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_has_address_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `testcrm`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `testcrm`.`people_has_address` (
  `people_has_address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `people_people_id` INT(11) NOT NULL,
  `address_address_id` INT(11) NOT NULL,
  PRIMARY KEY (`people_has_address_id`, `people_people_id`),
  INDEX `fk_people_has_address_people1_idx` (`people_people_id` ASC) VISIBLE,
  INDEX `fk_people_has_address_address1_idx` (`address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_people_has_address_people1`
    FOREIGN KEY (`people_people_id`)
    REFERENCES `testcrm`.`people` (`people_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_people_has_address_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `testcrm`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
