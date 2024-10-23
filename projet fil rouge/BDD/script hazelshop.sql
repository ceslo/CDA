
DROP DATABASE IF EXISTS hazelshop ;
CREATE DATABASE hazelshop;

USE hazelshop;

CREATE TABLE fournisseur(
   id_fournisseur INT AUTO_INCREMENT,
   nom_fournisseur VARCHAR(50)  NOT NULL,
   mail_fournisseur VARCHAR(50) NOT NULL,
   tel_fournisseur VARCHAR(50) NOT NULL ,
   PRIMARY KEY(id_fournisseur)
);

CREATE TABLE type_utilisateur(
   id_type_utilisateur INT AUTO_INCREMENT,
   libelle_utilisateur VARCHAR(50) ,
   PRIMARY KEY(id_type_utilisateur)
);

CREATE TABLE utilisateur(
   id_utilisateur INT AUTO_INCREMENT,
   mdp VARCHAR(255) ,
   nom VARCHAR(50)  NOT NULL,
   prenom VARCHAR(50)  NOT NULL,
   mail VARCHAR(50)  NOT NULL,
   pseudo VARCHAR(50),
   date_inscription DATE NOT NULL,
   id_type_utilisateur INT NOT NULL,
   PRIMARY KEY(id_utilisateur),
   FOREIGN KEY(id_type_utilisateur) REFERENCES type_utilisateur(id_type_utilisateur)
);

CREATE TABLE type_client(
   id_type_client INT AUTO_INCREMENT,
   libelle VARCHAR(50) ,
   PRIMARY KEY(id_type_client)
);

CREATE TABLE client (
   id_client INT AUTO_INCREMENT,
   num_client VARCHAR(50)  NOT NULL,
   telephone VARCHAR(20)  NOT NULL,
   coef_client DECIMAL(5,2)   NOT NULL,
   forme_juridique VARCHAR(50) ,
   raison_sociale VARCHAR(50) ,
   siren VARCHAR(9) ,
   num_tva VARCHAR(50) ,
   reduction_pro DECIMAL(5,2)  ,
   commercial VARCHAR(50) NOT NULL,
   id_type_client INT NOT NULL,
   id_utilisateur INT NOT NULL,
   PRIMARY KEY(id_client),
   FOREIGN KEY(id_type_client) REFERENCES type_client(id_type_client),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE categorie(
   id_categorie INT AUTO_INCREMENT,
   libelle_categorie VARCHAR(50)  NOT NULL,
   img_categorie VARCHAR(250) ,
   categorie_mere INT,
   PRIMARY KEY(id_categorie),
   FOREIGN KEY(categorie_mere) REFERENCES categorie(id_categorie)
);

CREATE TABLE article(
   id_article INT AUTO_INCREMENT,
   libelle_article VARCHAR(50)  NOT NULL,
   description TEXT  NOT NULL,
   img_article VARCHAR(50) ,
   qte_stock INT,
   prix_achat DECIMAL(8,2)   NOT NULL,
   id_categorie INT NOT NULL,
   ref_fournisseur VARCHAR(50),
   id_fournisseur INT,
   PRIMARY KEY(id_article),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie),
   FOREIGN KEY(id_fournisseur) REFERENCES fournisseur(id_fournisseur)
);

CREATE TABLE adresse(
   id_adresse INT AUTO_INCREMENT,
   libelle_adresse VARCHAR(50) ,
   numero VARCHAR(50) ,
   complement_adresse VARCHAR(50) ,
   voie VARCHAR(50) ,
   cp VARCHAR(10) ,
   ville VARCHAR(60) ,
   pays VARCHAR(50) ,
   id_client INT NOT NULL,
   PRIMARY KEY(id_adresse),
   FOREIGN KEY(id_client) REFERENCES client(id_client)
);

CREATE TABLE commande(
   id_commande INT AUTO_INCREMENT,
   date_commande DATE NOT NULL,
   coef_client DECIMAL(5,2),
   remise DECIMAL(5,2),
   total DECIMAL(10,2),
   frais_port DECIMAL(5,2),  
   mode_paiement VARCHAR(15),
   delais_reglement INT,
   montant_regle DECIMAL(10,2),
   num_facture VARCHAR(50),
   statut VARCHAR(50)  NOT NULL,
   adresse_facturation INT NOT NULL,
   adresse_livraison INT NOT NULL,
   id_client INT NOT NULL,
   PRIMARY KEY(id_commande),
   FOREIGN KEY(adresse_facturation) REFERENCES adresse(id_adresse),
   FOREIGN KEY(adresse_livraison) REFERENCES adresse(id_adresse),
   FOREIGN KEY(id_client) REFERENCES client(id_client)
);

