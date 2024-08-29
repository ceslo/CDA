-- Active: 1724318432273@@127.0.0.1@3306@hazelshop

-- Les commandes non soldées (en cours de livraison)
CREATE PROCEDURE commandes_non_soldees()
BEGIN
    SELECT *
    FROM commande
    WHERE statut like "en cours de livraison";
END;
CALL commandes_non_soldees;

-- Delais moyen d'expedition
CREATE PROCEDURE delais_expedition()
BEGIN
    SELECT c.id_commande, AVG(DATEDIFF(l.date_expedition, c.date_commande))
    FROM commande c
    JOIN livraison l ON l.id_commande=c.id_commande
    GROUP BY c.id_commande;
   
END;
CALL delais_expedition

-- Delais moyen entre la date de commande et la date de facturation.
CREATE PROCEDURE delais_facturation()
BEGIN
    SELECT  AVG(delais_reglement)
    FROM commande c
    JOIN livraison l ON l.id_commande=c.id_commande;
   
END;

CALL delais_facturation();


