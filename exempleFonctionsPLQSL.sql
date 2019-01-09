--1

SELECT NumAvion, SUM((DateArr - DateDep)*24) AS NBHeures
FROM TRAJET
GROUP BY NumAvion;

--2 

SET SERVEROUTPUT ON;
DECLARE
  CURSOR c_heuresDeVol IS 
    (SELECT NumAvion, SUM((DateArr - DateDep)*24) AS NbHeures
    FROM TRAJET
    GROUP BY NumAvion);
  l_NumAvion NUMBER(3);
  l_nbHeuresVol NUMBER(5);
BEGIN
  IF NOT(c_heuresDeVol%ISOPEN) THEN
    OPEN c_heuresDeVol;
    SYS.DBMS_OUTPUT.PUT_LINE('curseur ouvert');
  ELSE
    SYS.DBMS_OUTPUT.PUT_LINE('ERREUR');
  END IF;
    FETCH c_heuresDeVol INTO l_NumAvion, l_nbHeuresVol;
    WHILE C_heuresDeVol%FOUND LOOP
      IF (l_NbHeuresVol < 8) THEN
      DBMS_OUTPUT.PUT_LINE('L''avion ' || l_numAvion || ' a volé ' ||
      l_nbHeuresVol || ' heures');
    ELSE
      DBMS_OUTPUT.PUT_LINE('!! L''avion ' || l_numAvion ||
      ' doit être révisé !!');
    END IF;
    FETCH c_heuresDeVol INTO l_NumAvion, l_nbHeuresVol;
  END LOOP;
  CLOSE c_heuresDeVol;
END;
/

--3

SET SERVEROUTPUT ON;
DECLARE
  CURSOR c_heuresDeVol IS 
    (SELECT NumAvion, SUM((DateArr - DateDep)*24) AS NBHeures
    FROM TRAJET
    GROUP BY NumAvion);
BEGIN
  FOR l_heuresDeVol IN c_heuresDeVol LOOP
    IF (l_heuresDeVol.NBHeures < 8) THEN
      DBMS_OUTPUT.PUT_LINE('L''avion ' || l_heuresDeVol.numAvion || ' a volé ' ||
      l_HeuresDeVol.NBHeures || ' heures');
    ELSE
      DBMS_OUTPUT.PUT_LINE('!! L''avion ' || l_heuresDeVol.numAvion ||
      ' doit être révisé !!');
    END IF;
  END LOOP;
END;
/

--4

SET SERVEROUTPUT ON;
BEGIN
  FOR l_heuresDeVol IN (SELECT NumAvion, SUM((DateArr - DateDep)*24) AS NBHeures
                        FROM TRAJET
                        GROUP BY NumAvion) LOOP
    IF (l_heuresDeVol.NBHeures < 8) THEN
      DBMS_OUTPUT.PUT_LINE('L''avion ' || l_heuresDeVol.numAvion || ' a volé ' ||
      l_HeuresDeVol.NBHeures || ' heures');
    ELSE
      DBMS_OUTPUT.PUT_LINE('!! L''avion ' || l_heuresDeVol.numAvion ||
      ' doit être révisé !!');
    END IF;
  END LOOP;
END;
/

--5
SET SERVEROUTPUT ON;

DECLARE
  CURSOR c_villeDep IS (SELECT DISTINCT VilleDep FROM Trajet);
BEGIN
  FOR l_villeDep IN c_villeDep LOOP
    DBMS_OUTPUT.PUT_LINE('Vols au départ de : ' || l_villeDep.Villedep || ' : ');
    FOR l_vols IN (SELECT * FROM Trajet NATURAL JOIN AVION
                    WHERE VilleDep=l_villeDep.VilleDep) LOOP
      DBMS_OUTPUT.PUT_LINE('!! L''avion numéro ' || l_vols.numAvion ||
       ' - volera le ' || TO_CHAR(l_vols.dateDep, 'DD/MM/YY') || ' à ' || 
       TO_CHAR(l_vols.dateDep, 'HH24:MI') || ' pour la ville de ' || l_vols.villeArr);
    END LOOP;
  END LOOP;
END;



  
  


