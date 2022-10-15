-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autor` (
  `idautor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`idautor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`libro` (
  `idlibro` INT NOT NULL AUTO_INCREMENT,
  `pagina` INT(10) NOT NULL,
  `ISBN` VARCHAR(45) NOT NULL,
  `editorial` VARCHAR(45) NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idlibro`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`ejemplar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`ejemplar` (
  `idejemplar` INT NOT NULL AUTO_INCREMENT,
  `localizacion` VARCHAR(45) NOT NULL,
  `libro_idlibro` INT NOT NULL,
  PRIMARY KEY (`idejemplar`),
  INDEX `fk_ejemplar_libro1_idx` (`libro_idlibro` ASC) VISIBLE,
  CONSTRAINT `fk_ejemplar_libro1`
    FOREIGN KEY (`libro_idlibro`)
    REFERENCES `biblioteca`.`libro` (`idlibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`autor_tiene_libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autor_tiene_libro` (
  `autor_idautor` INT NOT NULL,
  `libro_idlibro` INT NOT NULL,
  PRIMARY KEY (`autor_idautor`, `libro_idlibro`),
  INDEX `fk_autor_has_libro_libro1_idx` (`libro_idlibro` ASC) VISIBLE,
  INDEX `fk_autor_has_libro_autor_idx` (`autor_idautor` ASC) VISIBLE,
  CONSTRAINT `fk_autor_has_libro_autor`
    FOREIGN KEY (`autor_idautor`)
    REFERENCES `biblioteca`.`autor` (`idautor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autor_has_libro_libro1`
    FOREIGN KEY (`libro_idlibro`)
    REFERENCES `biblioteca`.`libro` (`idlibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`usuario_tiene_ejemplar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`usuario_tiene_ejemplar` (
  `usuario_idusuario` INT NOT NULL,
  `ejemplar_idejemplar` INT NOT NULL,
  `fechaPrest` DATE NOT NULL,
  `fechaDev` DATE NULL,
  PRIMARY KEY (`usuario_idusuario`, `ejemplar_idejemplar`),
  INDEX `fk_usuario_has_ejemplar_ejemplar1_idx` (`ejemplar_idejemplar` ASC) VISIBLE,
  INDEX `fk_usuario_has_ejemplar_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_ejemplar_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `biblioteca`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_ejemplar_ejemplar1`
    FOREIGN KEY (`ejemplar_idejemplar`)
    REFERENCES `biblioteca`.`ejemplar` (`idejemplar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
