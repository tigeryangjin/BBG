SELECT 'SELECT COUNT(1) FROM RADM.' || T.table_name || ';'
  FROM ALL_ALL_TABLES T
 WHERE T.inmemory = 'ENABLED'
   AND T.owner = 'RADM'
   AND T.table_name LIKE '%SLS%'
 ORDER BY T.table_name;
