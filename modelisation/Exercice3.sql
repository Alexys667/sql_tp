--1er requete 

SELECT * from reservation INNER JOIN user_ ON reservation.id_user = user_.id_user

--2eme requete

SELECT quantite, nom, prenom, materiel.id_materiel
FROM reservation 
INNER JOIN user_ 
ON reservation.id_user = user_.id_user
INNER JOIN materiel
ON reservation.id_materiel = materiel.id_materiel WHERE prenom = 'Alexis'