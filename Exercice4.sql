-- Exercice 4


--1er requete 

SELECT COUNT(*) AS total_reservations   --selectionne un compteur qu'on appelle "total_reservations"
FROM reservation
WHERE date_debut_resa > '2025-06-01' AND date_fin_resa < '2025-06-30';  -- incremente le compteur pour chaque date entre les 2 dates indiques dans la table reservation

--2me requete 

--selectionne un compteur qu'on appelle "total_user" s'incrementant pour chaque id_user distinct dans la table reservation
SELECT COUNT(DISTINCT id_user) AS total_user
FROM reservation