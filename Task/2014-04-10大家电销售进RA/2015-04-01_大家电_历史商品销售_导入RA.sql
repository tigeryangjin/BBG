--*************************************************************************************************
--处理商品地点维度缺失(日期范围不对)
CREATE MATERIALIZED VIEW RADM.JIN_ITEM_LOC_JL_TMP AS
SELECT S.PROD_IT_NUM ITEM, TO_NUMBER(S.ORG_NUM) LOC, MIN(S.DAY_DT) DAY_DT
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL S
 WHERE EXISTS (SELECT 1
          FROM RADM.JIN_ITEM_LOC_NOT_JL_TMP T
         WHERE S.PROD_IT_NUM = T.ITEM
           AND S.ORG_NUM = T.LOC
					 AND T.DAY_DT IS NOT NULL)
 GROUP BY S.PROD_IT_NUM, TO_NUMBER(S.ORG_NUM);
 
DROP MATERIALIZED VIEW RADM.JIN_ITEM_LOC_JL_TMP;
 
--商品-地点维度问题
--1.查找销售未落在商品-地点维度中的
CREATE MATERIALIZED VIEW RADM.JIN_ITEM_LOC_NOT_JL_TMP AS
SELECT A.PROD_IT_NUM ITEM, A.ORG_NUM LOC, A.DAY_DT
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
 WHERE NOT EXISTS
 (SELECT 1
          FROM RADM.BBG_RA_ITEM_LOC_D B
         WHERE A.PROD_IT_NUM = B.ITEM
           AND A.ORG_NUM = B.LOC
           AND A.DAY_DT BETWEEN B.EFFECTIVE_FROM_DT AND B.EFFECTIVE_TO_DT)
   AND EXISTS (SELECT 1
          FROM RADM.BBG_RA_ITEM_LOC_D C
         WHERE A.PROD_IT_NUM = C.ITEM
           AND A.ORG_NUM = C.LOC)
   AND A.DAY_DT IS NOT NULL;
					 
DROP MATERIALIZED VIEW RADM.JIN_ITEM_LOC_NOT_JL_TMP;					 
					 
--2.商品-地点维度根本不存在的
SELECT A.PROD_IT_NUM ITEM, A.ORG_NUM LOC, A.DAY_DT
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.BBG_RA_ITEM_LOC_D C
         WHERE A.PROD_IT_NUM = C.ITEM
           AND A.ORG_NUM = C.LOC);
					 
SELECT A.PROD_IT_NUM ITEM, A.ORG_NUM LOC, A.DAY_DT
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
 WHERE NOT EXISTS (SELECT 1
          FROM BBG_RA_ITEM_LOC_JL_V@RA_JL C
         WHERE A.PROD_IT_NUM = C.ITEM
           AND A.ORG_NUM = C.LOC);
					 
--UPDATE RADM.BBG_RA_ITEM_LOC_D				 
 UPDATE RADM.BBG_RA_ITEM_LOC_D A
    SET (A.SRC_EFF_FROM_DT, A.EFFECTIVE_FROM_DT) =
        (SELECT B.DAY_DT, B.DAY_DT
           FROM RADM.JIN_ITEM_LOC_JL_TMP B
          WHERE A.ITEM = B.ITEM
            AND A.LOC = B.LOC)
  WHERE EXISTS (SELECT 1
           FROM (SELECT E.ITEM, E.LOC, MIN(E.ROW_WID) ROW_WID
                   FROM RADM.BBG_RA_ITEM_LOC_D E
                  WHERE EXISTS (SELECT 1
                           FROM RADM.JIN_ITEM_LOC_JL_TMP C
                          WHERE E.ITEM = C.ITEM
                            AND E.LOC = C.LOC)
                  GROUP BY E.ITEM, E.LOC) D
          WHERE A.ITEM = D.ITEM
            AND A.LOC = D.LOC
            AND A.ROW_WID = D.ROW_WID);
