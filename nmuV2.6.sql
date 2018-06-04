-- MySQL Script generated by MySQL Workbench
-- Mon Jun  4 14:18:43 2018
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
  `salesperson_code` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `description` VARCHAR(500) NULL,
  `other_information` VARCHAR(1000) NULL,
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
  `total_cost` DECIMAL(11,2) NOT NULL COMMENT 'total cost = write off + reserve',
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
  `tour_name` VARCHAR(45) NULL,
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
  `depart_location` VARCHAR(500) NULL COMMENT 'airport code',
  `depart_date` DATETIME NULL,
  `arrival_location` VARCHAR(500) NULL COMMENT 'airport code',
  `arrival_date` DATETIME NULL,
  `locators` VARCHAR(500) NOT NULL,
  `ticket_type` ENUM('group', 'individual') NULL COMMENT 'refund\nticketed\nrescheduled\n',
  `round_trip` ENUM('round', 'oneway') NOT NULL,
  `adult_number` INT NOT NULL DEFAULT 0,
  `child_number` INT NOT NULL DEFAULT 0,
  `infant_number` INT NOT NULL DEFAULT 0,
  `refunded` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  `passenger_name` VARCHAR(500) NULL,
  PRIMARY KEY (`airticket_tour_id`),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  UNIQUE INDEX `locator_UNIQUE` (`locators` ASC),
  CONSTRAINT `at_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `at_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
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
  `type` ENUM('airticket', 'group', 'individual') NOT NULL COMMENT 'type (selections provided on Web): \nadd ‘other type’',
  `group_tour_id` INT NULL,
  `indiv_tour_id` INT NULL,
  `airticket_tour_id` INT NULL,
  `salesperson_id` INT NOT NULL,
  `cc_id` INT NULL,
  `expense` DECIMAL(11,2) NOT NULL,
  `received` DECIMAL(11,2) NOT NULL,
  `received2` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `payment_type` ENUM('creditcard', 'mco', 'alipay', 'wechat', 'cash', 'check', 'other') NOT NULL COMMENT 'Payment (selections provided on Web): \ncredit card/mco/alipay/wechat pay/cash\n',
  `total_profit` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `note` VARCHAR(1000) NULL,
  `create_time` DATETIME NOT NULL DEFAULT current_timestamp,
  `source_id` INT NULL,
  `currency` ENUM('USD', 'RMB') NOT NULL,
  `lock_status` ENUM('Y', 'N') NOT NULL,
  `clear_status` ENUM('Y', 'N') NOT NULL,
  `coupon` DECIMAL(11,2) NULL,
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
  PRIMARY KEY (`indiv_collection_id`),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  INDEX `fk_indiv_tour_id_idx` (`indiv_tour_id` ASC),
  CONSTRAINT `ind_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_indiv_tour_id`
    FOREIGN KEY (`indiv_tour_id`)
    REFERENCES `nmu`.`IndividualTour` (`indiv_tour_id`)
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
  `password` VARCHAR(45) NOT NULL,
  `user_group_id` INT NOT NULL,
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

USE `nmu` ;

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`AirTicketTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirTicketTourOrder` (`transaction_id` INT, `'create_time'` INT, `salesperson_code` INT, `'name'` INT, `currency` INT, `payment_type` INT, `total_profit` INT, `received` INT, `received2` INT, `expense` INT, `coupon` INT, `flight_code` INT, `locators` INT, `ticket_type` INT, `round_trip` INT, `'passenger'` INT, `'depart'` INT, `'arrival'` INT, `refunded` INT, `source_name` INT, `note` INT, `clear_status` INT, `lock_status` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`GroupTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTourOrder` (`transaction_id` INT, `'create_time'` INT, `group_code` INT, `salesperson_code` INT, `'total_number'` INT, `currency` INT, `payment_type` INT, `'profit'` INT, `price` INT, `'cost'` INT, `flight_number` INT, `bus_company` INT, `'schedule'` INT, `'guide_name'` INT, `'guide_phone'` INT, `agency_name` INT, `source_name` INT, `'coupon'` INT, `clear_status` INT, `lock_status` INT, `note` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`IndividualTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTourOrder` (`transaction_id` INT, `'create_time'` INT, `product_code` INT, `tour_name` INT, `salesperson_code` INT, `wholesaler_code` INT, `currency` INT, `payment_type` INT, `total_profit` INT, `'revenue'` INT, `'cost'` INT, `indiv_number` INT, `'schedule'` INT, `source_name` INT, `note` INT, `c_list` INT, `lock_status` INT, `clear_status` INT, `coupon` INT);

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
a.ticket_type, 
a.round_trip,
concat(a.adult_number, ' / ', a.child_number, ' / ', a.infant_number) as 'passenger', 
concat(date_format(a.depart_date, '%Y-%m-%d'), ' / ', a.depart_location) as 'depart',
concat(date_format(a.arrival_date, '%Y-%m-%d'), ' / ', a.arrival_location) as 'arrival',
a.refunded,
sn.source_name, 
t.note,
t.clear_status,
t.lock_status
FROM AirticketTour a 
INNER JOIN Transactions t ON a.airticket_tour_id = t.airticket_tour_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Customer c ON a.customer_id = c.customer_id
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
gc.c_list, 
t.lock_status, 
t.clear_status, 
t.coupon
FROM Transactions t 
RIGHT JOIN IndividualTour it ON t.indiv_tour_id = it.indiv_tour_id 
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN Wholesaler w ON it.wholesaler_id = w.wholesaler_id 
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id 
LEFT JOIN 
(SELECT cs.indiv_tour_id, group_concat(cs.full_name SEPARATOR ', ') c_list 
    FROM (SELECT td.indiv_tour_id, concat(lname, ' ', fname) AS 'full_name' FROM Customer c 
    JOIN TourDetails td ON c.customer_id = td.customer_id) cs 
    GROUP BY cs.indiv_tour_id) gc 
ON it.indiv_tour_id = gc.indiv_tour_id
ORDER BY t.transaction_id DESC;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
