-- Active: 1724318432273@@127.0.0.1@3306@papyrus
drop TABLE `ARTICLES_A_COMMANDER`;

CREATE TABLE ARTICLES_A_COMMANDER (
CODART VARCHAR (50) NOT NULL, 
DATE DATETIME, 
QTE INT)

INSERT INTO `ARTICLES_A_COMMANDER` (`CODART`, DATE) VALUES ((SELECT `CODART` FROM produit), CURDATE());

INSERT INTO `ARTICLES_A_COMMANDER` (`CODART`, `DATE`)
SELECT `CODART`, CURDATE() FROM `produit`;