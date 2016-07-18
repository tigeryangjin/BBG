--2016.6.27，2016.6.28,2016.6.29,2016.6.30四天的销售存在问题，需要修复
--2016.6.27 已删除
--2016.6.28 已删除
--2016.6.29 已删除
--2016.6.30 已删除 FS
--1.删除销售数据
begin
  -- Call the procedure
  radm.bbg_ra_del_sls_dt(&DTWID);
end;

--2.清除ODI日志
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
TRUNCATE TABLE RADM.C_LOAD_DATES;

--3.
TRUNCATE TABLE RA_RMS.BBG_XTERN_RDWT;
INSERT /*+PARALLEL(16)*/
INTO RA_RMS.BBG_XTERN_RDWT
  SELECT /*+PARALLEL(16)*/
   *
    FROM RA_RMS.BBG_XTERN_RDWT_HIST
   WHERE BUSINESS_DT = &BUSINESS_DT;
COMMIT;

--4.清空tmp表
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

--5.修改BBG_RA_ITEM_LOC_SOH_V的日期为重导日期
SELECT * FROM RA_RMS.BBG_RA_ITEM_LOC_SOH_V;

--6.检查W_RTL_SLS_TRX_IT_LC_DY_FS
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;

--7.插入金立家电销售
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

--8.SIL

--9.PLP

--10.修复移动平台销售

