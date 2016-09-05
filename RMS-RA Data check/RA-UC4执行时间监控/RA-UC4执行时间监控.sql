SELECT *
  FROM (SELECT CASE
                 WHEN A.AH_NAME = 'PF.ORACLE_ANALYTICS_TOP_LEVEL' THEN
                  'TOTAL'
                 WHEN A.AH_NAME = 'PF.SDE_DIMENSION_LOAD' THEN
                  'PHASE1'
                 WHEN A.AH_NAME = 'CMX_RA_DIMENSION_CHECK.KSH' THEN
                  'PHASE2'
                 WHEN A.AH_NAME = 'PF.SIL_DIMENSION_LOAD' THEN
                  'PHASE3'
                 WHEN A.AH_NAME = 'PF.SDE_FACT_LOAD' THEN
                  'PHASE4'
                 WHEN A.AH_NAME = 'CMX_RA_FACT_CHECK.KSH' THEN
                  'PHASE5'
                 WHEN A.AH_NAME = 'PF.SIL_FACT_LOAD' THEN
                  'PHASE6'
                 WHEN A.AH_NAME = 'PF.PLP_AGGREGATE_LOADING' THEN
                  'PHASE7_1'
                 WHEN A.AH_NAME = 'BBG.CMX.RA.F16_SUPP_INV' THEN
                  'PHASE7_2'
                 WHEN A.AH_NAME = 'BBG.CMX.RA.F20_SUPP_SALES' THEN
                  'PHASE7_3'
                 WHEN A.AH_NAME = 'BBG.CMX.RA.F27_RETAIL_CUST' THEN
                  'PHASE7_4'
                 WHEN A.AH_NAME = 'BBG_ETL_MONTH_DATA.KSH' THEN
                  'PHASE8'
                 WHEN A.AH_NAME = 'BATCH_RESA2DW_BACKUP.KSH' THEN
                  'PHASE9'
               END PHASE,
               A.*
          FROM (SELECT trunc(D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
                       ah_name,
                       (D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) start_time,
                       (D.ah_timestamp4 + NUMTODSINTERVAL(8, 'hour')) end_time,
                       LPAD(trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24),
                            2,
                            '0') || ':' ||
                       LPAD((trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24 * 60) -
                            trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24) * 60),
                            2,
                            '0') || ':' ||
                       LPAD(TRUNC((D.ah_timestamp4 - D.ah_timestamp2) * 24 * 60 * 60 -
                                  trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24 * 60) * 60),
                            2,
                            '0') RUN_TIME,
                       --最近30天平均执行时间
                       (SELECT LPAD(trunc((SUM(ah_timestamp4 - ah_timestamp2) / 30) * 24),
                                    2,
                                    '0') || ':' ||
                               LPAD((trunc((SUM(ah_timestamp4 - ah_timestamp2) / 30) * 24 * 60) -
                                    trunc((SUM(ah_timestamp4 - ah_timestamp2) / 30) * 24) * 60),
                                    2,
                                    '0') || ':' ||
                               LPAD(TRUNC((SUM(ah_timestamp4 - ah_timestamp2) / 30) * 24 * 60 * 60 -
                                          trunc((SUM(ah_timestamp4 -
                                                     ah_timestamp2) / 30) * 24 * 60) * 60),
                                    2,
                                    '0') MONTH_AVG_RUN_ITME
                          FROM ah@rms_uc4 M
                         WHERE M.ah_client = 80
                           AND M.AH_STATUS IN (1800, 1850, 1900)
                           AND TRUNC(M.ah_timestamp2 +
                                     NUMTODSINTERVAL(8, 'hour')) BETWEEN
                               TRUNC(SYSDATE - 30) AND TRUNC(SYSDATE - 1)
                           AND M.ah_name IN
                               ('PF.ORACLE_ANALYTICS_TOP_LEVEL',
                                'PF.SDE_DIMENSION_LOAD',
                                'CMX_RA_DIMENSION_CHECK.KSH',
                                'PF.SIL_DIMENSION_LOAD',
                                'PF.SDE_FACT_LOAD',
                                'CMX_RA_FACT_CHECK.KSH',
                                'PF.SIL_FACT_LOAD',
                                'PF.SIL_DIMENSION_LOAD',
                                'PF.SDE_FACT_LOAD',
                                'CMX_RA_FACT_CHECK.KSH',
                                'PF.SIL_FACT_LOAD',
                                'PF.PLP_AGGREGATE_LOADING',
                                'BBG.CMX.RA.F16_SUPP_INV',
                                'BBG.CMX.RA.F20_SUPP_SALES',
                                'BBG.CMX.RA.F27_RETAIL_CUST',
                                'BBG_ETL_MONTH_DATA.KSH',
                                'BATCH_RESA2DW_BACKUP.KSH')
                           AND M.ah_name = D.AH_NAME) MONTH_AVG_RUNTIME,
                       case
                         when D.AH_STATUS = 1900 then
                          'ENDED_OK-ended normally'
                         when D.AH_STATUS = 1800 then
                          'ENDED_NOT_OK-aborted'
                         when D.AH_STATUS = 1850 then
                          'ENDED_CANCEL-manually canceled'
                       end STATUS
                  FROM ah@rms_uc4 D
                 WHERE D.ah_client = 80
                   AND D.AH_STATUS IN (1800, 1850, 1900)
                   AND TRUNC(D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) =
                       TRUNC(SYSDATE)
                   AND D.ah_name IN ('PF.ORACLE_ANALYTICS_TOP_LEVEL',
                                     'PF.SDE_DIMENSION_LOAD',
                                     'CMX_RA_DIMENSION_CHECK.KSH',
                                     'PF.SIL_DIMENSION_LOAD',
                                     'PF.SDE_FACT_LOAD',
                                     'CMX_RA_FACT_CHECK.KSH',
                                     'PF.SIL_FACT_LOAD',
                                     'PF.SIL_DIMENSION_LOAD',
                                     'PF.SDE_FACT_LOAD',
                                     'CMX_RA_FACT_CHECK.KSH',
                                     'PF.SIL_FACT_LOAD',
                                     'PF.PLP_AGGREGATE_LOADING',
                                     'BBG.CMX.RA.F16_SUPP_INV',
                                     'BBG.CMX.RA.F20_SUPP_SALES',
                                     'BBG.CMX.RA.F27_RETAIL_CUST',
                                     'BBG_ETL_MONTH_DATA.KSH',
                                     'BATCH_RESA2DW_BACKUP.KSH')) A)
 ORDER BY 1, 4;

