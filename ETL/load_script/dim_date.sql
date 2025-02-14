CREATE TABLE DW_DATE(
   ID_DATE NUMBER(10) PRIMARY KEY,
   Hour VARCHAR2(50),
   DayoOfWeek VARCHAR2(100),
   DateAccident VARCHAR2(100),
   Month VARCHAR2(50),
   Year VARCHAR2(50)
   );

---AJOUT D'UNE COLONNE VIDE DANS LA TABLE DE ACCIDENT_TAB
ALTER TABLE ACCIDENT_TAB ADD ID_DATE NUMBER(10) DEFAULT NULL;

----CREATION D'UN TRIGGER ET D'UNE SEQUENCE POUR AUTO-INCREMENTER LA CLE PRIMAIRE 
CREATE SEQUENCE SEQUENCE_DW_DATE START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRIGGER_DW_DATE
BEFORE INSERT ON DW_DATE
FOR EACH ROW
DECLARE
BEGIN
   Next=
   SELECT SEQUENCE_DW_DATE.nextval; into :new.ID_DATE from DUAL;

END;
/


-- REMPLISSAGE DE LA TABLE DE DIMENSION
INSERT INTO DW_DATE(DayoOfWeek,DateAccident,Hour,Month,Year)
SELECT DISTINCT a.get_day_week(),a.get_date(),a.get_hour_accident(),a.get_month(),a.get_year()			
FROM accident_tab a;










