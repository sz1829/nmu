-- MySQL Script generated by MySQL Workbench
-- Wed Jul 18 18:02:48 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

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
  `bus_company` VARCHAR(100) NULL,
  `price` DECIMAL(11,2) NOT NULL,
  `reserve` DECIMAL(11,2) NOT NULL,
  `write_off` DECIMAL(11,2) NOT NULL,
  `total_cost` DECIMAL(11,2) NOT NULL,
  `other_expense` DECIMAL(11,2) NULL,
  `agency_name` VARCHAR(45) NOT NULL,
  `guide_id` INT NULL,
  `leader_number` INT NOT NULL,
  `tourist_number` INT NOT NULL,
  PRIMARY KEY (`group_tour_id`),
  UNIQUE INDEX `tour_id_UNIQUE` (`group_tour_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `tg_fk_guide_id_idx` (`guide_id` ASC),
  UNIQUE INDEX `group_code_UNIQUE` (`group_code` ASC),
  CONSTRAINT `gt_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tg_fk_guide_id`
    FOREIGN KEY (`guide_id`)
    REFERENCES `nmu`.`TouristGuide` (`guide_id`)
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
  `expense` DECIMAL(11,2) NOT NULL,
  `received` DECIMAL(11,2) NOT NULL,
  `received2` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `payment_type` ENUM('creditcard', 'mco', 'alipay', 'wechat', 'cash', 'check', 'other', 'multiple') NOT NULL,
  `total_profit` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `note` VARCHAR(1000) NULL,
  `create_time` DATETIME NOT NULL,
  `source_id` INT NULL DEFAULT 1,
  `currency` ENUM('USD', 'RMB') NOT NULL,
  `lock_status` ENUM('Y', 'N') NOT NULL,
  `clear_status` ENUM('Y', 'N') NOT NULL,
  `coupon` DECIMAL(11,2) NULL DEFAULT 0,
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
-- Table `nmu`.`TourDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`TourDetails` (
  `indiv_collection_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `indiv_tour_id` INT NOT NULL,
  `join_date` DATETIME NULL,
  `leave_date` DATETIME NULL,
  `join_location` VARCHAR(45) NULL,
  `leave_location` VARCHAR(45) NULL,
  `note` VARCHAR(500) NULL,
  `currency` ENUM('USD', 'RMB') NULL,
  `payment_type` ENUM('creditcard', 'mco', 'alipay', 'wechat', 'cash', 'check', 'other') NULL,
  `payment_amount` DECIMAL(11,2) NULL,
  `clear_status` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  `lock_status` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  `cc_id` INT NULL,
  `coupon` DECIMAL(11,2) NULL DEFAULT 0,
  PRIMARY KEY (`indiv_collection_id`),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  INDEX `fk_indiv_tour_id_idx` (`indiv_tour_id` ASC),
  INDEX `fk_cc_id_idx` (`cc_id` ASC),
  CONSTRAINT `ind_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_indiv_tour_id`
    FOREIGN KEY (`indiv_tour_id`)
    REFERENCES `nmu`.`IndividualTour` (`indiv_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cc_id_td`
    FOREIGN KEY (`cc_id`)
    REFERENCES `nmu`.`CouponCode` (`cc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  CONSTRAINT `fk_user_group_id`
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
  `ta_id` INT NULL DEFAULT 1,
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
-- Table `nmu`.`NoticeBoard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`NoticeBoard` (
  `notice_id` INT NOT NULL AUTO_INCREMENT,
  `valid_until` DATETIME NOT NULL,
  `edited_by` INT NOT NULL,
  `content` VARCHAR(1000) NULL,
  `char1` VARCHAR(45) NULL,
  `char2` VARCHAR(45) NULL,
  `char3` VARCHAR(45) NULL,
  PRIMARY KEY (`notice_id`),
  INDEX `fk_user_id_nb_idx` (`edited_by` ASC),
  CONSTRAINT `fk_user_id_nb`
    FOREIGN KEY (`edited_by`)
    REFERENCES `nmu`.`UserAccount` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`ThingsToDo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`ThingsToDo` (
  `tto_id` INT NOT NULL,
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

USE `nmu` ;

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`AirTicketTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirTicketTourOrder` (`transaction_id` INT, `'create_time'` INT, `salesperson_code` INT, `'name'` INT, `currency` INT, `payment_type` INT, `total_profit` INT, `received` INT, `received2` INT, `expense` INT, `coupon` INT, `flight_code` INT, `locators` INT, `invoice` INT, `ticket_type` INT, `round_trip` INT, `'passenger'` INT, `all_schedule` INT, `refunded` INT, `agency_name` INT, `source_name` INT, `note` INT, `clear_status` INT, `lock_status` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`GroupTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTourOrder` (`transaction_id` INT, `'create_time'` INT, `group_code` INT, `salesperson_code` INT, `'total_number'` INT, `currency` INT, `payment_type` INT, `'profit'` INT, `price` INT, `'cost'` INT, `flight_number` INT, `bus_company` INT, `'schedule'` INT, `'guide_name'` INT, `'guide_phone'` INT, `agency_name` INT, `source_name` INT, `'coupon'` INT, `clear_status` INT, `lock_status` INT, `note` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`IndividualTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTourOrder` (`transaction_id` INT, `'create_time'` INT, `product_code` INT, `tour_name` INT, `salesperson_code` INT, `wholesaler_code` INT, `currency` INT, `payment_type` INT, `total_profit` INT, `'revenue'` INT, `'cost'` INT, `indiv_number` INT, `'schedule'` INT, `source_name` INT, `note` INT, `lock_status` INT, `clear_status` INT, `coupon` INT);

-- -----------------------------------------------------
-- procedure insertOneRow
-- -----------------------------------------------------

DELIMITER $$
USE `nmu`$$
CREATE PROCEDURE insertOneRow(
IN 
    fromDate DATETIME,
    fromDate_format VARCHAR(45),
    endDate DATETIME,
    endDate_format VARCHAR(45),
    s_code VARCHAR(45),
    d_currency DECIMAL(11,2),
    table_name VARCHAR(45),
    middle_part ENUM('Y', 'N'),
    frequency ENUM('daily', 'monthly', 'seasonly', 'hyearly', 'yearly')
)
    BEGIN
    IF frequency = 'yearly' THEN
        IF middle_part = 'Y' THEN
            SELECT DATE_FORMAT(fromDate, '%Y') INTO @time_period;
        ELSE
            SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @time_period;
        END IF;    
    ELSEIF frequency = 'monthly' THEN
        IF middle_part = 'Y' THEN
            SELECT DATE_FORMAT(fromDate, '%Y-%m') INTO @time_period;
        ELSE 
            SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @time_period;
        END IF;
    ELSEIF frequency = 'daily' THEN
        SELECT DATE_FORMAT(fromDate, '%Y-%m-%d') INTO @time_period;
    ELSEIF frequency = 'seasonly' OR frequency = 'hyearly' THEN
        IF middle_part = 'N' THEN
        SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @time_period;
        ELSE
        SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(concat(DATE_FORMAT(endDate, '%Y-%m'), '-01')-interval 1 month, '%Y-%m')) INTO @time_period;
        END IF;
    ELSEIF frequency = 'yearly' THEN
        IF middle_part = 'N' THEN
            SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @time_period;
        ELSE 
            SELECT DATE_FORMAT(fromDate, '%Y') INTO @time_period;
        END IF;
    END IF;
    SELECT ROUND(IFNULL((SELECT sum(profit) FROM GroupTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(profit) FROM GroupTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/d_currency, 2) INTO @groupSum;
    SELECT ROUND(IFNULL((SELECT sum(total_profit) FROM IndividualTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(total_profit) FROM IndividualTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/d_currency, 2) INTO @indivSum;
    SELECT ROUND(IFNULL((SELECT sum(total_profit) FROM AirticketTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(total_profit) FROM AirticketTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/d_currency, 2) INTO @airSum;
    SET @insertIntoTable = concat('INSERT INTO ', table_name, ' VALUES(@time_period, @groupSum, @indivSum, @airSum,  @groupSum+@indivSum+@airSum);');
    PREPARE forExecute FROM @insertIntoTable;
    EXECUTE forExecute;
    DEALLOCATE PREPARE forExecute;
    END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sum_profit
-- -----------------------------------------------------

DELIMITER $$
USE `nmu`$$
CREATE PROCEDURE sum_profit
(IN
    frequency VARCHAR(10), 
    s_code VARCHAR(50), 
    from_date DATETIME, 
    to_date DATETIME
) 
BEGIN 
    SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @default_currency;
    DROP TABLE IF EXISTS forCalculate;
    CREATE TEMPORARY TABLE forCalculate (
        time_period VARCHAR(45),
        groupSum DECIMAL(11,2),
        indivSum DECIMAL(11,2),
        airSum DECIMAL(11,2),
        totalSum DECIMAL(11,2)
    );
    IF frequency = 'monthly' THEN
        IF from_date > DATE_FORMAT(to_date, '%Y-%m') THEN 
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'monthly');
            SELECT * FROM forCalculate;
        ELSE
            CALL insertOneRow(concat(DATE_FORMAT(to_date, '%Y-%m'), '-01'), '%Y-%m', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'monthly');
            SET @cursor_day = to_date - interval 1 month;
            WHILE from_date < DATE_FORMAT(@cursor_day, '%Y-%m') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), 'hello', concat(DATE_FORMAT(@cursor_day + interval 1 month, '%Y-%m'), '-01'), 'world', s_code, @default_currency, 'forCalculate', 'Y', 'monthly');
                SET @cursor_day = @cursor_day - interval 1 month;
            END WHILE;
            SET @last_month = DATE_FORMAT(@cursor_day + interval 1 month, '%Y-%m');
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(@last_month, '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'N', 'monthly');
            SELECT * FROM forCalculate;
        END IF;
    ELSEIF frequency = 'daily' THEN 
        SET @cursor_day = to_date;
        WHILE @cursor_day >= from_date DO
            CALL insertOneRow(@cursor_day, '%Y-%m-%d', @cursor_day + interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'daily');
            SET @cursor_day = @cursor_day - interval 1 day;
        END WHILE;
        SELECT * FROM forCalculate;
    ELSEIF frequency = 'seasonly' THEN
        IF from_date > DATE_FORMAT(to_date - interval 3 month, '%Y-%m') THEN
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'seasonly');
        ELSE
            CALL insertOneRow(concat(DATE_FORMAT(to_date - interval 2 month, '%Y-%m'), '-01'), '%Y-%m', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'seasonly');
            SET @cursor_day = to_date - interval 2 month;
            WHILE from_date < DATE_FORMAT(@cursor_day - interval 3 month, '%Y-%m') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day - interval 3 month, '%Y-%m'), '-01'), '%Y-%m', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'seasonly');
                SET @cursor_day = @cursor_day - interval 3 month;
            END WHILE;
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'seasonly');
        END IF;
        SELECT * FROM forCalculate;
    ELSEIF frequency = 'hyearly' THEN
        IF from_date > DATE_FORMAT(to_date-interval 6 month, '%Y-%m') THEN
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'hyearly');
        ELSE
            CALL insertOneRow(concat(DATE_FORMAT(to_date - interval 5 month, '%Y-%m'), '-01'), '%Y-%m', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'hyearly');
            SET @cursor_day = to_date - interval 5 month;
            WHILE from_date < DATE_FORMAT(@cursor_day - interval 6 month, '%Y-%m') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day - interval 6 month, '%Y-%m'), '-01'), '%Y-%m', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'hyearly');
                SET @cursor_day = @cursor_day - interval 6 month;
            END WHILE;
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'hyearly');
        END IF;
        SELECT * FROM forCalculate;
    ELSEIF frequency = 'yearly' THEN
        IF from_date >= DATE_FORMAT(to_date-interval 12 month, '%Y-%m') THEN
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'yearly');
        ELSE 
            CALL insertOneRow(concat(DATE_FORMAT(to_date, '%Y'), '-01-01'), '%Y', to_date+interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'yearly');
            SET @cursor_day = to_date - interval 12 month;
            WHILE from_date < DATE_FORMAT(@cursor_day, '%Y') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day, '%Y'), '-01-01'), 'hello', concat(DATE_FORMAT(@cursor_day+interval 12 month, '%Y'), '-01-01'), 'world', s_code, @default_currency, 'forCalculate', 'Y', 'yearly');
                SET @cursor_day = @cursor_day - interval 12 month;
            END WHILE;
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(DATE_FORMAT(@cursor_day+interval 12 month, '%Y'), '-01-01'), '%Y', s_code, @default_currency, 'forCalculate', 'N', 'yearly');
        END IF;
        SELECT * FROM forCalculate;
    END IF;
    DROP TABLE forCalculate;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- View `nmu`.`AirTicketTourOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`AirTicketTourOrder`;
USE `nmu`;
CREATE  OR REPLACE VIEW AirTicketTourOrder AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
s.salesperson_code, 
concat(c.fname, ' ', c.lname) as 'name',
/*if Chinese, concat(c.lname, c.fname) as 'name' */
t.currency, 
t.payment_type, 
t.total_profit, 
t.received,
t.received2,
t.expense, 
t.coupon,
a.flight_code, 
a.locators, 
a.invoice,
a.ticket_type, 
a.round_trip,
concat(a.adult_number, ' / ', a.child_number, ' / ', a.infant_number) as 'passenger', 
asi.all_schedule,
a.refunded,
ta.agency_name,
sn.source_name, 
t.note,
t.clear_status,
t.lock_status
FROM AirticketTour a 
LEFT JOIN AirScheduleIntegrated asi 
ON a.airticket_tour_id = asi.airticket_tour_id
INNER JOIN Transactions t ON a.airticket_tour_id = t.airticket_tour_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Customer c ON a.customer_id = c.customer_id
LEFT JOIN TravelAgency ta ON a.ta_id = ta.ta_id
ORDER BY transaction_id DESC;

-- -----------------------------------------------------
-- View `nmu`.`GroupTourOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`GroupTourOrder`;
USE `nmu`;
CREATE  OR REPLACE VIEW GroupTourOrder AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
g.group_code, 
s.salesperson_code, 
(g.leader_number+g.tourist_number) as 'total_number',
t.currency, 
t.payment_type,
t.total_profit as 'profit',
g.price,
concat(g.total_cost, '(', g.reserve, '/', g.write_off, ')') AS 'cost', 
g.flight_number, 
g.bus_company, 
concat(date_format(g.start_date, '%Y-%m-%d'), '/', date_format(g.end_date, '%Y-%m-%d')) as 'schedule', 
concat(tg.fname, ' ', tg.lname) AS 'guide_name', 
tg.phone AS 'guide_phone', 
g.agency_name, 
cs.source_name, 
t.coupon AS 'coupon', 
t.clear_status, 
t.lock_status,
t.note
FROM Transactions t 
INNER JOIN GroupTour g ON t.group_tour_id = g.group_tour_id
LEFT JOIN TouristGuide tg ON g.guide_id = tg.guide_id
LEFT JOIN CustomerSource cs ON t.source_id = cs.source_id
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
ORDER BY t.transaction_id DESC;

