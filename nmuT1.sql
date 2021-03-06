-- MySQL Script generated by MySQL Workbench
-- Mon 06 Aug 2018 04:31:57 PM EDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nmu
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nmu` ;

-- -----------------------------------------------------
-- Schema nmu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nmu` DEFAULT CHARACTER SET utf8 ;
USE `nmu` ;

-- -----------------------------------------------------
-- Table `nmu`.`Wholesaler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Wholesaler` (
  `wholesaler_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `description` VARCHAR(1000) NULL,
  `region` VARCHAR(45) NULL,
  `business_type` VARCHAR(45) NULL,
  `wholesaler_code` VARCHAR(45) NULL,
  `contact_person` VARCHAR(45) NULL,
  `contact_person_phone` VARCHAR(45) NULL,
  PRIMARY KEY (`wholesaler_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Salesperson` (
  `salesperson_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NULL,
  `salesperson_code` VARCHAR(45) NULL,
  `department_id` INT NOT NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `description` VARCHAR(500) NULL,
  `gender` ENUM('M', 'F', 'UNKNOWN') NOT NULL,
  `active_status` ENUM('Y', 'N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`salesperson_id`),
  INDEX `fk_dep_id_idx` (`department_id` ASC),
  CONSTRAINT `fk_dep_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `nmu`.`Department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`TouristGuide`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`TouristGuide` (
  `guide_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NOT NULL,
  `other_contact_type` ENUM('wechat', 'QQ', 'facebook') NULL,
  `other_contact_number` VARCHAR(50) NULL,
  `gender` ENUM('M', 'F', 'UNKNOWN') NOT NULL,
  `descriptions` VARCHAR(500) NULL,
  `age` INT NULL,
  PRIMARY KEY (`guide_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`GroupTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTour` (
  `group_tour_id` INT NOT NULL AUTO_INCREMENT,
  `group_code` VARCHAR(45) NOT NULL,
  `salesperson_id` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `duration` INT NOT NULL,
  `flight_number` VARCHAR(100) NULL,
  `bus_company` VARCHAR(5000) NULL,
  `reserve_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `reserve` DECIMAL(11,2) NOT NULL,
  `total_cost_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `total_cost` DECIMAL(11,2) NOT NULL,
  `leader_number` INT NOT NULL,
  `tourist_number` INT NOT NULL,
  `wholesaler_id` INT NULL,
  `exchange_rate_usd_rmb` DECIMAL(11,2) NULL,
  `total_received` VARCHAR(45) NULL,
  PRIMARY KEY (`group_tour_id`),
  UNIQUE INDEX `tour_id_UNIQUE` (`group_tour_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  UNIQUE INDEX `group_code_UNIQUE` (`group_code` ASC),
  INDEX `fk_wholesaler_id_gt_idx` (`wholesaler_id` ASC),
  CONSTRAINT `gt_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wholesaler_id_gt`
    FOREIGN KEY (`wholesaler_id`)
    REFERENCES `nmu`.`Wholesaler` (`wholesaler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`CouponCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`CouponCode` (
  `cc_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(100) NOT NULL,
  `discount` DECIMAL(11,2) NOT NULL,
  `code_expired` ENUM('Y', 'N') NOT NULL COMMENT 'Y/N',
  `salesperson_id` INT NULL,
  `description` VARCHAR(500) NULL,
  `currency` ENUM('RMB', 'USD') NULL DEFAULT 'USD',
  PRIMARY KEY (`cc_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `cc_fk_salesperson_id_idx` (`salesperson_id` ASC),
  CONSTRAINT `cc_fk_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`IndividualTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTour` (
  `indiv_tour_id` INT NOT NULL AUTO_INCREMENT,
  `wholesaler_id` INT NULL,
  `salesperson_id` INT NULL,
  `indiv_number` INT NULL,
  `depart_date` DATETIME NULL,
  `arrival_date` DATETIME NULL,
  `product_code` VARCHAR(45) NOT NULL,
  `tour_name` VARCHAR(500) NULL,
  `exchange_rate` DECIMAL(11,2) NULL,
  PRIMARY KEY (`indiv_tour_id`),
  INDEX `fk_wholesaler_id_idx` (`wholesaler_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  CONSTRAINT `fk_wholesaler_id`
    FOREIGN KEY (`wholesaler_id`)
    REFERENCES `nmu`.`Wholesaler` (`wholesaler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `it_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `other_contact_type` VARCHAR(45) NULL,
  `other_contact_number` VARCHAR(45) NULL,
  `birth_date` DATETIME NULL,
  `gender` ENUM('M', 'F', 'UNKNOWN') NULL,
  `zipcode` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`AirticketTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirticketTour` (
  `airticket_tour_id` INT NOT NULL AUTO_INCREMENT,
  `salesperson_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `flight_code` VARCHAR(45) NULL,
  `locators` VARCHAR(10) NOT NULL,
  `ticket_type` ENUM('group', 'individual') NULL,
  `round_trip` ENUM('round', 'oneway') NULL,
  `adult_number` INT NOT NULL DEFAULT 0,
  `child_number` INT NOT NULL DEFAULT 0,
  `infant_number` INT NOT NULL DEFAULT 0,
  `refunded` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  `passenger_name` VARCHAR(500) NULL,
  `itinerary` VARCHAR(5000) NULL,
  `invoice` VARCHAR(45) NOT NULL,
  `ta_id` INT NULL DEFAULT 1,
  `exchange_rate_usd_rmb` DECIMAL(11,2) NULL,
  `base_price` DECIMAL(11,2) NULL,
  `base_currency` ENUM('USD', 'RMB') NULL,
  `sale_price` DECIMAL(11,2) NULL,
  `sale_currency` ENUM('USD', 'RMB') NULL,
  `received2` DECIMAL(11,2) NULL,
  `received2_currency` ENUM('USD', 'RMB') NULL,
  PRIMARY KEY (`airticket_tour_id`),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  INDEX `at_ta_id_idx` (`ta_id` ASC),
  CONSTRAINT `at_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `at_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `at_ta_id`
    FOREIGN KEY (`ta_id`)
    REFERENCES `nmu`.`TravelAgency` (`ta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`CustomerSource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`CustomerSource` (
  `source_id` INT NOT NULL AUTO_INCREMENT,
  `source_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE INDEX `sourse_name_UNIQUE` (`source_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('airticket', 'group', 'individual') NOT NULL,
  `group_tour_id` INT NULL,
  `indiv_tour_id` INT NULL,
  `airticket_tour_id` INT NULL,
  `salesperson_id` INT NULL,
  `cc_id` INT NULL,
  `expense` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `received` DECIMAL(11,2) NOT NULL,
  `payment_type` ENUM('creditcard', 'mco', 'alipay', 'wechat', 'cash', 'check', 'other', 'multiple', 'remit') NOT NULL,
  `total_profit` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `note` VARCHAR(1000) NULL,
  `create_time` DATETIME NOT NULL,
  `source_id` INT NULL DEFAULT 1,
  `lock_status` ENUM('Y', 'N') NOT NULL,
  `clear_status` ENUM('Y', 'N') NOT NULL,
  `coupon` DECIMAL(11,2) NULL DEFAULT 0,
  `currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `settle_date` DATETIME NULL,
  `coupon_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC),
  INDEX `fk_cc_id_idx` (`cc_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_indiv_id_idx` (`indiv_tour_id` ASC),
  INDEX `fk_airticket_id_idx` (`airticket_tour_id` ASC),
  INDEX `fk_source_id_idx` (`source_id` ASC),
  UNIQUE INDEX `group_tour_id_UNIQUE` (`group_tour_id` ASC),
  UNIQUE INDEX `indiv_tour_id_UNIQUE` (`indiv_tour_id` ASC),
  UNIQUE INDEX `airticket_tour_id_UNIQUE` (`airticket_tour_id` ASC),
  CONSTRAINT `fk_cc_id`
    FOREIGN KEY (`cc_id`)
    REFERENCES `nmu`.`CouponCode` (`cc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tr_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_indiv_id`
    FOREIGN KEY (`indiv_tour_id`)
    REFERENCES `nmu`.`IndividualTour` (`indiv_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_airticket_id`
    FOREIGN KEY (`airticket_tour_id`)
    REFERENCES `nmu`.`AirticketTour` (`airticket_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_source_id`
    FOREIGN KEY (`source_id`)
    REFERENCES `nmu`.`CustomerSource` (`source_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_id`
    FOREIGN KEY (`group_tour_id`)
    REFERENCES `nmu`.`GroupTour` (`group_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`UserAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`UserAccount` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` VARCHAR(8) NOT NULL,
  `password` VARCHAR(500) NOT NULL,
  `user_group_id` INT NOT NULL,
  `last_time_login` DATETIME NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_group_id_idx` (`user_group_id` ASC),
  UNIQUE INDEX `account_id_UNIQUE` (`account_id` ASC),
  CONSTRAINT `fk_user_group_id_ua`
    FOREIGN KEY (`user_group_id`)
    REFERENCES `nmu`.`UserGroup` (`user_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`OtherInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`OtherInfo` (
  `info_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `value` VARCHAR(45) NULL,
  PRIMARY KEY (`info_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
