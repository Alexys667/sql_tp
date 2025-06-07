-- creation de la table des utiilisateurs
CREATE TABLE User_(
   id_user INT NOT NULL,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY(id_user)
);

-- creation de la table des materiels
CREATE TABLE Materiel(
   id_materiel INT NOT NULL,
   nom_materiel VARCHAR(50),
   quantite SMALLINT,
   PRIMARY KEY(id_materiel)
);

-- creation de la table des reservations

CREATE TABLE Reservation(
   id_reservation INT,
   date_debut_resa DATE,
   date_fin_resa DATE,
   id_user INT NOT NULL,
   id_materiel INT NOT NULL,
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_user) REFERENCES User_(id_user),  -- cles etrangères dû aux relations 1:n
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel)
);

-- Insertion des données dans les tables 

-- Utilisateur 

INSERT INTO User_ (id_user, nom, prenom, email) VALUES
(1, 'Durand', 'Alice', 'alice.durand@email.com'),
(2, 'Martin', 'Bruno', 'bruno.martin@email.com'),
(3, 'Lemoine', 'Claire', 'claire.lemoine@email.com'),
(4, 'Petit', 'David', 'david.petit@email.com'),
(5, 'Moreau', 'Eva', 'eva.moreau@email.com'),
(6, 'Faure', 'Thomas', 'thomas.faure@example.com'),
(7, 'Dubois', 'Emma', 'emma.dubois@example.com'),
(8, 'Roux', 'Lucas', 'lucas.roux@example.com'),
(9, 'Petit', 'Julie', 'julie.petit@example.com'),
(10, 'Girard', 'Marc', 'marc.girard@example.com');

-- Materiel :


INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (1,'board', 10);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (2,'condensateur', 5);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (3,'resistaance', 20);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (4,'inductance', 15);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (5,'regulateur', 8);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (6,'transistor', 30);
    
INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (7,'camera', 20);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (8,'casque', 15);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (9,'clavier', 8);

INSERT INTO materiel(
	id_materiel,nom_materiel, quantite)
	VALUES (10,'souris', 30);


-- Reservation :


INSERT INTO reservation(
	id_reservation, date_debut_resa, date_fin_resa, id_materiel, id_user)
	VALUES (1, '2025-06-01', '2025-06-05', 1, 1);

INSERT INTO reservation(
	id_reservation, date_debut_resa, date_fin_resa, id_materiel, id_user)
	VALUES (2, '2025-06-03', '2025-06-07', 2, 2);

INSERT INTO reservation(
	id_reservation, date_debut_resa, date_fin_resa, id_materiel, id_user)
	VALUES (3, '2025-06-10', '2025-06-12', 3, 3);

INSERT INTO reservation(
	id_reservation, date_debut_resa, date_fin_resa, id_materiel, id_user)
	VALUES (4, '2025-06-15', '2025-06-20', 4, 4);
    
INSERT INTO reservation(
	id_reservation, date_debut_resa, date_fin_resa, id_materiel, id_user)
	VALUES (5, '2025-06-26', '2025-06-30', 5, 5);
    
INSERT INTO Reservation (id_reservation, date_debut_resa, date_fin_resa, id_user, id_materiel) VALUES
(6, '2025-07-01', '2025-07-05', 6, 6),
(7, '2025-07-10', '2025-07-12', 7, 7),
(8, '2025-07-15', '2025-07-20', 8, 8),
(9, '2025-07-18', '2025-07-22', 9, 9),
(10, '2025-07-25', '2025-07-28', 10, 10);
    
