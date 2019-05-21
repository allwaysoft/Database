set heading off;
set echo off;
Set pages 999;
set feedback off
set long 90000;
exec dbms_metadata.set_transform_param(dbms_metadata.session_transform, 'SQLTERMINATOR', true);
accept ROLE prompt 'Ingrese Rol: '
prompt Create role ...
SELECT dbms_metadata.get_ddl('ROLE','&ROLE') from dual;
prompt System grants
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT','&ROLE') from dual;
prompt Object grants
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT','&ROLE') from dual;
prompt Role grants
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT','&ROLE') from dual;
set feedback on