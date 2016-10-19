--*************************************************************************************
--金立130039门店缺失销售处理（2016-10-15）
--*************************************************************************************
--1.确定缺失的商品编码
SELECT *
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
 WHERE A.DAY_DT = DATE '2016-10-15'
   AND NOT EXISTS (SELECT 1
          FROM (SELECT /*+PARALLEL(16)*/
                DISTINCT E.ORG_NUM, D.PROD_NUM PROD_IT_NUM
                  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F C,
                       RADM.W_PRODUCT_D              D,
                       RADM.W_INT_ORG_D              E
                 WHERE C.PROD_WID = D.ROW_WID
                   AND C.ORG_WID = E.ROW_WID
                   AND C.DT_WID = 120161015000
                   AND C.BBG_SERVICE_SATISFACTION = 3.5) B
         WHERE A.PROD_IT_NUM = B.PROD_IT_NUM
           AND A.ORG_NUM = B.ORG_NUM);

--2.W_RTL_SLS_TRX_IT_LC_DY_FS
TRUNCATE TABLE RADM.C_LOAD_DATES;
TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
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
         T.RET_QTY RET_QTY,
         T.RET_AMT_LCL RET_AMT_LCL,
         T.RET_PROFIT_AMT_LCL,
         T.RET_TAX_AMT_LCL RET_TAX_AMT_LCL,
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
         T.HYK_NO HYK_NO
    FROM (SELECT A.SLS_TRX_ID,
                 A.PROD_IT_NUM,
                 A.ORG_NUM,
                 A.DAY_DT,
                 A.VOUCHER_ID,
                 A.RTL_TYPE_CODE,
                 A.MIN_NUM,
                 A.SLS_QTY,
                 A.SLS_AMT_LCL,
                 A.SLS_PROFIT_AMT_LCL,
                 A.SLS_TAX_AMT_LCL,
                 A.SLS_EMP_DISC_AMT_LCL,
                 A.SLS_MANUAL_COUNT,
                 A.SLS_SCAN_COUNT,
                 -A.RET_QTY                 RET_QTY,
                 -A.RET_AMT_LCL             RET_AMT_LCL,
                 -A.RET_PROFIT_AMT_LCL      RET_PROFIT_AMT_LCL,
                 -A.RET_TAX_AMT_LCL         RET_TAX_AMT_LCL,
                 -A.RET_EMP_DISC_AMT_LCL    RET_EMP_DISC_AMT_LCL,
                 -A.RET_MANUAL_COUNT        RET_MANUAL_COUNT,
                 -A.RET_SCAN_COUNT          RET_SCAN_COUNT,
                 A.SLS_MANUAL_MKDN_AMT_LCL,
                 A.SLS_MANUAL_MKUP_AMT_LCL,
                 -A.RET_MANUAL_MKDN_AMT_LCL RET_MANUAL_MKDN_AMT_LCL,
                 -A.RET_MANUAL_MKUP_AMT_LCL RET_MANUAL_MKUP_AMT_LCL,
                 A.BBG_RETAIL_TYPE_ID,
                 A.HYK_NO
            FROM BBG_RA_SLS_TRX_JL_V@RA_JL A
           WHERE A.DAY_DT = DATE '2016-10-15'
             AND NOT EXISTS
           (SELECT 1
                    FROM (SELECT /*+PARALLEL(16)*/
                          DISTINCT E.ORG_NUM, D.PROD_NUM PROD_IT_NUM
                            FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F C,
                                 RADM.W_PRODUCT_D              D,
                                 RADM.W_INT_ORG_D              E
                           WHERE C.PROD_WID = D.ROW_WID
                             AND C.ORG_WID = E.ROW_WID
                             AND C.DT_WID = 120161015000
                             AND C.BBG_SERVICE_SATISFACTION = 3.5) B
                   WHERE A.PROD_IT_NUM = B.PROD_IT_NUM
                     AND A.ORG_NUM = B.ORG_NUM)) T;
COMMIT;
--3.
SELECT * FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

