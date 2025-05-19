--1er requete 

SELECT COUNT(*) AS total_reservations
FROM reservation
WHERE date_debut > '2025-06-01' AND date_fin < '2025-06-30'; 
