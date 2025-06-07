--Exercice 7

--1er requete
--requete de jointure entre la table user_ et reservation. affiche tours les users ayant utilise au moins un equipement 

SELECT nom, prenom, email   
FROM user_
INNER JOIN reservation ON user_.id_user = reservation.id_user;


--2me requete

SELECT materiel.id_materiel,quantite, nom_materiel FROM materiel  --selection des atributs de la table materiel
LEFT JOIN reservation ON materiel.id_materiel = reservation.id_materiel -- jointure entre reservation et materiel associant chaque reservation au materiel correspondant
WHERE reservation.id_materiel IS NULL;  -- filtrage du select ne retenant que les id "NULL" donc n'apparaissant pas dans la table reservation (jamais empreinter.


--3me requete 

SELECT materiel.id_materiel, quantite, COUNT(reservation.id_materiel) AS nombre_emprunts
FROM reservation
INNER JOIN materiel ON materiel.id_materiel = reservation.id_materiel
GROUP BY materiel.id_materiel   --regroupe toutes les reservation d'un meme materiel (d'un meme id)
HAVING COUNT(reservation.id_materiel) > 3;      --filtrage des id_materiel apparaissant plus de 3 fois (donc des materiels empreinter plus de 3 fois)

--4me requete

SELECT user_.id_user,nom,prenom,COUNT(reservation.id_materiel) AS nombre_emprunts
FROM user_
LEFT JOIN reservation ON reservation.id_user = user_.id_user
GROUP BY user_.id_user, nom, prenom     -- regroupe les utilisateurs apparaissant dans la table reservation 
ORDER BY user_.id_user;     -- tri des donnees par id_user
	


