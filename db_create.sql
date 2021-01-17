CREATE SCHEMA sketching DEFAULT CHARACTER SET utf8 ;
USE sketching ;

-- -----------------------------------------------------
-- Table `sketching`.`layer`
-- -----------------------------------------------------
CREATE TABLE `layer` (
  `idlayer` INT NOT NULL,
  `updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlayer`));
-- -----------------------------------------------------
-- Table `sketching`.`entity`
-- -----------------------------------------------------
CREATE TABLE `entity` (
  `identity` INT NOT NULL,
  `layer` INT NOT NULL,
  PRIMARY KEY (`identity`),
  FOREIGN KEY (`layer`) REFERENCES `layer`(`idlayer`) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sketching`.`point`
-- -----------------------------------------------------
CREATE TABLE `point` (
  `idpoint` INT NOT NULL,
  `x` DOUBLE NOT NULL,
  `y` DOUBLE NOT NULL,
  PRIMARY KEY (`idpoint`),
  FOREIGN KEY (`idpoint`) REFERENCES `entity` (`identity`) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sketching`.`objtype`
-- -----------------------------------------------------
CREATE TABLE `objtype` (
  `idobjtype` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `freedegree` INT NOT NULL,
  PRIMARY KEY (`idobjtype`));


-- -----------------------------------------------------
-- Table `sketching`.`object`
-- -----------------------------------------------------
CREATE TABLE `object` (
  `idobject` INT NOT NULL,
  `objtype` TINYINT NOT NULL,
  PRIMARY KEY (`idobject`),
  FOREIGN KEY (`objtype`) REFERENCES `objtype` (`idobjtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`idobject`) REFERENCES `entity` (`identity`)  ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sketching`.`objspoints`
-- -----------------------------------------------------
CREATE TABLE `objpoints` (
  `idpoint` INT NOT NULL,
  `idobject` INT NOT NULL,
  `num` INT NULL,
  PRIMARY KEY (`idpoint`, `idobject`),
  FOREIGN KEY (`idpoint`) REFERENCES `point` (`idpoint`)   ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`idobject`) REFERENCES `object` (`idobject`) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sketching`.`constrtype`
-- -----------------------------------------------------
CREATE TABLE `constrtype` (
  `idconstrtype` TINYINT NOT NULL,
  `name` VARCHAR(45) NULL,
  `is_parametric` TINYINT NULL,
  PRIMARY KEY (`idconstrtype`));


-- -----------------------------------------------------
-- Table `sketching`.`constraint`
-- -----------------------------------------------------
CREATE TABLE `constraint` (
  `idconstraint` INT NOT NULL,
  `constrtype` TINYINT NOT NULL,
  `parameter` DOUBLE NULL,  
  PRIMARY KEY (`idconstraint`),
  FOREIGN KEY (`constrtype`) REFERENCES `constrtype` (`idconstrtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`idconstraint`) REFERENCES `entity` (`identity`) ON DELETE CASCADE ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `sketching`.`constinfo`
-- -----------------------------------------------------
CREATE TABLE `constrinfo` (
  `idconstraint` INT NOT NULL,
  `identity` INT NOT NULL,
  PRIMARY KEY (`idconstraint`, `identity`),
  FOREIGN KEY (`idconstraint`) REFERENCES `constraint` (`idconstraint`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`identity`) REFERENCES `entity` (`identity`) ON DELETE CASCADE ON UPDATE CASCADE);


