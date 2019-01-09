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

-- 1. Plusieurs sessions sur un seul compte de BD et transactions coucurrentes
