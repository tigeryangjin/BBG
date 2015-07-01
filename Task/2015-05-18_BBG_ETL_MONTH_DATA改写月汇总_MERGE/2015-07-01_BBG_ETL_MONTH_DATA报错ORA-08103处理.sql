--1.
SELECT T.owner,
       T.table_name,
       T.inmemory,
       T.inmemory_priority,
       T.inmemory_distribute,
       T.inmemory_compression,
       T.inmemory_duplicate
  FROM ALL_ALL_TABLES T
 WHERE T.inmemory = 'ENABLED'
   AND T.table_name LIKE '%MN%'
 ORDER BY T.inmemory, T.owner, T.table_name;

--2.NO INMEMORY
SELECT 'ALTER TABLE ' || T.owner || '.' || T.table_name || ' NO INMEMORY;'
  FROM ALL_ALL_TABLES T
 WHERE T.inmemory = 'ENABLED';

--3.INMEMORY
SELECT 'ALTER TABLE ' || T.owner || '.' || T.table_name ||
       ' INMEMORY PRIORITY CRITICAL MEMCOMPRESS FOR CAPACITY HIGH;'
  FROM ALL_ALL_TABLES T
 WHERE T.inmemory = 'DISABLED';
