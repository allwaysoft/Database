REM  Estadistica de sesion. Para la sesion actual
REM ======================================================================
REM v$sesstat.sql        Version 1.1    07 Julio 2011
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependencias:
REM
REM
REM Notas:
REM     Ejecutar con usuario dba
REM
REM Precauciones:
REM
REM ======================================================================
REM
set define off
set feedback off
set pagesize 400

clear col
SELECT --a.SID,
       DECODE (b.CLASS,
               1, 'User',
               2, 'Redo',
               4, 'Enqueue',
               8, 'Cache',
               16, 'OS',
               32, 'ParallelServer',
               64, 'SQL',
               128, 'Debug',
               72, 'SQL & Cache',
               40, 'ParallelServer & Cache'
              ) CLASS,
       b.NAME, a.VALUE
  FROM v$sesstat a, v$statname b , v$session c
 WHERE (a.statistic# = b.statistic#) AND 
 c.audsid=sys_context('userenv','SESSIONID')
 AND a.SID = c.SID
 AND value <> 0
 AND b.name like '%dbli%'
 ORDER BY value
 /
 set define on
 set feedback on