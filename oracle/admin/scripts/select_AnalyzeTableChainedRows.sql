SELECT 'PROMPT ANALYZANDO TABLA '||TABLE_NAME||' DE '||ROUND(BYTES/1024/1024,1)||'MB ... 
ANALYZE TABLE '||table_name||' LIST CHAINED ROWS INTO CHAINED_ROWS;'
  FROM user_tables join user_segments ON segment_name=table_name order by bytes desc;