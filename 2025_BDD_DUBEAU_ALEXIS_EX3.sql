-- Exercice 3

--1er requete 

SELECT * from reservation 
INNER JOIN user_ ON reservation.id_user = user_.id_user     -- jointure entre la table reservation et user_, en associant chaque reservation avec l'utilisateur correspondant via la clé étrangère "id_user". avec cette requete l'id user apparait 2 fois (cle primaire de user et cle etrangere de reservation). Pour eviter cela il faut utiliser cette requete :

SELECT reservation.*, user_.nom, user_.prenom, user_.email  -- On ne selectionne pas la cle primaire de user_ 
FROM reservation
INNER JOIN user_ ON reservation.id_user = user_.id_user;


--2eme requete

SELECT quantite,nom_materiel, nom, prenom, materiel.id_materiel -- on selectionne tout ce que l'on veut voir 
FROM reservation 
INNER JOIN user_ ON reservation.id_user = user_.id_user     -- jointure entre reservation et user.
INNER JOIN materiel ON reservation.id_materiel = materiel.id_materiel   -- jointure entre reservation et materiel
WHERE prenom = 'Emma';      -- filtrage par prenom (initialement dans la table user)
