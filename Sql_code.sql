-- Schema 2609002180_movieco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `2609002180_movieco` DEFAULT CHARACTER SET utf8 ;
USE `2609002180_movieco` ;

-- -----------------------------------------------------
-- Table `2609002180_movieco`.`membership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2609002180_movieco`.`membership` (
  `mem_num` INT(11) NOT NULL,
  `mem_Fname` VARCHAR(20) NOT NULL,
  `mem_Lname` VARCHAR(20) NOT NULL,
  `mem_street` VARCHAR(30) NOT NULL,
  `mem_city` VARCHAR(20) NOT NULL,
  `mem_state` VARCHAR(2) NOT NULL,
  `mem_zip` INT(5) NOT NULL,
  `mem_balance` INT(11) NOT NULL,
  PRIMARY KEY (`mem_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `2609002180_movieco`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2609002180_movieco`.`rental` (
  `rent_num` INT(11) NOT NULL,
  `rent_date` DATE NOT NULL,
  `mem_num` INT(11) NOT NULL,
  PRIMARY KEY (`rent_num`),
  INDEX `mem_num` (`mem_num` ASC),
  CONSTRAINT `rental_ibfk_1`
    FOREIGN KEY (`mem_num`)
    REFERENCES `2609002180_movieco`.`membership` (`mem_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `2609002180_movieco`.`price`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2609002180_movieco`.`price` (
  `price_code` INT(11) NOT NULL,
  `price_description` VARCHAR(15) NULL DEFAULT NULL,
  `price_rentfee` FLOAT NOT NULL,
  `price_dailylatefee` INT(11) NOT NULL,
  `price_rentdays` INT(2) NOT NULL,
  PRIMARY KEY (`price_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `2609002180_movieco`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2609002180_movieco`.`movie` (
  `movie_num` INT(11) NOT NULL,
  `movie_title` VARCHAR(30) NOT NULL,
  `movie_year` INT(11) NOT NULL,
  `movie_cost` FLOAT NOT NULL,
  `movie_genre` VARCHAR(10) NULL DEFAULT NULL,
  `price_code` INT(11) NOT NULL,
  PRIMARY KEY (`movie_num`),
  INDEX `price_code` (`price_code` ASC),
  CONSTRAINT `movie_ibfk_1`
    FOREIGN KEY (`price_code`)
    REFERENCES `2609002180_movieco`.`price` (`price_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `2609002180_movieco`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2609002180_movieco`.`video` (
  `vid_num` INT(11) NOT NULL,
  `vid_indate` DATE NOT NULL,
  `movie_num` INT(11) NOT NULL,
  `VID_STATUS` VARCHAR(4) NOT NULL DEFAULT 'IN',
  PRIMARY KEY (`vid_num`),
  INDEX `movie_num` (`movie_num` ASC),
  CONSTRAINT `video_ibfk_1`
    FOREIGN KEY (`movie_num`)
    REFERENCES `2609002180_movieco`.`movie` (`movie_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `2609002180_movieco`.`detailrental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2609002180_movieco`.`detailrental` (
  `rent_num` INT(11) NOT NULL,
  `vid_num` INT(11) NOT NULL,
  `detail_fee` FLOAT NOT NULL,
  `detail_duedate` DATE NOT NULL,
  `detail_returndate` DATE NULL DEFAULT NULL,
  `detail_dailylatefee` INT(11) NOT NULL,
  `detail_dayslate` DECIMAL(3,0) NULL DEFAULT NULL,
  INDEX `rent_num` (`rent_num` ASC),
  INDEX `vid_num` (`vid_num` ASC),
  CONSTRAINT `detailrental_ibfk_1`
    FOREIGN KEY (`rent_num`)
    REFERENCES `2609002180_movieco`.`rental` (`rent_num`),
  CONSTRAINT `detailrental_ibfk_2`
    FOREIGN KEY (`vid_num`)
    REFERENCES `2609002180_movieco`.`video` (`vid_num`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