CREATE TABLE livraison(
   id_livraison INT AUTO_INCREMENT,
   date_expedition DATE NOT NULL,
   mode_livraison VARCHAR(50)  NOT NULL,
   id_commande INT NOT NULL,
   PRIMARY KEY(id_livraison),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande)
);

CREATE TABLE details_commande(
   id_article INT,
   id_commande INT,
   qte_article INT,
   prix_achat DECIMAL(8,2) NOT NULL,
   PRIMARY KEY(id_article, id_commande),
   FOREIGN KEY(id_article) REFERENCES article(id_article),
   FOREIGN KEY(id_commande) REFERENCES commande(id_commande)
);


CREATE TABLE details_livraison(
   id_article INT,
   id_livraison INT,
   qte_livree INT,
   PRIMARY KEY(id_article, id_livraison),
   FOREIGN KEY(id_article) REFERENCES article(id_article),
   FOREIGN KEY(id_livraison) REFERENCES livraison(id_livraison)
);



INSERT INTO type_client (id_type_client, libelle) VALUES (1, "Particulier");
INSERT INTO type_client (id_type_client, libelle) VALUES (2, "Professionnel");


INSERT INTO type_utilisateur(id_type_utilisateur , libelle_utilisateur) VALUES (1, "client");
INSERT INTO type_utilisateur(id_type_utilisateur , libelle_utilisateur) VALUES (2, "commercial");
INSERT INTO type_utilisateur(id_type_utilisateur , libelle_utilisateur) VALUES (3, "administrateur");

INSERT INTO fournisseur ( id_fournisseur, nom_fournisseur, mail_fournisseur, tel_fournisseur) VALUES (1, "megajeux","megajeux@mail.fr", "010203040506");
INSERT INTO fournisseur ( id_fournisseur, nom_fournisseur, mail_fournisseur, tel_fournisseur) VALUES (2,"ludothek", "ludothek@mail.fr","0204060810");
INSERT INTO fournisseur ( id_fournisseur, nom_fournisseur, mail_fournisseur, tel_fournisseur)VALUES (3,"gameland","gameland@mail.fr","0606060606");


INSERT INTO categorie ( id_categorie,  libelle_categorie)  VALUES (1, "Jeux Experts");
INSERT INTO categorie ( id_categorie,  libelle_categorie)  VALUES (2,"Jeux d’ambiance");
INSERT INTO categorie ( id_categorie,  libelle_categorie)  VALUES (3, "Escape Games");
INSERT INTO categorie ( id_categorie,  libelle_categorie, categorie_mere)  VALUES (4, "Jeux coopératifs", 1);
INSERT INTO categorie ( id_categorie,  libelle_categorie, categorie_mere)  VALUES (5, "Jeux non coopératifs", 1);
INSERT INTO categorie ( id_categorie,  libelle_categorie, categorie_mere)  VALUES (6, "Jeux de cartes", 3);
INSERT INTO categorie ( id_categorie,  libelle_categorie, categorie_mere)  VALUES (7, "Escape Box", 3);



