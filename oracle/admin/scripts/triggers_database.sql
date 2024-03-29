{\rtf1\ansi\ansicpg1252\deff0\deflang11274{\fonttbl{\f0\froman\fcharset0 Times New Roman;}{\f1\fswiss\fcharset0 Arial;}}
{\*\generator Msftedit 5.41.21.2508;}\viewkind4\uc1\pard\sb100\sa100\f0\fs24 /*****\par
Trigger que evita usar ciertos programas conectados a la Base\par
*****/\par
CREATE OR REPLACE TRIGGER nombre_del_trigger\line AFTER LOGON ON DATABASE\line DECLARE\line v_prog sys.v_$session.program%TYPE;\line BEGIN\line SELECT program INTO v_prog \line FROM sys.v_$session\line WHERE audsid = USERENV('SESSIONID')\line AND audsid != 0 -- Don't Check SYS Connections\line AND rownum = 1; -- Parallel processes will have the same AUDSID's\line\line IF UPPER(v_prog) LIKE '%TOAD%' OR UPPER(v_prog) LIKE '%T.O.A.D%' OR -- Toad\line UPPER(v_prog) LIKE '%SQLNAV%' OR -- SQL Navigator\line UPPER(v_prog) LIKE '%PLSQLDEV%' OR -- PLSQL Developer\line UPPER(v_prog) LIKE '%BUSOBJ%' OR -- Business Objects\line UPPER(v_prog) LIKE '%EXCEL%' -- MS-Excel plug-in\line THEN\line RAISE_APPLICATION_ERROR(-20000, 'Esta herramiente no se puede utilizar para la BD!');\line END IF;\line END;\par
\pard\f1\fs20\par
}
 