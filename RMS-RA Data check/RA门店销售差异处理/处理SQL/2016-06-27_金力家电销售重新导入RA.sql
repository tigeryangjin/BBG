--**********************************************************************************************************
--1.
--**********************************************************************************************************
--商品销售
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;

--销售接口
SELECT * FROM BBG_RA_SLS_TRX_JL_V@RA_JL WHERE DAY_DT = &DAY_DT;

--**********************************************************************************************************
--2.删除RA中金立家电的数据。
--**********************************************************************************************************
--商品销售清单表
/*
W_RTL_SLS_TRX_IT_LC_DY_F
W_RTL_SLS_CL_DY_CUR_A
W_RTL_SLS_CL_LC_DY_A
W_RTL_SLS_CL_LC_DY_CUR_A
W_RTL_SLS_DP_DY_CUR_A
W_RTL_SLS_DP_LC_DY_A
W_RTL_SLS_DP_LC_DY_CUR_A
W_RTL_SLS_IT_DY_A
W_RTL_SLS_IT_DY_SN_A
W_RTL_SLS_IT_LC_DY_A
W_RTL_SLS_IT_LC_DY_SN_A
W_RTL_SLS_LC_DY_A
W_RTL_SLS_SC_DY_A
W_RTL_SLS_SC_DY_CUR_A
W_RTL_SLS_SC_LC_DY_A
W_RTL_SLS_SC_LC_DY_CUR_A
W_RTL_SLS_TRX_DP_LC_DY_A
W_RTL_SLS_TRX_LC_DY_A
*/

--删除商品销售汇总表
DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_TRX_IT_LC_DY_F A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS (SELECT /*+PARALLEL(16)*/
         1
          FROM BBG_RA_SLS_TRX_JL_V@RA_JL B
         WHERE B.DAY_DT = &DAY_DT
           AND A.SLS_TRX_ID = B.SLS_TRX_ID);
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_CL_DY_CUR_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_CL_LC_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_CL_LC_DY_CUR_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_DP_DY_CUR_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_DP_LC_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_DP_LC_DY_CUR_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_IT_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_IT_DY_SN_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_IT_LC_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_IT_LC_DY_SN_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_SC_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_SC_DY_CUR_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_SC_LC_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_SC_LC_DY_CUR_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE /*+PARALLEL(16)*/
RADM.W_RTL_SLS_TRX_DP_LC_DY_A A
 WHERE A.DT_WID = &DT_WID
   AND EXISTS
 (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
--**********************************************************************************************************
--3.重新插入金力销售数据
--**********************************************************************************************************
--商品销售
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
         T.HYK_NO HYK_NO
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
                 BBG_RETAIL_TYPE_ID,
                 HYK_NO
            FROM BBG_RA_SLS_TRX_JL_V@RA_JL
           WHERE DAY_DT = &DAY_DT) T;

--**********************************************************************************************************
--4.SIL
--**********************************************************************************************************
TRUNCATE TABLE RADM.C_LOAD_DATES;
--BBG_SIL_Retail_SalesTransactionFact
--BBG_SIL_BBG_RA_SUPP_SALES_IT_LC_DY_F
SELECT * FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

--**********************************************************************************************************
--5.PLP
--**********************************************************************************************************
--UC4
--PLP_SALES_TRANSACTION