--有销售无商品-地点维度
SELECT /*+PARALLEL(A,20)*/
DISTINCT A.PROD_IT_NUM ITEM, A.ORG_NUM LOC, A.DAY_DT
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
 WHERE NOT EXISTS
 (SELECT /*+PARALLEL(B,20)*/
         1
          FROM RADM.BBG_RA_ITEM_LOC_D B
         WHERE A.PROD_IT_NUM = B.ITEM
           AND A.ORG_NUM = B.LOC
           AND A.DAY_DT BETWEEN B.EFFECTIVE_FROM_DT AND B.EFFECTIVE_TO_DT)
   AND A.DAY_DT IS NOT NULL
 ORDER BY A.PROD_IT_NUM, A.ORG_NUM;
--*************************************************************************************************


--1.金力销售导入W_RTL_SLS_TRX_IT_LC_DY_FS--------------------------------------------------------
TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP;

INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
  (SLS_TRX_ID,
   PROD_IT_NUM,
   ORG_NUM,
   DAY_DT,
   VOUCHER_ID,
   RTL_TYPE_CODE,
   MIN_NUM,
   EMPLOYEE_NUM,
   SLS_QTY,
   SLS_AMT_LCL,
   SLS_PROFIT_AMT_LCL,
   SLS_TAX_AMT_LCL,
   SLS_EMP_DISC_AMT_LCL,
   SLS_MANUAL_COUNT,
   SLS_SCAN_COUNT,
   RET_QTY,
   RET_AMT_LCL,
   RET_PROFIT_AMT_LCL,
   RET_TAX_AMT_LCL,
   RET_EMP_DISC_AMT_LCL,
   RET_MANUAL_COUNT,
   RET_SCAN_COUNT,
   REJECT_FLG,
   SLS_MANUAL_MKDN_AMT_LCL,
   SLS_MANUAL_MKUP_AMT_LCL,
   RET_MANUAL_MKDN_AMT_LCL,
   RET_MANUAL_MKUP_AMT_LCL,
   EXCHANGE_DT,
   AUX1_CHANGED_ON_DT,
   AUX2_CHANGED_ON_DT,
   AUX3_CHANGED_ON_DT,
   AUX4_CHANGED_ON_DT,
   CHANGED_BY_ID,
   CHANGED_ON_DT,
   CREATED_BY_ID,
   CREATED_ON_DT,
   DATASOURCE_NUM_ID,
   DELETE_FLG,
   DOC_CURR_CODE,
   ETL_THREAD_VAL,
   GLOBAL1_EXCHANGE_RATE,
   GLOBAL2_EXCHANGE_RATE,
   GLOBAL3_EXCHANGE_RATE,
   INTEGRATION_ID,
   LOC_CURR_CODE,
   LOC_EXCHANGE_RATE,
   TENANT_ID,
   X_CUSTOM,
   BBG_RETAIL_TYPE_ID,
   BBG_SERVICE_SATISFACTION,
   SRC_REF_NO1,
   SRC_REF_NO2,
   SRC_REF_NO3,
   SRC_REF_NO6,
   SRC_REF_NO7,
   SRC_REF_NO8,
   BBG_REFERENCE_DO1,
   BBG_REFERENCE_DO2,
   BBG_REFERENCE_DO3,
   BBG_REFERENCE_DO4,
   BBG_REFERENCE_DO5,
   BBG_REFERENCE_FO1,
   BBG_REFERENCE_FO2,
   BBG_REFERENCE_FO3,
   BBG_REFERENCE_FO4,
   BBG_REFERENCE_FO5,
   BBG_REFERENCE_FO6,
   BBG_REFERENCE_FO7,
   BBG_REFERENCE_FO8,
   BBG_REFERENCE_FO9,
   BBG_REFERENCE_FO10,
   HYK_NO)
  SELECT T.SLS_TRX_ID,
         T.PROD_IT_NUM,
         T.ORG_NUM,
         T.DAY_DT,
         -1 VOUCHER_ID,
         T.RTL_TYPE_CODE,
         T.MIN_NUM,
         -1 EMPLOYEE_NUM,
         T.SLS_QTY,
         T.SLS_AMT_LCL,
         T.SLS_PROFIT_AMT_LCL,
         T.SLS_TAX_AMT_LCL,
         T.SLS_EMP_DISC_AMT_LCL,
         T.SLS_MANUAL_COUNT,
         T.SLS_SCAN_COUNT,
         ABS(T.RET_QTY) RET_QTY,
         ABS(T.RET_AMT_LCL) RET_AMT_LCL,
         T.RET_PROFIT_AMT_LCL,
         ABS(T.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
         T.RET_EMP_DISC_AMT_LCL,
         T.RET_MANUAL_COUNT,
         T.RET_SCAN_COUNT,
         NULL REJECT_FLG,
         T.SLS_MANUAL_MKDN_AMT_LCL,
         T.SLS_MANUAL_MKUP_AMT_LCL,
         T.RET_MANUAL_MKDN_AMT_LCL,
         T.RET_MANUAL_MKUP_AMT_LCL,
         T.DAY_DT EXCHANGE_DT,
         NULL AUX1_CHANGED_ON_DT,
         NULL AUX2_CHANGED_ON_DT,
         NULL AUX3_CHANGED_ON_DT,
         NULL AUX4_CHANGED_ON_DT,
         -1 CHANGED_BY_ID,
         SYSDATE CHANGED_ON_DT,
         -1 CREATED_BY_ID,
         SYSDATE CREATED_ON_DT,
         1 DATASOURCE_NUM_ID,
         NULL DELETE_FLG,
         'CNY' DOC_CURR_CODE,
         (SELECT L.THREAD_VAL
            FROM RA_RMS.RA_RESTART_LOC@RA_RMS_DBLINK L
           WHERE T.ORG_NUM = L.DRIVER_VALUE
             AND L.SCENARIO_NAME = 'SDE_BBG_RETAIL_SALESTRANSACTIONFACT') ETL_THREAD_VAL,
         NULL GLOBAL1_EXCHANGE_RATE,
         NULL GLOBAL2_EXCHANGE_RATE,
         NULL GLOBAL3_EXCHANGE_RATE,
         T.SLS_TRX_ID || '~' || T.PROD_IT_NUM || '~-1~' ||
         TO_CHAR(T.DAY_DT, 'DD-MON-YY', 'NLS_DATE_LANGUAGE = American') INTEGRATION_ID,
         'CNY' LOC_CURR_CODE,
         NULL LOC_EXCHANGE_RATE,
         NULL TENANT_ID,
         NULL X_CUSTOM,
         T.BBG_RETAIL_TYPE_ID,
         3.5 BBG_SERVICE_SATISFACTION,
         NULL SRC_REF_NO1,
         NULL SRC_REF_NO2,
         NULL SRC_REF_NO3,
         T.PROD_IT_NUM SRC_REF_NO6,
         NULL SRC_REF_NO7,
         NULL SRC_REF_NO8,
         NULL BBG_REFERENCE_DO1,
         NULL BBG_REFERENCE_DO2,
         NULL BBG_REFERENCE_DO3,
         NULL BBG_REFERENCE_DO4,
         NULL BBG_REFERENCE_DO5,
         NULL BBG_REFERENCE_FO1,
         NULL BBG_REFERENCE_FO2,
         NULL BBG_REFERENCE_FO3,
         NULL BBG_REFERENCE_FO4,
         NULL BBG_REFERENCE_FO5,
         NULL BBG_REFERENCE_FO6,
         NULL BBG_REFERENCE_FO7,
         NULL BBG_REFERENCE_FO8,
         NULL BBG_REFERENCE_FO9,
         NULL BBG_REFERENCE_FO10,
         NULL HYK_NO
    FROM (SELECT SLS_TRX_ID,
                 PROD_IT_NUM,
                 ORG_NUM,
                 DAY_DT,
                 VOUCHER_ID,
                 RTL_TYPE_CODE,
                 MIN_NUM,
                 SLS_QTY,
                 SLS_AMT_LCL,
                 SLS_PROFIT_AMT_LCL,
                 SLS_TAX_AMT_LCL,
                 SLS_EMP_DISC_AMT_LCL,
                 SLS_MANUAL_COUNT,
                 SLS_SCAN_COUNT,
                 -RET_QTY                 RET_QTY,
                 -RET_AMT_LCL             RET_AMT_LCL,
                 -RET_PROFIT_AMT_LCL      RET_PROFIT_AMT_LCL,
                 -RET_TAX_AMT_LCL         RET_TAX_AMT_LCL,
                 -RET_EMP_DISC_AMT_LCL    RET_EMP_DISC_AMT_LCL,
                 -RET_MANUAL_COUNT        RET_MANUAL_COUNT,
                 -RET_SCAN_COUNT          RET_SCAN_COUNT,
                 SLS_MANUAL_MKDN_AMT_LCL,
                 SLS_MANUAL_MKUP_AMT_LCL,
                 -RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
                 -RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
                 BBG_RETAIL_TYPE_ID
            FROM BBG_RA_SLS_TRX_JL_V@RA_JL
           WHERE DAY_DT BETWEEN &BDATE AND &EDATE) T;

--2.修改商品维度的日期----------------------------------------------------------------------------
UPDATE RABATCHER.W_PRODUCT_D_RTL_TMP T
   SET T.SRC_EFF_FROM_DT = DATE '2012-01-01'
 WHERE EXISTS
 (SELECT O.PROD_IT_NUM, O.SRC_EFF_FROM_DT
          FROM (SELECT A.PROD_IT_NUM, MIN(A.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT
                  FROM RABATCHER.W_PRODUCT_D_RTL_TMP A
                 GROUP BY A.PROD_IT_NUM) O
         WHERE T.PROD_IT_NUM = O.PROD_IT_NUM
           AND T.SRC_EFF_FROM_DT = O.SRC_EFF_FROM_DT)
   AND T.PROD_DV_NUM = 7
   AND T.PROD_DP_NUM NOT IN (75, 76);
COMMIT;

--3.SIL----------------------------------------------------------------------------

--4.检查数据----------------------------------------------------------------------------
SELECT DISTINCT T.DAY_DT FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP T;

--5.核对数据_汇总----------------------------------------------------------------------------
SELECT J.DAY_DT,
       J.JL_QTY,
       R.RA_QTY,
       J.JL_QTY - R.RA_QTY QTY_DIFF,
       J.JL_NOTAX_AMT,
       R.RA_NOTAX_AMT,
       J.JL_NOTAX_AMT - R.RA_NOTAX_AMT NOTAX_AMT_DIFF,
       J.JL_PROFIT,
       R.RA_PROFIT,
       J.JL_PROFIT - R.RA_PROFIT PROFIT_DIFF
  FROM (SELECT T.DAY_DT,
               SUM(T.SLS_QTY - T.RET_QTY) JL_QTY,
               SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                   (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) JL_NOTAX_AMT,
               SUM(T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL) JL_PROFIT
          FROM (SELECT SLS_TRX_ID,
                       PROD_IT_NUM,
                       ORG_NUM,
                       DAY_DT,
                       VOUCHER_ID,
                       RTL_TYPE_CODE,
                       MIN_NUM,
                       SLS_QTY,
                       SLS_AMT_LCL,
                       SLS_PROFIT_AMT_LCL,
                       SLS_TAX_AMT_LCL,
                       SLS_EMP_DISC_AMT_LCL,
                       SLS_MANUAL_COUNT,
                       SLS_SCAN_COUNT,
                       -RET_QTY                 RET_QTY,
                       -RET_AMT_LCL             RET_AMT_LCL,
                       -RET_PROFIT_AMT_LCL      RET_PROFIT_AMT_LCL,
                       -RET_TAX_AMT_LCL         RET_TAX_AMT_LCL,
                       -RET_EMP_DISC_AMT_LCL    RET_EMP_DISC_AMT_LCL,
                       -RET_MANUAL_COUNT        RET_MANUAL_COUNT,
                       -RET_SCAN_COUNT          RET_SCAN_COUNT,
                       SLS_MANUAL_MKDN_AMT_LCL,
                       SLS_MANUAL_MKUP_AMT_LCL,
                       -RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
                       -RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
                       BBG_RETAIL_TYPE_ID
                  FROM BBG_RA_SLS_TRX_JL_V@RA_JL
                 WHERE DAY_DT BETWEEN &BDATE AND &EDATE) T
         GROUP BY T.DAY_DT) J,
       (SELECT TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
               SUM(T.SLS_QTY - T.RET_QTY) RA_QTY,
               SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                   (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) RA_NOTAX_AMT,
               SUM(T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL) RA_PROFIT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
         WHERE T.DT_WID BETWEEN '1' || TO_CHAR(&BDATE, 'YYYYMMDD') || '000' AND
               '1' || TO_CHAR(&EDATE, 'YYYYMMDD') || '000'
           AND T.BBG_SERVICE_SATISFACTION = 3.5
         GROUP BY T.DT_WID) R
 WHERE J.DAY_DT = R.DAY_DT(+);

--核对数据_单品
SELECT J.DAY_DT,
       J.ORG_NUM,
       J.PROD_IT_NUM,
       J.JL_QTY,
       R.RA_QTY,
       J.JL_QTY - R.RA_QTY QTY_DIFF,
       J.JL_NOTAX_AMT,
       R.RA_NOTAX_AMT,
       J.JL_NOTAX_AMT - R.RA_NOTAX_AMT NOTAX_AMT_DIFF,
       J.JL_PROFIT,
       R.RA_PROFIT,
       J.JL_PROFIT - R.RA_PROFIT PROFIT_DIFF
  FROM (SELECT T.DAY_DT,
               T.PROD_IT_NUM,
               T.ORG_NUM,
               SUM(T.SLS_QTY - T.RET_QTY) JL_QTY,
               SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                   (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) JL_NOTAX_AMT,
               SUM(T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL) JL_PROFIT
          FROM (SELECT SLS_TRX_ID,
                       PROD_IT_NUM,
                       ORG_NUM,
                       DAY_DT,
                       VOUCHER_ID,
                       RTL_TYPE_CODE,
                       MIN_NUM,
                       SLS_QTY,
                       SLS_AMT_LCL,
                       SLS_PROFIT_AMT_LCL,
                       SLS_TAX_AMT_LCL,
                       SLS_EMP_DISC_AMT_LCL,
                       SLS_MANUAL_COUNT,
                       SLS_SCAN_COUNT,
                       -RET_QTY                 RET_QTY,
                       -RET_AMT_LCL             RET_AMT_LCL,
                       -RET_PROFIT_AMT_LCL      RET_PROFIT_AMT_LCL,
                       -RET_TAX_AMT_LCL         RET_TAX_AMT_LCL,
                       -RET_EMP_DISC_AMT_LCL    RET_EMP_DISC_AMT_LCL,
                       -RET_MANUAL_COUNT        RET_MANUAL_COUNT,
                       -RET_SCAN_COUNT          RET_SCAN_COUNT,
                       SLS_MANUAL_MKDN_AMT_LCL,
                       SLS_MANUAL_MKUP_AMT_LCL,
                       -RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
                       -RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
                       BBG_RETAIL_TYPE_ID
                  FROM BBG_RA_SLS_TRX_JL_V@RA_JL
                 WHERE DAY_DT BETWEEN &BDATE AND &EDATE) T
         GROUP BY T.DAY_DT, T.PROD_IT_NUM, T.ORG_NUM) J,
       (SELECT TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
               P.PROD_NUM,
               O.ORG_NUM,
               SUM(T.SLS_QTY - T.RET_QTY) RA_QTY,
               SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
                   (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) RA_NOTAX_AMT,
               SUM(T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL) RA_PROFIT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T,
               RADM.W_PRODUCT_D              P,
               RADM.W_INT_ORG_D              O
         WHERE T.PROD_WID = P.ROW_WID
           AND T.ORG_WID = O.ROW_WID
           AND T.DT_WID BETWEEN '1' || TO_CHAR(&BDATE, 'YYYYMMDD') || '000' AND
               '1' || TO_CHAR(&EDATE, 'YYYYMMDD') || '000'
           AND T.BBG_SERVICE_SATISFACTION = 3.5
         GROUP BY T.DT_WID, P.PROD_NUM, O.ORG_NUM) R
 WHERE J.DAY_DT = R.DAY_DT(+)
   AND J.PROD_IT_NUM = R.PROD_NUM(+)
   AND J.ORG_NUM = R.ORG_NUM(+)
   AND J.JL_QTY - NVL(R.RA_QTY, 0) > 0;


--6.PLP----------------------------------------------------------------------------