--单个ksh执行时间监控
SELECT *
  FROM (SELECT A.*
          FROM (SELECT trunc(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
                       ah_name,
                       (ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) start_time,
                       (ah_timestamp4 + NUMTODSINTERVAL(8, 'hour')) end_time,
                       LPAD(trunc((ah_timestamp4 - ah_timestamp2) * 24),
                            2,
                            '0') || ':' ||
                       LPAD((trunc((ah_timestamp4 - ah_timestamp2) * 24 * 60) -
                            trunc((ah_timestamp4 - ah_timestamp2) * 24) * 60),
                            2,
                            '0') || ':' ||
                       LPAD(TRUNC((ah_timestamp4 - ah_timestamp2) * 24 * 60 * 60 -
                                  trunc((ah_timestamp4 - ah_timestamp2) * 24 * 60) * 60),
                            2,
                            '0') RUN_TIME,
                       ROWCOUNT,
                       case
                         when AH_STATUS = 1900 then
                          'ENDED_OK-ended normally'
                         when AH_STATUS = 1800 then
                          'ENDED_NOT_OK-aborted'
                         when AH_STATUS = 1850 then
                          'ENDED_CANCEL-manually canceled'
                       end STATUS
                  FROM ah@rms_uc4,
                       (SELECT /*+PARALLEL(16)*/
                         COUNT(*) ROWCOUNT
                          FROM BBG_RA_ITEM_LOC_SUPP_DS@RMS_RA T)
                 WHERE ah_client = 80
                   AND AH_STATUS IN (1800, 1850, 1900)
                   AND TRUNC(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) =
                       TRUNC(SYSDATE)
                   AND ah_name IN ('BBG_RA_ITEM_LOC_SUPP_SIL.KSH')) A)
 ORDER BY 1, 4;

--执行时间慢的ksh监控
--BBG_INVILDSIL.KSH
--NCSTUIDPLP
--CSTISLPLP
--BBG_RA_SUPP_SLSSLDPLP.KSH
--BBG_RA_CUST_IT_SIL.KSH
SELECT *
  FROM (SELECT A.*
          FROM (SELECT --trunc(D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
                 ah_name,
                 (D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) start_time,
                 (D.ah_timestamp4 + NUMTODSINTERVAL(8, 'hour')) end_time,
                 LPAD(trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24), 2, '0') || ':' ||
                 LPAD((trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24 * 60) -
                      trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24) * 60),
                      2,
                      '0') || ':' ||
                 LPAD(TRUNC((D.ah_timestamp4 - D.ah_timestamp2) * 24 * 60 * 60 -
                            trunc((D.ah_timestamp4 - D.ah_timestamp2) * 24 * 60) * 60),
                      2,
                      '0') RUN_TIME,
                 --2016年上半年
                 (SELECT LPAD(trunc((SUM(ah_timestamp4 - ah_timestamp2) / 182) * 24),
                              2,
                              '0') || ':' ||
                         LPAD((trunc((SUM(ah_timestamp4 - ah_timestamp2) / 182) * 24 * 60) -
                              trunc((SUM(ah_timestamp4 - ah_timestamp2) / 182) * 24) * 60),
                              2,
                              '0') || ':' ||
                         LPAD(TRUNC((SUM(ah_timestamp4 - ah_timestamp2) / 182) * 24 * 60 * 60 -
                                    trunc((SUM(ah_timestamp4 - ah_timestamp2) / 182) * 24 * 60) * 60),
                              2,
                              '0') MONTH_AVG_RUN_ITME
                    FROM ah@rms_uc4 M
                   WHERE M.ah_client = 80
                     AND M.AH_STATUS IN (1800, 1850, 1900)
                     AND TRUNC(M.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) BETWEEN DATE
                   '2016-01-01'
                     AND DATE '2016-06-30'
                     AND M.ah_name IN
                         ('BBG_INVILDSIL.KSH',
                          'NCSTUIDPLP',
                          'CSTISLPLP',
                          'BBG_RA_SUPP_SLSSLDPLP.KSH',
                          'BBG_RA_CUST_IT_SIL.KSH',
                          'PF.ORACLE_ANALYTICS_TOP_LEVEL')
                     AND M.ah_name = D.AH_NAME) MONTH_AVG_RUNTIME,
                 case
                   when D.AH_STATUS = 1900 then
                    'ENDED_OK-ended normally'
                   when D.AH_STATUS = 1800 then
                    'ENDED_NOT_OK-aborted'
                   when D.AH_STATUS = 1850 then
                    'ENDED_CANCEL-manually canceled'
                 end STATUS
                  FROM ah@rms_uc4 D
                 WHERE D.ah_client = 80
                   AND D.AH_STATUS IN (1800, 1850, 1900)
                   AND TRUNC(D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) = DATE
                 '2016-08-01'
                   AND D.ah_name IN
                       ('BBG_INVILDSIL.KSH',
                        'NCSTUIDPLP',
                        'CSTISLPLP',
                        'BBG_RA_SUPP_SLSSLDPLP.KSH',
                        'BBG_RA_CUST_IT_SIL.KSH',
                        'PF.ORACLE_ANALYTICS_TOP_LEVEL')) A);

