-- Active: 1724318432273@@127.0.0.1@3306@adventureworks

-- AdventureWorks
-- 1. Afficher la liste des personnes (nom, prénom, poste) qui sont des employés de l’entreprise
-- AdventureWorks
SELECT p.LastName, p.FirstName, e.JobTitle 
FROM HumanResources_Employee e
LEFT JOIN Person_Person p ON e.BusinessEntityID=p.BusinessEntityID;

-- 2. Afficher la liste des employés (nom, prénom, service dans lequel ils se trouvent et depuis quelle
-- date ils s’y trouvent)

SELECT p.LastName, p.FirstName, d.Name, dh.StartDate
FROM HumanResources_Employee e
LEFT JOIN Person_Person p ON e.BusinessEntityID= p.BusinessEntityID
LEFT JOIN HumanResources_EmployeeDepartmentHistory dh on e.BusinessEntityID= dh.BusinessEntityID
LEFT JOIN HumanResources_Department d ON d.DepartmentID=dh.DepartmentID
WHERE EndDate IS NULL 

-- 3. Afficher la liste des personnes (nom, prénom, numéro de téléphone) disposant d’un numéro
-- de téléphone cellulaire

SELECT p.LastName, p.FirstName, pp.PhoneNumber
FROM Person_Person p 
JOIN Person_PersonPhone pp ON pp.BusinessEntityID= p.BusinessEntityID
WHERE PhoneNumberTypeID = 1;

-- 4. Afficher la liste des personnes (nom, prénom, numéro de téléphone) disposant d’un numéro
-- de téléphone professionnel

SELECT p.LastName, p.FirstName, pp.PhoneNumber
FROM Person_Person p
JOIN Person_PersonPhone pp ON pp.BusinessEntityID= p.BusinessEntityID
WHERE PhoneNumberTypeID = 3;

-- 5. Afficher la liste des personnes avec leurs numéros de téléphone respectifs qu’ils soient
-- professionnels ou personnels (nom, prénom, numéro)

SELECT p.LastName, p.FirstName, pp.PhoneNumber 


-- 6. Afficher la liste des personnes (nom, prénom, adresse) disposant d’une adresse de domicile
SELECT p.LastName, p.FirstName, a.`AddressLine1`,a.`AddressLine2`,a.`City`, a.`PostalCode`
FROM Person_Person p
JOIN Person_BusinessEntityAddress bea ON bea.BusinessEntityID=p.BusinessEntityID
JOIN Person_Address a ON a.AddressID=bea.AddressID
WHERE bea.AddressTypeID=2;
-- 7. Afficher la liste des personnes (nom, prénom, adresse) disposant d’une adresse de bureau
-- (main office)
SELECT p.LastName, p.FirstName, a.AddressLine1,a.AddressLine2,a.City, a.PostalCode
FROM Person_Person p
JOIN Person_BusinessEntityAddress bea ON bea.BusinessEntityID=p.BusinessEntityID
JOIN Person_Address a ON a.AddressID=bea.AddressID
WHERE bea.AddressTypeID=3;

-- 8. Afficher la liste des personnes (nom, prénom, emails) disposant de plusieurs adresses email
-- (au minimum 2)


-- 9. Afficher la liste des personnes (nom, prénom, numéro de compte) qui sont clientes de
-- l’entreprise
-- 10. Afficher la liste des modèles de produits (nom, description) avec leur description en français
-- 11. Afficher la liste des commandes passées (numéro de commande, date de la commande) sur
-- l’année 2014
-- 12. Afficher combien de ventes ont été réalisées par type de carte de crédit
-- 13. Afficher la quantité par produit qui ont été vendus
-- 14. Afficher le montant total vendu par produit
-- 15. Afficher les produits (code produit, nom du produit, nom de la catégorie) par catégorie
-- 16. Afficher le produit (nom) le plus vendu par l’entreprise
-- 17. Afficher le numéro de produit, le nom du produit, le nom du fichier photo de produit (large),
-- la description en anglais, le nom de la sous-catégorie à laquelle le produit appartient et le
-- nombre de produits commandés sur l’ensemble des commandes