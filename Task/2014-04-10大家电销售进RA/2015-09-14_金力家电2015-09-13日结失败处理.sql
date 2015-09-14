--**********************************************************************************************************
--1.
--**********************************************************************************************************
--商品销售
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
--供应商销售
SELECT * FROM RADM.BBG_RA_SLS_IT_LC_DY_FS;

--销售接口
SELECT * FROM BBG_RA_SLS_TRX_JL_V@RA_JL WHERE DAY_DT = DATE '2015-09-13';
--供应商销售接口
SELECT * FROM BBG_RA_SUPP_SLS_JL_V@RA_JL WHERE DAY_DT = DATE '2015-09-13';

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
*/
--供应商销售清单表
/*
  BBG_RA_SUPP_SALES_IT_LC_DY_F
  BBG_RA_SLS_SC_LC_DY_CUR_A
  BBG_RA_SLS_SC_LC_DY_A
  BBG_RA_SLS_SC_DY_CUR_A
  BBG_RA_SLS_SC_DY_A
  BBG_RA_SLS_LC_DY_A
  BBG_RA_SLS_IT_LC_DY_SN_A
  BBG_RA_SLS_IT_LC_DY_A
  BBG_RA_SLS_IT_DY_SN_A
  BBG_RA_SLS_IT_DY_A
  BBG_RA_SLS_DP_LC_DY_CUR_A
  BBG_RA_SLS_DP_LC_DY_A
  BBG_RA_SLS_DP_DY_CUR_A
  BBG_RA_SLS_CL_LC_DY_CUR_A
  BBG_RA_SLS_CL_LC_DY_A
  BBG_RA_SLS_CL_DY_CUR_A
*/
--删除商品销售汇总表
DELETE RADM.W_RTL_SLS_TRX_IT_LC_DY_F A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM BBG_RA_SLS_TRX_JL_V@RA_JL B
         WHERE B.DAY_DT = DATE '2015-09-13'
           AND A.SLS_TRX_ID = B.SLS_TRX_ID);
COMMIT;
DELETE RADM.W_RTL_SLS_CL_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_CL_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_CL_LC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_DP_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_DP_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_DP_LC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE RADM.W_RTL_SLS_IT_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE RADM.W_RTL_SLS_IT_DY_SN_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE RADM.W_RTL_SLS_IT_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE RADM.W_RTL_SLS_IT_LC_DY_SN_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;

DELETE RADM.W_RTL_SLS_SC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_SC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_SC_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.W_RTL_SLS_SC_LC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

--删除供应商销售汇总表
DELETE RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;
DELETE RADM.BBG_RA_SLS_SC_LC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_SC_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_SC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_SC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;

DELETE RADM.BBG_RA_SLS_IT_LC_DY_SN_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;
DELETE RADM.BBG_RA_SLS_IT_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;
DELETE RADM.BBG_RA_SLS_IT_DY_SN_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;
DELETE RADM.BBG_RA_SLS_IT_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PRODUCT_D C
         WHERE A.PROD_WID = C.ROW_WID
           AND SUBSTR(C.PROD_CAT5, 3, 2) IN (70, 71, 72, 73, 74, 77, 78, 79)
           AND C.PROD_NUM LIKE '24%');
COMMIT;
DELETE RADM.BBG_RA_SLS_DP_LC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_DP_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_DP_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_CL_LC_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_CL_LC_DY_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
          FROM RADM.W_PROD_CAT_DH B
         WHERE A.PROD_DH_WID = B.ROW_WID
           AND B.LVL7ANC_PRODCAT_ID IN (70, 71, 72, 73, 74, 77, 78, 79));