---RA全部KSH执行对比
SELECT *
  FROM (SELECT A.*
          FROM (SELECT --trunc(D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
                 ah_name,
                 LPAD(trunc((SUM(D.ah_timestamp4 - D.ah_timestamp2) / 23) * 24),
                      2,
                      '0') || ':' ||
                 LPAD((trunc((SUM(D.ah_timestamp4 - D.ah_timestamp2) / 23) * 24 * 60) -
                      trunc((SUM(D.ah_timestamp4 - D.ah_timestamp2) / 23) * 24) * 60),
                      2,
                      '0') || ':' ||
                 LPAD(TRUNC((SUM(D.ah_timestamp4 - D.ah_timestamp2) / 23) * 24 * 60 * 60 -
                            trunc((SUM(D.ah_timestamp4 - D.ah_timestamp2) / 23) * 24 * 60) * 60),
                      2,
                      '0') RUN_TIME,
                 /*2016年上半年*/
                 (SELECT LPAD(trunc((SUM(ah_timestamp4 - ah_timestamp2) / 21) * 24),
                              2,
                              '0') || ':' ||
                         LPAD((trunc((SUM(ah_timestamp4 - ah_timestamp2) / 21) * 24 * 60) -
                              trunc((SUM(ah_timestamp4 - ah_timestamp2) / 21) * 24) * 60),
                              2,
                              '0') || ':' ||
                         LPAD(TRUNC((SUM(ah_timestamp4 - ah_timestamp2) / 21) * 24 * 60 * 60 -
                                    trunc((SUM(ah_timestamp4 - ah_timestamp2) / 21) * 24 * 60) * 60),
                              2,
                              '0') P_RUN_ITME
                    FROM ah@rms_uc4 M
                   WHERE M.ah_client = 80
                     AND M.AH_STATUS IN (1800, 1850, 1900)
                     AND TRUNC(M.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) BETWEEN DATE
                   '2016-07-01'
                     AND DATE '2016-07-21'
                     AND M.ah_hostdst = 'RA_AGENT'
										 
                     AND EXISTS
                   (SELECT 1
                            FROM AH@RMS_UC4 TP
                           WHERE M.AH_TOPNR = TP.AH_IDNR
                             AND TP.AH_NAME = 'PF.ORACLE_RETAIL_BATCH')
                     AND M.ah_name = D.AH_NAME) P_RUN_ITME
                  FROM ah@rms_uc4 D
                 WHERE D.ah_client = 80
                   AND D.AH_STATUS IN (1800, 1850, 1900)
                   AND TRUNC(D.ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) BETWEEN DATE
                 '2016-08-01'
                   AND DATE '2016-08-23'
                   AND D.ah_hostdst = 'RA_AGENT'
                   AND EXISTS
                 (SELECT 1
                          FROM AH@RMS_UC4 TP
                         WHERE D.AH_TOPNR = TP.AH_IDNR
                           AND TP.AH_NAME = 'PF.ORACLE_RETAIL_BATCH')
                 GROUP BY ah_name) A)
 ORDER BY 1;

ORDER BY 1, 4;
