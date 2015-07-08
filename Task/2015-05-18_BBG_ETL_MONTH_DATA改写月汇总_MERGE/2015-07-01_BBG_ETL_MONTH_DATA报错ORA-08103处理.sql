--1.
SELECT T.OWNER,
       T.TABLE_NAME,
       T.INMEMORY,
       T.INMEMORY_PRIORITY,
       T.INMEMORY_DISTRIBUTE,
       T.INMEMORY_COMPRESSION,
       T.INMEMORY_DUPLICATE
  FROM ALL_ALL_TABLES T
 WHERE /*T.INMEMORY = 'ENABLED'
   AND*/
 T.TABLE_NAME IN ('BBG_RA_SLS_SC_LC_DY_A',
                  'W_RTL_SLS_CL_LC_DY_A',
                  'W_RTL_SLS_CL_LC_DY_CUR_A',
                  'W_RTL_SLS_DP_LC_DY_A',
                  'W_RTL_SLS_DP_LC_DY_CUR_A',
                  'W_RTL_SLS_LC_DY_A',
                  'W_RTL_SLS_SC_DY_A',
                  'W_RTL_SLS_SC_DY_CUR_A',
                  'W_RTL_SLS_SC_LC_DY_A',
                  'W_RTL_SLS_SC_LC_DY_CUR_A')
 ORDER BY T.INMEMORY, T.OWNER, T.TABLE_NAME;

EXECUTE IMMEDIATE 'ALTER TABLE RADM.W_RTL_SLS_SC_LC_DY_CUR_A NO INMEMORY';
--2.NO INMEMORY
SELECT 'EXECUTE IMMEDIATE ''ALTER TABLE ' || T.OWNER || '.' || T.TABLE_NAME ||
       ' NO INMEMORY'';'
  FROM ALL_ALL_TABLES T
 WHERE T.INMEMORY = 'ENABLED'
   AND T.TABLE_NAME IN ('BBG_RA_SLS_SC_LC_DY_A',
                        'W_RTL_SLS_CL_LC_DY_A',
                        'W_RTL_SLS_CL_LC_DY_CUR_A',
                        'W_RTL_SLS_DP_LC_DY_A',
                        'W_RTL_SLS_DP_LC_DY_CUR_A',
                        'W_RTL_SLS_LC_DY_A',
                        'W_RTL_SLS_SC_DY_A',
                        'W_RTL_SLS_SC_DY_CUR_A',
                        'W_RTL_SLS_SC_LC_DY_A',
                        'W_RTL_SLS_SC_LC_DY_CUR_A')
 ORDER BY T.TABLE_NAME;

--3.INMEMORY
SELECT 'EXECUTE IMMEDIATE ''ALTER TABLE ' || T.OWNER || '.' || T.TABLE_NAME ||
       ' INMEMORY PRIORITY CRITICAL MEMCOMPRESS FOR CAPACITY HIGH'';'
  FROM ALL_ALL_TABLES T
 WHERE T.INMEMORY = 'ENABLED'
   AND T.TABLE_NAME IN ('BBG_RA_SLS_SC_LC_DY_A',
                        'W_RTL_SLS_CL_LC_DY_A',
                        'W_RTL_SLS_CL_LC_DY_CUR_A',
                        'W_RTL_SLS_DP_LC_DY_A',
                        'W_RTL_SLS_DP_LC_DY_CUR_A',
                        'W_RTL_SLS_LC_DY_A',
                        'W_RTL_SLS_SC_DY_A',
                        'W_RTL_SLS_SC_DY_CUR_A',
                        'W_RTL_SLS_SC_LC_DY_A',
                        'W_RTL_SLS_SC_LC_DY_CUR_A')
 ORDER BY T.TABLE_NAME;