COMMIT;
DELETE RADM.BBG_RA_SLS_CL_DY_CUR_A A
 WHERE A.DT_WID = 120150913000
   AND EXISTS
 (SELECT 1
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
    FROM RADM.BBG_RA_SLS_TRX_JL_V T;
--供应商销售
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
   WHERE T.DAY_DT = TRUNC(SYSDATE - 1);
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
--BBG.CMX.RA.F20_SUPP_SALES 

--**********************************************************************************************************
--6.处理W_RTL_SLS_LC_DY_A,BBG_RA_SLS_LC_DY_A
--**********************************************************************************************************
DELETE RADM.W_RTL_SLS_LC_DY_A T WHERE T.DT_WID = 120150913000;
COMMIT;
DELETE RADM.BBG_RA_SLS_LC_DY_A T WHERE T.DT_WID = 120150913000;
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
        WHERE A.DT_WID BETWEEN &BDTWID AND &EDTWID
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

--MERGE BBG_RA_SLS_LC_DY_A
merge /*+ APPEND */
into RADM.BBG_RA_SLS_LC_DY_A T
using (Select /*+ APPEND */
        BBG_RA_SLS_LC_DY_TMP.ORG_WID ORG_WID,
        MAX(BBG_RA_SLS_LC_DY_TMP.ORG_DH_WID) ORG_DH_WID,
        MAX(BBG_RA_SLS_LC_DY_TMP.ORG_SCD1_WID) ORG_SCD1_WID,
        BBG_RA_SLS_LC_DY_TMP.DT_WID DT_WID,
        BBG_RA_SLS_LC_DY_TMP.SUPPLIER_WID SUPPLIER_WID,
        MAX(BBG_RA_SLS_LC_DY_TMP.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
        MAX(BBG_RA_SLS_LC_DY_TMP.DELETE_FLG) DELETE_FLG,
        MAX(BBG_RA_SLS_LC_DY_TMP.DOC_CURR_CODE) DOC_CURR_CODE,
        100 ETL_PROC_WID,
        MAX(BBG_RA_SLS_LC_DY_TMP.GLOBAL1_EXCHANGE_RATE) GLOBAL1_EXCHANGE_RATE,
        MAX(BBG_RA_SLS_LC_DY_TMP.GLOBAL2_EXCHANGE_RATE) GLOBAL2_EXCHANGE_RATE,
        MAX(BBG_RA_SLS_LC_DY_TMP.GLOBAL3_EXCHANGE_RATE) GLOBAL3_EXCHANGE_RATE,
        MAX(SUBSTR(BBG_RA_SLS_LC_DY_TMP.INTEGRATION_ID,
                   INSTR(BBG_RA_SLS_LC_DY_TMP.INTEGRATION_ID, '~', 1, 1) + 1,
                   6) || '~' ||
            SUBSTR(BBG_RA_SLS_LC_DY_TMP.INTEGRATION_ID,
                   INSTR(BBG_RA_SLS_LC_DY_TMP.INTEGRATION_ID, '~', 1, 2) + 1,
                   INSTR(BBG_RA_SLS_LC_DY_TMP.INTEGRATION_ID, '~', 1, 3) + 8 - 1)) INTEGRATION_ID,
        MAX(BBG_RA_SLS_LC_DY_TMP.LOC_CURR_CODE) LOC_CURR_CODE,
        MAX(BBG_RA_SLS_LC_DY_TMP.LOC_EXCHANGE_RATE) LOC_EXCHANGE_RATE,
        MAX(BBG_RA_SLS_LC_DY_TMP.TENANT_ID) TENANT_ID,
        SYSDATE W_INSERT_DT,
        SYSDATE W_UPDATE_DT,
        MAX(BBG_RA_SLS_LC_DY_TMP.X_CUSTOM) X_CUSTOM,
        BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_DO1 BBG_REFERENCE_DO1,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_DO2) BBG_REFERENCE_DO2,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_DO3) BBG_REFERENCE_DO3,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_DO4) BBG_REFERENCE_DO4,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_DO5) BBG_REFERENCE_DO5,
        sum(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO1) BBG_REFERENCE_FO1,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO2) BBG_REFERENCE_FO2,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO3) BBG_REFERENCE_FO3,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO4) BBG_REFERENCE_FO4,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO5) BBG_REFERENCE_FO5,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO6) BBG_REFERENCE_FO6,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO7) BBG_REFERENCE_FO7,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO8) BBG_REFERENCE_FO8,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO9) BBG_REFERENCE_FO9,
        MAX(BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_FO10) BBG_REFERENCE_FO10,
        SUM(BBG_RA_SLS_LC_DY_TMP.SUPP_SALES_QTY) SUPP_SALES_QTY,
        SUM(BBG_RA_SLS_LC_DY_TMP.SUPP_SALES_COST) SUPP_SALES_COST,
        SUM(BBG_RA_SLS_LC_DY_TMP.SUPP_SALES_AMT) SUPP_SALES_AMT
         From RADM.BBG_RA_SLS_IT_LC_DY_A BBG_RA_SLS_LC_DY_TMP
        Where (1 = 1)
				AND BBG_RA_SLS_LC_DY_TMP.DT_WID BETWEEN &BDTWID AND &EDTWID
        Group By BBG_RA_SLS_LC_DY_TMP.ORG_WID,
                 BBG_RA_SLS_LC_DY_TMP.DT_WID,
                 BBG_RA_SLS_LC_DY_TMP.SUPPLIER_WID,
                 BBG_RA_SLS_LC_DY_TMP.BBG_REFERENCE_DO1
       
       ) S
