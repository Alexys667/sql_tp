--Exercice 5

--1er requete 

UPDATE materiel     -- MAJ de la table materiel
SET quantite= 40    -- on met la valeur quantite à 40
WHERE id_materiel = 8;  -- la ou l'id est egal a 8 (les cameras dans notre cas)

--2me requete 

UPDATE materiel     -- MAJ de la table materiel
SET quantite= quantite-1    --decrementation de la quantite 
WHERE id_materiel       -- cible les id_materiel present dans la sous requete 
IN(SELECT id_materiel FROM reservation WHERE date_fin_resa > CURRENT_DATE + INTERVAL '2 days') -- selectionne les id_materiel avec une date fin resa supérieur a 2 jours a partir de la date actuelle 
