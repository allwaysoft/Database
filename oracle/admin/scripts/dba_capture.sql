--dba_capture
COLUMN CONSUMER_NAME HEADING 'Capture|Process|Name' FORMAT A15
COLUMN NAME HEADING 'Archived Redo Log|File Name' FORMAT A25
COLUMN FIRST_SCN HEADING 'First SCN' FORMAT 9999999999999
COLUMN NEXT_SCN HEADING 'Next SCN' FORMAT 9999999999999
COLUMN PURGEABLE HEADING 'Purgeable?' FORMAT A10
 
SELECT r.CONSUMER_NAME,
       r.NAME, 
       r.FIRST_SCN,
       r.NEXT_SCN,
       r.PURGEABLE 
  FROM DBA_REGISTERED_ARCHIVED_LOG r, DBA_CAPTURE c
  WHERE r.CONSUMER_NAME = c.CAPTURE_NAME;
