-- TP3 : Transaction & PLSQL

-- Partie 1 : Transactions

-- 1. Atomicité d'une transaction courrantes

-- Q.1
create table test_TP3
(
	id int generated as identity
		constraint test_TP3_pk
			primary key,
	valeur int not null
);

insert into test_TP3(valeur) values(2);
insert into test_TP3(valeur) values(3);
insert into test_TP3(valeur) values(6);
insert into test_TP3(valeur) values(1);

update TEST_TP3 set valeur = 7 where VALEUR = 2;

delete from TEST_TP3 where ID = 12;

ROLLBACK --à enlever toutes les valeurs

--Q.2
insert into test_TP3(valeur) values(2);
insert into test_TP3(valeur) values(3);
insert into test_TP3(valeur) values(6);
insert into test_TP3(valeur) values(1);

delete from test_TP3 where valeur = 6;

commit ;

ROLLBACK; -- rien ne change seul la valeur 6 est supprimer, les autres restes

delete from test_TP3 where id in (select id from test_TP3);

commit;

--Q.3
insert into test_TP3(valeur) values(2);
insert into test_TP3(valeur) values(3);
insert into test_TP3(valeur) values(6);
insert into test_TP3(valeur) values(1);

exit -- se deconnecte sans changer la table

--Q.4
insert into test_TP3(valeur) values(2);
insert into test_TP3(valeur) values(3);
insert into test_TP3(valeur) values(6);
insert into test_TP3(valeur) values(1);

-- fermeture brutal sessions
ROLLBACK
-- les valeur insérer sont supprimer

-- Q.5
insert into test_TP3(valeur) values(2);
insert into test_TP3(valeur) values(3);
insert into test_TP3(valeur) values(6);
insert into test_TP3(valeur) values(1);

alter table test_TP3
add nouvelleC varcher(30);

ROLLBACK; -- ne change rien

-- Q.6
-- transaction courrante : changement dans les données d'une table
-- valider
COMMIT;
--ANNULER :
ROLLBACK

-- ne marche pas pour les modif de tableau

-- 2. Plusieurs sessions sur un seul compte de BD et transactions coucurrentes

-- Q.2
insert into test_TP3(valeur) values(1);
insert into test_TP3(valeur) values(2);
insert into test_TP3(valeur) values(3);

-- on voit juste les transactions effectuer à partir de la fenètre

-- Q.3
create table test2_TP3
(
	id int generated as identity
		constraint test_TP3_pk
			primary key,
	valeur int not null
);

-- on voit les modif sur la table init de l'utilisateur qui a créer la nouvelle table
-- on voit la nouvelle table
-- on voit juste les transactions effectuer à partir de la fenètre


-- Q.4
drop table test2_TP3;
--la suppreion marche

-- Q.5

-- USER A : 1ère insertion ok !
-- USER B : 2eme insertion probleme ! chargement infini
-- USER A : ROLLBACK ; supprime l'insertion
-- USER B : 2eme insertion ok !

-- Q.6

-- exit permet de "COMMIT" les changement
-- ces changement sont donc visible pour l'autre utilisateur

-- Q.7

-- oui

-- Q.8

insert into TESTQ5_TP3(id, valeur) values (3, 9);

create table testQ8_TP3 (
  id int null,
  valeur int null
)

insert into testQ8_TP3(id, valeur) values (1, 1);

rollback ;

-- on peut voir les 2 tables mais seulement l'insertion effectué avant la
-- création de la table est encore visible

-- Q.9
insert into TESTQ5_TP3(id, valeur) values (4, 29);

select * from TESTQ5_TP3;

drop table TESTQ8_TP3;

rollback ;

select * from TESTQ5_TP3;

-- DROP TABLE effectue un "COMMIT"

-- 3. Droits/privilèges entre deux comptes d’une même base de données

-- Q.1
select * from ALL_TABLES where OWNER = 'INI3A06';

select * from INI3A06.TRANSACTION

-- Q.2

-- on peut voir les mises à jour seulement si l'autre groupe realise un "COMMIT"

-- Q.3

-- insertion impossible (on à pas les droits)

-- Q.4

-- insertion ok !

-- Q.5
select * from INI3A06.TRANSACTION T
join INI3A03.TESTQ5_TP3 I on T.ID_TRANSACTION = I.ID;

-- partie 2
-- 1. copier les tables
CREATE TABLE EMP AS SELECT * FROM SCOTT.emp;
CREATE TABLE DEPT AS SELECT * FROM SCOTT.Dept;
CREATE TABLE SalGrade AS SELECT * FROM SCOTT.SalGrade;

-- 1
select E1.* from EMP E1
join EMP E2 on E2.EMPNO = E1.MGR
where E2.ENAME = 'KING'

-- 2
SELECT EMP.*
FROM EMP
WHERE EMP.ENAME <> 'JONES'
START WITH EMP.MGR = (SELECT EMP.EMPNO FROM EMP WHERE ENAME = 'JONES')
CONNECT BY EMP.MGR = prior EMP.EMPNO;

-- 3
SELECT EMP.*
FROM EMP
WHERE EMP.ENAME <> 'JONES'
START WITH EMP.EMPNO = (SELECT EMP.MGR FROM EMP WHERE EMP.ENAME = 'JONES')
CONNECT BY EMP.EMPNO = prior EMP.MGR;

-- 4
SELECT EMP.*
FROM EMP
WHERE EMP.ENAME <> 'BLAKE'
START WITH EMP.MGR = (SELECT EMP.EMPNO FROM EMP WHERE EMP.ENAME = 'BLAKE')
CONNECT BY EMP.MGR = prior EMP.EMPNO;
