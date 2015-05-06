--1. ÷π§SQL insert into W_RTL_SLS_TRX_IT_LC_DY_TMP
insert into RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP T
  (ORG_WID,
   ORG_LC_WID,
   ORG_DS_WID,
   ORG_RG_WID,
   ORG_AR_WID,
   ORG_CH_WID,
   ORG_NUM,
   ORG_DS_NUM,
   ORG_RG_NUM,
   ORG_AR_NUM,
   ORG_CH_NUM,
   ORG_SCD1_WID,
   PROD_SCD1_WID,
   PROD_IT_WID,
   PROD_SC_WID,
   PROD_CL_WID,
   PROD_DP_WID,
   PROD_GP_WID,
   PROD_DV_WID,
   PROD_IT_NUM,
   PROD_SC_NUM,
   PROD_CL_NUM,
   PROD_DP_NUM,
   PROD_GP_NUM,
   PROD_DV_NUM,
   SLS_TRX_ID,
   VOUCHER_ID,
   RTL_TYPE_WID,
   RTL_TYPE_CODE,
   DT_WID,
   DAY_DT,
   MIN_WID,
   MIN_NUM,
   WK_WID,
   WK_NUM,
   PR_WID,
   PR_NUM,
   QT_WID,
   QT_NUM,
   SLS_QTY,
   SLS_AMT_LCL,
   SLS_PROFIT_AMT_LCL,
   SLS_MANUAL_MKDN_AMT_LCL,
   SLS_MANUAL_MKUP_AMT_LCL,
   SLS_TAX_AMT_LCL,
   SLS_EMP_DISC_AMT_LCL,
   SLS_MANUAL_COUNT,
   SLS_SCAN_COUNT,
   RET_QTY,
   RET_AMT_LCL,
   RET_PROFIT_AMT_LCL,
   RET_MANUAL_MKDN_AMT_LCL,
   RET_MANUAL_MKUP_AMT_LCL,
   RET_TAX_AMT_LCL,
   RET_EMP_DISC_AMT_LCL,
   RET_MANUAL_COUNT,
   RET_SCAN_COUNT,
   DOC_CURR_CODE,
   LOC_CURR_CODE,
   LOC_EXCHANGE_RATE,
   GLOBAL1_EXCHANGE_RATE,
   GLOBAL2_EXCHANGE_RATE,
   GLOBAL3_EXCHANGE_RATE,
   CREATED_BY_ID,
   CHANGED_BY_ID,
   DELETE_FLG,
   DATASOURCE_NUM_ID,
   TENANT_ID,
   X_CUSTOM,
   ETL_THREAD_VAL,
   BBG_ITEM_LOC_WID,
   BBG_RETAIL_TYPE_ID,
   BBG_RETAIL_TYPE_WID,
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
   HYK_NO,
   EMPLOYEE_WID,
   CREATED_ON_DT,
   CHANGED_ON_DT)
  select W_INT_ORG_D_RTL_TMP.ORG_WID,
         W_INT_ORG_DH_RTL_TMP.ORG_LC_WID,
         W_INT_ORG_DH_RTL_TMP.ORG_DS_WID,
         W_INT_ORG_DH_RTL_TMP.ORG_RG_WID,
         W_INT_ORG_DH_RTL_TMP.ORG_AR_WID,
         W_INT_ORG_DH_RTL_TMP.ORG_CH_WID,
         W_INT_ORG_DH_RTL_TMP.ORG_NUM,
         W_INT_ORG_DH_RTL_TMP.ORG_DS_NUM,
         W_INT_ORG_DH_RTL_TMP.ORG_RG_NUM,
         W_INT_ORG_DH_RTL_TMP.ORG_AR_NUM,
         W_INT_ORG_DH_RTL_TMP.ORG_CH_NUM,
         W_INT_ORG_DH_RTL_TMP.ORG_SCD1_WID,
         W_PRODUCT_D_RTL_TMP.PROD_SCD1_WID,
         W_PRODUCT_D_RTL_TMP.PROD_IT_WID,
         W_PRODUCT_D_RTL_TMP.PROD_SC_WID,
         W_PRODUCT_D_RTL_TMP.PROD_CL_WID,
         W_PRODUCT_D_RTL_TMP.PROD_DP_WID,
         W_PRODUCT_D_RTL_TMP.PROD_GP_WID,
         W_PRODUCT_D_RTL_TMP.PROD_DV_WID,
         W_PRODUCT_D_RTL_TMP.PROD_IT_NUM,
         W_PRODUCT_D_RTL_TMP.PROD_SC_NUM,
         W_PRODUCT_D_RTL_TMP.PROD_CL_NUM,
         W_PRODUCT_D_RTL_TMP.PROD_DP_NUM,
         W_PRODUCT_D_RTL_TMP.PROD_GP_NUM,
         W_PRODUCT_D_RTL_TMP.PROD_DV_NUM,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TRX_ID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.VOUCHER_ID,
         W_XACT_TYPE_D.ROW_WID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RTL_TYPE_CODE,
         W_MCAL_DAY_D.ROW_WID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT,
         W_MINUTE_OF_DAY_D.ROW_WID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.MIN_NUM,
         W_MCAL_WEEK_D.ROW_WID,
         W_MCAL_WEEK_D.MCAL_YEAR || W_MCAL_WEEK_D.MCAL_WEEK,
         W_MCAL_DAY_D.MCAL_PERIOD_WID,
         W_MCAL_DAY_D.MCAL_YEAR || W_MCAL_DAY_D.MCAL_PERIOD,
         W_MCAL_DAY_D.MCAL_QTR_WID,
         W_MCAL_DAY_D.MCAL_YEAR || W_MCAL_DAY_D.MCAL_QTR,
         0 SLS_QTY, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_QTY,
         0 SLS_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_AMT_LCL,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_PROFIT_AMT_LCL -
         STF.SLS_PROFIT_AMT_LCL SLS_PROFIT_AMT_LCL,
         0 SLS_MANUAL_MKDN_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_MANUAL_MKDN_AMT_LCL,
         0 SLS_MANUAL_MKUP_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_MANUAL_MKUP_AMT_LCL,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TAX_AMT_LCL -
         STF.SLS_TAX_AMT_LCL SLS_TAX_AMT_LCL,
         0 SLS_EMP_DISC_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_EMP_DISC_AMT_LCL,
         0 SLS_MANUAL_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_MANUAL_COUNT,
         0 SLS_SCAN_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_SCAN_COUNT,
         0 RET_QTY, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_QTY,
         0 RET_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_AMT_LCL,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_PROFIT_AMT_LCL -
         STF.RET_PROFIT_AMT_LCL RET_PROFIT_AMT_LCL,
         0 RET_MANUAL_MKDN_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_MANUAL_MKDN_AMT_LCL,
         0 RET_MANUAL_MKUP_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_MANUAL_MKUP_AMT_LCL,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_TAX_AMT_LCL -
         STF.RET_TAX_AMT_LCL RET_TAX_AMT_LCL,
         0 RET_EMP_DISC_AMT_LCL, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_EMP_DISC_AMT_LCL,
         0 RET_MANUAL_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_MANUAL_COUNT,
         0 RET_SCAN_COUNT, --STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_SCAN_COUNT,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE,
         (CASE
           WHEN STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE =
                STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
            1.0
           ELSE
            (SELECT EX_RT.EXCH_RATE
               FROM RADM.W_EXCH_RATE_G EX_RT
              WHERE EX_RT.W_FROM_CURCY_CODE =
                    STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                AND EX_RT.W_TO_CURCY_CODE =
                    STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE
                AND EX_RT.START_DT <=
                    STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                AND EX_RT.END_DT > STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.DEFAULT_LOC_RATE_TYPE
                AND EX_RT.DATASOURCE_NUM_ID =
                    STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID)
         
         END),
         (CASE
           WHEN W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE IS NULL THEN
            NULL
           ELSE
            (CASE
              WHEN W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE =
                   STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
               1.0
              ELSE
               (CASE
                 WHEN W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE =
                      STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE AND
                      NOT STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE IS NULL THEN
                  STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE
                 ELSE
                  (SELECT EX_RT.EXCH_RATE
                     FROM RADM.W_EXCH_RATE_G EX_RT
                    WHERE EX_RT.W_FROM_CURCY_CODE =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                      AND EX_RT.W_TO_CURCY_CODE = W_GLOBAL_CURR_G.GLOBAL1_CURR_CODE
                      AND EX_RT.START_DT <=
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                      AND EX_RT.END_DT > STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                      AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.GLOBAL1_RATE_TYPE
                      AND EX_RT.DATASOURCE_NUM_ID =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID
                   
                   )
               
               END)
            
            END)
         
         END),
         (CASE
           WHEN W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE IS NULL THEN
            NULL
           ELSE
            (CASE
              WHEN W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE =
                   STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
               1.0
              ELSE
               (CASE
                 WHEN W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE =
                      STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE AND
                      NOT STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE IS NULL THEN
                  STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE
                 ELSE
                  (SELECT EX_RT.EXCH_RATE
                     FROM RADM.W_EXCH_RATE_G EX_RT
                    WHERE EX_RT.W_FROM_CURCY_CODE =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                      AND EX_RT.W_TO_CURCY_CODE = W_GLOBAL_CURR_G.GLOBAL2_CURR_CODE
                      AND EX_RT.START_DT <=
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                      AND EX_RT.END_DT > STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                      AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.GLOBAL2_RATE_TYPE
                      AND EX_RT.DATASOURCE_NUM_ID =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID
                   
                   )
               
               END)
            
            END)
         
         END),
         (CASE
           WHEN W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE IS NULL THEN
            NULL
           ELSE
            (CASE
              WHEN W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE =
                   STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE THEN
               1.0
              ELSE
               (CASE
                 WHEN W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE =
                      STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_CURR_CODE AND
                      NOT STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE IS NULL THEN
                  STG_W_RTL_SLS_TRX_IT_LC_DY_FS.LOC_EXCHANGE_RATE
                 ELSE
                  (SELECT EX_RT.EXCH_RATE
                     FROM RADM.W_EXCH_RATE_G EX_RT
                    WHERE EX_RT.W_FROM_CURCY_CODE =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DOC_CURR_CODE
                      AND EX_RT.W_TO_CURCY_CODE = W_GLOBAL_CURR_G.GLOBAL3_CURR_CODE
                      AND EX_RT.START_DT <=
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                      AND EX_RT.END_DT > STG_W_RTL_SLS_TRX_IT_LC_DY_FS.EXCHANGE_DT
                      AND EX_RT.RATE_TYPE = W_GLOBAL_CURR_G.GLOBAL3_RATE_TYPE
                      AND EX_RT.DATASOURCE_NUM_ID =
                          STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID
                   
                   )
               
               END)
            
            END)
         
         END),
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.CREATED_BY_ID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.CHANGED_BY_ID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DELETE_FLG,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.TENANT_ID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.X_CUSTOM,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ETL_THREAD_VAL,
         BBG_RA_ITEM_LOC_D.ROW_WID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_RETAIL_TYPE_ID,
         BBG_RA_RETAIL_TYPE_D.ROW_WID,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_SERVICE_SATISFACTION,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO1,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO2,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO3,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO6,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO7,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SRC_REF_NO8,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO1,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO2,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO3,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO4,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_DO5,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO1,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO2,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO3,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO4,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO5,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO6,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO7,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO8,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO9,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_REFERENCE_FO10,
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.HYK_NO,
         1,
         SYSDATE,
         SYSDATE
    from RADM.W_GLOBAL_CURR_G W_GLOBAL_CURR_G,
         RABATCHER.W_INT_ORG_DH_RTL_TMP W_INT_ORG_DH_RTL_TMP,
         RABATCHER.W_PRODUCT_D_RTL_TMP W_PRODUCT_D_RTL_TMP,
         RADM.W_MCAL_WEEK_D W_MCAL_WEEK_D,
         RADM.W_MCAL_DAY_D W_MCAL_DAY_D,
         RADM.W_XACT_TYPE_D W_XACT_TYPE_D,
         RADM.W_MCAL_CONTEXT_G W_MCAL_CONTEXT_G,
         RABATCHER.W_INT_ORG_D_RTL_TMP W_INT_ORG_D_RTL_TMP,
         RADM.BBG_RA_RETAIL_TYPE_D BBG_RA_RETAIL_TYPE_D,
         RADM.BBG_RA_ITEM_LOC_D BBG_RA_ITEM_LOC_D,
         RADM.W_MINUTE_OF_DAY_D W_MINUTE_OF_DAY_D,
         (SELECT T.SLS_TRX_ID,
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
                     AND L.SCENARIO_NAME =
                         'SDE_BBG_RETAIL_SALESTRANSACTIONFACT') ETL_THREAD_VAL,
                 NULL GLOBAL1_EXCHANGE_RATE,
                 NULL GLOBAL2_EXCHANGE_RATE,
                 NULL GLOBAL3_EXCHANGE_RATE,
                 T.SLS_TRX_ID || '~' || T.PROD_IT_NUM || '~-1~' ||
                 TO_CHAR(T.DAY_DT,
                         'DD-MON-YY',
                         'NLS_DATE_LANGUAGE = American') INTEGRATION_ID,
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
                   WHERE DAY_DT BETWEEN &BDATE AND &EDATE) T) STG_W_RTL_SLS_TRX_IT_LC_DY_FS,
         RADM.W_RTL_SLS_TRX_IT_LC_DY_F STF
   where (1 = 1)
     AND STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TRX_ID = STF.SLS_TRX_ID(+)
     AND W_INT_ORG_D_RTL_TMP.ORG_WID = STF.ORG_WID(+)
     AND W_PRODUCT_D_RTL_TMP.PROD_IT_WID = STF.PROD_WID(+)
     And (W_MCAL_DAY_D.MCAL_CAL_WID = W_MCAL_CONTEXT_G.MCAL_CAL_WID)
     AND (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID =
         W_MCAL_CONTEXT_G.DATASOURCE_NUM_ID)
     AND (W_MCAL_CONTEXT_G.MCAL_CAL_WID = W_MCAL_WEEK_D.MCAL_CAL_WID)
     AND (((LPAD(W_MINUTE_OF_DAY_D.HOUR_24_NUM, 2, '0') ||
         LPAD(W_MINUTE_OF_DAY_D.MINUTE_NUM, 2, '0')) =
         LPAD(STG_W_RTL_SLS_TRX_IT_LC_DY_FS.MIN_NUM, 4, '0')) AND
         W_MINUTE_OF_DAY_D.DATASOURCE_NUM_ID =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID)
     AND (BBG_RA_RETAIL_TYPE_D.RETAIL_TYPE_ID =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.BBG_RETAIL_TYPE_ID)
     AND (BBG_RA_ITEM_LOC_D.ITEM =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.PROD_IT_NUM AND
         BBG_RA_ITEM_LOC_D.LOC = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM and
         (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT between
         BBG_RA_ITEM_LOC_D.EFFECTIVE_FROM_DT and
         BBG_RA_ITEM_LOC_D.EFFECTIVE_TO_DT))
     AND ((((W_MCAL_DAY_D.MCAL_DAY_DT BETWEEN
         W_MCAL_WEEK_D.MCAL_WEEK_START_DT AND
         W_MCAL_WEEK_D.MCAL_WEEK_END_DT)) AND
         W_MCAL_DAY_D.DATASOURCE_NUM_ID = W_MCAL_WEEK_D.DATASOURCE_NUM_ID))
     AND ((W_PRODUCT_D_RTL_TMP.PROD_IT_NUM =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.PROD_IT_NUM) AND
         W_PRODUCT_D_RTL_TMP.SRC_EFF_FROM_DT <=
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT AND
         W_PRODUCT_D_RTL_TMP.SRC_EFF_TO_DT >=
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
     AND ((W_MCAL_DAY_D.DATASOURCE_NUM_ID =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID) AND
         W_MCAL_DAY_D.MCAL_DAY_DT = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
     AND (W_XACT_TYPE_D.DATASOURCE_NUM_ID =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID AND
         W_XACT_TYPE_D.W_XACT_CAT_CODE = 'RETAIL_TRAN_TYPE' and
         W_XACT_TYPE_D.W_XACT_TYPE_CODE =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RTL_TYPE_CODE)
     AND ((W_INT_ORG_DH_RTL_TMP.ORG_NUM =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM) AND
         W_INT_ORG_DH_RTL_TMP.EFFECTIVE_FROM_DT <=
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT AND
         W_INT_ORG_DH_RTL_TMP.EFFECTIVE_TO_DT >=
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
     AND ((W_INT_ORG_D_RTL_TMP.ORG_NUM =
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM) AND
         W_INT_ORG_D_RTL_TMP.EFFECTIVE_FROM_DT <=
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT AND
         W_INT_ORG_D_RTL_TMP.EFFECTIVE_TO_DT >=
         STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT)
     AND (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DATASOURCE_NUM_ID =
         W_GLOBAL_CURR_G.DATASOURCE_NUM_ID)
     AND EXISTS
   (SELECT 1
            FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F F,
                 RADM.W_PRODUCT_D              P,
                 RADM.W_INT_ORG_D              O
           WHERE F.PROD_WID = P.ROW_WID
             AND F.ORG_WID = O.ROW_WID
             AND F.SLS_TRX_ID = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TRX_ID
             AND P.PROD_NUM = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.PROD_IT_NUM
             AND O.ORG_NUM = STG_W_RTL_SLS_TRX_IT_LC_DY_FS.ORG_NUM
             AND F.DT_WID = '1' || TO_CHAR(STG_W_RTL_SLS_TRX_IT_LC_DY_FS.DAY_DT,
                                           'YYYYMMDD') || '000'
             AND F.DT_WID BETWEEN
                 '1' || TO_CHAR(&BDATE, 'YYYYMMDD') || '000' AND
                 '1' || TO_CHAR(&EDATE, 'YYYYMMDD') || '000'
             AND F.BBG_SERVICE_SATISFACTION = 3.5
             AND ABS((STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_AMT_LCL -
                     STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_AMT_LCL) -
                     (STG_W_RTL_SLS_TRX_IT_LC_DY_FS.SLS_TAX_AMT_LCL -
                     STG_W_RTL_SLS_TRX_IT_LC_DY_FS.RET_TAX_AMT_LCL)) <>
                 ABS((F.SLS_AMT_LCL - F.RET_AMT_LCL) -
                     (F.SLS_TAX_AMT_LCL - F.RET_TAX_AMT_LCL)));

--2.UPDATE F
UPDATE RADM.W_RTL_SLS_TRX_IT_LC_DY_F A
   SET (A.SLS_PROFIT_AMT_LCL,
        A.SLS_TAX_AMT_LCL,
        A.RET_PROFIT_AMT_LCL,
        A.RET_TAX_AMT_LCL) =
       (SELECT B.SLS_PROFIT_AMT_LCL,
               B.SLS_TAX_AMT_LCL,
               B.RET_PROFIT_AMT_LCL,
               B.RET_TAX_AMT_LCL
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
                 WHERE DAY_DT BETWEEN &BDATE AND &EDATE) B,
               RADM.W_INT_ORG_D O,
               RADM.W_PRODUCT_D P
         WHERE B.PROD_IT_NUM = P.PROD_NUM
           AND B.DAY_DT BETWEEN P.EFFECTIVE_FROM_DT AND P.EFFECTIVE_TO_DT
           AND O.ORG_NUM = B.ORG_NUM
           AND B.DAY_DT BETWEEN O.EFFECTIVE_FROM_DT AND O.EFFECTIVE_TO_DT
           AND A.SLS_TRX_ID = B.SLS_TRX_ID
           AND A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID
           AND (NVL(A.SLS_PROFIT_AMT_LCL, 0) + NVL(A.SLS_TAX_AMT_LCL, 0)
                NVL(A.RET_PROFIT_AMT_LCL, 0)
                NVL(A.RET_TAX_AMT_LCL, 0) <>
                NVL(B.SLS_PROFIT_AMT_LCL, 0) + NVL(B.SLS_TAX_AMT_LCL, 0)
                NVL(B.RET_PROFIT_AMT_LCL, 0) NVL(B.RET_TAX_AMT_LCL, 0)));
