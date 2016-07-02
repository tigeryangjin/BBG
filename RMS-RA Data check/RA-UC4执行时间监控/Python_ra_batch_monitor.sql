SELECT B.PHASE,
       B.DAYS,
       B.AH_NAME,
       B.START_TIME,
       B.END_TIME,
       B.RUN_TIME,
       B.MONTH_AVG_RUNTIME,
       B.STATUS
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
                       /*最近30天平均执行时间*/
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
                                     'BATCH_RESA2DW_BACKUP.KSH')) A) B
 ORDER BY 1, 4
