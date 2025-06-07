--Exercice 6

--1er requete
-- supprime la ligne ou l'id_reservation est egal à 1 dans  la table reservation

DELETE FROM reservation     
	WHERE id_reservation = 1 ;

--2me requete
-- supprime les lignes ou la date de fin est inferieur a la date actuelle dans la table reservation

DELETE FROM reservation
	WHERE date_fin_resa < CURRENT_DATE ;
