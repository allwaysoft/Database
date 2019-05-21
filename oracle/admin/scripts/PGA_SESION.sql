SELECT B.NAME, ROUND (A.VALUE / 1024 / 1024, 2) MB
  FROM V$SESSTAT A, V$STATNAME B, V$SESSION C
 WHERE C.AUDSID = USERENV ('sessionid')
   AND A.SID = C.SID
   AND (A.STATISTIC# = B.STATISTIC#)
   AND NAME IN ('session pga memory', 'session pga memory max');