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

select * from ALL_TABLES
where OWNER = 'CIRQUE';

select * from ALL_VIEWS
where OWNER = 'CIRQUE';

-- 3
select * from ALL_CONSTRAINTS
where OWNER = 'CIRQUE';
-- 8 elems

select * from ALL_CONS_COLUMNS
where OWNER = 'CIRQUE';
-- 10 elems
-- Position permet de savoir dans quel ordre les colonne ont été appéllées lors
-- d'une contrainte (tres utile pour les foreign key lors de la suppresion d'une table)

-- 4
-- cf partie2-4.png$

-- 5
-- les vues ne sont des résultats de requêtes que s'actualise automatiquement

-- 6 Copie de la base de données de CIRQUE
create table Personnel as (SELECT * FROM CIRQUE.Personnel);
create table Numeros as (SELECT * FROM CIRQUE.Numeros);
create table Utilisation as (SELECT * FROM CIRQUE.Utilisation);
create table Accessoires as (SELECT * FROM CIRQUE.ACCESSOIRES);

 --  7
 -- les contraintes d'intégrité (primary and foreign key) n'ont pas été dupliquer
 -- les attributs de type NOT NULL ont été dupliquer

 -- 8
 alter table ACCESSOIRES modify NOCAMION not null;
-- erreur : ORA-01442: colonne à modifier en NOT NULL est déjà NOT NULL

alter table ACCESSOIRES
add check ( NOCAMION is not null );
-- ca marche

alter table ACCESSOIRES
add check ( NOCAMION is not null );
-- ca marche encore !!

alter table ACCESSOIRES
add check ( NORÂTELIER is not null );
-- ca marche

alter table ACCESSOIRES
drop constraint nomDeLaContrainte;

-- ccl :
-- si contrainte sur un attribut : un seul appel (les autres seront des erreurs)
-- si contrainte sur un attribut avec check : plusieurs appel possible

-- 9
alter table UTILISATION
add constraint pk_utilisation
PRIMARY KEY (TITREDENUMÉRO, UTILISATEUR, ACCESSOIRE);

alter table UTILISATION
add constraint fk_utilisateur
foreign key (UTILISATEUR) references PERSONNEL(NOM);

alter table UTILISATION
add constraint fk_titreNum
foreign key (TITREDENUMÉRO) references NUMEROS(TITREDENUMÉRO);

alter table NUMEROS
add constraint fk_responsable
foreign key (RESPONSABLE) REFERENCES PERSONNEL (NOM);

alter table NUMEROS
add constraint pk_numero
primary key (TITREDENUMÉRO);

select * from USER_INDEXES;
-- affiche les 3 clé primaire créées

select * from USER_IND_COLUMNS;
-- affiche les clés primaire créées avec tout les details (quel attributs y sont)

-- 10
alter table UTILISATION
add constraint fk_utilisation_accesoire
foreign key (ACCESSOIRE) references ACCESSOIRES(ACCESSOIRE);
-- impossible car ACCESSOIRES.ACCESSOIRE n'est ni une primary key ni
-- une unique key

alter table ACCESSOIRES
add constraint uk_accessoires
unique (ACCESSOIRE);
-- impossible car des doublons existent deja

-- 11
-- impossible on ne pas passer ACCESSOIRES.ACCESSOIRE en unique key
-- impossible car la clé n'est pas créé
