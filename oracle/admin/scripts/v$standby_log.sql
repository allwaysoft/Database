select group#, thread#, sequence#, archived, ROUND (BYTES / 1024 / 1024) mb, status from v$standby_log;