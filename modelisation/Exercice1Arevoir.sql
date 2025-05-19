
Materiel :


INSERT INTO public.materiel(
	id_materiel, quantite)
	VALUES (5, 10);

INSERT INTO public.materiel(
	id_materiel, quantite)
	VALUES (6, 5);

INSERT INTO public.materiel(
	id_materiel, quantite)
	VALUES (7, 20);

INSERT INTO public.materiel(
	id_materiel, quantite)
	VALUES (8, 15);

INSERT INTO public.materiel(
	id_materiel, quantite)
	VALUES (9, 8);

INSERT INTO public.materiel(
	id_materiel, quantite)
	VALUES (10, 30);


Reservation :


INSERT INTO public.reservation(
	id_reservation, date_debut, date_fin, id_materiel, id_user)
	VALUES (5, '2025-06-01', '2025-06-05', 1, 3);

INSERT INTO public.reservation(
	id_reservation, date_debut, date_fin, id_materiel, id_user)
	VALUES (2, '2025-06-03', '2025-06-07', 2, 4);

INSERT INTO public.reservation(
	id_reservation, date_debut, date_fin, id_materiel, id_user)
	VALUES (3, '2025-06-10', '2025-06-12', 3, 5);

INSERT INTO public.reservation(
	id_reservation, date_debut, date_fin, id_materiel, id_user)
	VALUES (4, '2025-06-15', '2025-06-20', 4, 6);