INSERT INTO article ( id_article ,  libelle_article ,  description ,  img_article  ,  qte_stock ,  prix_achat,  id_categorie, ref_fournisseur, id_fournisseur) VALUES ( 1, "Cthulhu : Death May Die", "Cthulhu : Death May Die est un jeu de plateau coopératif au rythme endiablé pouvant réunir 1 à 5 participants. Pour vaincre les horreurs surnaturelles venues de par-delà le temps et l’espace, vous devrez oeuvrer de concert et accepter de sombrer dans la folie. 
Plongez dans les mystères de six histoires différentes. Résolvez-les en utilisant à la fois les compétences et les névroses de vos investigateurs. Combattez toute une ménagerie de monstres issus du Mythe.
Vous allez devoir interrompre le rituel juste le temps de rendre le Grand Ancien vulnérable. Et vous allez le tuer. Une bonne fois pour toutes." , "cthulhu-death-may-die.webp", 15, "79.92", 4, "C04404", 1);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES ( 2, "The Descent: Legendes des Ténèbres" , "Pendant des années, vos voyages vous ont mené à travers le royaume fantastique de Terrinoth, vous aventurant dans des forêts sombres, des villes obscures, des cryptes anciennes et des marais brumeux... mais votre véritable voyage légendaire ne fait que commencer… Forgez votre propre légende avec vos amis en vous aventurant à travers le royaume fantastique de Terrinoth dans Descent : Legends of the Dark, le jeu de plateau coopératif par excellence pour un à quatre joueurs ! Grâce à son application gratuite entièrement intégrée, Descent : Legends of the Dark vous met dans le rôle d un héros en herbe avec son propre style de jeu et ses propres capacités.", "descent-legendes-des-tenebres.webp", 2, "135.90", "4", "C04405", 1);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES (3, "Arkeis",  "Arkeis est un jeu narratif et coopératif utilisant des figurines, dans lequel les joueurs explorent d’anciennes ruines égyptiennes. Le jeu est prévu pour être joué en campagne où chaque décision prise et chaque objet récupéré peut avoir une influence importante sur l’histoire qui se déroule. Chaque scénario s’accompagne d’objectifs que les joueurs peuvent remplir durant la partie. Compléter ces missions les récompensera avec de nouveaux objets importants ou de nouveaux pouvoirs qui influenceront les scénarios suivants. Il faudra une équipe de joueurs vétérans pour réussir à découvrir tous les secrets d’Arkeis !", "arkeis.webp", 3 , "74.92", 4, "C04406", 1);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES ( 4, "Cyclades", "Dans les Cyclades la lutte pour faire rayonner votre cité sera terrible !
Embarquez pour l’archipel des Cyclades au coeur de la Grèce Antique. Avec la bénédiction des dieux de l’Olympe, et l’appui de fabuleuses créatures mythologiques, recrutez des troupes, construisez des navires, érigez des forteresses et des ports, bâtissez des métropoles.", "cyclades.webp", 8, "50.50", 5, "NC6078", 1);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES ( 5, "Galerapagos", "Après le naufrage de votre bateau, vous faites partie d’un groupe de survivants bloqué sur une île déserte. Les portions d’eau sont comptées et le poisson se fait rare. Avec un tel régime, il n’est pas certain que tout le monde survive. Vous n’avez pas le choix : vous devez vous entraider pour quitter l’île. Pour quitter cette île, vous n’avez qu’une seule solution : rassembler vos forces pour construire ensemble un grand radeau. Mais il ne faut pas tarder car les nuages à l’horizon indiquent l’arrivée d’un dangereux ouragan. Faites équipe pour survivre mais soyez prêt à sacrifier vos camarades en cas de pénurie. Diplomatie et fourberies seront des éléments importants de votre survie. Soyez malin, utile et ne vous mettez personne à dos. Votre place sur le radeau en dépend !", "galerapagos.jpg", 20, "15.84", 2,"A50756", 2);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES ( 6, "[Kosmopoli:t]", "[Kosmopoli:t] est un jeu coopératif dans lequel les joueurs revivent tous ensemble l'atmosphère du service du soir d'un restaurant très ... cosmopolite. Ici, les clients viennent du monde entier et chacun commande dans sa propre langue. Les plats commandés concernent des plats typiques de chaque pays, qu'il vous faudra déchiffrer correctement pour satisfaire les clients exigeants. Pour relever le défi, il vous faudra répéter le mieux possible ce que vous avez entendu (ou cru entendre) aux autres joueurs.", "-kosmopoli-t-.jpg", 36, "18.84", 2,  "A50789", 2);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES (7, "Unlock!: Legendary Adventures", "Unlock! est un jeu de cartes coopératif inspiré des escape rooms. Legendary Adventures est 9ème opus de la saga. Découvrez 3 nouvelles aventures palpitantes : Action Story, Robin des bois : mort ou vif ! et Sherlock Homes : L'Affaire des Anges Brûlés." , "unlock-legendary-adventures.webp" , 18 , "25.42", 6, "E32099", 3);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES (8, "Unlock!: Epic Adventures", "Unlock! est un jeu de cartes coopératif inspiré des escape rooms. Epic Adventures est le 7e opus de la saga Unlock. Découvrez 3 nouvelles aventures palpitantes : 7ème art et décès, Les 7 épreuves du Dragon et Mission #07.", "unlock-epic-adventures.webp", 12 , "25.42" , "6", "E32089", 3);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES (9, "Cluebox: Casier de Davy Jones", "Commencez l'aventure du puzzle et résolvez les tâches une par une jusqu'à pouvoir regarder à l'intérieur du casier de Davy Jones" , "cluebox-casier-de-davy-jones.jpg" , 6 ,"35.42", 7, "CB0789", 3);
INSERT INTO article (id_article, libelle_article, description, img_article, qte_stock, prix_achat, id_categorie, ref_fournisseur, id_fournisseur) VALUES (10, "Cluebox: Chat de Schrödinger" , "La Cluebox est une boîte à puzzle interactive avec diverses énigmes et tâches qu il faut résoudre les unes après les autres pour ouvrir la boîte." , "cluebox-chat-de-schrodinger.jpg", 10,"35.42", 7,"CB0791", 3);

 
INSERT INTO utilisateur( nom , prenom , mail, date_inscription, id_type_utilisateur) VALUES ( "Scott", "Michael","m.scott@mail.com", "2020-09-06" ,1);
INSERT INTO utilisateur( nom , prenom , mail, date_inscription, id_type_utilisateur) VALUES ( "Palmer", "Meredith","m.palmer@mail.com", "2021-11-27" ,1);
INSERT INTO utilisateur( nom , prenom , mail, date_inscription, id_type_utilisateur) VALUES ( "Beesly", "Pamela","p.beesly@mail.com", "2021-11-27" ,1);


INSERT INTO client (num_client, telephone, coef_client, commercial, id_type_client, id_utilisateur) VALUES ("999000", "0404040404", "1.35" ,"MrTruc", "1", "1" );
INSERT INTO client (num_client, telephone, coef_client, forme_juridique ,raison_sociale, siren , num_tva , reduction_pro , commercial, id_type_client, id_utilisateur) VALUES ("999001", "0304040403", "1.2" , "SARL", "DunderMifflin", "777777777", "FR32777777777", "3", "MrMachin", "2", "2" );
INSERT INTO client (num_client, telephone, coef_client, forme_juridique ,raison_sociale, siren , num_tva , reduction_pro , commercial, id_type_client, id_utilisateur) VALUES ("999002", "0504040405", "1.2" , "SARL", "MSPC", "123456789", "FR32123456789", "4.5", "MrBidule", "2","3");


INSERT INTO adresse (libelle_adresse, numero , voie, cp, ville , pays , id_client) VALUES ("maison", 7, "rue de la plage","02240", "Scranton", "France", 1);

INSERT INTO adresse (libelle_adresse, numero , voie, cp, ville , pays , id_client) VALUES ("bureau", 
3, "rue de l'opéra","60120", "Breteuil", "France", 2);

INSERT INTO commande(date_commande,coef_client, total, frais_port, mode_paiement, delais_reglement, montant_regle, num_facture, statut, adresse_facturation, adresse_livraison, id_client) VALUES ("2020-09-06", 1.35, 25.43, 4.90, "CB", "0", 30.33, 1, "livrée", 1, 1, 1);
INSERT INTO commande(date_commande,coef_client, total, frais_port, mode_paiement, delais_reglement,montant_regle, num_facture, statut, adresse_facturation, adresse_livraison, id_client) VALUES ("2021-12-20", 1.2, 265.90, 4.90,  "virement", "30", 270.80, 1, "livrée", 2, 2, 2) ;

INSERT INTO details_commande(id_article, id_commande, qte_article, prix_achat) VALUES (6,1,1,18.84);
INSERT INTO details_commande(id_article, id_commande, qte_article, prix_achat) VALUES (1,2,1,79.90);
INSERT INTO details_commande(id_article, id_commande, qte_article, prix_achat) VALUES (9,2,4,35.42);

INSERT INTO livraison(date_expedition, mode_livraison, id_commande) VALUES ("2020-09-07","domicile",1);
INSERT INTO livraison(date_expedition, mode_livraison, id_commande) VALUES ("2021-12-21","domicile",2);
INSERT INTO livraison(date_expedition, mode_livraison, id_commande) VALUES ("2022-01-07","domicile",2);

INSERT INTO details_livraison (id_article, id_livraison, qte_livree) VALUES (6,1,1);
INSERT INTO details_livraison (id_article, id_livraison, qte_livree) VALUES (1,2,1);
INSERT INTO details_livraison (id_article, id_livraison, qte_livree) VALUES (9,2,4);
