--Exercice 8

CREATE TABLE User_(
    id_user INT NOT NULL,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(50),
    PRIMARY KEY(id_user)
);

CREATE TABLE Materiel(
   id_materiel INT NOT NULL,
   nom_materiel VARCHAR(50),
   quantite SMALLINT,
   PRIMARY KEY(id_materiel)
);

CREATE TABLE Disponibilite(
    id_disponibilite INT NOT NULL,
    date_debut DATE,
    date_fin DATE,
    id_materiel INT NOT NULL,
    PRIMARY KEY(id_disponibilite),
    FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
    CHECK(date_fin>date_debut)  -- verification que la date de fin est plus tard que la date de debut 
);

CREATE TABLE Reservation(
    id_reservation INT NOT NULL,
    date_debut_resa DATE,
    date_fin_resa DATE,
    id_disponibilite INT NOT NULL,
    id_materiel INT NOT NULL,
    id_user INT NOT NULL,
    PRIMARY KEY(id_reservation),
    FOREIGN KEY(id_disponibilite) REFERENCES Disponibilite(id_disponibilite),
    FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
    FOREIGN KEY(id_user) REFERENCES user_(id_user),
    CHECK(date_fin_resa > date_debut_resa)  -- verification que la date de fin est plus tard que la date de debut 
);

-- question 4

SELECT id_reservation,Disponibilite.id_materiel,date_debut_resa,date_fin_resa,date_debut,date_fin,
CASE
WHEN date_debut_resa >= date_debut AND date_fin_resa <= date_fin
THEN 'vous pouvez reserver'
ELSE 'vous ne pouvez pas reserver a cette date'
END 
FROM Reservation
JOIN Disponibilite ON Disponibilite.id_disponibilite = Reservation.id_disponibilite;


-- question 5

INSERT INTO Disponibilite (id_disponibilite, date_debut, date_fin, id_materiel) -- Ajout d'une periode de disponibilite 
VALUES (6, '2025-08-01', '2025-08-15', 2);

UPDATE Disponibilite        -- Modification d'une periode de disponibilite 
SET date_fin = '2025-08-20'
WHERE id_disponibilite = 6;



-- Suppression sécurisée
DELETE FROM Reservation WHERE id_disponibilite = 5;     -- Suppression de la reservation dans le cas ou la disponibilite est lie a une reservation en cours
DELETE FROM Disponibilite WHERE id_disponibilite = 5;   -- Supression d'une periode de disponibilite