-- -----------------------------------------------------
-- View `nmu`.`IndividualTourOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`IndividualTourOrder`;
USE `nmu`;
/*_____*/
CREATE  OR REPLACE VIEW IndividualTourOrder AS
SELECT
t.transaction_id,
date_format(t.create_time, '%Y-%m-%d') AS 'create_time', 
it.product_code, 
it.tour_name, 
s.salesperson_code, 
w.wholesaler_code, 
t.currency, 
t.payment_type,
t.total_profit,
t.received as 'revenue', 
t.expense AS 'cost',
it.indiv_number, 
concat(date_format(it.depart_date, '%Y-%m-%d'), '/', date_format(it.arrival_date, '%Y-%m-%d')) as 'schedule',
sn.source_name, 
t.note, 
t.lock_status, 
t.clear_status, 
t.coupon
FROM Transactions t 
RIGHT JOIN IndividualTour it ON t.indiv_tour_id = it.indiv_tour_id 
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN Wholesaler w ON it.wholesaler_id = w.wholesaler_id 
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id
ORDER BY t.transaction_id DESC;
USE `nmu`;

DELIMITER $$
USE `nmu`$$
CREATE Trigger addNewCustomer BEFORE INSERT ON TourDetails
FOR EACH ROW
BEGIN 
SET @new_coupon = NEW.coupon;
SET @indiv_tour_id = NEW.indiv_tour_id;
SELECT coupon FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @transaction_coupon;
UPDATE Transactions SET coupon = @transaction_coupon  + @new_coupon, total_profit = received-expense-coupon WHERE indiv_tour_id = @indiv_tour_id;
END;$$

USE `nmu`$$
CREATE TRIGGER updateCoupon BEFORE UPDATE ON TourDetails
FOR EACH ROW
BEGIN
SET @indiv_collection_id = NEW.indiv_collection_id;
SET @indiv_tour_id = NEW.indiv_tour_id;
SET @new_coupon = NEW.coupon;
SELECT coupon FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @transaction_coupon;
SELECT coupon FROM TourDetails WHERE indiv_collection_id = @indiv_collection_id INTO @old_coupon;
UPDATE Transactions SET coupon = @transaction_coupon - @old_coupon + @new_coupon, total_profit = received-expense-coupon WHERE indiv_tour_id = @indiv_tour_id;
END;$$

USE `nmu`$$
CREATE TRIGGER if_all_cleared_locked AFTER UPDATE ON TourDetails
FOR EACH ROW
BEGIN
SET @indiv_tour_id = NEW.indiv_tour_id;
SET @all_clear_status = 'N';
SET @all_lock_status = 'N';

SELECT count(DISTINCT clear_status) FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @clear_status_number;
IF @clear_status_number = 1 THEN 
    SELECT DISTINCT clear_status FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @all_clear_status;
END IF;
SELECT count(DISTINCT lock_status) FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @lock_status_number;
IF @lock_status_number = 1 THEN 
    SELECT DISTINCT lock_status FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @all_lock_status;
END IF;
IF @all_clear_status = 'Y' THEN
    UPDATE Transactions SET clear_status = 'Y' WHERE indiv_tour_id = @indiv_tour_id;
END IF;
IF @all_lock_status = 'Y' THEN
    UPDATE Transactions SET clear_status = 'Y', lock_status = 'Y' WHERE indiv_tour_id = @indiv_tour_id;
END IF;
END$$

USE `nmu`$$
CREATE TRIGGER deleteCoupon BEFORE DELETE ON TourDetails
FOR EACH ROW
BEGIN 
SET @old_coupon = OLD.coupon;
SET @indiv_tour_id = OLD.indiv_tour_id;
SELECT coupon FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @transaction_coupon;
UPDATE Transactions SET coupon = @transaction_coupon  - @old_coupon, total_profit = received-expense-coupon WHERE indiv_tour_id = @indiv_tour_id;
END;$$

USE `nmu`$$
CREATE TRIGGER integrateAirSchedule BEFORE INSERT ON AirSchedule 
FOR EACH ROW
BEGIN
SET @at_id = NEW.airticket_tour_id;
SELECT count(*) INTO @days FROM AirSchedule WHERE airticket_tour_id = @at_id;
IF @days = 0 THEN 
    INSERT INTO AirScheduleIntegrated(airticket_tour_id, all_schedule) VALUES 
        (
            @at_id, 
            concat(NEW.depart_airport, ' - ', NEW.arrival_airport, ' ', DATE_FORMAT(NEW.depart_date, '%M/%d'), ' | ')
        );
ELSE 
    SELECT all_schedule FROM AirScheduleIntegrated WHERE airticket_tour_id = @at_id INTO @all_schedule;
    SET @all_schedule = concat(@all_schedule, NEW.depart_airport, ' - ', NEW.arrival_airport, ' ', DATE_FORMAT(NEW.depart_date, '%M/%d'), ' | ');
    UPDATE AirScheduleIntegrated SET all_schedule = @all_schedule WHERE airticket_tour_id = @at_id;
END IF;
END;$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;