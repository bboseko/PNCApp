/*
SQLyog Ultimate v11.11 (32 bit)
MySQL - 5.5.34 : Database - dbpncapp
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
drop database if exists`dbpncapp`;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dbpncapp` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dbpncapp`;

/*Table structure for table `acceder` */

DROP TABLE IF EXISTS `acceder`;

CREATE TABLE `acceder` (
  `id_fonctionnalite` int(11) NOT NULL AUTO_INCREMENT,
  `id_profil` int(11) NOT NULL,
  PRIMARY KEY (`id_fonctionnalite`,`id_profil`),
  KEY `FK_acceder_id_profil` (`id_profil`),
  CONSTRAINT `FK_acceder_id_fonctionnalite` FOREIGN KEY (`id_fonctionnalite`) REFERENCES `fonctionnalite` (`id_fonctionnalite`),
  CONSTRAINT `FK_acceder_id_profil` FOREIGN KEY (`id_profil`) REFERENCES `profil` (`id_profil`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `acceder` */

insert  into `acceder`(`id_fonctionnalite`,`id_profil`) values (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(1,2),(2,2),(8,2),(9,2),(10,2),(11,2),(1,3),(2,3),(3,3),(11,3),(1,4),(2,4),(3,4),(11,4),(1,5),(3,5),(11,5),(1,6),(3,6),(11,6),(1,7),(5,7),(11,7),(1,8),(6,8),(11,8);

/*Table structure for table `anneebudgetaire` */

DROP TABLE IF EXISTS `anneebudgetaire`;

CREATE TABLE `anneebudgetaire` (
  `id_anneebudgetaire` int(11) NOT NULL AUTO_INCREMENT,
  `anneebudgetaire` varchar(10) DEFAULT NULL,
  `shortname_annee` int(10) DEFAULT NULL,
  `etat` varchar(20) DEFAULT NULL,
  `id_budgetprovisoire` int(11) NOT NULL,
  `id_budgetvote` int(11) NOT NULL,
  PRIMARY KEY (`id_anneebudgetaire`),
  KEY `FK_anneeBudgetaire_id_budgetprovisoire` (`id_budgetprovisoire`),
  KEY `FK_anneeBudgetaire_id_budgetvote` (`id_budgetvote`),
  CONSTRAINT `FK_anneeBudgetaire_id_budgetprovisoire` FOREIGN KEY (`id_budgetprovisoire`) REFERENCES `budgetprovisoire` (`id_budgetprovisoire`),
  CONSTRAINT `FK_anneeBudgetaire_id_budgetvote` FOREIGN KEY (`id_budgetvote`) REFERENCES `budgetvote` (`id_budgetvote`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `anneebudgetaire` */

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id_article` int(11) NOT NULL AUTO_INCREMENT,
  `nom_article` varchar(30) DEFAULT NULL,
  `code_article` varchar(20) DEFAULT NULL,
  `id_chapitre` int(11) NOT NULL,
  PRIMARY KEY (`id_article`),
  KEY `FK_article_id_chapitre` (`id_chapitre`),
  CONSTRAINT `FK_article_id_chapitre` FOREIGN KEY (`id_chapitre`) REFERENCES `chapitre` (`id_chapitre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `article` */

/*Table structure for table `beneficiaire` */

DROP TABLE IF EXISTS `beneficiaire`;

CREATE TABLE `beneficiaire` (
  `id_beneficiaire` int(11) NOT NULL AUTO_INCREMENT,
  `matricule_beneficiaire` varchar(20) DEFAULT NULL,
  `prenom_beneficiaire` varchar(30) DEFAULT NULL,
  `nom_beneficiaire` varchar(20) DEFAULT NULL,
  `postnom_beneficiaire` varchar(20) DEFAULT NULL,
  `grade_beneficiaire` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_beneficiaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `beneficiaire` */

/*Table structure for table `beneficier` */

DROP TABLE IF EXISTS `beneficier`;

CREATE TABLE `beneficier` (
  `id_beneficiaire` int(11) NOT NULL AUTO_INCREMENT,
  `id_depense` int(11) NOT NULL,
  PRIMARY KEY (`id_beneficiaire`,`id_depense`),
  KEY `FK_beneficier_id_depense` (`id_depense`),
  CONSTRAINT `FK_beneficier_id_beneficiaire` FOREIGN KEY (`id_beneficiaire`) REFERENCES `beneficiaire` (`id_beneficiaire`),
  CONSTRAINT `FK_beneficier_id_depense` FOREIGN KEY (`id_depense`) REFERENCES `depense` (`id_depense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `beneficier` */

/*Table structure for table `besoin` */

DROP TABLE IF EXISTS `besoin`;

CREATE TABLE `besoin` (
  `id_besoin` int(11) NOT NULL AUTO_INCREMENT,
  `description_besion` text,
  `date_expression` date DEFAULT NULL,
  `id_unite` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_besoin`),
  KEY `FK_besoin_id_unite` (`id_unite`),
  CONSTRAINT `FK_besoin_id_unite` FOREIGN KEY (`id_unite`) REFERENCES `unite` (`id_unite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `besoin` */

/*Table structure for table `budgetprovisoire` */

DROP TABLE IF EXISTS `budgetprovisoire`;

CREATE TABLE `budgetprovisoire` (
  `id_budgetprovisoire` int(11) NOT NULL AUTO_INCREMENT,
  `description_budgetprovisoire` text,
  `id_anneebudgetaire` int(11) NOT NULL,
  PRIMARY KEY (`id_budgetprovisoire`),
  KEY `FK_budgetProvisoire_id_anneebudgetaire` (`id_anneebudgetaire`),
  CONSTRAINT `FK_budgetProvisoire_id_anneebudgetaire` FOREIGN KEY (`id_anneebudgetaire`) REFERENCES `anneebudgetaire` (`id_anneebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `budgetprovisoire` */

/*Table structure for table `budgetvote` */

DROP TABLE IF EXISTS `budgetvote`;

CREATE TABLE `budgetvote` (
  `id_budgetvote` int(11) NOT NULL AUTO_INCREMENT,
  `descritption_budgetvote` text,
  `id_anneebudgetaire` int(11) NOT NULL,
  PRIMARY KEY (`id_budgetvote`),
  KEY `FK_budgetVote_id_anneebudgetaire` (`id_anneebudgetaire`),
  CONSTRAINT `FK_budgetVote_id_anneebudgetaire` FOREIGN KEY (`id_anneebudgetaire`) REFERENCES `anneebudgetaire` (`id_anneebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `budgetvote` */

/*Table structure for table `categorieunite` */

DROP TABLE IF EXISTS `categorieunite`;

CREATE TABLE `categorieunite` (
  `id_categorieunite` int(11) NOT NULL AUTO_INCREMENT,
  `nom_categorieunite` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_categorieunite`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `categorieunite` */

insert  into `categorieunite`(`id_categorieunite`,`nom_categorieunite`) values (1,'Commissariat Général');

/*Table structure for table `chapitre` */

DROP TABLE IF EXISTS `chapitre`;

CREATE TABLE `chapitre` (
  `id_chapitre` int(11) NOT NULL AUTO_INCREMENT,
  `nom_chapitre` varchar(30) DEFAULT NULL,
  `code_chapitre` varchar(20) DEFAULT NULL,
  `id_section` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_chapitre`),
  KEY `FK_chapitre_id_section` (`id_section`),
  CONSTRAINT `FK_chapitre_id_section` FOREIGN KEY (`id_section`) REFERENCES `section` (`id_section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `chapitre` */

/*Table structure for table `composer` */

DROP TABLE IF EXISTS `composer`;

CREATE TABLE `composer` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `id_besoin` int(11) NOT NULL,
  `quantite_itembesoin` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_item`,`id_besoin`),
  KEY `FK_composer_id_besoin` (`id_besoin`),
  CONSTRAINT `FK_composer_id_besoin` FOREIGN KEY (`id_besoin`) REFERENCES `besoin` (`id_besoin`),
  CONSTRAINT `FK_composer_id_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `composer` */

/*Table structure for table `comprendre` */

DROP TABLE IF EXISTS `comprendre`;

CREATE TABLE `comprendre` (
  `id_budgetprovisoire` int(11) NOT NULL AUTO_INCREMENT,
  `id_lignebudgetaire` int(11) NOT NULL,
  `montant_provisoire` double DEFAULT NULL,
  `montant_arbitre` double DEFAULT NULL,
  PRIMARY KEY (`id_budgetprovisoire`,`id_lignebudgetaire`),
  KEY `FK_comprendre_id_lignebudgetaire` (`id_lignebudgetaire`),
  CONSTRAINT `FK_comprendre_id_budgetprovisoire` FOREIGN KEY (`id_budgetprovisoire`) REFERENCES `budgetprovisoire` (`id_budgetprovisoire`),
  CONSTRAINT `FK_comprendre_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `comprendre` */

/*Table structure for table `consolidation` */

DROP TABLE IF EXISTS `consolidation`;

CREATE TABLE `consolidation` (
  `id_consolidation` int(11) NOT NULL AUTO_INCREMENT,
  `description_consolidation` text,
  `date_consolidation` date DEFAULT NULL,
  PRIMARY KEY (`id_consolidation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `consolidation` */

/*Table structure for table `controle` */

DROP TABLE IF EXISTS `controle`;

CREATE TABLE `controle` (
  `id_controle` int(11) NOT NULL AUTO_INCREMENT,
  `numero_bdecontrole` varchar(20) DEFAULT NULL,
  `id_dossierdepense` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_controle`),
  KEY `FK_controle_id_dossierdepense` (`id_dossierdepense`),
  KEY `FK_controle_id_utilisateur` (`id_utilisateur`),
  CONSTRAINT `FK_controle_id_dossierdepense` FOREIGN KEY (`id_dossierdepense`) REFERENCES `dossierdepense` (`id_dossierdepense`),
  CONSTRAINT `FK_controle_id_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `controle` */

/*Table structure for table `depense` */

DROP TABLE IF EXISTS `depense`;

CREATE TABLE `depense` (
  `id_depense` int(11) NOT NULL AUTO_INCREMENT,
  `numero_depense` varchar(20) DEFAULT NULL,
  `objet_depense` varchar(20) DEFAULT NULL,
  `date_saisidepense` date DEFAULT NULL,
  `montant_depense` double DEFAULT NULL,
  `date_derniere_actiondepense` date DEFAULT NULL,
  `id_dossierdepense` int(11) NOT NULL,
  `id_lignebudgetaire` int(11) NOT NULL,
  PRIMARY KEY (`id_depense`),
  KEY `FK_depense_id_dossierdepense` (`id_dossierdepense`),
  KEY `FK_depense_id_lignebudgetaire` (`id_lignebudgetaire`),
  CONSTRAINT `FK_depense_id_dossierdepense` FOREIGN KEY (`id_dossierdepense`) REFERENCES `dossierdepense` (`id_dossierdepense`),
  CONSTRAINT `FK_depense_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `depense` */

/*Table structure for table `district` */

DROP TABLE IF EXISTS `district`;

CREATE TABLE `district` (
  `id_district` int(11) NOT NULL AUTO_INCREMENT,
  `nom_district` varchar(30) DEFAULT NULL,
  `id_province` int(11) NOT NULL,
  PRIMARY KEY (`id_district`),
  KEY `FK_district_id_province` (`id_province`),
  CONSTRAINT `FK_district_id_province` FOREIGN KEY (`id_province`) REFERENCES `province` (`id_province`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `district` */

insert  into `district`(`id_district`,`nom_district`,`id_province`) values (1,'Funa',3),(2,'Lukunga',3),(3,'Tshangu',3),(4,'Mont-amba',3);

/*Table structure for table `dossierdepense` */

DROP TABLE IF EXISTS `dossierdepense`;

CREATE TABLE `dossierdepense` (
  `id_dossierdepense` int(11) NOT NULL AUTO_INCREMENT,
  `numero_dossierdepense` varchar(20) DEFAULT NULL,
  `numero_bde` varchar(20) DEFAULT NULL,
  `date_bde` date DEFAULT NULL,
  `etat_dossierdepense` varchar(10) DEFAULT NULL,
  `date_ouverture` date DEFAULT NULL,
  `date_derniere_action` date DEFAULT NULL,
  `montant_prevu` double DEFAULT NULL,
  `montant_paye` double DEFAULT NULL,
  `monnaie` varchar(20) DEFAULT NULL,
  `acte_generateur` text,
  `id_lignebudgetaire` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_controle` int(11) NOT NULL,
  `id_gestionnaire` int(11) NOT NULL,
  `id_chapitre` int(11) NOT NULL,
  `id_typeprocedure` int(11) NOT NULL,
  PRIMARY KEY (`id_dossierdepense`),
  KEY `FK_dossierDepense_id_lignebudgetaire` (`id_lignebudgetaire`),
  KEY `FK_dossierDepense_id_utilisateur` (`id_utilisateur`),
  KEY `FK_dossierDepense_id_controle` (`id_controle`),
  KEY `FK_dossierDepense_id_gestionnaire` (`id_gestionnaire`),
  KEY `FK_dossierDepense_id_chapitre` (`id_chapitre`),
  KEY `FK_dossierDepense_id_typeprocedure` (`id_typeprocedure`),
  CONSTRAINT `FK_dossierDepense_id_chapitre` FOREIGN KEY (`id_chapitre`) REFERENCES `chapitre` (`id_chapitre`),
  CONSTRAINT `FK_dossierDepense_id_controle` FOREIGN KEY (`id_controle`) REFERENCES `controle` (`id_controle`),
  CONSTRAINT `FK_dossierDepense_id_gestionnaire` FOREIGN KEY (`id_gestionnaire`) REFERENCES `gestionnairecredit` (`id_gestionnaire`),
  CONSTRAINT `FK_dossierDepense_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`),
  CONSTRAINT `FK_dossierDepense_id_typeprocedure` FOREIGN KEY (`id_typeprocedure`) REFERENCES `typeprocedure` (`id_typeprocedure`),
  CONSTRAINT `FK_dossierDepense_id_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dossierdepense` */

/*Table structure for table `etre_associer` */

DROP TABLE IF EXISTS `etre_associer`;

CREATE TABLE `etre_associer` (
  `id_lignebudgetaire` int(11) NOT NULL AUTO_INCREMENT,
  `id_budgetvote` int(11) NOT NULL,
  `montant_vote` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_lignebudgetaire`,`id_budgetvote`),
  KEY `FK_etre_associer_id_budgetvote` (`id_budgetvote`),
  CONSTRAINT `FK_etre_associer_id_budgetvote` FOREIGN KEY (`id_budgetvote`) REFERENCES `budgetvote` (`id_budgetvote`),
  CONSTRAINT `FK_etre_associer_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `etre_associer` */

/*Table structure for table `etre_composer` */

DROP TABLE IF EXISTS `etre_composer`;

CREATE TABLE `etre_composer` (
  `id_lignebudgetaire` int(11) NOT NULL AUTO_INCREMENT,
  `id_pebunite` int(11) NOT NULL,
  `montant_pebunitelb` double DEFAULT NULL,
  PRIMARY KEY (`id_lignebudgetaire`,`id_pebunite`),
  KEY `FK_etre_composer_id_pebunite` (`id_pebunite`),
  CONSTRAINT `FK_etre_composer_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`),
  CONSTRAINT `FK_etre_composer_id_pebunite` FOREIGN KEY (`id_pebunite`) REFERENCES `pebunite` (`id_pebunite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `etre_composer` */

/*Table structure for table `etre_constituer` */

DROP TABLE IF EXISTS `etre_constituer`;

CREATE TABLE `etre_constituer` (
  `id_lignebudgetaire` int(11) NOT NULL AUTO_INCREMENT,
  `id_peb` int(11) NOT NULL,
  `montant_peblb` double DEFAULT NULL,
  PRIMARY KEY (`id_lignebudgetaire`,`id_peb`),
  KEY `FK_etre_constituer_id_peb` (`id_peb`),
  CONSTRAINT `FK_etre_constituer_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`),
  CONSTRAINT `FK_etre_constituer_id_peb` FOREIGN KEY (`id_peb`) REFERENCES `peb` (`id_peb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `etre_constituer` */

/*Table structure for table `etre_gerer` */

DROP TABLE IF EXISTS `etre_gerer`;

CREATE TABLE `etre_gerer` (
  `id_anneebudgetaire` int(11) NOT NULL AUTO_INCREMENT,
  `id_gestionnaire` int(11) NOT NULL,
  PRIMARY KEY (`id_anneebudgetaire`,`id_gestionnaire`),
  KEY `FK_etre_gerer_id_gestionnaire` (`id_gestionnaire`),
  CONSTRAINT `FK_etre_gerer_id_anneebudgetaire` FOREIGN KEY (`id_anneebudgetaire`) REFERENCES `anneebudgetaire` (`id_anneebudgetaire`),
  CONSTRAINT `FK_etre_gerer_id_gestionnaire` FOREIGN KEY (`id_gestionnaire`) REFERENCES `gestionnairecredit` (`id_gestionnaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `etre_gerer` */

/*Table structure for table `faire_partie` */

DROP TABLE IF EXISTS `faire_partie`;

CREATE TABLE `faire_partie` (
  `id_consolidation` int(11) NOT NULL AUTO_INCREMENT,
  `id_unite` int(11) NOT NULL,
  PRIMARY KEY (`id_consolidation`,`id_unite`),
  KEY `FK_faire_partie_id_unite` (`id_unite`),
  CONSTRAINT `FK_faire_partie_id_consolidation` FOREIGN KEY (`id_consolidation`) REFERENCES `consolidation` (`id_consolidation`),
  CONSTRAINT `FK_faire_partie_id_unite` FOREIGN KEY (`id_unite`) REFERENCES `unite` (`id_unite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `faire_partie` */

/*Table structure for table `financement` */

DROP TABLE IF EXISTS `financement`;

CREATE TABLE `financement` (
  `id_financement` int(11) NOT NULL AUTO_INCREMENT,
  `nom_financement` varchar(30) DEFAULT NULL,
  `code_financement` varchar(20) DEFAULT NULL,
  `id_littera` int(11) NOT NULL,
  PRIMARY KEY (`id_financement`),
  KEY `FK_financement_id_littera` (`id_littera`),
  CONSTRAINT `FK_financement_id_littera` FOREIGN KEY (`id_littera`) REFERENCES `littera` (`id_littera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `financement` */

/*Table structure for table `fonctionnalite` */

DROP TABLE IF EXISTS `fonctionnalite`;

CREATE TABLE `fonctionnalite` (
  `id_fonctionnalite` int(11) NOT NULL AUTO_INCREMENT,
  `nom_fonctionnalite` text,
  `shortname_fonctionnalite` varchar(30) DEFAULT NULL,
  `commande_fonctionnalite` text,
  `page_fonctionnalite` varchar(50) DEFAULT NULL,
  `icone_fonctionnalite` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_fonctionnalite`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `fonctionnalite` */

insert  into `fonctionnalite`(`id_fonctionnalite`,`nom_fonctionnalite`,`shortname_fonctionnalite`,`commande_fonctionnalite`,`page_fonctionnalite`,`icone_fonctionnalite`) values (1,'Accueil','Accueil','/views/home','home','ui-icon ui-icon-home'),(2,'Préparation Budgétaire','Préparation Budgétaire','/views/preparingBudget','preparingBudget','ui-icon ui-icon-calculator'),(3,'Exécution Budgétaire','Exécution Budgétaire','/views/executingBudget','executingBudget','ui-icon ui-icon-refresh'),(4,'Suivi des Investissements','Suivi des Investissements','/views/investment','investment','ui-icon ui-icon-transferthick-e-w'),(5,'Gestion des Recettes','Gestion des Recettes','/views/revenue','revenue','ui-icon ui-icon-suitcase'),(6,'Gestion de la Trésorerie','Gestion de la Trésorerie','/views/treasury','treasury','ui-icon ui-icon-cart'),(7,'Comptabilité Elémentaire','Comptabilité Elémentaire','/views/accounting','accounting','ui-icon ui-icon-disk'),(8,'Gestion Electronique des Documents (GED)','Gestion Documents (GED)','/views/docManager','docManager','ui-icon ui-icon-note'),(9,'Aide à l’analyse, les études et la redevabilité','Reporting et Décisionnel','/views/reporting','reporting','ui-icon ui-icon-print'),(10,'Administration Technique','Administration Technique','/views/adminTech','adminTech','ui-icon ui-icon-gear'),(11,'Paramètrages','Paramètrages','/views/setting','setting','ui-icon ui-icon-wrench');

/*Table structure for table `fournisseur` */

DROP TABLE IF EXISTS `fournisseur`;

CREATE TABLE `fournisseur` (
  `id_fournisseur` int(11) NOT NULL AUTO_INCREMENT,
  `nom_fournisseur` varchar(70) DEFAULT NULL,
  `adresse_fournisseur` text,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fournisseur` */

/*Table structure for table `fournisseuritem` */

DROP TABLE IF EXISTS `fournisseuritem`;

CREATE TABLE `fournisseuritem` (
  `id_fournisseuritem` int(11) NOT NULL AUTO_INCREMENT,
  `nom_fournisseuritem` varchar(70) DEFAULT NULL,
  `adresse_fournisseruitem` text,
  PRIMARY KEY (`id_fournisseuritem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fournisseuritem` */

/*Table structure for table `gestionnairecredit` */

DROP TABLE IF EXISTS `gestionnairecredit`;

CREATE TABLE `gestionnairecredit` (
  `id_gestionnaire` int(11) NOT NULL AUTO_INCREMENT,
  `prenom_gestionnaire` varchar(30) DEFAULT NULL,
  `nom_gestionnaire` varchar(30) DEFAULT NULL,
  `Postnom_gestionnaire` varchar(30) DEFAULT NULL,
  `sexe_gestionnaire` varchar(10) DEFAULT NULL,
  `grade_gestionnaire` varchar(30) DEFAULT NULL,
  `fonction_gestionnaire` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_gestionnaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gestionnairecredit` */

/*Table structure for table `grandefonctionetat` */

DROP TABLE IF EXISTS `grandefonctionetat`;

CREATE TABLE `grandefonctionetat` (
  `id_grandefonction` int(11) NOT NULL AUTO_INCREMENT,
  `nom_grandefonction` varchar(30) DEFAULT NULL,
  `code_grandefonction` varchar(30) DEFAULT NULL,
  `id_anneebudgetaire` int(11) NOT NULL,
  PRIMARY KEY (`id_grandefonction`),
  KEY `FK_grandeFonctionEtat_id_anneebudgetaire` (`id_anneebudgetaire`),
  CONSTRAINT `FK_grandeFonctionEtat_id_anneebudgetaire` FOREIGN KEY (`id_anneebudgetaire`) REFERENCES `anneebudgetaire` (`id_anneebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `grandefonctionetat` */

/*Table structure for table `inclure` */

DROP TABLE IF EXISTS `inclure`;

CREATE TABLE `inclure` (
  `id_depense` int(11) NOT NULL AUTO_INCREMENT,
  `id_fournisseur` int(11) NOT NULL,
  PRIMARY KEY (`id_depense`,`id_fournisseur`),
  KEY `FK_inclure_id_fournisseur` (`id_fournisseur`),
  CONSTRAINT `FK_inclure_id_depense` FOREIGN KEY (`id_depense`) REFERENCES `depense` (`id_depense`),
  CONSTRAINT `FK_inclure_id_fournisseur` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseur` (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `inclure` */

/*Table structure for table `intervenir_a_arbitrage` */

DROP TABLE IF EXISTS `intervenir_a_arbitrage`;

CREATE TABLE `intervenir_a_arbitrage` (
  `id_particilpant` int(11) NOT NULL AUTO_INCREMENT,
  `id_budgetprovisoire` int(11) NOT NULL,
  PRIMARY KEY (`id_particilpant`,`id_budgetprovisoire`),
  KEY `FK_intervenir_a_arbitrage_id_budgetprovisoire` (`id_budgetprovisoire`),
  CONSTRAINT `FK_intervenir_a_arbitrage_id_budgetprovisoire` FOREIGN KEY (`id_budgetprovisoire`) REFERENCES `budgetprovisoire` (`id_budgetprovisoire`),
  CONSTRAINT `FK_intervenir_a_arbitrage_id_particilpant` FOREIGN KEY (`id_particilpant`) REFERENCES `participant` (`id_particilpant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `intervenir_a_arbitrage` */

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `nom_item` varchar(50) DEFAULT NULL,
  `descritption_item` text,
  `id_lignebudgetaire` int(11) NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `FK_item_id_lignebudgetaire` (`id_lignebudgetaire`),
  CONSTRAINT `FK_item_id_lignebudgetaire` FOREIGN KEY (`id_lignebudgetaire`) REFERENCES `lignebudgetaire` (`id_lignebudgetaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item` */

/*Table structure for table `justificatifbesoin` */

DROP TABLE IF EXISTS `justificatifbesoin`;

CREATE TABLE `justificatifbesoin` (
  `id_justificatifbesoin` int(11) NOT NULL AUTO_INCREMENT,
  `nom_justificatifbesoin` varchar(30) DEFAULT NULL,
  `taille_justificatifbesoin` varchar(10) DEFAULT NULL,
  `format_justificatifbesoin` varchar(10) DEFAULT NULL,
  `cheminfichier_justificatifbesoin` text,
  `id_besoin` int(11) NOT NULL,
  PRIMARY KEY (`id_justificatifbesoin`),
  KEY `FK_justificatifBesoin_id_besoin` (`id_besoin`),
  CONSTRAINT `FK_justificatifBesoin_id_besoin` FOREIGN KEY (`id_besoin`) REFERENCES `besoin` (`id_besoin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `justificatifbesoin` */

/*Table structure for table `justificatifdepense` */

DROP TABLE IF EXISTS `justificatifdepense`;

CREATE TABLE `justificatifdepense` (
  `id_justificatif` int(11) NOT NULL AUTO_INCREMENT,
  `nom_justificatif` varchar(30) DEFAULT NULL,
  `taille_justificatif` double DEFAULT NULL,
  `format_justificatif` varchar(10) DEFAULT NULL,
  `chemin_fichier` text,
  `id_depense` int(11) NOT NULL,
  PRIMARY KEY (`id_justificatif`),
  KEY `FK_justificatifDepense_id_depense` (`id_depense`),
  CONSTRAINT `FK_justificatifDepense_id_depense` FOREIGN KEY (`id_depense`) REFERENCES `depense` (`id_depense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `justificatifdepense` */

/*Table structure for table `justificatifmission` */

DROP TABLE IF EXISTS `justificatifmission`;

CREATE TABLE `justificatifmission` (
  `id_justificatifmission` int(11) NOT NULL AUTO_INCREMENT,
  `nom_justificatifmission` varchar(30) DEFAULT NULL,
  `taille_justificatifmission` varchar(20) DEFAULT NULL,
  `format_justificatifmission` varchar(30) DEFAULT NULL,
  `chemin_fichiermission` text,
  `numero_ordremission` varchar(20) DEFAULT NULL,
  `id_mission` int(11) NOT NULL,
  PRIMARY KEY (`id_justificatifmission`),
  KEY `FK_justificatifMission_id_mission` (`id_mission`),
  CONSTRAINT `FK_justificatifMission_id_mission` FOREIGN KEY (`id_mission`) REFERENCES `mission` (`id_mission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `justificatifmission` */

/*Table structure for table `lignebudgetaire` */

DROP TABLE IF EXISTS `lignebudgetaire`;

CREATE TABLE `lignebudgetaire` (
  `id_lignebudgetaire` int(11) NOT NULL AUTO_INCREMENT,
  `libelle_lignebudgetaire` varchar(50) DEFAULT NULL,
  `id_localisation` int(11) NOT NULL,
  PRIMARY KEY (`id_lignebudgetaire`),
  KEY `FK_ligneBudgetaire_id_localisation` (`id_localisation`),
  CONSTRAINT `FK_ligneBudgetaire_id_localisation` FOREIGN KEY (`id_localisation`) REFERENCES `localisation` (`id_localisation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lignebudgetaire` */

/*Table structure for table `littera` */

DROP TABLE IF EXISTS `littera`;

CREATE TABLE `littera` (
  `id_littera` int(11) NOT NULL AUTO_INCREMENT,
  `nom_littera` varchar(30) DEFAULT NULL,
  `code_littera` varchar(20) DEFAULT NULL,
  `id_article` int(11) NOT NULL,
  PRIMARY KEY (`id_littera`),
  KEY `FK_littera_id_article` (`id_article`),
  CONSTRAINT `FK_littera_id_article` FOREIGN KEY (`id_article`) REFERENCES `article` (`id_article`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `littera` */

/*Table structure for table `localisation` */

DROP TABLE IF EXISTS `localisation`;

CREATE TABLE `localisation` (
  `id_localisation` int(11) NOT NULL AUTO_INCREMENT,
  `nom_localisation` varchar(30) DEFAULT NULL,
  `code_localisation` varchar(20) DEFAULT NULL,
  `id_numeroprojet` int(11) NOT NULL,
  PRIMARY KEY (`id_localisation`),
  KEY `FK_localisation_id_numeroprojet` (`id_numeroprojet`),
  CONSTRAINT `FK_localisation_id_numeroprojet` FOREIGN KEY (`id_numeroprojet`) REFERENCES `numeroprojet` (`id_numeroprojet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `localisation` */

/*Table structure for table `manipuler` */

DROP TABLE IF EXISTS `manipuler`;

CREATE TABLE `manipuler` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `id_sousfonctionnalite` int(11) NOT NULL,
  PRIMARY KEY (`id_utilisateur`,`id_sousfonctionnalite`),
  KEY `FK_manipuler_id_sousfonctionnalite` (`id_sousfonctionnalite`),
  CONSTRAINT `FK_manipuler_id_sousfonctionnalite` FOREIGN KEY (`id_sousfonctionnalite`) REFERENCES `sousfonctionnalite` (`id_sousfonctionnalite`),
  CONSTRAINT `FK_manipuler_id_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `manipuler` */

/*Table structure for table `mission` */

DROP TABLE IF EXISTS `mission`;

CREATE TABLE `mission` (
  `id_mission` int(11) NOT NULL AUTO_INCREMENT,
  `numero_mission` varchar(20) DEFAULT NULL,
  `but_mission` text,
  `destination_mission` text,
  `duree_mission` varchar(20) DEFAULT NULL,
  `moyentransport` varchar(30) DEFAULT NULL,
  `datedepart_mission` date DEFAULT NULL,
  `montant_mission` double DEFAULT NULL,
  `id_depense` int(11) NOT NULL,
  PRIMARY KEY (`id_mission`),
  KEY `FK_mission_id_depense` (`id_depense`),
  CONSTRAINT `FK_mission_id_depense` FOREIGN KEY (`id_depense`) REFERENCES `depense` (`id_depense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mission` */

/*Table structure for table `numeroprojet` */

DROP TABLE IF EXISTS `numeroprojet`;

CREATE TABLE `numeroprojet` (
  `id_numeroprojet` int(11) NOT NULL AUTO_INCREMENT,
  `nom_numeroprojet` varchar(30) DEFAULT NULL,
  `code_numeroprojet` varchar(20) DEFAULT NULL,
  `id_specification` int(11) NOT NULL,
  PRIMARY KEY (`id_numeroprojet`),
  KEY `FK_numeroProjet_id_specification` (`id_specification`),
  CONSTRAINT `FK_numeroProjet_id_specification` FOREIGN KEY (`id_specification`) REFERENCES `specification` (`id_specification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `numeroprojet` */

/*Table structure for table `operation` */

DROP TABLE IF EXISTS `operation`;

CREATE TABLE `operation` (
  `id_operation` int(11) NOT NULL AUTO_INCREMENT,
  `nom_operation` text,
  `shortname_operation` varchar(30) DEFAULT NULL,
  `commande_operation` varchar(70) DEFAULT NULL,
  `icone_operation` varchar(50) DEFAULT NULL,
  `id_sousfonctionnalite` int(11) NOT NULL,
  PRIMARY KEY (`id_operation`),
  KEY `FK_operation_id_sousfonctionnalite` (`id_sousfonctionnalite`),
  CONSTRAINT `FK_operation_id_sousfonctionnalite` FOREIGN KEY (`id_sousfonctionnalite`) REFERENCES `sousfonctionnalite` (`id_sousfonctionnalite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `operation` */

/*Table structure for table `operer` */

DROP TABLE IF EXISTS `operer`;

CREATE TABLE `operer` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `id_operation` int(11) NOT NULL,
  PRIMARY KEY (`id_utilisateur`,`id_operation`),
  KEY `FK_operer_id_operation` (`id_operation`),
  CONSTRAINT `FK_operer_id_operation` FOREIGN KEY (`id_operation`) REFERENCES `operation` (`id_operation`),
  CONSTRAINT `FK_operer_id_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `operer` */

/*Table structure for table `participant` */

DROP TABLE IF EXISTS `participant`;

CREATE TABLE `participant` (
  `id_particilpant` int(11) NOT NULL AUTO_INCREMENT,
  `nom_participant` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_particilpant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `participant` */

/*Table structure for table `participer` */

DROP TABLE IF EXISTS `participer`;

CREATE TABLE `participer` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `id_consolidation` int(11) NOT NULL,
  `id_fournisseuritem` int(11) NOT NULL,
  `quantite_itemconsolidation` int(10) DEFAULT NULL,
  `prix_unitaire` double DEFAULT NULL,
  `monnaie_utilisee` varchar(70) DEFAULT NULL,
  `commentaire` text,
  PRIMARY KEY (`id_item`,`id_consolidation`,`id_fournisseuritem`),
  KEY `FK_participer_id_consolidation` (`id_consolidation`),
  KEY `FK_participer_id_fournisseuritem` (`id_fournisseuritem`),
  CONSTRAINT `FK_participer_id_consolidation` FOREIGN KEY (`id_consolidation`) REFERENCES `consolidation` (`id_consolidation`),
  CONSTRAINT `FK_participer_id_fournisseuritem` FOREIGN KEY (`id_fournisseuritem`) REFERENCES `fournisseuritem` (`id_fournisseuritem`),
  CONSTRAINT `FK_participer_id_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `participer` */

/*Table structure for table `peb` */

DROP TABLE IF EXISTS `peb`;

CREATE TABLE `peb` (
  `id_peb` int(11) NOT NULL AUTO_INCREMENT,
  `description_peb` text,
  `trimestre` varchar(20) DEFAULT NULL,
  `date_elaborationpeb` date DEFAULT NULL,
  `montant_peb` double DEFAULT NULL,
  PRIMARY KEY (`id_peb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `peb` */

/*Table structure for table `pebunite` */

DROP TABLE IF EXISTS `pebunite`;

CREATE TABLE `pebunite` (
  `id_pebunite` int(11) NOT NULL AUTO_INCREMENT,
  `description_pebunite` text,
  `trimestre_pebunite` varchar(20) DEFAULT NULL,
  `date_elaborationpebunite` date DEFAULT NULL,
  `montant_pebunite` double DEFAULT NULL,
  `id_unite` int(11) NOT NULL,
  `id_peb` int(11) NOT NULL,
  PRIMARY KEY (`id_pebunite`),
  KEY `FK_PEBUnite_id_unite` (`id_unite`),
  KEY `FK_PEBUnite_id_peb` (`id_peb`),
  CONSTRAINT `FK_PEBUnite_id_peb` FOREIGN KEY (`id_peb`) REFERENCES `peb` (`id_peb`),
  CONSTRAINT `FK_PEBUnite_id_unite` FOREIGN KEY (`id_unite`) REFERENCES `unite` (`id_unite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pebunite` */

/*Table structure for table `profil` */

DROP TABLE IF EXISTS `profil`;

CREATE TABLE `profil` (
  `id_profil` int(11) NOT NULL AUTO_INCREMENT,
  `nom_profil` varchar(40) DEFAULT NULL,
  `shortname_profil` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_profil`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `profil` */

insert  into `profil`(`id_profil`,`nom_profil`,`shortname_profil`) values (1,'Super Administrateur','Super Admin'),(2,'Administrateur Informatique','Admin Info'),(3,'Administrateur budgétaire','Admin Budget'),(4,'Responsable budgétaire','Respo Budget'),(5,'Sous-Gestionnaire','Sous Gest'),(6,'Contrôleur Budgétaire','Contro Budget'),(7,'Gestionnaire des Recettes','Gest recettes'),(8,'Trésorier','Trésorier');

/*Table structure for table `province` */

DROP TABLE IF EXISTS `province`;

CREATE TABLE `province` (
  `id_province` int(11) NOT NULL AUTO_INCREMENT,
  `nom_province` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_province`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `province` */

insert  into `province`(`id_province`,`nom_province`) values (1,'Bas-Congo'),(2,'Bandundu'),(3,'Kinshasa'),(4,'Maniema'),(5,'Sud-Kivu'),(6,'Province Orientale'),(7,'Equateur'),(8,'Katanga'),(9,'Kasai-Occidentale'),(10,'Kasai-Oriental'),(11,'Nord-Kivu');

/*Table structure for table `section` */

DROP TABLE IF EXISTS `section`;

CREATE TABLE `section` (
  `id_section` int(11) NOT NULL AUTO_INCREMENT,
  `nom_section` varchar(30) DEFAULT NULL,
  `code_section` varchar(20) DEFAULT NULL,
  `id_grandefonction` int(11) NOT NULL,
  PRIMARY KEY (`id_section`),
  KEY `FK_section_id_grandefonction` (`id_grandefonction`),
  CONSTRAINT `FK_section_id_grandefonction` FOREIGN KEY (`id_grandefonction`) REFERENCES `grandefonctionetat` (`id_grandefonction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `section` */

/*Table structure for table `sousfonctionnalite` */

DROP TABLE IF EXISTS `sousfonctionnalite`;

CREATE TABLE `sousfonctionnalite` (
  `id_sousfonctionnalite` int(11) NOT NULL AUTO_INCREMENT,
  `nom_sousfoncionnalite` varchar(40) DEFAULT NULL,
  `shortname_sousfonctionnalite` varchar(30) DEFAULT NULL,
  `commande_sousfonctionnalite` varchar(50) DEFAULT NULL,
  `icone_sousfonctionnalite` varchar(40) DEFAULT NULL,
  `id_fonctionnalite` int(11) NOT NULL,
  PRIMARY KEY (`id_sousfonctionnalite`),
  KEY `FK_sousFonctionnalite_id_fonctionnalite` (`id_fonctionnalite`),
  CONSTRAINT `FK_sousFonctionnalite_id_fonctionnalite` FOREIGN KEY (`id_fonctionnalite`) REFERENCES `fonctionnalite` (`id_fonctionnalite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sousfonctionnalite` */

/*Table structure for table `specification` */

DROP TABLE IF EXISTS `specification`;

CREATE TABLE `specification` (
  `id_specification` int(11) NOT NULL AUTO_INCREMENT,
  `nom_specification` varchar(30) DEFAULT NULL,
  `code_specification` varchar(20) DEFAULT NULL,
  `id_financement` int(11) NOT NULL,
  PRIMARY KEY (`id_specification`),
  KEY `FK_specification_id_financement` (`id_financement`),
  CONSTRAINT `FK_specification_id_financement` FOREIGN KEY (`id_financement`) REFERENCES `financement` (`id_financement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `specification` */

/*Table structure for table `typeprocedure` */

DROP TABLE IF EXISTS `typeprocedure`;

CREATE TABLE `typeprocedure` (
  `id_typeprocedure` int(11) NOT NULL AUTO_INCREMENT,
  `nom_typeprocedure` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_typeprocedure`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `typeprocedure` */

/*Table structure for table `unite` */

DROP TABLE IF EXISTS `unite`;

CREATE TABLE `unite` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `nom_unite` varchar(50) DEFAULT NULL,
  `code_unite` varchar(50) DEFAULT NULL,
  `adresse_unite` text,
  `compte_bancaire` varchar(20) DEFAULT NULL,
  `id_categorieunite` int(11) NOT NULL,
  `id_district` int(11) NOT NULL,
  PRIMARY KEY (`id_unite`),
  KEY `FK_unite_id_categorieunite` (`id_categorieunite`),
  KEY `FK_unite_id_district` (`id_district`),
  CONSTRAINT `FK_unite_id_categorieunite` FOREIGN KEY (`id_categorieunite`) REFERENCES `categorieunite` (`id_categorieunite`),
  CONSTRAINT `FK_unite_id_district` FOREIGN KEY (`id_district`) REFERENCES `district` (`id_district`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `unite` */

insert  into `unite`(`id_unite`,`nom_unite`,`code_unite`,`adresse_unite`,`compte_bancaire`,`id_categorieunite`,`id_district`) values (1,'Direction Budget et Finance','DBF',NULL,NULL,1,2);

/*Table structure for table `utilisateur` */

DROP TABLE IF EXISTS `utilisateur`;

CREATE TABLE `utilisateur` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `matricule` varchar(40) DEFAULT NULL,
  `prenom` varchar(30) DEFAULT NULL,
  `nom` varchar(70) DEFAULT NULL,
  `postnom` varchar(70) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `grade` varchar(40) DEFAULT NULL,
  `identifiant` varchar(40) DEFAULT NULL,
  `mot_de_passe` varchar(70) DEFAULT NULL,
  `date_enregistrement` datetime DEFAULT NULL,
  `date_derniere_visite` datetime DEFAULT NULL,
  `nouveau` int(10) DEFAULT NULL,
  `statut` int(10) DEFAULT NULL,
  `id_unite` int(11) DEFAULT NULL,
  `id_profil` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_utilisateur`),
  KEY `FK_utilisateur_id_unite` (`id_unite`),
  KEY `FK_utilisateur_id_profil` (`id_profil`),
  CONSTRAINT `FK_utilisateur_id_profil` FOREIGN KEY (`id_profil`) REFERENCES `profil` (`id_profil`),
  CONSTRAINT `FK_utilisateur_id_unite` FOREIGN KEY (`id_unite`) REFERENCES `unite` (`id_unite`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `utilisateur` */

insert  into `utilisateur`(`id_utilisateur`,`matricule`,`prenom`,`nom`,`postnom`,`phone`,`email`,`grade`,`identifiant`,`mot_de_passe`,`date_enregistrement`,`date_derniere_visite`,`nouveau`,`statut`,`id_unite`,`id_profil`) values (1,'007/KIN/DBF','Bob','Boseko','Bokanga','+243814520766','bobnoblesse@gmail.com','Software Developer','bboseko','cozAa29LxC9vVzoMfYUUkL2Hq9W5mLaBxYM0LPul2pM=','2013-09-11 06:11:31','2014-02-20 17:04:02',0,1,1,1),(2,'008/KIN/DBF','Eddy','Bongwele',NULL,NULL,NULL,NULL,'eddy','cozAa29LxC9vVzoMfYUUkL2Hq9W5mLaBxYM0LPul2pM=','2014-02-20 15:56:07','2014-02-20 16:41:43',1,1,1,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
