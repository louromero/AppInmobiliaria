-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema appInmuebles
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `appInmuebles` ;

-- -----------------------------------------------------
-- Schema appInmuebles
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `appInmuebles` ;
USE `appInmuebles` ;

-- -----------------------------------------------------
-- Table `appInmuebles`.`agente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appInmuebles`.`agente` ;

CREATE TABLE IF NOT EXISTS `appInmuebles`.`agente` (
  `idagente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idagente`),
  UNIQUE INDEX `idagente_UNIQUE` (`idagente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appInmuebles`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appInmuebles`.`cliente` ;

CREATE TABLE IF NOT EXISTS `appInmuebles`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `idcliente_UNIQUE` (`idcliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appInmuebles`.`inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appInmuebles`.`inmueble` ;

CREATE TABLE IF NOT EXISTS `appInmuebles`.`inmueble` (
  `idinmueble` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(800) NOT NULL,
  `ubicacion` VARCHAR(80) NOT NULL,
  `estado` ENUM('alquiler', 'venta') NOT NULL,
  `tipo` ENUM('casa', 'departamento', 'terreno', 'oficina', 'local') NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idinmueble`),
  UNIQUE INDEX `idinmueble_UNIQUE` (`idinmueble` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appInmuebles`.`imagenes_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appInmuebles`.`imagenes_inmueble` ;

CREATE TABLE IF NOT EXISTS `appInmuebles`.`imagenes_inmueble` (
  `idimagenes_inmueble` INT NOT NULL AUTO_INCREMENT,
  `url_imagen` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `inmueble_idinmueble` INT NOT NULL,
  PRIMARY KEY (`idimagenes_inmueble`),
  UNIQUE INDEX `idimagenes_inmueble_UNIQUE` (`idimagenes_inmueble` ASC) VISIBLE,
  INDEX `fk_imagenes_inmueble_inmueble_idx` (`inmueble_idinmueble` ASC) VISIBLE,
  CONSTRAINT `fk_imagenes_inmueble_inmueble`
    FOREIGN KEY (`inmueble_idinmueble`)
    REFERENCES `appInmuebles`.`inmueble` (`idinmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appInmuebles`.`visita_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appInmuebles`.`visita_inmueble` ;

CREATE TABLE IF NOT EXISTS `appInmuebles`.`visita_inmueble` (
  `idvisita_inmueble` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` DATE NOT NULL,
  `estado` ENUM('pendiente', 'confirmada', 'cancelada') NOT NULL,
  `inmueble_idinmueble` INT NOT NULL,
  `agente_idagente` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idvisita_inmueble`, `fecha`),
  UNIQUE INDEX `idvisita_inmueble_UNIQUE` (`idvisita_inmueble` ASC) VISIBLE,
  INDEX `fk_visita_inmueble_inmueble1_idx` (`inmueble_idinmueble` ASC) VISIBLE,
  INDEX `fk_visita_inmueble_agente1_idx` (`agente_idagente` ASC) VISIBLE,
  INDEX `fk_visita_inmueble_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_visita_inmueble_inmueble1`
    FOREIGN KEY (`inmueble_idinmueble`)
    REFERENCES `appInmuebles`.`inmueble` (`idinmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_visita_inmueble_agente1`
    FOREIGN KEY (`agente_idagente`)
    REFERENCES `appInmuebles`.`agente` (`idagente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_visita_inmueble_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `appInmuebles`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
