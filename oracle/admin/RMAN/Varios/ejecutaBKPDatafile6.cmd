set oracle_sid=dtest
del c:\oracle\disco2\rman_logs\rman_log.log
rman target / @C:\rman\backdatafile6.sql
sqlplus "/ as sysdba" @c:\rman\ejecuta_mail.sql