--SUPP SALES 
--1.CHECK ITEM_LOC
SELECT /*+PARALLEL(20)*/
 T1.ITEM,
 T1.LOC,
 T1.DT_WID,
 T1.SLS_NOTAX_AMT,
 T2.SUPP_NOTAX_SALES_AMT,
 ABS(NVL(T1.SLS_NOTAX_AMT, 0) - NVL(T2.SUPP_NOTAX_SALES_AMT, 0)) NOTAX_AMT_DIFF
  FROM (SELECT /*+PARALLEL(T20)*/
         T3.ITEM,
         T3.LOC,
         T3.DT_WID,
         SUM(T3.SLS_QTY) SLS_QTY,
         SUM(SLS_AMT) SLS_AMT,
         SUM(SLS_NOTAX_AMT) SLS_NOTAX_AMT
          FROM (SELECT /*+PARALLEL(20)*/
                 CASE
                   WHEN PK.ITEM IS NULL THEN
                    P.PROD_IT_NUM
                   ELSE
                    PK.ITEM
                 END ITEM,
                 O.ORG_NUM LOC,
                 W.DT_WID,
                 SUM((NVL(W.SLS_QTY, 0) - NVL(W.RET_QTY, 0)) *
                     NVL(PK.PACK_QTY, 1)) SLS_QTY,
                 SUM((NVL(W.SLS_AMT_LCL, 0) - NVL(W.RET_AMT_LCL, 0)) /
                     NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) SLS_AMT,
                 SUM(((NVL(W.SLS_AMT_LCL, 0) - NVL(W.RET_AMT_LCL, 0)) -
                     (NVL(W.SLS_TAX_AMT_LCL, 0) - NVL(W.RET_TAX_AMT_LCL, 0))) /
                     NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) SLS_NOTAX_AMT
                  FROM RADM.W_RTL_SLS_IT_LC_DY_A W,
                       RABATCHER.W_INT_ORG_D_RTL_TMP O,
                       RABATCHER.W_PRODUCT_D_RTL_TMP P,
                       RADM.PACKITEM PK,
                       (SELECT /*+PARALLEL(20)*/
                         PACK_NO, SUM(PK1.PACK_QTY) PACK_QTY
                          FROM PACKITEM PK1
                         GROUP BY PACK_NO) PK2
                 WHERE W.PROD_WID = P.PROD_IT_WID
                   AND W.ORG_WID = O.ORG_WID
                   AND W.DT_WID = &DT_WID
                   AND PK.PACK_NO(+) = P.PROD_IT_NUM
                      /*AND P.PROD_IT_NUM IN ('100075536', '800207722', '100844024')*/
                   AND PK2.PACK_NO(+) = PK.PACK_NO
                 GROUP BY P.PROD_IT_NUM, O.ORG_NUM, W.DT_WID, PK.ITEM) T3
         GROUP BY T3.ITEM, T3.LOC, T3.DT_WID) T1,
       (SELECT /*+PARALLEL(20)*/
         P.PROD_IT_NUM ITEM,
         O.ORG_NUM LOC,
         B.DT_WID,
         SUM(B.SUPP_SALES_QTY) SUPP_SALES_QTY,
         SUM(B.SUPP_SALES_AMT) SUPP_NOTAX_SALES_AMT
          FROM RADM.BBG_RA_SLS_IT_LC_DY_A    B,
               RABATCHER.W_INT_ORG_D_RTL_TMP O,
               RABATCHER.W_PRODUCT_D_RTL_TMP P
         WHERE B.PROD_WID = P.PROD_IT_WID
           AND B.ORG_WID = O.ORG_WID
           AND B.DT_WID = &DT_WID
         GROUP BY P.PROD_IT_NUM, O.ORG_NUM, B.DT_WID) T2
 WHERE T1.ITEM = T2.ITEM(+)
   AND T1.LOC = T2.LOC(+)
   AND T1.DT_WID = T2.DT_WID(+)
   AND ABS(NVL(T1.SLS_NOTAX_AMT, 0) - NVL(T2.SUPP_NOTAX_SALES_AMT, 0)) > 0.1
   AND T1.LOC = &LOCATION;

