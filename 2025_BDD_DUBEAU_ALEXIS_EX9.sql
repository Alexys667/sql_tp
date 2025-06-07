DROP TABLE IF EXISTS Reservation CASCADE;
DROP TABLE IF EXISTS RetourMateriel CASCADE;

CREATE TABLE Utilisateur(
   id_utilisateur INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY(id_utilisateur)
);

CREATE TABLE Materiel(
   id_materiel INT,
   nom_materiel VARCHAR(50),
   quantite SMALLINT,
   PRIMARY KEY(id_materiel)
);

CREATE TABLE Disponibilite(
   id_disponibilite INT,
   date_debut DATE,
   date_fin DATE,
   id_materiel INT,
   PRIMARY KEY(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel)
);


CREATE TABLE Reservation(
   id_reservation INT,
   date_deb_resa DATE,
   date_retour_effectif DATE,
   date_fin_resa DATE,
   id_disponibilite INT,
   id_materiel INT,
   id_utilisateur INT,
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_disponibilite) REFERENCES Disponibilite(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
   FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
   CHECK (date_fin_resa >= date_deb_resa),
   CHECK (date_retour_effectif IS NULL OR date_retour_effectif >= date_deb_resa)
);


CREATE TABLE RetourMateriel(
   id_retour INT,
   date_retour DATE,
   retard bool,
   id_reservation INT,
   PRIMARY KEY(id_retour),
   FOREIGN KEY(id_reservation) REFERENCES Reservation(id_reservation)
);


-- question 4 et 5

ALTER TABLE Utilisateur ADD COLUMN penalite INT DEFAULT 0;  -- Ajout d'un attribut penalite dans la table user afin de savoir le nombre de penalite sur un utilisateur


-- Insertion de lignes dans les tables afin de faire les tests 
INSERT INTO Utilisateur (id_utilisateur, nom, prenom, email) 
VALUES (1, 'Alexis', 'Dubeau', 'ajiodjad');

INSERT INTO Utilisateur (id_utilisateur, nom, prenom, email) 
VALUES (2, 'Alex', 'Dub', 'ajiod');

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (1,'board', 10);
    
INSERT INTO Disponibilite (id_disponibilite, date_debut, date_fin, id_materiel) -- Ajout d'une periode de disponibilite 
VALUES (1, '2025-08-01', '2025-08-15', 1);

INSERT INTO Reservation (id_reservation, date_deb_resa,date_retour_effectif,date_fin_resa,id_disponibilite,id_materiel,id_utilisateur)
VALUES (1,'2025-08-02' , '2025-08-12' , '2025-08-12', 1, 1, 1);

INSERT INTO Reservation (id_reservation, date_deb_resa,date_retour_effectif,date_fin_resa,id_disponibilite,id_materiel,id_utilisateur)
VALUES (2,'2025-08-02' , '2025-08-12' , '2025-08-12', 1, 1, 2);

INSERT INTO RetourMateriel (id_retour, date_retour, retard, id_reservation)
VALUES (1,'2025-08-17', true, 1);

INSERT INTO RetourMateriel (id_retour, date_retour, retard, id_reservation)
VALUES (2,'2025-08-12', false, 2);

-- Creation d'une vue permettant de renvoyer TRUE date de retour est superieur a la date de fin de reservation et FALSE sinon 
CREATE VIEW VRetardPenalite AS
SELECT 
    RetourMateriel.id_retour,
    RetourMateriel.date_retour,
    RetourMateriel.id_reservation,
    Reservation.date_fin_resa,
    CASE 
    WHEN RetourMateriel.date_retour > Reservation.date_fin_resa THEN true
    ELSE false
    END AS calcul_retard
FROM RetourMateriel
JOIN Reservation ON RetourMateriel.id_reservation = Reservation.id_reservation;

SELECT * FROM VRetardPenalite;  -- Permet d'avoir acces retour et de savoir si le materiel est revenu en retard ou non.

-- MAJ de la ligne de l'utilisateur qui a remis un materiel en retard. +1 de penalite a chaque retard
UPDATE Utilisateur
SET penalite = penalite + 1
FROM Reservation 
JOIN RetourMateriel ON RetourMateriel.id_reservation = Reservation.id_reservation
WHERE Utilisateur.id_utilisateur = Reservation.id_utilisateur
AND RetourMateriel.date_retour > Reservation.date_fin_resa;

select * from utilisateur   -- Nous pouvons remarquer avec le resultat que les utilisateurs ont bien 1 ou 0 dans leur colonne "penalite"





