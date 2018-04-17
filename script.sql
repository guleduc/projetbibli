-- MySQL Script generated by MySQL Workbench
-- mer. 21 mars 2018 09:12:53 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Livre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Livre` (
  `idlivre` INT(11) NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(45) NULL,
  `ams` VARCHAR(45) NULL,
  `cle` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `lang` VARCHAR(45) NULL,
  `lango` VARCHAR(45) NULL,
  `auteur` VARCHAR(45) NULL,
  PRIMARY KEY (`idlivre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Editeur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Editeur` (
  `idEditeur` INT NOT NULL,
  `nom_editeur` VARCHAR(45) NULL,
  PRIMARY KEY (`idEditeur`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exemplaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exemplaire` (
  `numfiche` INT(11) NOT NULL,
  `collection` VARCHAR(45) NULL,
  `numcoll` INT(11) NULL,
  `date` INT(11) NULL,
  `isbn` VARCHAR(45) NULL,
  `cote` VARCHAR(45) NULL,
  `inventaire` VARCHAR(45) NULL,
  `titre` VARCHAR(45) NULL,
  `Livre_idlivre` INT(11) NOT NULL,
  `Editeur_idEditeur` INT NOT NULL,
  PRIMARY KEY (`numfiche`, `Livre_idlivre`, `Editeur_idEditeur`),
  INDEX `fk_Exemplaire_Livre_idx` (`Livre_idlivre` ASC),
  INDEX `fk_Exemplaire_Editeur1_idx` (`Editeur_idEditeur` ASC),
  CONSTRAINT `fk_Exemplaire_Livre`
    FOREIGN KEY (`Livre_idlivre`)
    REFERENCES `mydb`.`Livre` (`idlivre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exemplaire_Editeur1`
    FOREIGN KEY (`Editeur_idEditeur`)
    REFERENCES `mydb`.`Editeur` (`idEditeur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Utilisateur` (
  `identifiant` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NULL,
  `prenom` VARCHAR(45) NULL,
  `divers` VARCHAR(45) NULL,
  PRIMARY KEY (`identifiant`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Saisie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Saisie` (
  `numfiche` INT(11) NOT NULL,
  `collection` VARCHAR(45) NULL,
  `numcoll` INT(11) NULL,
  `date` INT(11) NULL,
  `isbn` VARCHAR(45) NULL,
  `cote` VARCHAR(45) NULL,
  `inventaire` VARCHAR(45) NULL,
  `titre` VARCHAR(45) NULL,
  `Exemplaire_numfiche` INT(11) NOT NULL,
  `Exemplaire_Livre_idlivre` INT(11) NOT NULL,
  `Exemplaire_Editeur_idEditeur` INT NOT NULL,
  PRIMARY KEY (`numfiche`, `Exemplaire_numfiche`, `Exemplaire_Livre_idlivre`, `Exemplaire_Editeur_idEditeur`),
  INDEX `fk_Saisie_Exemplaire1_idx` (`Exemplaire_numfiche` ASC, `Exemplaire_Livre_idlivre` ASC, `Exemplaire_Editeur_idEditeur` ASC),
  CONSTRAINT `fk_Saisie_Exemplaire1`
    FOREIGN KEY (`Exemplaire_numfiche` , `Exemplaire_Livre_idlivre` , `Exemplaire_Editeur_idEditeur`)
    REFERENCES `mydb`.`Exemplaire` (`numfiche` , `Livre_idlivre` , `Editeur_idEditeur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Commande` (
  `numcom` INT(11) NOT NULL,
  `auteur` VARCHAR(45) NULL,
  `titre` VARCHAR(45) NULL,
  `commentaire` VARCHAR(45) NULL,
  `prix` INT(11) NULL,
  `etat` CHAR(1) NULL,
  `fournisseur` VARCHAR(45) NULL,
  `date` DATE NULL,
  `Exemplaire_numfiche` INT(11) NOT NULL,
  `Utilisateur_identifiant` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`numcom`, `Exemplaire_numfiche`, `Utilisateur_identifiant`),
  INDEX `fk_Commande_Exemplaire1_idx` (`Exemplaire_numfiche` ASC),
  INDEX `fk_Commande_Utilisateur1_idx` (`Utilisateur_identifiant` ASC),
  CONSTRAINT `fk_Commande_Exemplaire1`
    FOREIGN KEY (`Exemplaire_numfiche`)
    REFERENCES `mydb`.`Exemplaire` (`numfiche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_Utilisateur1`
    FOREIGN KEY (`Utilisateur_identifiant`)
    REFERENCES `mydb`.`Utilisateur` (`identifiant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Emprunt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Emprunt` (
  `numemprunt` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `Utilisateur_identifiant` VARCHAR(45) NOT NULL,
  `Exemplaire_numfiche` INT(11) NOT NULL,
  PRIMARY KEY (`numemprunt`, `Utilisateur_identifiant`, `Exemplaire_numfiche`),
  INDEX `fk_Emprunt_Utilisateur1_idx` (`Utilisateur_identifiant` ASC),
  INDEX `fk_Emprunt_Exemplaire1_idx` (`Exemplaire_numfiche` ASC),
  CONSTRAINT `fk_Emprunt_Utilisateur1`
    FOREIGN KEY (`Utilisateur_identifiant`)
    REFERENCES `mydb`.`Utilisateur` (`identifiant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Emprunt_Exemplaire1`
    FOREIGN KEY (`Exemplaire_numfiche`)
    REFERENCES `mydb`.`Exemplaire` (`numfiche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