--2.supp sde 
TRUNCATE TABLE RADM.BBG_RA_SLS_IT_LC_DY_FS;
INSERT INTO RADM.BBG_RA_SLS_IT_LC_DY_FS
  (DAY_DT,
   PROD_IT_NUM,
   ORG_NUM,
   SUPPLIER_NUM,
   SUPP_SALES_QTY,
   SUPP_SALES_COST,
   SUPP_SALES_AMT,
   CHANGED_BY_ID,
   CHANGED_ON_DT,
   CREATED_BY_ID,
   CREATED_ON_DT,
   DATASOURCE_NUM_ID,
   DELETE_FLG,
   ETL_THREAD_VAL,
   INTEGRATION_ID,
   AUX1_CHANGED_ON_DT,
   AUX2_CHANGED_ON_DT,
   AUX3_CHANGED_ON_DT,
   AUX4_CHANGED_ON_DT,
   DOC_CURR_CODE,
   GLOBAL1_EXCHANGE_RATE,
   GLOBAL2_EXCHANGE_RATE,
   GLOBAL3_EXCHANGE_RATE,
   LOC_CURR_CODE,
   LOC_EXCHANGE_RATE,
   TENANT_ID,
   X_CUSTOM,
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
   BBG_REFERENCE_FO10)
  SELECT T.DAY_DT,
         T.PROD_IT_NUM,
         T.ORG_NUM,
         T.SUPPLIER_NUM,
         T.SUPP_SALES_QTY,
         T.SUPP_SALES_COST,
         T.SUPP_SALES_AMT,
         -1 CHANGED_BY_ID,
         SYSDATE CHANGED_ON_DT,
         -1 CREATED_BY_ID,
         SYSDATE CREATED_ON_DT,
         1 DATASOURCE_NUM_ID,
         NULL DELETE_FLG,
         (SELECT L.THREAD_VAL
            FROM RA_RMS.RA_RESTART_LOC@RA_RMS_DBLINK L
           WHERE T.ORG_NUM = L.DRIVER_VALUE
             AND L.SCENARIO_NAME = 'SDE_BBG_RA_SUPP_SALES_IT_LC_DY_FS') ETL_THREAD_VAL,
         TO_CHAR(T.DAY_DT, 'DD-MON-YY', 'NLS_DATE_LANGUAGE = American') || '~' ||
         T.PROD_IT_NUM || '~' || T.ORG_NUM || '~' || T.SUPPLIER_NUM INTEGRATION_ID,
         NULL AUX1_CHANGED_ON_DT,
         NULL AUX2_CHANGED_ON_DT,
         NULL AUX3_CHANGED_ON_DT,
         NULL AUX4_CHANGED_ON_DT,
         'CNY' DOC_CURR_CODE,
         NULL GLOBAL1_EXCHANGE_RATE,
         NULL GLOBAL2_EXCHANGE_RATE,
         NULL GLOBAL3_EXCHANGE_RATE,
         'CNY' LOC_CURR_CODE,
         NULL LOC_EXCHANGE_RATE,
         NULL TENANT_ID,
         NULL X_CUSTOM,
         (SELECT IL.BUSINESS_MODE
            FROM RADM.BBG_RA_ITEM_LOC_D IL
           WHERE IL.ITEM = T.PROD_IT_NUM
             AND IL.LOC = T.ORG_NUM
             AND T.DAY_DT BETWEEN IL.EFFECTIVE_FROM_DT AND
                 IL.EFFECTIVE_TO_DT) BBG_REFERENCE_DO1,
         'JINLI' BBG_REFERENCE_DO2,
         NULL BBG_REFERENCE_DO3,
         NULL BBG_REFERENCE_DO4,
         NULL BBG_REFERENCE_DO5,
         T.BBG_REFERENCE_FO1 BBG_REFERENCE_FO1,
         NULL BBG_REFERENCE_FO2,
         NULL BBG_REFERENCE_FO3,
         NULL BBG_REFERENCE_FO4,
         NULL BBG_REFERENCE_FO5,
         NULL BBG_REFERENCE_FO6,
         NULL BBG_REFERENCE_FO7,
         NULL BBG_REFERENCE_FO8,
         NULL BBG_REFERENCE_FO9,
         NULL BBG_REFERENCE_FO10
    FROM RADM.BBG_RA_SUPP_JL_VIEW T
   WHERE T.DAY_DT = DATE
   '2016-10-15'
     AND T.ORG_NUM = '130039'
     AND T.PROD_IT_NUM IN ('2400077031566',
                           '2400077021756',
                           '2400073090095',
                           '2400073020633',
                           '2400073090092',
                           '2400077031536',
                           '2400071027217',
                           '2400073012320',
                           '2400073090093',
                           '2400073021411',
                           '2400078054237',
                           '2400078051139',
                           '2400073090099',
                           '2400071027052',
                           '2400077090281',
                           '2400078053166',
                           '2400078053843',
                           '2400073012330',
                           '2400071027155',
                           '2400071027152',
                           '2400071027115',
                           '2400078053829',
                           '2400071027228',
                           '2400077090161',
                           '2400071026707',
                           '2400073040591',
                           '2400071027038',
                           '2400073012298',
                           '2400073040563',
                           '2400077090266');
COMMIT;

--3.SIL
TRUNCATE TABLE RADM.C_LOAD_DATES;
SELECT * FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP;

--4.supp sales plp


--*************************************************************************************
--120183门店缺失销售（2016-10-15）
--*************************************************************************************
--1.
DELETE RA_RMS.BBG_XTERN_RDWT T WHERE T.BUSINESS_DT = 20161017;
COMMIT;

--2.120183包装商品700005756销售已经接入RA
DELETE RA_RMS.BBG_XTERN_RDWT T
 WHERE T.ITEM = '700005756'
   AND T.BUSINESS_DT = 20161015
   AND T.LOCATION = '0000120183';
COMMIT;

SELECT * FROM ITEM_MASTER T WHERE T.ITEM = '700005756';

--3.修改日期
SELECT * FROM RA_RMS.BBG_RA_ITEM_LOC_SOH_V;

--4.SDE
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
SELECT DISTINCT ORG_NUM, DAY_DT FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;

DELETE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS T
 WHERE NVL(T.BBG_SERVICE_SATISFACTION, 0) = 3.5;
COMMIT;

--5.SIL,RETAIL_CUST
SELECT * FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

SELECT DISTINCT ORG_WID FROM RABATCHER.BBG_RA_CUST_IT_LC_DY_TMP;
