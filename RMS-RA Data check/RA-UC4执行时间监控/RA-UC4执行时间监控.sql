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
          FROM (SELECT trunc(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
                       ah_name,
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
                       (ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) start_time,
                       (ah_timestamp4 + NUMTODSINTERVAL(8, 'hour')) end_time
                  FROM ah@rms_uc4
                 WHERE ah_client = 80
                   AND AH_STATUS IN (1800, 1900)
                   AND TRUNC(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) = TRUNC(SYSDATE) 
                   AND ah_name IN ('PF.ORACLE_ANALYTICS_TOP_LEVEL',
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
 ORDER BY 1;
