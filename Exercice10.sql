CREATE TABLE Utilisateur(
   id_utilisateur INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY(id_utilisateur)
);

CREATE TABLE Materiel(
   id_materiel INT,
   quantite SMALLINT,
   nom_materiel VARCHAR(50),
   description_materiel VARCHAR(50),
   PRIMARY KEY(id_materiel)
);

CREATE TABLE Disponibilite(
   id_disponibilite INT,
   id_materiel INT,
   date_debut DATE,
   date_fin DATE,
   retard BOOL,
   PRIMARY KEY(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel)
);


CREATE TABLE Reservation(
   id_reservation INT,
   date_deb_resa DATE,
   date_fin_resa DATE,
   id_utilisateur INT,
   id_materiel INT,
   id_disponibilite INT,
   date_retour_effectif DATE,
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_disponibilite) REFERENCES Disponibilite(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
   FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
   CHECK (date_fin_resa >= date_deb_resa),
   CHECK (date_retour_effectif IS NULL OR date_retour_effectif >= date_deb_resa)
);


alter table disponibilite drop constraint disponibilite_id_materiel_fkey;
alter table reservation drop constraint reservation_id_utilisateur_fkey;
alter table reservation drop constraint reservation_id_Materiel_fkey;
alter table reservation drop constraint reservation_id_disponibilite_fkey;

TRUNCATE TABLE reservation RESTART IDENTITY CASCADE;
TRUNCATE TABLE disponibilite RESTART IDENTITY CASCADE;
TRUNCATE TABLE materiel RESTART IDENTITY CASCADE;
TRUNCATE TABLE utilisateur RESTART IDENTITY CASCADE;


-- Insert 100,000 rows into utilisateur
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO utilisateur (id_utilisateur, nom, prenom,email)
        VALUES (
            i,
            'nom_' || i,
            'prenom_' || i,
            'user_' || i || '@example.com'
        );
    END LOOP;
END $$;

-- Insert 100,000 rows into materiel
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO Materiel (id_materiel,quantite,nom_materiel,description_materiel)
        VALUES (
            i,
		(random() * 20)::INT + 1, -- Random quantity between 1 and 20 for the available quantity
            'materiel_' || i,
            'description for materiel_' || i
            
        );
    END LOOP;
END $$;

-- Insert 200,000 rows into disponibilite
DO $$
DECLARE
    i INT;
    start_date DATE;
    end_date DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        -- Generate random start and end dates
        start_date := DATE '2025-01-01' + (random() * 365)::INT;
        end_date := start_date + (random() * 30)::INT;

        INSERT INTO disponibilite (id_disponibilite, id_materiel, date_debut, date_fin, retard)
        VALUES (
            i,
            (random() * 99999)::INT + 1, -- Random id_materiel between 1 and 100,000
            start_date,
            end_date,
            (random() < 0.5) -- Random boolean for retard
        );
    END LOOP;
END $$;

-- Insert 2,000,000 rows into reservation
DO $$
DECLARE
    i INT;
    reservation_date DATE;
    return_date DATE;
	effective_return_date DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        -- Generate random reservation and return dates
        reservation_date := DATE '2025-01-01' + (random() * 365)::INT;
        return_date := reservation_date + (random() * 15)::INT;
		effective_return_date := reservation_date + (random() * 15)::INT;

        INSERT INTO reservation (id_reservation, date_deb_resa,date_fin_resa,id_utilisateur,id_materiel,id_disponibilite,date_retour_effectif)
        VALUES (
            i,
            reservation_date,
            return_date,
            (random() * 999999)::INT + 1, -- Random numero_etudiant between 1 and 1,000,000
            (random() * 999999)::INT + 1,  -- Random identifiant_materiel between 1 and 1,000,000
			(random() * 999999)::INT + 1 , -- Random identifiant_materiel between 1 and 1,000,000
			effective_return_date
        );
    END LOOP;
END $$;


-- Question 5 et 6

--Requete affichant toutes les reservation dont la date est superieur au premier juin 2025

/*EXPLAIN ANALYZE 
SELECT 
reservation.id_reservation,
reservation.date_deb_resa,
reservation.date_fin_resa,
reservation.date_retour_effectif,
utilisateur.nom,
utilisateur.prenom,
materiel.nom_materiel,
materiel.description_materiel,
disponibilite.date_debut,
disponibilite.date_fin,
disponibilite.retard
FROM reservation 
JOIN utilisateur ON Reservation.id_utilisateur = utilisateur.id_utilisateur
JOIN materiel ON Reservation.id_materiel = materiel.id_materiel
JOIN disponibilite ON Reservation.id_disponibilite = disponibilite.id_disponibilite
WHERE reservation.date_deb_resa >= DATE '2025-06-01'
ORDER BY reservation.date_deb_resa
LIMIT 100;*/

-- les causes du ralentissement sont les full scan sur les tables. Il faudrait creer des index sur les jointures pour eviter ces scans.


--Question 7

CREATE INDEX idx_resa_date_deb ON reservation(date_deb_resa);
CREATE INDEX idx_resa_utilisateur ON reservation(id_utilisateur);
CREATE INDEX idx_resa_materiel ON reservation(id_materiel);
CREATE INDEX idx_resa_dispo ON reservation(id_disponibilite);

CREATE INDEX idx_dispo_id ON disponibilite(id_disponibilite);
CREATE INDEX idx_materiel_id ON materiel(id_materiel);
CREATE INDEX idx_utilisateur_id ON utilisateur(id_utilisateur);

EXPLAIN ANALYZE 
SELECT 
reservation.id_reservation,
reservation.date_deb_resa,
reservation.date_fin_resa,
reservation.date_retour_effectif,
utilisateur.nom,
utilisateur.prenom,
materiel.nom_materiel,
materiel.description_materiel,
disponibilite.date_debut,
disponibilite.date_fin,
disponibilite.retard
FROM reservation 
JOIN utilisateur ON Reservation.id_utilisateur = utilisateur.id_utilisateur
JOIN materiel ON Reservation.id_materiel = materiel.id_materiel
JOIN disponibilite ON Reservation.id_disponibilite = disponibilite.id_disponibilite
WHERE reservation.date_deb_resa >= DATE '2025-06-01'
ORDER BY reservation.date_deb_resa
LIMIT 100;

-- Avec ces index, nous sommes passe d'une requete de 500ms a une requete d'environ 317 ms.