on (T.ORG_WID = S.ORG_WID and T.ORG_DH_WID = S.ORG_DH_WID and T.DT_WID = S.DT_WID and T.SUPPLIER_WID = S.SUPPLIER_WID)
when matched then
  update
     set T.ORG_SCD1_WID          = S.ORG_SCD1_WID,
         T.DATASOURCE_NUM_ID     = S.DATASOURCE_NUM_ID,
         T.DELETE_FLG            = S.DELETE_FLG,
         T.DOC_CURR_CODE         = S.DOC_CURR_CODE,
         T.ETL_PROC_WID          = S.ETL_PROC_WID,
         T.GLOBAL1_EXCHANGE_RATE = S.GLOBAL1_EXCHANGE_RATE,
         T.GLOBAL2_EXCHANGE_RATE = S.GLOBAL2_EXCHANGE_RATE,
         T.GLOBAL3_EXCHANGE_RATE = S.GLOBAL3_EXCHANGE_RATE,
         T.INTEGRATION_ID        = S.INTEGRATION_ID,
         T.LOC_CURR_CODE         = S.LOC_CURR_CODE,
         T.LOC_EXCHANGE_RATE     = S.LOC_EXCHANGE_RATE,
         T.TENANT_ID             = S.TENANT_ID,
         T.W_INSERT_DT           = S.W_INSERT_DT,
         T.W_UPDATE_DT           = S.W_UPDATE_DT,
         T.X_CUSTOM              = S.X_CUSTOM,
         T.BBG_REFERENCE_DO1     = S.BBG_REFERENCE_DO1,
         T.BBG_REFERENCE_DO2     = S.BBG_REFERENCE_DO2,
         T.BBG_REFERENCE_DO3     = S.BBG_REFERENCE_DO3,
         T.BBG_REFERENCE_DO4     = S.BBG_REFERENCE_DO4,
         T.BBG_REFERENCE_DO5     = S.BBG_REFERENCE_DO5,
         T.BBG_REFERENCE_FO1     = S.BBG_REFERENCE_FO1,
         T.BBG_REFERENCE_FO2     = S.BBG_REFERENCE_FO2,
         T.BBG_REFERENCE_FO3     = S.BBG_REFERENCE_FO3,
         T.BBG_REFERENCE_FO4     = S.BBG_REFERENCE_FO4,
         T.BBG_REFERENCE_FO5     = S.BBG_REFERENCE_FO5,
         T.BBG_REFERENCE_FO6     = S.BBG_REFERENCE_FO6,
         T.BBG_REFERENCE_FO7     = S.BBG_REFERENCE_FO7,
         T.BBG_REFERENCE_FO8     = S.BBG_REFERENCE_FO8,
         T.BBG_REFERENCE_FO9     = S.BBG_REFERENCE_FO9,
         T.BBG_REFERENCE_FO10    = S.BBG_REFERENCE_FO10,
         T.SUPP_SALES_QTY        = T.SUPP_SALES_QTY,
         T.SUPP_SALES_COST       = T.SUPP_SALES_COST,
         T.SUPP_SALES_AMT        = T.SUPP_SALES_AMT
  

when not matched then
  insert
    (
     
     T.ROW_WID,
     T.ORG_WID,
     T.ORG_DH_WID,
     T.ORG_SCD1_WID,
     T.DT_WID,
     T.SUPP_SALES_QTY,
     T.SUPP_SALES_COST,
     T.SUPP_SALES_AMT,
     T.SUPPLIER_WID,
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
     T.BBG_REFERENCE_FO10
     
     )
  values
    (
     
     RADM.BBG_RA_SLS_LC_DY_A_SEQ.NEXTVAL,
     S.ORG_WID,
     S.ORG_DH_WID,
     S.ORG_SCD1_WID,
     S.DT_WID,
     S.SUPP_SALES_QTY,
     S.SUPP_SALES_COST,
     S.SUPP_SALES_AMT,
     S.SUPPLIER_WID,
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
     S.BBG_REFERENCE_FO10
     
     );

SELECT * FROM RADM.BBG_RA_SLS_IT_LC_DY_A;
SELECT * FROM RADM.BBG_RA_SLS_LC_DY_A;
