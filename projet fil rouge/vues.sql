-- Créez une vue correspondant à la jointure Produits - Fournisseurs

CREATE VIEW v_article_fournisseur
AS
SELECT a.id_article ,a.libelle, a.description, a.img_article, a.qte_stock, a.prix_achat, a.id_categorie,df.id_fournisseur, df.ref_fournisseur, f.nom_fournisseur , f.mail_fournisseur, f.tel_fournisseur 
FROM article as a
JOIN details_fournisseur df ON df.id_article=a.id_article
JOIN fournisseur f ON df.id_fournisseur=f.id_fournisseur;

SELECT*FROM v_article_fournisseur
-- Créez une vue correspondant à la jointure Produits - Catégorie/Sous catégorie

CREATE VIEW v_article_categorie
AS
SELECT a.id_article ,a.libelle, a.description, a.img_article, a.qte_stock, a.prix_achat, a.id_categorie, c.libelle_categorie, c.img_cat, c.id_categorie_1
FROM article a
JOIN categorie c ON c.id_categorie=a.id_categorie;

SELECT*FROM v_article_categorie