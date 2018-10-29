-- MySQL Script generated by MySQL Workbench
-- Mon 29 Oct 2018 03:01:39 PM EDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nmu
-- -----------------------------------------------------

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
  PRIMARY KEY (`wholesaler_id`),
  UNIQUE INDEX `wholesaler_code_UNIQUE` (`wholesaler_code` ASC))
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
-- Table `nmu`.`TravelAgency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`TravelAgency` (
  `ta_id` INT NOT NULL AUTO_INCREMENT,
  `agency_name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(1000) NULL,
  `email` VARCHAR(500) NULL,
  `phone` VARCHAR(45) NULL,
  `active_status` ENUM('Y', 'N') NOT NULL DEFAULT 'Y',
  `create_time` DATETIME NOT NULL,
  `address` VARCHAR(1000) NULL,
  `zipcode` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`ta_id`))
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
  `ta_id` INT NULL,
  PRIMARY KEY (`salesperson_id`),
  INDEX `fk_dep_id_idx` (`department_id` ASC),
  INDEX `fk_s_ta_id_idx` (`ta_id` ASC),
  CONSTRAINT `fk_dep_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `nmu`.`Department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_s_ta_id`
    FOREIGN KEY (`ta_id`)
    REFERENCES `nmu`.`TravelAgency` (`ta_id`)
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
  `group_code` VARCHAR(45) NULL,
  `salesperson_id` INT NOT NULL,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `duration` INT NULL,
  `flight_number` VARCHAR(100) NULL,
  `total_cost_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `total_cost` DECIMAL(11,2) NULL,
  `leader_number` INT NULL,
  `tourist_number` INT NULL,
  `exchange_rate_usd_rmb` DECIMAL(11,2) NULL,
  `received` VARCHAR(45) NULL DEFAULT 0,
  `received_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `extra_cost` VARCHAR(45) NULL,
  `extra_cost_currency` VARCHAR(45) NULL,
  PRIMARY KEY (`group_tour_id`),
  UNIQUE INDEX `tour_id_UNIQUE` (`group_tour_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  CONSTRAINT `gt_salesperson_id`
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
-- Table `nmu`.`McoPayment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`McoPayment` (
  `mp_id` INT NOT NULL AUTO_INCREMENT,
  `mco_party` VARCHAR(45) NULL,
  `face_value` VARCHAR(45) NULL,
  `mco_value` VARCHAR(45) NULL,
  `mco_credit` VARCHAR(45) NULL,
  `fee_ratio` VARCHAR(45) NULL,
  `face_currency` ENUM('USD', 'RMB') NULL,
  `mco_currency` ENUM('USD', 'RMB') NULL,
  `mco_credit_currency` ENUM('USD', 'RMB') NULL,
  PRIMARY KEY (`mp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`IndividualTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTour` (
  `indiv_tour_id` INT NOT NULL AUTO_INCREMENT,
  `wholesaler_id` INT NULL,
  `salesperson_id` INT NULL,
  `depart_date` DATETIME NULL,
  `arrival_date` DATETIME NULL,
  `product_code` VARCHAR(45) NOT NULL,
  `tour_name` VARCHAR(500) NULL,
  `exchange_rate` DECIMAL(11,2) NULL,
  `selling_price` DECIMAL(11,2) NULL DEFAULT 0,
  `selling_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `base_price` DECIMAL(11,2) NULL DEFAULT 0,
  `base_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `indiv_tour_invoice` VARCHAR(100) NULL DEFAULT '',
  `customer_id` INT NULL,
  `payment_type` ENUM('wholesalerall', 'wholesalercheck', 'wholesalercash', 'wholesaleralipay', 'wholesalerwechat', 'wholesalerremit', 'wholesalermco', 'mcoall', 'check', 'cash', 'alipay', 'wechat', 'remit') NULL,
  `mp_id` INT NULL,
  PRIMARY KEY (`indiv_tour_id`),
  INDEX `fk_wholesaler_id_idx` (`wholesaler_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_customer_id_indiv_idx` (`customer_id` ASC),
  INDEX `fk_mp_id_it_idx` (`mp_id` ASC),
  CONSTRAINT `fk_wholesaler_id`
    FOREIGN KEY (`wholesaler_id`)
    REFERENCES `nmu`.`Wholesaler` (`wholesaler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `it_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_id_indiv`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mp_id_it`
    FOREIGN KEY (`mp_id`)
    REFERENCES `nmu`.`McoPayment` (`mp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `youth_number` INT NULL,
  `child_number` INT NOT NULL DEFAULT 0,
  `infant_number` INT NOT NULL DEFAULT 0,
  `refunded` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  `itinerary` VARCHAR(5000) NULL,
  `invoice` VARCHAR(45) NOT NULL,
  `exchange_rate_usd_rmb` DECIMAL(11,2) NULL,
  `base_price` DECIMAL(11,2) NULL,
  `base_currency` ENUM('USD', 'RMB') NULL,
  `selling_price` DECIMAL(11,2) NULL,
  `selling_currency` ENUM('USD', 'RMB') NULL,
  `wholesaler_id` INT NULL,
  `deal_location` ENUM('CN', 'US') NULL,
  `mp_id` INT NULL,
  `payment_type` ENUM('cash', 'check', 'alipay', 'wechat', 'remit', 'airall', 'airmco') NULL,
  PRIMARY KEY (`airticket_tour_id`),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  INDEX `at_wholesaler_id_idx` (`wholesaler_id` ASC),
  INDEX `at_mp_id_idx` (`mp_id` ASC),
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
  CONSTRAINT `at_wholesaler_id`
    FOREIGN KEY (`wholesaler_id`)
    REFERENCES `nmu`.`Wholesaler` (`wholesaler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `at_mp_id`
    FOREIGN KEY (`mp_id`)
    REFERENCES `nmu`.`McoPayment` (`mp_id`)
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
-- Table `nmu`.`UserGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`UserGroup` (
  `user_group_id` INT NOT NULL,
  `group_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_group_id`))
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
-- Table `nmu`.`NoticeBoard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`NoticeBoard` (
  `notice_id` INT NOT NULL AUTO_INCREMENT,
  `valid_until` DATETIME NOT NULL,
  `edited_by` INT NOT NULL,
  `content` VARCHAR(1000) NULL,
  `gotop` ENUM('Y', 'N') NULL DEFAULT 'N',
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`notice_id`),
  INDEX `fk_user_id_nb_idx` (`edited_by` ASC),
  CONSTRAINT `fk_user_id_nb`
    FOREIGN KEY (`edited_by`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`McoInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`McoInfo` (
  `mco_id` INT NOT NULL AUTO_INCREMENT,
  `cardholder` VARCHAR(45) NULL,
  `card_number` VARCHAR(45) NULL,
  `exp_date` VARCHAR(4) NULL,
  `charging_amount_currency` VARCHAR(45) NULL,
  `charging_amount` VARCHAR(45) NULL,
  `notice_id` INT NULL,
  `used` ENUM('Y', 'N') NULL DEFAULT 'N',
  `create_time` DATETIME NULL,
  `note` VARCHAR(500) NULL,
  PRIMARY KEY (`mco_id`),
  INDEX `fk_McoInfo_notice_id_idx` (`notice_id` ASC),
  CONSTRAINT `fk_McoInfo_notice_id`
    FOREIGN KEY (`notice_id`)
    REFERENCES `nmu`.`NoticeBoard` (`notice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `create_time` DATETIME NOT NULL,
  `settle_time` DATETIME NULL,
  `currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `expense` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `received` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `total_profit` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `source_id` INT NULL DEFAULT 1,
  `note` VARCHAR(1000) NULL,
  `mco_id` INT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC),
  INDEX `fk_indiv_id_idx` (`indiv_tour_id` ASC),
  INDEX `fk_airticket_id_idx` (`airticket_tour_id` ASC),
  INDEX `fk_source_id_idx` (`source_id` ASC),
  UNIQUE INDEX `group_tour_id_UNIQUE` (`group_tour_id` ASC),
  UNIQUE INDEX `indiv_tour_id_UNIQUE` (`indiv_tour_id` ASC),
  UNIQUE INDEX `airticket_tour_id_UNIQUE` (`airticket_tour_id` ASC),
  INDEX `t_mco_id_idx` (`mco_id` ASC),
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
    ON UPDATE NO ACTION,
  CONSTRAINT `t_mco_id`
    FOREIGN KEY (`mco_id`)
    REFERENCES `nmu`.`McoInfo` (`mco_id`)
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
-- Table `nmu`.`OtherInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`OtherInfo` (
  `info_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `value` VARCHAR(45) NULL,
  PRIMARY KEY (`info_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`QuestionBoard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`QuestionBoard` (
  `question_id` INT NOT NULL AUTO_INCREMENT,
  `question_title` VARCHAR(1000) NOT NULL,
  `question_time` DATETIME NULL,
  `ask_salesperson_id` INT NULL,
  `answer_content` VARCHAR(1000) NULL,
  `question_status` ENUM('solved', 'pending') NOT NULL DEFAULT 'pending',
  `question_content` VARCHAR(5000) NULL,
  `ta_id` INT NULL,
  PRIMARY KEY (`question_id`),
  INDEX `fk_ask_salesperson_id_idx` (`ask_salesperson_id` ASC),
  INDEX `fk_qb_ta_id_idx` (`ta_id` ASC),
  CONSTRAINT `fk_ask_salesperson_id`
    FOREIGN KEY (`ask_salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qb_ta_id`
    FOREIGN KEY (`ta_id`)
    REFERENCES `nmu`.`TravelAgency` (`ta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`AirSchedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirSchedule` (
  `as_id` INT NOT NULL AUTO_INCREMENT,
  `airticket_tour_id` INT NOT NULL,
  `depart_airport` VARCHAR(45) NULL,
  `arrival_airport` VARCHAR(45) NULL,
  `depart_date` DATETIME NULL,
  `flight_number` VARCHAR(45) NULL,
  PRIMARY KEY (`as_id`),
  INDEX `fk_as_airticket_tour_id_idx` (`airticket_tour_id` ASC),
  CONSTRAINT `fk_as_airticket_tour_id`
    FOREIGN KEY (`airticket_tour_id`)
    REFERENCES `nmu`.`AirticketTour` (`airticket_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`AirScheduleIntegrated`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirScheduleIntegrated` (
  `as_integrated_id` INT NOT NULL AUTO_INCREMENT,
  `all_schedule` VARCHAR(500) NULL,
  `airticket_tour_id` INT NULL,
  PRIMARY KEY (`as_integrated_id`),
  INDEX `fk_asi_at_id_idx` (`airticket_tour_id` ASC),
  CONSTRAINT `fk_asi_at_id`
    FOREIGN KEY (`airticket_tour_id`)
    REFERENCES `nmu`.`AirticketTour` (`airticket_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`ThingsToDo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`ThingsToDo` (
  `tto_id` INT NOT NULL AUTO_INCREMENT,
  `create_time` DATETIME NOT NULL,
  `content` VARCHAR(500) NULL,
  `user_id` INT NULL,
  `importance` ENUM('highlight', 'normal') NULL DEFAULT 'normal',
  `type` ENUM('calendar', 'notice') NULL,
  `title` VARCHAR(45) NULL,
  PRIMARY KEY (`tto_id`),
  INDEX `fk_user_id_tto_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_id_tto`
    FOREIGN KEY (`user_id`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`FrequentWords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`FrequentWords` (
  `title_id` INT NOT NULL AUTO_INCREMENT,
  `words` VARCHAR(1000) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`title_id`),
  INDEX `fk_fw_user_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_fw_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`GroupTourGuideDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTourGuideDetails` (
  `gd_id` INT NOT NULL AUTO_INCREMENT,
  `guide_id` INT NOT NULL,
  `group_tour_id` INT NOT NULL,
  `write_off` DECIMAL(11,2) NOT NULL,
  `write_off_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `reserve` DECIMAL(11,2) NULL,
  PRIMARY KEY (`gd_id`),
  INDEX `fk_group_tour_id_gtg_idx` (`group_tour_id` ASC),
  INDEX `fk_tour_guide_gtg_idx` (`guide_id` ASC),
  CONSTRAINT `fk_group_tour_id_gtg`
    FOREIGN KEY (`group_tour_id`)
    REFERENCES `nmu`.`GroupTour` (`group_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tour_guide_gtg`
    FOREIGN KEY (`guide_id`)
    REFERENCES `nmu`.`TouristGuide` (`guide_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`GroupTourReceived`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTourReceived` (
  `gtr_id` INT NOT NULL AUTO_INCREMENT,
  `group_tour_id` INT NOT NULL,
  `payment_amount` DECIMAL(11,2) NULL,
  `received` DECIMAL(11,2) NULL DEFAULT 0,
  `received_currency` ENUM('USD', 'RMB') NULL DEFAULT 'USD',
  `payment_type` ENUM('wholesalerall', 'wholesalercheck', 'wholesalercash', 'wholesaleralipay', 'wholesalerwechat', 'wholesalerremit', 'wholesalermco', 'mcoall', 'check', 'cash', 'alipay', 'wechat', 'remit') NULL,
  `title` VARCHAR(45) NULL,
  `mp_id` INT NULL,
  PRIMARY KEY (`gtr_id`),
  INDEX `fk_mp_id_gtr_idx` (`mp_id` ASC),
  CONSTRAINT `fk_mp_id_gtr`
    FOREIGN KEY (`mp_id`)
    REFERENCES `nmu`.`McoPayment` (`mp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`UpdateLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`UpdateLog` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_id` INT NULL,
  `name` VARCHAR(45) NULL,
  `value_before` DECIMAL(11,2) NULL,
  `value_after` DECIMAL(11,2) NULL,
  `value_difference` DECIMAL(11,2) NULL,
  `currency_before` ENUM('USD', 'RMB') NULL,
  `currency_after` ENUM('USD', 'RMB') NULL,
  `revised_by` INT NULL,
  `revised_time` DATETIME NULL,
  PRIMARY KEY (`log_id`),
  INDEX `ul_fk_transaction_id_idx` (`transaction_id` ASC),
  INDEX `ul_fk_user_id_idx` (`revised_by` ASC),
  CONSTRAINT `ul_fk_transaction_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `nmu`.`Transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ul_fk_user_id`
    FOREIGN KEY (`revised_by`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`NoticeTarget`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`NoticeTarget` (
  `nt_id` INT NOT NULL AUTO_INCREMENT,
  `notice_id` INT NULL,
  `target_id` INT NULL,
  PRIMARY KEY (`nt_id`),
  INDEX `fk_nt_notice_id_idx` (`notice_id` ASC),
  INDEX `fk_nt_target_id_idx` (`target_id` ASC),
  CONSTRAINT `fk_nt_notice_id`
    FOREIGN KEY (`notice_id`)
    REFERENCES `nmu`.`NoticeBoard` (`notice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nt_target_id`
    FOREIGN KEY (`target_id`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`WholesalerCollection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`WholesalerCollection` (
  `wc_id` INT NOT NULL AUTO_INCREMENT,
  `wholesaler_id` INT NULL,
  `group_tour_id` INT NULL,
  `payment_amount` DECIMAL(11,2) NULL,
  `payment_currency` ENUM('USD', 'RMB') NULL,
  `invoice` VARCHAR(100) NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`wc_id`),
  INDEX `wc_fk_wholesaler_id_idx` (`wholesaler_id` ASC),
  INDEX `wk_fk_group_tour_id_idx` (`group_tour_id` ASC),
  CONSTRAINT `wc_fk_wholesaler_id`
    FOREIGN KEY (`wholesaler_id`)
    REFERENCES `nmu`.`Wholesaler` (`wholesaler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `wk_fk_group_tour_id`
    FOREIGN KEY (`group_tour_id`)
    REFERENCES `nmu`.`GroupTour` (`group_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`LogLastEditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`LogLastEditor` (
  `lle_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_id` INT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`lle_id`),
  INDEX `lle_fk_transaction_id_idx` (`transaction_id` ASC),
  INDEX `lle_fk_user_id_idx` (`user_id` ASC),
  CONSTRAINT `lle_fk_transaction_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `nmu`.`Transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lle_fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`ExtensionActivation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`ExtensionActivation` (
  `ea_id` INT NOT NULL AUTO_INCREMENT,
  `extension_name` VARCHAR(45) NULL,
  `extension_status` VARCHAR(45) NULL,
  `extra_page` VARCHAR(45) NULL,
  PRIMARY KEY (`ea_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`TransactionCollections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`TransactionCollections` (
  `tc_id` INT NOT NULL AUTO_INCREMENT,
  `starter_id` INT NULL,
  `following_id` INT NULL,
  PRIMARY KEY (`tc_id`),
  INDEX `fk_following_id_idx` (`following_id` ASC),
  CONSTRAINT `fk_following_id`
    FOREIGN KEY (`following_id`)
    REFERENCES `nmu`.`Transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`McoParty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`McoParty` (
  `mpt_id` INT NOT NULL AUTO_INCREMENT,
  `party_title` VARCHAR(45) NULL,
  `party_order` INT NULL,
  PRIMARY KEY (`mpt_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`FinanceStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`FinanceStatus` (
  `fs_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_id` INT NOT NULL,
  `invoice` VARCHAR(45) NULL,
  `indiv_tour_id` INT NULL,
  `group_tour_id` INT NULL,
  `airticket_tour_id` INT NULL,
  `lock_status` ENUM('Y', 'N') NULL,
  `clear_status` ENUM('Y', 'N') NULL,
  `paid_status` ENUM('Y', 'N') NULL,
  `finish_status` ENUM('Y', 'N') NULL,
  `amount` DECIMAL(11,2) NULL,
  PRIMARY KEY (`fs_id`),
  INDEX `fk_transaction_id_fs_idx` (`transaction_id` ASC),
  INDEX `fk_indiv_tour_id_idx` (`indiv_tour_id` ASC),
  INDEX `fk_group_tour_id_fs_idx` (`group_tour_id` ASC),
  INDEX `gk_airticket_tour_id_fs_idx` (`airticket_tour_id` ASC),
  CONSTRAINT `fk_transaction_id_fs`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `nmu`.`Transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_indiv_tour_id_fs`
    FOREIGN KEY (`indiv_tour_id`)
    REFERENCES `nmu`.`IndividualTour` (`indiv_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_tour_id_fs`
    FOREIGN KEY (`group_tour_id`)
    REFERENCES `nmu`.`GroupTour` (`group_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gk_airticket_tour_id_fs`
    FOREIGN KEY (`airticket_tour_id`)
    REFERENCES `nmu`.`AirticketTour` (`airticket_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
