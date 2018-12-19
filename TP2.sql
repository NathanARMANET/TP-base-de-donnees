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
-- Le fournisseur BonVin existe déjà

-- 2
insert into FOURNISSEUR(nomfour, statut, ville) VALUES  ('VinBon' , 'SARL', 'Dijon');
-- => insertion valide

-- 3
delete from FOURNISSEUR
  where NOMFOUR= 'BonVin'
        AND STATUT = 'SARL'
        AND VILLE = 'Dijon';
-- ORA-02292: violation de contrainte (INI3A03.FK_PRODUIT) d'intégrité - enregistrement fils existant
-- Le fournisseur BonVin avait des produits encore enregistrés dans la table PRODUIT

-- 4
insert into PRODUIT(appellation, nomfour, prix) values  ('Bordeaux' , 'Chapoutier', '20');
-- ORA-00001: violation de contrainte unique (INI3A03.PK_PRODUIT)
-- le couple (Bordeaux, Chapoutier) existe déjà

-- AUTRES !!!

-- Entrer les données dans un ordre précis
-- 1. FOURNISSEUR
-- 2. PRODUIT
-- 3. COMMANDE

--Partie 2

-- 1
drop view ...
drop table ...
select * from USER_TABLES;
select * from USER_VIEWS;
select * from USER_OBJECTS;

-- 2
select * from ALL_OBJECTS;
-- 9180 objets accessibles

select distinct OBJECT_TYPE, count(*) as nbObject from ALL_OBJECTS
group by OBJECT_TYPE;
--voir partie2-2-1.png

select count(*) as nbTableSys from ALL_OBJECTS
where OWNER = 'SYS';

select distinct OBJECT_TYPE, count(*) as nbObject from ALL_OBJECTS
where OWNER = 'SYS'
group by OBJECT_TYPE;
--voir partie2-2-2.png

select distinct OBJECT_TYPE, count(*) as nbObject from ALL_OBJECTS
where OWNER = 'CIRQUE'
group by OBJECT_TYPE;
--voir partie2-2-3.png
