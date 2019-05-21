--test_io_oper.sql
SET verify off
SET timing on

ACCEPT TBS prompt 'Tablespace para las tablas: '

DROP TABLE PRB4 PURGE;

alter session set tracefile_identifier=test_io_insert;
alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;
alter session set events '10046 trace name context forever,level 12';

PROMPT Creo tablas de prueba.

CREATE TABLE prb4 NOLOGGING TABLESPACE &tbs AS SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 1;
  
PROMPT INSERT 1. insertando en tabla PRB4

PROMPT CREANDO INDICES

CREATE INDEX PRB4_ID_IDX ON PRB4 (ID) TABLESPACE &tbs;

SET autotrace on statistics

DECLARE
   vID   NUMBER;
BEGIN
   FOR i IN (SELECT     ROWNUM ID , 'Cod' || LPAD (ROWNUM, 9, 0) com, SYSDATE fecha
         FROM DUAL
   CONNECT BY LEVEL <= 2000000)
   LOOP
      insert into prb4 (ID,COM,FECHA) values (i.ID,i.COM,i.FECHA);
   END LOOP;
   COMMIT;
END;
/

set autotrace off
alter session set events '10046 trace name context off';