--**********************************************************************************************************
--6.处理W_RTL_SLS_LC_DY_A,W_RTL_SLS_TRX_LC_DY_A
--**********************************************************************************************************
DELETE RADM.W_RTL_SLS_LC_DY_A T WHERE T.DT_WID = &DT_WID;
COMMIT;
--MERGE W_RTL_SLS_LC_DY_A
MERGE /*+ APPEND */
INTO RADM.W_RTL_SLS_LC_DY_A T
USING (SELECT A.ORG_WID,
              MAX(A.ORG_DH_WID) ORG_DH_WID,
              MAX(A.ORG_SCD1_WID) ORG_SCD1_WID,
              A.DT_WID,
              A.RTL_TYPE_WID,
              A.VOUCHER_FLG,
              SUM(A.SLS_QTY) SLS_QTY,
              SUM(A.SLS_AMT_LCL) SLS_AMT_LCL,
              SUM(A.SLS_PROFIT_AMT_LCL) SLS_PROFIT_AMT_LCL,
              SUM(A.SLS_MANUAL_MKDN_AMT_LCL) SLS_MANUAL_MKDN_AMT_LCL,
              SUM(A.SLS_MANUAL_MKUP_AMT_LCL) SLS_MANUAL_MKUP_AMT_LCL,
              SUM(A.SLS_TAX_AMT_LCL) SLS_TAX_AMT_LCL,
              SUM(A.SLS_EMP_DISC_AMT_LCL) SLS_EMP_DISC_AMT_LCL,
              0 SLS_TRX_COUNT,
              SUM(A.RET_QTY) RET_QTY,
              SUM(A.RET_AMT_LCL) RET_AMT_LCL,
              SUM(A.RET_PROFIT_AMT_LCL) RET_PROFIT_AMT_LCL,
              SUM(A.RET_MANUAL_MKDN_AMT_LCL) RET_MANUAL_MKDN_AMT_LCL,
              SUM(A.RET_MANUAL_MKUP_AMT_LCL) RET_MANUAL_MKUP_AMT_LCL,
              SUM(A.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
              SUM(A.RET_EMP_DISC_AMT_LCL) RET_EMP_DISC_AMT_LCL,
              0 RET_TRX_COUNT,
              MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
              MAX(A.DELETE_FLG) DELETE_FLG,
              MAX(A.DOC_CURR_CODE) DOC_CURR_CODE,
              MAX(A.ETL_PROC_WID) ETL_PROC_WID,
              MAX(A.GLOBAL1_EXCHANGE_RATE) GLOBAL1_EXCHANGE_RATE,
              MAX(A.GLOBAL2_EXCHANGE_RATE) GLOBAL2_EXCHANGE_RATE,
              MAX(A.GLOBAL3_EXCHANGE_RATE) GLOBAL3_EXCHANGE_RATE,
              MAX(SUBSTR(A.INTEGRATION_ID,
                         INSTR(A.INTEGRATION_ID, '~', 1, 1) + 1,
                         6) || '~' ||
                  SUBSTR(A.INTEGRATION_ID,
                         INSTR(A.INTEGRATION_ID, '~', 1, 2) + 1,
                         INSTR(A.INTEGRATION_ID, '~', 1, 3) -
                         INSTR(A.INTEGRATION_ID, '~', 1, 2) - 1) || '~' ||
                  A.RTL_TYPE_CODE || '~' || A.VOUCHER_FLG) INTEGRATION_ID,
              MAX(A.LOC_CURR_CODE) LOC_CURR_CODE,
              MAX(A.LOC_EXCHANGE_RATE) LOC_EXCHANGE_RATE,
              MAX(A.TENANT_ID) TENANT_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              MAX(A.X_CUSTOM) X_CUSTOM,
              A.BBG_RETAIL_TYPE_WID,
              MAX(A.BBG_CUSTOMER_COUNT) BBG_CUSTOMER_COUNT,
              MAX(A.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION,
              MAX(A.BBG_REFERENCE_DO1) BBG_REFERENCE_DO1,
              MAX(A.BBG_REFERENCE_DO2) BBG_REFERENCE_DO2,
              MAX(A.BBG_REFERENCE_DO3) BBG_REFERENCE_DO3,
              MAX(A.BBG_REFERENCE_DO4) BBG_REFERENCE_DO4,
              MAX(A.BBG_REFERENCE_DO5) BBG_REFERENCE_DO5,
              SUM(A.BBG_REFERENCE_FO1) BBG_REFERENCE_FO1,
              SUM(A.BBG_REFERENCE_FO2) BBG_REFERENCE_FO2,
              MAX(A.BBG_REFERENCE_FO3) BBG_REFERENCE_FO3,
              MAX(A.BBG_REFERENCE_FO4) BBG_REFERENCE_FO4,
              MAX(A.BBG_REFERENCE_FO5) BBG_REFERENCE_FO5,
              MAX(A.BBG_REFERENCE_FO6) BBG_REFERENCE_FO6,
              MAX(A.BBG_REFERENCE_FO7) BBG_REFERENCE_FO7,
              MAX(A.BBG_REFERENCE_FO8) BBG_REFERENCE_FO8,
              MAX(A.BBG_REFERENCE_FO9) BBG_REFERENCE_FO9,
              MAX(A.BBG_REFERENCE_FO10) BBG_REFERENCE_FO10
         FROM RADM.W_RTL_SLS_IT_LC_DY_A A
        WHERE A.DT_WID = &DT_WID
        GROUP BY A.ORG_WID,
                 A.DT_WID,
                 A.RTL_TYPE_WID,
                 A.VOUCHER_FLG,
                 A.BBG_RETAIL_TYPE_WID) S
ON (T.ORG_WID = S.ORG_WID and T.ORG_DH_WID = S.ORG_DH_WID and T.ORG_SCD1_WID = S.ORG_SCD1_WID and T.DT_WID = S.DT_WID and T.RTL_TYPE_WID = S.RTL_TYPE_WID and T.VOUCHER_FLG = S.VOUCHER_FLG and T.ETL_PROC_WID = S.ETL_PROC_WID and T.BBG_RETAIL_TYPE_WID = S.BBG_RETAIL_TYPE_WID)
when matched then
  update
     set T.DATASOURCE_NUM_ID        = S.DATASOURCE_NUM_ID,
         T.DELETE_FLG               = S.DELETE_FLG,
         T.DOC_CURR_CODE            = S.DOC_CURR_CODE,
         T.GLOBAL1_EXCHANGE_RATE    = S.GLOBAL1_EXCHANGE_RATE,
         T.GLOBAL2_EXCHANGE_RATE    = S.GLOBAL2_EXCHANGE_RATE,
         T.GLOBAL3_EXCHANGE_RATE    = S.GLOBAL3_EXCHANGE_RATE,
         T.INTEGRATION_ID           = S.INTEGRATION_ID,
         T.LOC_CURR_CODE            = S.LOC_CURR_CODE,
         T.LOC_EXCHANGE_RATE        = S.LOC_EXCHANGE_RATE,
         T.TENANT_ID                = S.TENANT_ID,
         T.W_INSERT_DT              = S.W_INSERT_DT,
         T.W_UPDATE_DT              = S.W_UPDATE_DT,
         T.X_CUSTOM                 = S.X_CUSTOM,
         T.BBG_CUSTOMER_COUNT       = S.BBG_CUSTOMER_COUNT,
         T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
         T.BBG_REFERENCE_DO1        = S.BBG_REFERENCE_DO1,
         T.BBG_REFERENCE_DO2        = S.BBG_REFERENCE_DO2,
         T.BBG_REFERENCE_DO3        = S.BBG_REFERENCE_DO3,
         T.BBG_REFERENCE_DO4        = S.BBG_REFERENCE_DO4,
         T.BBG_REFERENCE_DO5        = S.BBG_REFERENCE_DO5,
         T.BBG_REFERENCE_FO1        = S.BBG_REFERENCE_FO1,
         T.BBG_REFERENCE_FO2        = S.BBG_REFERENCE_FO2,
         T.BBG_REFERENCE_FO3        = S.BBG_REFERENCE_FO3,
         T.BBG_REFERENCE_FO4        = S.BBG_REFERENCE_FO4,
         T.BBG_REFERENCE_FO5        = S.BBG_REFERENCE_FO5,
         T.BBG_REFERENCE_FO6        = S.BBG_REFERENCE_FO6,
         T.BBG_REFERENCE_FO7        = S.BBG_REFERENCE_FO7,
         T.BBG_REFERENCE_FO8        = S.BBG_REFERENCE_FO8,
         T.BBG_REFERENCE_FO9        = S.BBG_REFERENCE_FO9,
         T.BBG_REFERENCE_FO10       = S.BBG_REFERENCE_FO10,
         T.SLS_QTY                  = S.SLS_QTY,
         T.SLS_AMT_LCL              = S.SLS_AMT_LCL,
         T.SLS_PROFIT_AMT_LCL       = S.SLS_PROFIT_AMT_LCL,
         T.SLS_MANUAL_MKDN_AMT_LCL  = S.SLS_MANUAL_MKDN_AMT_LCL,
         T.SLS_MANUAL_MKUP_AMT_LCL  = S.SLS_MANUAL_MKUP_AMT_LCL,
         T.SLS_TAX_AMT_LCL          = S.SLS_TAX_AMT_LCL,
         T.SLS_EMP_DISC_AMT_LCL     = S.SLS_EMP_DISC_AMT_LCL,
         T.SLS_TRX_COUNT            = S.SLS_TRX_COUNT,
         T.RET_QTY                  = S.RET_QTY,
         T.RET_AMT_LCL              = S.RET_AMT_LCL,
         T.RET_PROFIT_AMT_LCL       = S.RET_PROFIT_AMT_LCL,
         T.RET_MANUAL_MKDN_AMT_LCL  = S.RET_MANUAL_MKDN_AMT_LCL,
         T.RET_MANUAL_MKUP_AMT_LCL  = S.RET_MANUAL_MKUP_AMT_LCL,
         T.RET_TAX_AMT_LCL          = S.RET_TAX_AMT_LCL,
         T.RET_EMP_DISC_AMT_LCL     = S.RET_EMP_DISC_AMT_LCL,
         T.RET_TRX_COUNT            = S.RET_TRX_COUNT
when not matched then
  insert
    (T.ROW_WID,
     T.ORG_WID,
     T.ORG_DH_WID,
     T.ORG_SCD1_WID,
     T.DT_WID,
     T.RTL_TYPE_WID,
     T.VOUCHER_FLG,
     T.SLS_QTY,
     T.SLS_AMT_LCL,
     T.SLS_PROFIT_AMT_LCL,
     T.SLS_MANUAL_MKDN_AMT_LCL,
     T.SLS_MANUAL_MKUP_AMT_LCL,
     T.SLS_TAX_AMT_LCL,
     T.SLS_EMP_DISC_AMT_LCL,
     T.SLS_TRX_COUNT,
     T.RET_QTY,
     T.RET_AMT_LCL,
     T.RET_PROFIT_AMT_LCL,
     T.RET_MANUAL_MKDN_AMT_LCL,
     T.RET_MANUAL_MKUP_AMT_LCL,
     T.RET_TAX_AMT_LCL,
     T.RET_EMP_DISC_AMT_LCL,
     T.RET_TRX_COUNT,
     T.DATASOURCE_NUM_ID,
     T.DELETE_FLG,
     T.DOC_CURR_CODE,
     T.ETL_PROC_WID,
     T.GLOBAL1_EXCHANGE_RATE,
     T.GLOBAL2_EXCHANGE_RATE,
     T.GLOBAL3_EXCHANGE_RATE,
     T.INTEGRATION_ID,
     T.LOC_CURR_CODE,
     T.LOC_EXCHANGE_RATE,
     T.TENANT_ID,
     T.W_INSERT_DT,
     T.W_UPDATE_DT,
     T.X_CUSTOM,
     T.BBG_RETAIL_TYPE_WID,
     T.BBG_CUSTOMER_COUNT,
     T.BBG_SERVICE_SATISFACTION,
     T.BBG_REFERENCE_DO1,
     T.BBG_REFERENCE_DO2,
     T.BBG_REFERENCE_DO3,
     T.BBG_REFERENCE_DO4,
     T.BBG_REFERENCE_DO5,
     T.BBG_REFERENCE_FO1,
     T.BBG_REFERENCE_FO2,
     T.BBG_REFERENCE_FO3,
     T.BBG_REFERENCE_FO4,
     T.BBG_REFERENCE_FO5,
     T.BBG_REFERENCE_FO6,
     T.BBG_REFERENCE_FO7,
     T.BBG_REFERENCE_FO8,
     T.BBG_REFERENCE_FO9,
     T.BBG_REFERENCE_FO10)
  values
    (RADM.W_RTL_SLS_LC_DY_A_SEQ.NEXTVAL,
     S.ORG_WID,
     S.ORG_DH_WID,
     S.ORG_SCD1_WID,
     S.DT_WID,
     S.RTL_TYPE_WID,
     S.VOUCHER_FLG,
     S.SLS_QTY,
     S.SLS_AMT_LCL,
     S.SLS_PROFIT_AMT_LCL,
     S.SLS_MANUAL_MKDN_AMT_LCL,
     S.SLS_MANUAL_MKUP_AMT_LCL,
     S.SLS_TAX_AMT_LCL,
     S.SLS_EMP_DISC_AMT_LCL,
     S.SLS_TRX_COUNT,
     S.RET_QTY,
     S.RET_AMT_LCL,
     S.RET_PROFIT_AMT_LCL,
     S.RET_MANUAL_MKDN_AMT_LCL,
     S.RET_MANUAL_MKUP_AMT_LCL,
     S.RET_TAX_AMT_LCL,
     S.RET_EMP_DISC_AMT_LCL,
     S.RET_TRX_COUNT,
     S.DATASOURCE_NUM_ID,
     S.DELETE_FLG,
     S.DOC_CURR_CODE,
     S.ETL_PROC_WID,
     S.GLOBAL1_EXCHANGE_RATE,
     S.GLOBAL2_EXCHANGE_RATE,
     S.GLOBAL3_EXCHANGE_RATE,
     S.INTEGRATION_ID,
     S.LOC_CURR_CODE,
     S.LOC_EXCHANGE_RATE,
     S.TENANT_ID,
     S.W_INSERT_DT,
     S.W_UPDATE_DT,
     S.X_CUSTOM,
     S.BBG_RETAIL_TYPE_WID,
     S.BBG_CUSTOMER_COUNT,
     S.BBG_SERVICE_SATISFACTION,
     S.BBG_REFERENCE_DO1,
     S.BBG_REFERENCE_DO2,
     S.BBG_REFERENCE_DO3,
     S.BBG_REFERENCE_DO4,
     S.BBG_REFERENCE_DO5,
     S.BBG_REFERENCE_FO1,
     S.BBG_REFERENCE_FO2,
     S.BBG_REFERENCE_FO3,
     S.BBG_REFERENCE_FO4,
     S.BBG_REFERENCE_FO5,
     S.BBG_REFERENCE_FO6,
     S.BBG_REFERENCE_FO7,
     S.BBG_REFERENCE_FO8,
     S.BBG_REFERENCE_FO9,
     S.BBG_REFERENCE_FO10);
COMMIT;

--W_RTL_SLS_TRX_LC_DY_A
DELETE RADM.W_RTL_SLS_TRX_LC_DY_A T WHERE T.DT_WID = &DT_WID;
COMMIT;
--MERGE W_RTL_SLS_TRX_LC_DY_A
MERGE /*+ APPEND */
INTO RADM.W_RTL_SLS_TRX_LC_DY_A T
USING (SELECT A.ORG_WID,
              MAX(A.ORG_DH_WID) ORG_DH_WID,
              MAX(A.ORG_SCD1_WID) ORG_SCD1_WID,
              A.DT_WID,
              MAX(A.MIN_WID) MIN_WID,
              A.SLS_TRX_ID,
              MAX(A.VOUCHER_ID) VOUCHER_ID,
              MAX(A.EMPLOYEE_WID) EMPLOYEE_WID,
              SUM(A.SLS_QTY) SLS_QTY,
              SUM(A.SLS_AMT_LCL) SLS_AMT_LCL,
              SUM(A.SLS_PROFIT_AMT_LCL) SLS_PROFIT_AMT_LCL,
              SUM(A.SLS_MANUAL_MKDN_AMT_LCL) SLS_MANUAL_MKDN_AMT_LCL,
              SUM(A.SLS_MANUAL_MKUP_AMT_LCL) SLS_MANUAL_MKUP_AMT_LCL,
              SUM(A.SLS_TAX_AMT_LCL) SLS_TAX_AMT_LCL,
              SUM(A.SLS_EMP_DISC_AMT_LCL) SLS_EMP_DISC_AMT_LCL,
              SUM(A.SLS_MANUAL_COUNT) SLS_MANUAL_COUNT,
              SUM(A.SLS_SCAN_COUNT) SLS_SCAN_COUNT,
              SUM(A.RET_QTY) RET_QTY,
              SUM(A.RET_AMT_LCL) RET_AMT_LCL,
              SUM(A.RET_PROFIT_AMT_LCL) RET_PROFIT_AMT_LCL,
              SUM(A.RET_MANUAL_MKDN_AMT_LCL) RET_MANUAL_MKDN_AMT_LCL,
              SUM(A.RET_MANUAL_MKUP_AMT_LCL) RET_MANUAL_MKUP_AMT_LCL,
              SUM(A.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
              SUM(A.RET_EMP_DISC_AMT_LCL) RET_EMP_DISC_AMT_LCL,
              SUM(A.RET_MANUAL_COUNT) RET_MANUAL_COUNT,
              SUM(A.RET_SCAN_COUNT) RET_SCAN_COUNT,
              MAX(A.AUX1_CHANGED_ON_DT) AUX1_CHANGED_ON_DT,
              MAX(A.AUX2_CHANGED_ON_DT) AUX2_CHANGED_ON_DT,
              MAX(A.AUX3_CHANGED_ON_DT) AUX3_CHANGED_ON_DT,
              MAX(A.AUX4_CHANGED_ON_DT) AUX4_CHANGED_ON_DT,
              MAX(A.CHANGED_BY_WID) CHANGED_BY_WID,
              MAX(A.CHANGED_ON_DT) CHANGED_ON_DT,
              MAX(A.CREATED_BY_WID) CREATED_BY_WID,
              MAX(A.CREATED_ON_DT) CREATED_ON_DT,
              MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
              MAX(A.DELETE_FLG) DELETE_FLG,
              MAX(A.DOC_CURR_CODE) DOC_CURR_CODE,
              MAX(A.ETL_PROC_WID) ETL_PROC_WID,
              MAX(A.GLOBAL1_EXCHANGE_RATE) GLOBAL1_EXCHANGE_RATE,
              MAX(A.GLOBAL2_EXCHANGE_RATE) GLOBAL2_EXCHANGE_RATE,
              MAX(A.GLOBAL3_EXCHANGE_RATE) GLOBAL3_EXCHANGE_RATE,
              MAX(SUBSTR(A.INTEGRATION_ID,
                         1,
                         INSTR(A.INTEGRATION_ID, '~', 1, 1)) ||
                  SUBSTR(A.INTEGRATION_ID,
                         INSTR(A.INTEGRATION_ID, '~', 1, 2) + 1,
                         LENGTH(A.INTEGRATION_ID))) INTEGRATION_ID,
              MAX(A.LOC_CURR_CODE) LOC_CURR_CODE,
              MAX(A.LOC_EXCHANGE_RATE) LOC_EXCHANGE_RATE,
              MAX(A.TENANT_ID) TENANT_ID,
              SYSDATE W_INSERT_DT,
              SYSDATE W_UPDATE_DT,
              MAX(A.X_CUSTOM) X_CUSTOM,
              MAX(A.BBG_CUSTOMER_COUNT) BBG_CUSTOMER_COUNT,
              MAX(A.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION,
              MAX(A.SRC_REF_NO1) SRC_REF_NO1,
              MAX(A.SRC_REF_NO2) SRC_REF_NO2,
              MAX(A.SRC_REF_NO3) SRC_REF_NO3,
              MAX(A.SRC_REF_NO6) SRC_REF_NO6,
              MAX(A.SRC_REF_NO7) SRC_REF_NO7,
              MAX(A.SRC_REF_NO8) SRC_REF_NO8,
              MAX(A.BBG_REFERENCE_DO1) BBG_REFERENCE_DO1,
              MAX(A.BBG_REFERENCE_DO2) BBG_REFERENCE_DO2,
              MAX(A.BBG_REFERENCE_DO3) BBG_REFERENCE_DO3,
              MAX(A.BBG_REFERENCE_DO4) BBG_REFERENCE_DO4,
              MAX(A.BBG_REFERENCE_DO5) BBG_REFERENCE_DO5,
              SUM(A.BBG_REFERENCE_FO1) BBG_REFERENCE_FO1,
              SUM(A.BBG_REFERENCE_FO2) BBG_REFERENCE_FO2,
              MAX(A.BBG_REFERENCE_FO3) BBG_REFERENCE_FO3,
              MAX(A.BBG_REFERENCE_FO4) BBG_REFERENCE_FO4,
              MAX(A.BBG_REFERENCE_FO5) BBG_REFERENCE_FO5,
              MAX(A.BBG_REFERENCE_FO6) BBG_REFERENCE_FO6,
              MAX(A.BBG_REFERENCE_FO7) BBG_REFERENCE_FO7,
              MAX(A.BBG_REFERENCE_FO8) BBG_REFERENCE_FO8,
              MAX(A.BBG_REFERENCE_FO9) BBG_REFERENCE_FO9,
              MAX(A.BBG_REFERENCE_FO10) BBG_REFERENCE_FO10,
              MAX(HYK_NO) HYK_NO,
              SUM(VIP_SLS_QTY) VIP_SLS_QTY,
              SUM(VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
              SUM(VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
              SUM(VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
              SUM(VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
              SUM(VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
              SUM(VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
              SUM(VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
              SUM(VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
              SUM(VIP_RET_QTY) VIP_RET_QTY,
              SUM(VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
              SUM(VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
              SUM(VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
              SUM(VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
              SUM(VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
              SUM(VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
              SUM(VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
              SUM(VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT,
              --SUM(N69_NET_SALES_AMT),
              SUM(CASE
                    WHEN C.LVL6ANC_PRODCAT_ID IN (60,
                                                  61,
                                                  62,
                                                  63,
                                                  64,
                                                  65,
                                                  66,
                                                  67,
                                                  68,
                                                  69,
                                                  70,
                                                  71,
                                                  72,
                                                  73,
                                                  74,
                                                  75,
                                                  76,
                                                  77,
                                                  78,
                                                  79,
                                                  80,
                                                  81,
                                                  82,
                                                  83,
                                                  84,
                                                  85,
                                                  86,
                                                  87,
                                                  88,
                                                  89,
                                                  90,
                                                  91,
                                                  92,
                                                  93,
                                                  94,
                                                  95,
                                                  96,
                                                  97,
                                                  98,
                                                  99) THEN
                     (A.SLS_AMT_LCL - A.RET_AMT_LCL) -
                     (A.SLS_TAX_AMT_LCL - A.RET_TAX_AMT_LCL)
                    ELSE
                     0
                  END) N69_NET_SALES_AMT,
              --SUM(N69_NET_SALES_AMT_INC_TAX),
              SUM(CASE
                    WHEN C.LVL6ANC_PRODCAT_ID IN (60,
                                                  61,
                                                  62,
                                                  63,
                                                  64,
                                                  65,
                                                  66,
                                                  67,
                                                  68,
                                                  69,
                                                  70,
                                                  71,
                                                  72,
                                                  73,
                                                  74,
                                                  75,
                                                  76,
                                                  77,
                                                  78,
                                                  79,
                                                  80,
                                                  81,
                                                  82,
                                                  83,
                                                  84,
                                                  85,
                                                  86,
                                                  87,
                                                  88,
                                                  89,
                                                  90,
                                                  91,
                                                  92,
                                                  93,
                                                  94,
                                                  95,
                                                  96,
                                                  97,
                                                  98,
                                                  99) THEN
                     A.SLS_AMT_LCL - A.RET_AMT_LCL
                    ELSE
                     0
                  END) N69_NET_SALES_AMT_INC_TAX,
              --SUM(VIP_N69_NET_SALES_AMT),
              SUM(CASE
                    WHEN A.HYK_NO IS NOT NULL AND
                         C.LVL6ANC_PRODCAT_ID IN (60,
                                                  61,
                                                  62,
                                                  63,
                                                  64,
                                                  65,
                                                  66,
                                                  67,
                                                  68,
                                                  69,
                                                  70,
                                                  71,
                                                  72,
                                                  73,
                                                  74,
                                                  75,
                                                  76,
                                                  77,
                                                  78,
                                                  79,
                                                  80,
                                                  81,
                                                  82,
                                                  83,
                                                  84,
                                                  85,
                                                  86,
                                                  87,
                                                  88,
                                                  89,
                                                  90,
                                                  91,
                                                  92,
                                                  93,
                                                  94,
                                                  95,
                                                  96,
                                                  97,
                                                  98,
                                                  99) THEN
                     (A.SLS_AMT_LCL - A.RET_AMT_LCL) -
                     (A.RET_AMT_LCL - A.RET_TAX_AMT_LCL)
                    ELSE
                     0
                  END) VIP_N69_NET_SALES_AMT,
              --SUM(VIP_N69_NET_SALES_AMT_INC_TAX)
              SUM(CASE
                    WHEN A.HYK_NO IS NOT NULL AND
                         C.LVL6ANC_PRODCAT_ID IN (60,
                                                  61,
                                                  62,
                                                  63,
                                                  64,
                                                  65,
                                                  66,
                                                  67,
                                                  68,
                                                  69,
                                                  70,
                                                  71,
                                                  72,
                                                  73,
                                                  74,
                                                  75,
                                                  76,
                                                  77,
                                                  78,
                                                  79,
                                                  80,
                                                  81,
                                                  82,
                                                  83,
                                                  84,
                                                  85,
                                                  86,
                                                  87,
                                                  88,
                                                  89,
                                                  90,
                                                  91,
                                                  92,
                                                  93,
                                                  94,
                                                  95,
                                                  96,
                                                  97,
                                                  98,
                                                  99) THEN
                     A.SLS_AMT_LCL - A.RET_AMT_LCL
                    ELSE
                     0
                  END) VIP_N69_NET_SALES_AMT_INC_TAX
       
         FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F A,
              RADM.W_PRODUCT_D              P,
              RADM.W_PROD_CAT_DH            C
        WHERE A.PROD_WID = P.ROW_WID
          AND P.PROD_CAT5_WID_AS_WAS = C.ROW_WID
          AND A.DT_WID = &DT_WID
        GROUP BY A.ORG_WID, A.DT_WID, A.SLS_TRX_ID) S
ON (T.ORG_WID = S.ORG_WID and T.DT_WID = S.DT_WID and T.SLS_TRX_ID = S.SLS_TRX_ID)
when matched then
  update
     set T.SLS_QTY                       = S.SLS_QTY,
         T.SLS_AMT_LCL                   = S.SLS_AMT_LCL,
         T.SLS_PROFIT_AMT_LCL            = S.SLS_PROFIT_AMT_LCL,
         T.SLS_MANUAL_MKDN_AMT_LCL       = S.SLS_MANUAL_MKDN_AMT_LCL,
         T.SLS_MANUAL_MKUP_AMT_LCL       = S.SLS_MANUAL_MKUP_AMT_LCL,
         T.SLS_TAX_AMT_LCL               = S.SLS_TAX_AMT_LCL,
         T.SLS_EMP_DISC_AMT_LCL          = S.SLS_EMP_DISC_AMT_LCL,
         T.SLS_MANUAL_COUNT              = S.SLS_MANUAL_COUNT,
         T.SLS_SCAN_COUNT                = S.SLS_SCAN_COUNT,
         T.RET_QTY                       = S.RET_QTY,
         T.RET_AMT_LCL                   = S.RET_AMT_LCL,
         T.RET_PROFIT_AMT_LCL            = S.RET_PROFIT_AMT_LCL,
         T.RET_MANUAL_MKDN_AMT_LCL       = S.RET_MANUAL_MKDN_AMT_LCL,
         T.RET_MANUAL_MKUP_AMT_LCL       = S.RET_MANUAL_MKUP_AMT_LCL,
         T.RET_TAX_AMT_LCL               = S.RET_TAX_AMT_LCL,
         T.RET_EMP_DISC_AMT_LCL          = S.RET_EMP_DISC_AMT_LCL,
         T.RET_MANUAL_COUNT              = S.RET_MANUAL_COUNT,
         T.RET_SCAN_COUNT                = S.RET_SCAN_COUNT,
         T.CHANGED_BY_WID                = S.CHANGED_BY_WID,
         T.CHANGED_ON_DT                 = S.CHANGED_ON_DT,
         T.W_UPDATE_DT                   = S.W_UPDATE_DT,
         T.BBG_CUSTOMER_COUNT            = S.BBG_CUSTOMER_COUNT,
         T.BBG_SERVICE_SATISFACTION      = S.BBG_SERVICE_SATISFACTION,
         T.SRC_REF_NO1                   = S.SRC_REF_NO1,
         T.SRC_REF_NO2                   = S.SRC_REF_NO2,
         T.SRC_REF_NO3                   = S.SRC_REF_NO3,
         T.SRC_REF_NO6                   = S.SRC_REF_NO6,
         T.SRC_REF_NO7                   = S.SRC_REF_NO7,
         T.SRC_REF_NO8                   = S.SRC_REF_NO8,
         T.BBG_REFERENCE_DO1             = S.BBG_REFERENCE_DO1,
         T.BBG_REFERENCE_DO2             = S.BBG_REFERENCE_DO2,
         T.BBG_REFERENCE_DO3             = S.BBG_REFERENCE_DO3,
         T.BBG_REFERENCE_DO4             = S.BBG_REFERENCE_DO4,
         T.BBG_REFERENCE_DO5             = S.BBG_REFERENCE_DO5,
         T.BBG_REFERENCE_FO1             = S.BBG_REFERENCE_FO1,
         T.BBG_REFERENCE_FO2             = S.BBG_REFERENCE_FO2,
         T.BBG_REFERENCE_FO3             = S.BBG_REFERENCE_FO3,
         T.BBG_REFERENCE_FO4             = S.BBG_REFERENCE_FO4,
         T.BBG_REFERENCE_FO5             = S.BBG_REFERENCE_FO5,
         T.BBG_REFERENCE_FO6             = S.BBG_REFERENCE_FO6,
         T.BBG_REFERENCE_FO7             = S.BBG_REFERENCE_FO7,
         T.BBG_REFERENCE_FO8             = S.BBG_REFERENCE_FO8,
         T.BBG_REFERENCE_FO9             = S.BBG_REFERENCE_FO9,
         T.BBG_REFERENCE_FO10            = S.BBG_REFERENCE_FO10,
         T.HYK_NO                        = S.HYK_NO,
         T.VIP_SLS_QTY                   = S.VIP_SLS_QTY,
         T.VIP_SLS_AMT_LCL               = S.VIP_SLS_AMT_LCL,
         T.VIP_SLS_PROFIT_AMT_LCL        = S.VIP_SLS_PROFIT_AMT_LCL,
         T.VIP_SLS_MANUAL_MKDN_AMT_LCL   = S.VIP_SLS_MANUAL_MKDN_AMT_LCL,
         T.VIP_SLS_MANUAL_MKUP_AMT_LCL   = S.VIP_SLS_MANUAL_MKUP_AMT_LCL,
         T.VIP_SLS_TAX_AMT_LCL           = S.VIP_SLS_TAX_AMT_LCL,
         T.VIP_SLS_EMP_DISC_AMT_LCL      = S.VIP_SLS_EMP_DISC_AMT_LCL,
         T.VIP_SLS_MANUAL_COUNT          = S.VIP_SLS_MANUAL_COUNT,
         T.VIP_SLS_SCAN_COUNT            = S.VIP_SLS_SCAN_COUNT,
         T.VIP_RET_QTY                   = S.VIP_RET_QTY,
         T.VIP_RET_AMT_LCL               = S.VIP_RET_AMT_LCL,
         T.VIP_RET_PROFIT_AMT_LCL        = S.VIP_RET_PROFIT_AMT_LCL,
         T.VIP_RET_MANUAL_MKDN_AMT_LCL   = S.VIP_RET_MANUAL_MKDN_AMT_LCL,
         T.VIP_RET_MANUAL_MKUP_AMT_LCL   = S.VIP_RET_MANUAL_MKUP_AMT_LCL,
         T.VIP_RET_TAX_AMT_LCL           = S.VIP_RET_TAX_AMT_LCL,
         T.VIP_RET_EMP_DISC_AMT_LCL      = S.VIP_RET_EMP_DISC_AMT_LCL,
         T.VIP_RET_MANUAL_COUNT          = S.VIP_RET_MANUAL_COUNT,
         T.VIP_RET_SCAN_COUNT            = S.VIP_RET_SCAN_COUNT,
         T.N69_NET_SALES_AMT             = S.N69_NET_SALES_AMT,
         T.N69_NET_SALES_AMT_INC_TAX     = S.N69_NET_SALES_AMT_INC_TAX,
         T.VIP_N69_NET_SALES_AMT         = S.VIP_N69_NET_SALES_AMT,
         T.VIP_N69_NET_SALES_AMT_INC_TAX = S.VIP_N69_NET_SALES_AMT_INC_TAX
when not matched then
  insert
    (T.ROW_WID,
     T.ORG_WID,
     T.ORG_DH_WID,
     T.ORG_SCD1_WID,
     T.DT_WID,
     T.MIN_WID,
     T.SLS_TRX_ID,
     T.VOUCHER_ID,
     T.EMPLOYEE_WID,
     T.SLS_QTY,
     T.SLS_AMT_LCL,
     T.SLS_PROFIT_AMT_LCL,
     T.SLS_MANUAL_MKDN_AMT_LCL,
     T.SLS_MANUAL_MKUP_AMT_LCL,
     T.SLS_TAX_AMT_LCL,
     T.SLS_EMP_DISC_AMT_LCL,
     T.SLS_MANUAL_COUNT,
     T.SLS_SCAN_COUNT,
     T.RET_QTY,
     T.RET_AMT_LCL,
     T.RET_PROFIT_AMT_LCL,
     T.RET_MANUAL_MKDN_AMT_LCL,
     T.RET_MANUAL_MKUP_AMT_LCL,
     T.RET_TAX_AMT_LCL,
     T.RET_EMP_DISC_AMT_LCL,
     T.RET_MANUAL_COUNT,
     T.RET_SCAN_COUNT,
     T.AUX1_CHANGED_ON_DT,
     T.AUX2_CHANGED_ON_DT,
     T.AUX3_CHANGED_ON_DT,
     T.AUX4_CHANGED_ON_DT,
     T.CHANGED_BY_WID,
     T.CHANGED_ON_DT,
     T.CREATED_BY_WID,
     T.CREATED_ON_DT,
     T.DATASOURCE_NUM_ID,
     T.DELETE_FLG,
     T.DOC_CURR_CODE,
     T.ETL_PROC_WID,
     T.GLOBAL1_EXCHANGE_RATE,
     T.GLOBAL2_EXCHANGE_RATE,
     T.GLOBAL3_EXCHANGE_RATE,
     T.INTEGRATION_ID,
     T.LOC_CURR_CODE,
     T.LOC_EXCHANGE_RATE,
     T.TENANT_ID,
     T.W_INSERT_DT,
     T.W_UPDATE_DT,
     T.X_CUSTOM,
     T.BBG_CUSTOMER_COUNT,
     T.BBG_SERVICE_SATISFACTION,
     T.SRC_REF_NO1,
     T.SRC_REF_NO2,
     T.SRC_REF_NO3,
     T.SRC_REF_NO6,
     T.SRC_REF_NO7,
     T.SRC_REF_NO8,
     T.BBG_REFERENCE_DO1,
     T.BBG_REFERENCE_DO2,
     T.BBG_REFERENCE_DO3,
     T.BBG_REFERENCE_DO4,
     T.BBG_REFERENCE_DO5,
     T.BBG_REFERENCE_FO1,
     T.BBG_REFERENCE_FO2,
     T.BBG_REFERENCE_FO3,
     T.BBG_REFERENCE_FO4,
     T.BBG_REFERENCE_FO5,
     T.BBG_REFERENCE_FO6,
     T.BBG_REFERENCE_FO7,
     T.BBG_REFERENCE_FO8,
     T.BBG_REFERENCE_FO9,
     T.BBG_REFERENCE_FO10,
     T.HYK_NO,
     T.VIP_SLS_QTY,
     T.VIP_SLS_AMT_LCL,
     T.VIP_SLS_PROFIT_AMT_LCL,
     T.VIP_SLS_MANUAL_MKDN_AMT_LCL,
     T.VIP_SLS_MANUAL_MKUP_AMT_LCL,
     T.VIP_SLS_TAX_AMT_LCL,
     T.VIP_SLS_EMP_DISC_AMT_LCL,
     T.VIP_SLS_MANUAL_COUNT,
     T.VIP_SLS_SCAN_COUNT,
     T.VIP_RET_QTY,
     T.VIP_RET_AMT_LCL,
     T.VIP_RET_PROFIT_AMT_LCL,
     T.VIP_RET_MANUAL_MKDN_AMT_LCL,
     T.VIP_RET_MANUAL_MKUP_AMT_LCL,
     T.VIP_RET_TAX_AMT_LCL,
     T.VIP_RET_EMP_DISC_AMT_LCL,
     T.VIP_RET_MANUAL_COUNT,
     T.VIP_RET_SCAN_COUNT,
     T.N69_NET_SALES_AMT,
     T.N69_NET_SALES_AMT_INC_TAX,
     T.VIP_N69_NET_SALES_AMT,
     T.VIP_N69_NET_SALES_AMT_INC_TAX)
  values
    (RADM.W_RTL_SLS_LC_DY_A_SEQ.NEXTVAL,
     S.ORG_WID,
     S.ORG_DH_WID,
     S.ORG_SCD1_WID,
     S.DT_WID,
     S.MIN_WID,
     S.SLS_TRX_ID,
     S.VOUCHER_ID,
     S.EMPLOYEE_WID,
     S.SLS_QTY,
     S.SLS_AMT_LCL,
     S.SLS_PROFIT_AMT_LCL,
     S.SLS_MANUAL_MKDN_AMT_LCL,
     S.SLS_MANUAL_MKUP_AMT_LCL,
     S.SLS_TAX_AMT_LCL,
     S.SLS_EMP_DISC_AMT_LCL,
     S.SLS_MANUAL_COUNT,
     S.SLS_SCAN_COUNT,
     S.RET_QTY,
     S.RET_AMT_LCL,
     S.RET_PROFIT_AMT_LCL,
     S.RET_MANUAL_MKDN_AMT_LCL,
     S.RET_MANUAL_MKUP_AMT_LCL,
     S.RET_TAX_AMT_LCL,
     S.RET_EMP_DISC_AMT_LCL,
     S.RET_MANUAL_COUNT,
     S.RET_SCAN_COUNT,
     S.AUX1_CHANGED_ON_DT,
     S.AUX2_CHANGED_ON_DT,
     S.AUX3_CHANGED_ON_DT,
     S.AUX4_CHANGED_ON_DT,
     S.CHANGED_BY_WID,
     S.CHANGED_ON_DT,
     S.CREATED_BY_WID,
     S.CREATED_ON_DT,
     S.DATASOURCE_NUM_ID,
     S.DELETE_FLG,
     S.DOC_CURR_CODE,
     S.ETL_PROC_WID,
     S.GLOBAL1_EXCHANGE_RATE,
     S.GLOBAL2_EXCHANGE_RATE,
     S.GLOBAL3_EXCHANGE_RATE,
     S.INTEGRATION_ID,
     S.LOC_CURR_CODE,
     S.LOC_EXCHANGE_RATE,
     S.TENANT_ID,
     S.W_INSERT_DT,
     S.W_UPDATE_DT,
     S.X_CUSTOM,
     S.BBG_CUSTOMER_COUNT,
     S.BBG_SERVICE_SATISFACTION,
     S.SRC_REF_NO1,
     S.SRC_REF_NO2,
     S.SRC_REF_NO3,
     S.SRC_REF_NO6,
     S.SRC_REF_NO7,
     S.SRC_REF_NO8,
     S.BBG_REFERENCE_DO1,
     S.BBG_REFERENCE_DO2,
     S.BBG_REFERENCE_DO3,
     S.BBG_REFERENCE_DO4,
     S.BBG_REFERENCE_DO5,
     S.BBG_REFERENCE_FO1,
     S.BBG_REFERENCE_FO2,
     S.BBG_REFERENCE_FO3,
     S.BBG_REFERENCE_FO4,
     S.BBG_REFERENCE_FO5,
     S.BBG_REFERENCE_FO6,
     S.BBG_REFERENCE_FO7,
     S.BBG_REFERENCE_FO8,
     S.BBG_REFERENCE_FO9,
     S.BBG_REFERENCE_FO10,
     S.HYK_NO,
     S.VIP_SLS_QTY,
     S.VIP_SLS_AMT_LCL,
     S.VIP_SLS_PROFIT_AMT_LCL,
     S.VIP_SLS_MANUAL_MKDN_AMT_LCL,
     S.VIP_SLS_MANUAL_MKUP_AMT_LCL,
     S.VIP_SLS_TAX_AMT_LCL,
     S.VIP_SLS_EMP_DISC_AMT_LCL,
     S.VIP_SLS_MANUAL_COUNT,
     S.VIP_SLS_SCAN_COUNT,
     S.VIP_RET_QTY,
     S.VIP_RET_AMT_LCL,
     S.VIP_RET_PROFIT_AMT_LCL,
     S.VIP_RET_MANUAL_MKDN_AMT_LCL,
     S.VIP_RET_MANUAL_MKUP_AMT_LCL,
     S.VIP_RET_TAX_AMT_LCL,
     S.VIP_RET_EMP_DISC_AMT_LCL,
     S.VIP_RET_MANUAL_COUNT,
     S.VIP_RET_SCAN_COUNT,
     S.N69_NET_SALES_AMT,
     S.N69_NET_SALES_AMT_INC_TAX,
     S.VIP_N69_NET_SALES_AMT,
     S.VIP_N69_NET_SALES_AMT_INC_TAX);
COMMIT;

SELECT * FROM W_RTL_SLS_TRX_LC_DY_A;
