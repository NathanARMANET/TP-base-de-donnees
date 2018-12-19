-- Partie 1

-- Ajout des clés primaires

ALTER TABLE FOURNISSEUR ADD
CONSTRAINT pk_fournisseur
PRIMARY KEY (NOMFOUR);

ALTER TABLE PRODUIT ADD
CONSTRAINT pk_produit
PRIMARY KEY (NOMFOUR, APPELLATION);

ALTER TABLE COMMANDE ADD
CONSTRAINT pk_commande
PRIMARY KEY (NOCOM);

-- Ajout clé Etrangère

ALTER TABLE PRODUIT ADD CONSTRAINT fk_produit
FOREIGN KEY (NOMFOUR) REFERENCES FOURNISSEUR(NOMFOUR);

ALTER TABLE COMMANDE ADD CONSTRAINT fk_commande
FOREIGN KEY (APPELLATION, NOMFOUR) REFERENCES PRODUIT(APPELLATION, NOMFOUR);

-- Vérification
select * from USER_CONSTRAINTS;

-- Test contraintes d'intégrité

-- 1
insert into FOURNISSEUR(nomfour, statut, ville) VALUES ('BonVin', 'EARL', 'Bordeaux');
-- => ORA-00001: violation de contrainte unique (INI3A03.PK_FOURNISSEUR)

-- 2
insert into FOURNISSEUR(nomfour, statut, ville) VALUES  ('VinBon' , 'SARL', 'Dijon');
-- => insertion valide

-- 3
insert into FOURNISSEUR(nomfour, statut, ville) VALUES  ('VinBon' , 'SARL', 'Dijon');
-- => ORA-00001: violation de contrainte unique (INI3A03.PK_FOURNISSEUR)

-- 4
insert into PRODUIT(appellation, nomfour, prix) values  ('Bordeaux' , 'Chapoutier', '20');
-- ORA-00001: violation de contrainte unique (INI3A03.PK_PRODUIT)
