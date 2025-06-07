-- Exercice 2

--1er requete 

SELECT nom_materiel, quantite from materiel WHERE quantite > 10 -- on selectionne les quantites superieures a 10 dans la table materiel 

--2eme requete

SELECT email from user_ WHERE email LIKE '%@gmail.com' -- on selectionne les email qui finissent par "@gmail.com" dans la table user_ (ne retourne rien avec mes valeurs)

--3eme requete

SELECT date_debut_resa from reservation WHERE date_debut_resa < '2025-10-10' -- on selectionne les date_debut inferieures à une certaine date dans la table reservation