/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hazelshop
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adresse` (
  `id_adresse` int(11) NOT NULL AUTO_INCREMENT,
  `libelle_adresse` varchar(50) DEFAULT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `complement_adresse` varchar(50) DEFAULT NULL,
  `voie` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `ville` varchar(60) DEFAULT NULL,
  `pays` varchar(50) DEFAULT NULL,
  `id_client` int(11) NOT NULL,
  PRIMARY KEY (`id_adresse`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `adresse_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresse`
--

LOCK TABLES `adresse` WRITE;
/*!40000 ALTER TABLE `adresse` DISABLE KEYS */;
INSERT INTO `adresse` VALUES
(1,'maison','7',NULL,'rue de la plage','02240','Scranton','France',1),
(2,'bureau','3',NULL,'rue de l\'opéra','60120','Breteuil','France',2);
/*!40000 ALTER TABLE `adresse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adresse_livraison`
--

DROP TABLE IF EXISTS `adresse_livraison`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adresse_livraison` (
  `id_commande` int(11) NOT NULL,
  `id_adresse` int(11) NOT NULL,
  PRIMARY KEY (`id_commande`,`id_adresse`),
  KEY `id_adresse` (`id_adresse`),
  CONSTRAINT `adresse_livraison_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`),
  CONSTRAINT `adresse_livraison_ibfk_2` FOREIGN KEY (`id_adresse`) REFERENCES `adresse` (`id_adresse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresse_livraison`
--

LOCK TABLES `adresse_livraison` WRITE;
/*!40000 ALTER TABLE `adresse_livraison` DISABLE KEYS */;
INSERT INTO `adresse_livraison` VALUES
(1,1),
(2,2);
/*!40000 ALTER TABLE `adresse_livraison` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id_article` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `img_article` varchar(50) DEFAULT NULL,
  `qte_stock` int(11) DEFAULT NULL,
  `prix_ht` decimal(8,2) NOT NULL,
  `id_categorie` int(11) NOT NULL,
  PRIMARY KEY (`id_article`),
  KEY `id_categorie` (`id_categorie`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES
(1,'Cthulhu : Death May Die','Cthulhu : Death May Die est un jeu de plateau coopératif au rythme endiablé pouvant réunir 1 à 5 participants. Pour vaincre les horreurs surnaturelles venues de par-delà le temps et l’espace, vous devrez oeuvrer de concert et accepter de sombrer dans la folie. \nPlongez dans les mystères de six histoires différentes. Résolvez-les en utilisant à la fois les compétences et les névroses de vos investigateurs. Combattez toute une ménagerie de monstres issus du Mythe.\nVous allez devoir interrompre le rituel juste le temps de rendre le Grand Ancien vulnérable. Et vous allez le tuer. Une bonne fois pour toutes.','cthulhu-death-may-die.webp',15,79.90,4),
(2,'The Descent: Legendes des Ténèbres','Pendant des années, vos voyages vous ont mené à travers le royaume fantastique de Terrinoth, vous aventurant dans des forêts sombres, des villes obscures, des cryptes anciennes et des marais brumeux... mais votre véritable voyage légendaire ne fait que commencer… Forgez votre propre légende avec vos amis en vous aventurant à travers le royaume fantastique de Terrinoth dans Descent : Legends of the Dark, le jeu de plateau coopératif par excellence pour un à quatre joueurs ! Grâce à son application gratuite entièrement intégrée, Descent : Legends of the Dark vous met dans le rôle d un héros en herbe avec son propre style de jeu et ses propres capacités.','descent-legendes-des-tenebres.webp',2,135.90,4),
(3,'Arkeis','Arkeis est un jeu narratif et coopératif utilisant des figurines, dans lequel les joueurs explorent d’anciennes ruines égyptiennes. Le jeu est prévu pour être joué en campagne où chaque décision prise et chaque objet récupéré peut avoir une influence importante sur l’histoire qui se déroule. Chaque scénario s’accompagne d’objectifs que les joueurs peuvent remplir durant la partie. Compléter ces missions les récompensera avec de nouveaux objets importants ou de nouveaux pouvoirs qui influenceront les scénarios suivants. Il faudra une équipe de joueurs vétérans pour réussir à découvrir tous les secrets d’Arkeis !','arkeis.webp',3,74.92,4),
(4,'Cyclades','Dans les Cyclades la lutte pour faire rayonner votre cité sera terrible !\nEmbarquez pour l’archipel des Cyclades au coeur de la Grèce Antique. Avec la bénédiction des dieux de l’Olympe, et l’appui de fabuleuses créatures mythologiques, recrutez des troupes, construisez des navires, érigez des forteresses et des ports, bâtissez des métropoles.','cyclades.webp',8,50.50,5),
(5,'Galerapagos','Après le naufrage de votre bateau, vous faites partie d’un groupe de survivants bloqué sur une île déserte. Les portions d’eau sont comptées et le poisson se fait rare. Avec un tel régime, il n’est pas certain que tout le monde survive. Vous n’avez pas le choix : vous devez vous entraider pour quitter l’île. Pour quitter cette île, vous n’avez qu’une seule solution : rassembler vos forces pour construire ensemble un grand radeau. Mais il ne faut pas tarder car les nuages à l’horizon indiquent l’arrivée d’un dangereux ouragan. Faites équipe pour survivre mais soyez prêt à sacrifier vos camarades en cas de pénurie. Diplomatie et fourberies seront des éléments importants de votre survie. Soyez malin, utile et ne vous mettez personne à dos. Votre place sur le radeau en dépend !','galerapagos.jpg',20,15.84,2),
(6,'[Kosmopoli:t]','[Kosmopoli:t] est un jeu coopératif dans lequel les joueurs revivent tous ensemble l\'atmosphère du service du soir d\'un restaurant très ... cosmopolite. Ici, les clients viennent du monde entier et chacun commande dans sa propre langue. Les plats commandés concernent des plats typiques de chaque pays, qu\'il vous faudra déchiffrer correctement pour satisfaire les clients exigeants. Pour relever le défi, il vous faudra répéter le mieux possible ce que vous avez entendu (ou cru entendre) aux autres joueurs.','-kosmopoli-t-.jpg',36,18.84,2),
(7,'Unlock!: Legendary Adventures','Unlock! est un jeu de cartes coopératif inspiré des escape rooms. Legendary Adventures est 9ème opus de la saga. Découvrez 3 nouvelles aventures palpitantes : Action Story, Robin des bois : mort ou vif ! et Sherlock Homes : L\'Affaire des Anges Brûlés.','unlock-legendary-adventures.webp',18,25.42,6),
(8,'Unlock!: Epic Adventures','Unlock! est un jeu de cartes coopératif inspiré des escape rooms. Epic Adventures est le 7e opus de la saga Unlock. Découvrez 3 nouvelles aventures palpitantes : 7ème art et décès, Les 7 épreuves du Dragon et Mission #07.','unlock-epic-adventures.webp',12,25.42,6),
(9,'Cluebox: Casier de Davy Jones','Commencez l\'aventure du puzzle et résolvez les tâches une par une jusqu\'à pouvoir regarder à l\'intérieur du casier de Davy Jones','cluebox-casier-de-davy-jones.jpg',6,35.42,7),
(10,'Cluebox: Chat de Schrödinger','La Cluebox est une boîte à puzzle interactive avec diverses énigmes et tâches qu\'il faut résoudre les unes après les autres pour ouvrir la boîte.','cluebox-chat-de-schrodinger.jpg',10,35.42,7);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorie` (
  `id_categorie` int(11) NOT NULL AUTO_INCREMENT,
  `libelle_cat` varchar(50) NOT NULL,
  `img_cat` varchar(250) DEFAULT NULL,
  `id_categorie_1` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_categorie`),
  KEY `id_categorie_1` (`id_categorie_1`),
  CONSTRAINT `categorie_ibfk_1` FOREIGN KEY (`id_categorie_1`) REFERENCES `categorie` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorie`
--

LOCK TABLES `categorie` WRITE;
/*!40000 ALTER TABLE `categorie` DISABLE KEYS */;
INSERT INTO `categorie` VALUES
(1,'Jeux Experts',NULL,NULL),
(2,'Jeux d’ambiance',NULL,NULL),
(3,'Escape Games',NULL,NULL),
(4,'Jeux coopératifs',NULL,1),
(5,'Jeux non coopératifs',NULL,1),
(6,'Jeux de cartes',NULL,3),
(7,'Escape Box',NULL,3);
/*!40000 ALTER TABLE `categorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id_client` int(11) NOT NULL AUTO_INCREMENT,
  `num_client` varchar(50) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `coef_taxes` decimal(5,2) NOT NULL,
  `forme_juridique` varchar(50) DEFAULT NULL,
  `raison_sociale` varchar(50) DEFAULT NULL,
  `siren` varchar(9) DEFAULT NULL,
  `num_tva` varchar(50) DEFAULT NULL,
  `reduction_pro` decimal(5,2) DEFAULT NULL,
  `commercial` varchar(50) NOT NULL,
  `id_type_client` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_client`),
  KEY `id_type_client` (`id_type_client`),
  KEY `id_utilisateur` (`id_utilisateur`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`id_type_client`) REFERENCES `type_client` (`id_type_client`),
  CONSTRAINT `client_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES
(1,'999000','0404040404',20.00,NULL,NULL,NULL,NULL,NULL,'MrTruc',1,1),
(2,'999001','0304040403',10.00,'SARL','DunderMifflin','777777777','FR32777777777',3.00,'MrMachin',2,2),
(3,'999002','0504040405',10.00,'SARL','MSPC','123456789','FR32123456789',4.50,'MrBidule',2,3);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande`
--

DROP TABLE IF EXISTS `commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commande` (
  `id_commande` int(11) NOT NULL AUTO_INCREMENT,
  `date_commande` date NOT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `frais_port` decimal(5,2) DEFAULT NULL,
  `reduction` decimal(3,2) DEFAULT NULL,
  `mode_paiement` varchar(15) DEFAULT NULL,
  `delais_reglement` int(11) DEFAULT NULL,
  `montant_regle` decimal(10,2) DEFAULT NULL,
  `id_facture` varchar(50) DEFAULT NULL,
  `statut` varchar(50) NOT NULL,
  `id_adresse` int(11) NOT NULL,
  `id_client` int(11) NOT NULL,
  PRIMARY KEY (`id_commande`),
  KEY `id_adresse` (`id_adresse`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`id_adresse`) REFERENCES `adresse` (`id_adresse`),
  CONSTRAINT `commande_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande`
--

LOCK TABLES `commande` WRITE;
/*!40000 ALTER TABLE `commande` DISABLE KEYS */;
INSERT INTO `commande` VALUES
(1,'2020-09-06',NULL,4.90,NULL,'CB',0,NULL,'1','livrée',1,1),
(2,'2021-12-20',NULL,4.90,NULL,'virement',30,NULL,'1','livrée',2,2);
/*!40000 ALTER TABLE `commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details_commande`
--

DROP TABLE IF EXISTS `details_commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details_commande` (
  `id_article` int(11) NOT NULL,
  `id_commande` int(11) NOT NULL,
  `qte_article` int(11) DEFAULT NULL,
  `prix_ht` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_article`,`id_commande`),
  KEY `id_commande` (`id_commande`),
  CONSTRAINT `details_commande_ibfk_1` FOREIGN KEY (`id_article`) REFERENCES `article` (`id_article`),
  CONSTRAINT `details_commande_ibfk_2` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details_commande`
--

LOCK TABLES `details_commande` WRITE;
/*!40000 ALTER TABLE `details_commande` DISABLE KEYS */;
INSERT INTO `details_commande` VALUES
(1,2,1,79.90),
(6,1,1,18.84),
(9,2,4,35.42);
/*!40000 ALTER TABLE `details_commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details_fournisseur`
--

DROP TABLE IF EXISTS `details_fournisseur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details_fournisseur` (
  `id_article` int(11) NOT NULL,
  `id_fournisseur` int(11) NOT NULL,
  `ref_fournisseur` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_article`,`id_fournisseur`),
  KEY `id_fournisseur` (`id_fournisseur`),
  CONSTRAINT `details_fournisseur_ibfk_1` FOREIGN KEY (`id_article`) REFERENCES `article` (`id_article`),
  CONSTRAINT `details_fournisseur_ibfk_2` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseur` (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details_fournisseur`
--

LOCK TABLES `details_fournisseur` WRITE;
/*!40000 ALTER TABLE `details_fournisseur` DISABLE KEYS */;
INSERT INTO `details_fournisseur` VALUES
(1,2,'J04404'),
(3,1,'S60789');
/*!40000 ALTER TABLE `details_fournisseur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details_livraison`
--

DROP TABLE IF EXISTS `details_livraison`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details_livraison` (
  `id_article` int(11) NOT NULL,
  `id_livraison` int(11) NOT NULL,
  `qte_livree` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_article`,`id_livraison`),
  KEY `id_livraison` (`id_livraison`),
  CONSTRAINT `details_livraison_ibfk_1` FOREIGN KEY (`id_article`) REFERENCES `article` (`id_article`),
  CONSTRAINT `details_livraison_ibfk_2` FOREIGN KEY (`id_livraison`) REFERENCES `livraison` (`id_livraison`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details_livraison`
--

LOCK TABLES `details_livraison` WRITE;
/*!40000 ALTER TABLE `details_livraison` DISABLE KEYS */;
INSERT INTO `details_livraison` VALUES
(1,2,1),
(6,1,1),
(9,2,4);
/*!40000 ALTER TABLE `details_livraison` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fournisseur` (
  `id_fournisseur` int(11) NOT NULL AUTO_INCREMENT,
  `nom_fournisseur` varchar(50) NOT NULL,
  `mail_contact` varchar(50) NOT NULL,
  `tel_fournisseur` varchar(50) NOT NULL,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fournisseur`
--

LOCK TABLES `fournisseur` WRITE;
/*!40000 ALTER TABLE `fournisseur` DISABLE KEYS */;
INSERT INTO `fournisseur` VALUES
(1,'megajeux','megajeux@mail.fr','010203040506'),
(2,'ludothek','ludothek@mail.fr','0204060810'),
(3,'gameland','gameland@mail.fr','0606060606');
/*!40000 ALTER TABLE `fournisseur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livraison`
--

DROP TABLE IF EXISTS `livraison`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `livraison` (
  `id_livraison` int(11) NOT NULL AUTO_INCREMENT,
  `date_expedition` date NOT NULL,
  `mode_livraison` varchar(50) NOT NULL,
  `id_commande` int(11) NOT NULL,
  PRIMARY KEY (`id_livraison`),
  KEY `id_commande` (`id_commande`),
  CONSTRAINT `livraison_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livraison`
--

LOCK TABLES `livraison` WRITE;
/*!40000 ALTER TABLE `livraison` DISABLE KEYS */;
INSERT INTO `livraison` VALUES
(1,'2020-09-07','domicile',1),
(2,'2021-12-21','domicile',2),
(3,'2022-01-07','domicile',2);
/*!40000 ALTER TABLE `livraison` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_client`
--

DROP TABLE IF EXISTS `type_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_client` (
  `id_type_client` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_type_client`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_client`
--

LOCK TABLES `type_client` WRITE;
/*!40000 ALTER TABLE `type_client` DISABLE KEYS */;
INSERT INTO `type_client` VALUES
(1,'Particulier'),
(2,'Professionnel');
/*!40000 ALTER TABLE `type_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_utilisateur`
--

DROP TABLE IF EXISTS `type_utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_utilisateur` (
  `id_type_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_type_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_utilisateur`
--

LOCK TABLES `type_utilisateur` WRITE;
/*!40000 ALTER TABLE `type_utilisateur` DISABLE KEYS */;
INSERT INTO `type_utilisateur` VALUES
(1,'client'),
(2,'commercial'),
(3,'administrateur');
/*!40000 ALTER TABLE `type_utilisateur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilisateur` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `mdp` varchar(255) DEFAULT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `pseudo` varchar(50) DEFAULT NULL,
  `date_inscription` date NOT NULL,
  `id_type_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  KEY `id_type_utilisateur` (`id_type_utilisateur`),
  CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`id_type_utilisateur`) REFERENCES `type_utilisateur` (`id_type_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES
(1,NULL,'Scott','Michael','m.scott@mail.com',NULL,'2020-09-06',1),
(2,NULL,'Palmer','Meredith','m.palmer@mail.com',NULL,'2021-11-27',1),
(3,NULL,'Beesly','Pamela','p.beesly@mail.com',NULL,'2022-08-22',1);
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-26 14:04:37
