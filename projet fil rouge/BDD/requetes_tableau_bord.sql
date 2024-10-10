-- Chiffre d'affaires mois par mois pour une année sélectionnée (y)

SELECT MONTH(date_commande), sum(total) 
FROM commande 
WHERE YEAR(date_commande)=2020 
GROUP BY MONTH(date_commande)

-- Chiffre d'affaires généré pour un fournisseur

SELECT f.nom_fournisseur, sum(dc.qte_article*dc.prix_achat*c.coef_client) CA
FROM details_commande dc
JOIN details_fournisseur df ON df.id_article=dc.id_article
JOIN commande c ON dc.id_commande=c.id_commande
JOIN fournisseur f ON df.id_fournisseur=f.id_fournisseur
GROUP BY df.id_fournisseur

-- TOP 10 des produits les plus commandés pour une année sélectionnée "y"(référence et nom du produit, quantité commandée, fournisseur)

SELECT a.libelle, df.ref_fournisseur, dc.qte_article, f.nom_fournisseur
FROM article a
JOIN details_commande dc ON dc.id_article=a.id_article
JOIN details_fournisseur df ON df.id_article=dc.id_article
JOIN fournisseur f ON f.id_fournisseur=df.id_fournisseur
JOIN commande c ON dc.id_commande=c.id_commande
WHERE YEAR(date_commande)=2021
ORDER BY dc.qte_article DESC
LIMIT 10

-- TOP 10 des produits les plus rémunérateurs pour une année sélectionnée y (référence et nom du produit, marge, fournisseur)

SELECT a.libelle, df.ref_fournisseur, (dc.qte_article*dc.prix_achat*c.coef_client)-(dc.qte_article*dc.prix_achat) marge, f.nom_fournisseur
FROM article a
JOIN details_commande dc ON dc.id_article=a.id_article
JOIN details_fournisseur df ON df.id_article=dc.id_article
JOIN fournisseur f ON f.id_fournisseur=df.id_fournisseur
JOIN commande c ON dc.id_commande=c.id_commande
WHERE YEAR(date_commande)="y"
ORDER BY marge DESC
LIMIT 10

-- Top 10 des clients en nombre de commandes 

SELECT cli.id_client, COUNT(c.id_commande) Nombre_commandes
FROM client cli
JOIN commande c ON c.id_client = cli.id_client
GROUP BY cli.id_client
ORDER BY Nombre_commandes DESC
LIMIT 10

-- ou chiffre d'affaires

SELECT cli.id_client, SUM(c.total) CA 
FROM client cli
JOIN commande c ON c.id_client=cli.id_client
GROUP BY cli.id_client
ORDER BY CA DESC
LIMIT 10

-- Répartition du chiffre d'affaires par type de client

SELECT tc.libelle_client Type_client, SUM(c.total) CA 
FROM client cli
JOIN commande c ON c.id_client=cli.id_client
JOIN type_client tc ON cli.id_type_client=tc.id_type_client
GROUP BY cli.id_type_client
ORDER BY CA DESC
LIMIT 10

-- Nombre de commandes en cours de livraison.

SELECT COUNT(id_commande)
FROM commande
where statut like "en cours de livraison"
