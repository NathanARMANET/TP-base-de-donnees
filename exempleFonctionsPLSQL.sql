/* PARTIE A */
-- 1.

CREATE OR REPLACE FUNCTION
  getSalaire(p_nomEmploye IN EMPLOYE.NOMEMPLOYE%TYPE)
    RETURN NUMBER
IS
  l_Salaire NUMBER;
BEGIN
  SELECT Salaire INTO l_salaire
  FROM EMPLOYE
  WHERE LOWER(nomEmploye) = LOWER(p_nomEmploye);
  RETURN l_Salaire;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE(p_NomEmploye || ' n''existe pas');
      RETURN null;
END;
/

--
SET SERVEROUTPUT ON;
BEGIN
  DBMS_OUTPUT.PUT_LINE(getSalaire('PROVISTE')); 
END;
/

--2.

CREATE OR REPLACE FUNCTION
  changeSalaire(p_Fonction IN EMPLOYE.Fonction%TYPE, p_Pourcentage NUMBER)
    RETURN NUMBER
IS
BEGIN
  UPDATE EMPLOYE SET Salaire=Salaire*(1+p_Pourcentage/100) WHERE Fonction = p_Fonction;
  RETURN SQL%ROWCOUNT;
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE(changeSalaire('Agent accueil', 10));
END;


--3.

CREATE OR REPLACE FUNCTION
  transfertVehicule(p_codeAgence1 IN AGENCE.codeAgence%TYPE, p_codeAgence2 IN AGENCE.codeAgence%TYPE)
  RETURN NUMBER
IS l_nbVehicules NUMBER;

BEGIN
  UPDATE VEHICULE SET CodeAgence=p_codeAgence2 WHERE codeAgence = p_codeAgence1;
  l_nbVehicules := SQL%ROWCOUNT;
  DELETE FROM AGENCE WHERE CodeAgence = p_codeAgence1;
  RETURN l_nbVehicules;
END;
/

SELECT * FROM VEHICULE;

BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE(transfertVehicule('AG03', 'AG01'));
END;

SELECT * FROM VEHICULE;
SELECT * FROM AGENCE;




--4.

BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE(transfertVehicule('AG02', 'AG01'));
END;

CREATE OR REPLACE FUNCTION
  transfertVehicule(p_codeAgence1 IN AGENCE.codeAgence%TYPE, p_codeAgence2 IN AGENCE.codeAgence%TYPE)
  RETURN NUMBER
IS l_nbVehicules NUMBER;

BEGIN
  UPDATE VEHICULE SET CodeAgence=p_codeAgence2 WHERE codeAgence = p_codeAgence1;
  l_nbVehicules := SQL%ROWCOUNT;
  DELETE FROM AGENCE WHERE CodeAgence = p_codeAgence1;
  RETURN l_nbVehicules;
   
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = (-02292) THEN
        DBMS_OUTPUT.PUT_LINE('Transfert impossible : il y a des employés ds l''agence');
        RETURN 0;
      ELSE
        DBMS_OUTPUT.PUT_LINE('ERREUR ORACLE');
      END IF;
END;
/

  
  
  
  
  
  
  
  
  /* PARTIE B*/
 -- code original 
DECLARE
  CURSOR c_user_tables IS (SELECT object_name, object_type
                           FROM user_objects WHERE object_type = 'TABLE');
BEGIN
  FOR c_user_tables IN l_user_tables LOOP
    EXECUTE IMMEDIATE 'DROP' || c_user_objets.object_type || ' ' ||
                                c_user_objets.object_name || 'CASCADE CONSTRAINTS';
  END LOOP;
END;
/

 -- code corrigé
 
DECLARE
  CURSOR c_user_tables IS (SELECT object_name, object_type
                           FROM user_objects WHERE object_type = 'TABLE');
BEGIN
  FOR l_user_tables IN c_user_tables LOOP
    EXECUTE IMMEDIATE 'DROP ' || l_user_tables.object_type || ' ' ||
                                l_user_tables.object_name || ' CASCADE CONSTRAINTS ';
  END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE
  delTables()
BEGIN
DECLARE
  CURSOR c_user_tables IS (SELECT object_name, object_type
                           FROM user_objects WHERE object_type = 'TABLE');
BEGIN
  FOR l_user_tables IN c_user_tables LOOP
    EXECUTE IMMEDIATE 'DROP ' || l_user_tables.object_type || ' ' ||
                                l_user_tables.object_name || ' CASCADE CONSTRAINTS ';
  END LOOP;
END;
/


  /* PARTIE C*/
  
  --1.

  
  











  







