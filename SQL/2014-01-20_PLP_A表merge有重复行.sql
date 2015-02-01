 merge   /*+ APPEND */  into  
 RADM.W_RTL_SLS_IT_LC_DY_A T 
 using  
   (
   Select  /*+ APPEND */ 
   W_RTL_SLS_IT_LC_DY_TMP.PROD_IT_WID  PROD_WID,
  W_RTL_SLS_IT_LC_DY_TMP.PROD_SCD1_WID  PROD_SCD1_WID,
  W_RTL_SLS_IT_LC_DY_TMP.ORG_WID  ORG_WID,
  W_RTL_SLS_IT_LC_DY_TMP.ORG_SCD1_WID  ORG_SCD1_WID,
  W_RTL_SLS_IT_LC_DY_TMP.ORG_LC_WID  ORG_DH_WID,
  W_RTL_SLS_IT_LC_DY_TMP.DT_WID  DT_WID,
  W_RTL_SLS_IT_LC_DY_TMP.VOUCHER_FLG  VOUCHER_FLG,
  W_RTL_SLS_IT_LC_DY_TMP.RTL_TYPE_WID  RTL_TYPE_WID,
  W_RTL_SLS_IT_LC_DY_TMP.EMPLOYEE_WID  EMPLOYEE_WID,
  W_RTL_SLS_IT_LC_DY_TMP.RTL_TYPE_CODE  RTL_TYPE_CODE,
  W_RTL_SLS_IT_LC_DY_TMP.DATASOURCE_NUM_ID  DATASOURCE_NUM_ID,
  W_RTL_SLS_IT_LC_DY_TMP.DELETE_FLG  DELETE_FLG,
  W_RTL_SLS_IT_LC_DY_TMP.DOC_CURR_CODE  DOC_CURR_CODE,
  100  ETL_PROC_WID,
  W_RTL_SLS_IT_LC_DY_TMP.GLOBAL1_EXCHANGE_RATE  GLOBAL1_EXCHANGE_RATE,
  W_RTL_SLS_IT_LC_DY_TMP.GLOBAL2_EXCHANGE_RATE  GLOBAL2_EXCHANGE_RATE,
  W_RTL_SLS_IT_LC_DY_TMP.GLOBAL3_EXCHANGE_RATE  GLOBAL3_EXCHANGE_RATE,
  W_RTL_SLS_IT_LC_DY_TMP.PROD_IT_NUM||'~'||W_RTL_SLS_IT_LC_DY_TMP.ORG_NUM||'~'||W_RTL_SLS_IT_LC_DY_TMP.DAY_DT||'~'||W_RTL_SLS_IT_LC_DY_TMP.RTL_TYPE_CODE  INTEGRATION_ID,
  W_RTL_SLS_IT_LC_DY_TMP.LOC_CURR_CODE  LOC_CURR_CODE,
  W_RTL_SLS_IT_LC_DY_TMP.LOC_EXCHANGE_RATE  LOC_EXCHANGE_RATE,
  W_RTL_SLS_IT_LC_DY_TMP.TENANT_ID  TENANT_ID,
  SYSDATE  W_INSERT_DT,
  SYSDATE  W_UPDATE_DT,
  W_RTL_SLS_IT_LC_DY_TMP.X_CUSTOM  X_CUSTOM,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_ITEM_LOC_WID  BBG_ITEM_LOC_WID,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_RETAIL_TYPE_WID  BBG_RETAIL_TYPE_WID,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_CUSTOMER_COUNT  BBG_CUSTOMER_COUNT,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_SERVICE_SATISFACTION  BBG_SERVICE_SATISFACTION,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_DO1  BBG_REFERENCE_DO1,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_DO2  BBG_REFERENCE_DO2,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_DO3  BBG_REFERENCE_DO3,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_DO4  BBG_REFERENCE_DO4,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_DO5  BBG_REFERENCE_DO5,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO1  BBG_REFERENCE_FO1,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO2  BBG_REFERENCE_FO2,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO3  BBG_REFERENCE_FO3,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO4  BBG_REFERENCE_FO4,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO5  BBG_REFERENCE_FO5,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO6  BBG_REFERENCE_FO6,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO7  BBG_REFERENCE_FO7,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO8  BBG_REFERENCE_FO8,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO8  BBG_REFERENCE_FO9,
  W_RTL_SLS_IT_LC_DY_TMP.BBG_REFERENCE_FO10  BBG_REFERENCE_FO10
   ,W_RTL_SLS_IT_LC_DY_TMP.SLS_QTY  SLS_QTY,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_AMT_LCL  SLS_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_PROFIT_AMT_LCL  SLS_PROFIT_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_MANUAL_MKDN_AMT_LCL  SLS_MANUAL_MKDN_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_MANUAL_MKUP_AMT_LCL  SLS_MANUAL_MKUP_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_TAX_AMT_LCL  SLS_TAX_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_EMP_DISC_AMT_LCL  SLS_EMP_DISC_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_MANUAL_COUNT  SLS_MANUAL_COUNT,
  W_RTL_SLS_IT_LC_DY_TMP.SLS_SCAN_COUNT  SLS_SCAN_COUNT,
  W_RTL_SLS_IT_LC_DY_TMP.RET_QTY  RET_QTY,
  W_RTL_SLS_IT_LC_DY_TMP.RET_AMT_LCL  RET_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.RET_PROFIT_AMT_LCL  RET_PROFIT_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.RET_MANUAL_MKDN_AMT_LCL  RET_MANUAL_MKDN_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.RET_MANUAL_MKUP_AMT_LCL  RET_MANUAL_MKUP_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.RET_TAX_AMT_LCL  RET_TAX_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.RET_EMP_DISC_AMT_LCL  RET_EMP_DISC_AMT_LCL,
  W_RTL_SLS_IT_LC_DY_TMP.RET_MANUAL_COUNT  RET_MANUAL_COUNT,
  W_RTL_SLS_IT_LC_DY_TMP.RET_SCAN_COUNT  RET_SCAN_COUNT
   From RABATCHER.W_RTL_SLS_IT_LC_DY_TMP   W_RTL_SLS_IT_LC_DY_TMP
        Where  (1=1)
  
  
  
  
   ) S
 on  (
     T.PROD_WID=S.PROD_WID
  and    T.ORG_WID=S.ORG_WID
  and    T.DT_WID=S.DT_WID
  and    T.VOUCHER_FLG=S.VOUCHER_FLG
  and    T.RTL_TYPE_WID=S.RTL_TYPE_WID
  and    T.BBG_ITEM_LOC_WID=S.BBG_ITEM_LOC_WID
  and    T.BBG_RETAIL_TYPE_WID=S.BBG_RETAIL_TYPE_WID
   )
 when matched
 then update set
   T.PROD_SCD1_WID = S.PROD_SCD1_WID,
  T.ORG_SCD1_WID = S.ORG_SCD1_WID,
  T.ORG_DH_WID = S.ORG_DH_WID,
  T.EMPLOYEE_WID = S.EMPLOYEE_WID,
  T.RTL_TYPE_CODE = S.RTL_TYPE_CODE,
  T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID,
  T.DELETE_FLG = S.DELETE_FLG,
  T.DOC_CURR_CODE = S.DOC_CURR_CODE,
  T.ETL_PROC_WID = S.ETL_PROC_WID,
  T.GLOBAL1_EXCHANGE_RATE = S.GLOBAL1_EXCHANGE_RATE,
  T.GLOBAL2_EXCHANGE_RATE = S.GLOBAL2_EXCHANGE_RATE,
  T.GLOBAL3_EXCHANGE_RATE = S.GLOBAL3_EXCHANGE_RATE,
  T.INTEGRATION_ID = S.INTEGRATION_ID,
  T.LOC_CURR_CODE = S.LOC_CURR_CODE,
  T.LOC_EXCHANGE_RATE = S.LOC_EXCHANGE_RATE,
  T.TENANT_ID = S.TENANT_ID,
  T.W_INSERT_DT = S.W_INSERT_DT,
  T.W_UPDATE_DT = S.W_UPDATE_DT,
  T.X_CUSTOM = S.X_CUSTOM,
  T.BBG_CUSTOMER_COUNT = S.BBG_CUSTOMER_COUNT,
  T.BBG_SERVICE_SATISFACTION = S.BBG_SERVICE_SATISFACTION,
  T.BBG_REFERENCE_DO1 = S.BBG_REFERENCE_DO1,
  T.BBG_REFERENCE_DO2 = S.BBG_REFERENCE_DO2,
  T.BBG_REFERENCE_DO3 = S.BBG_REFERENCE_DO3,
  T.BBG_REFERENCE_DO4 = S.BBG_REFERENCE_DO4,
  T.BBG_REFERENCE_DO5 = S.BBG_REFERENCE_DO5,
  T.BBG_REFERENCE_FO1 = S.BBG_REFERENCE_FO1,
  T.BBG_REFERENCE_FO2 = S.BBG_REFERENCE_FO2,
  T.BBG_REFERENCE_FO3 = S.BBG_REFERENCE_FO3,
  T.BBG_REFERENCE_FO4 = S.BBG_REFERENCE_FO4,
  T.BBG_REFERENCE_FO5 = S.BBG_REFERENCE_FO5,
  T.BBG_REFERENCE_FO6 = S.BBG_REFERENCE_FO6,
  T.BBG_REFERENCE_FO7 = S.BBG_REFERENCE_FO7,
  T.BBG_REFERENCE_FO8 = S.BBG_REFERENCE_FO8,
  T.BBG_REFERENCE_FO9 = S.BBG_REFERENCE_FO9,
  T.BBG_REFERENCE_FO10 = S.BBG_REFERENCE_FO10
   ,T.SLS_QTY = S.SLS_QTY + T.SLS_QTY,
  T.SLS_AMT_LCL = S.SLS_AMT_LCL + T.SLS_AMT_LCL,
  T.SLS_PROFIT_AMT_LCL = S.SLS_PROFIT_AMT_LCL + T.SLS_PROFIT_AMT_LCL,
  T.SLS_MANUAL_MKDN_AMT_LCL = S.SLS_MANUAL_MKDN_AMT_LCL + T.SLS_MANUAL_MKDN_AMT_LCL,
  T.SLS_MANUAL_MKUP_AMT_LCL = S.SLS_MANUAL_MKUP_AMT_LCL + T.SLS_MANUAL_MKUP_AMT_LCL,
  T.SLS_TAX_AMT_LCL = S.SLS_TAX_AMT_LCL + T.SLS_TAX_AMT_LCL,
  T.SLS_EMP_DISC_AMT_LCL = S.SLS_EMP_DISC_AMT_LCL + T.SLS_EMP_DISC_AMT_LCL,
  T.SLS_MANUAL_COUNT = S.SLS_MANUAL_COUNT + T.SLS_MANUAL_COUNT,
  T.SLS_SCAN_COUNT = S.SLS_SCAN_COUNT + T.SLS_SCAN_COUNT,
  T.RET_QTY = S.RET_QTY + T.RET_QTY,
  T.RET_AMT_LCL = S.RET_AMT_LCL + T.RET_AMT_LCL,
  T.RET_PROFIT_AMT_LCL = S.RET_PROFIT_AMT_LCL + T.RET_PROFIT_AMT_LCL,
  T.RET_MANUAL_MKDN_AMT_LCL = S.RET_MANUAL_MKDN_AMT_LCL + T.RET_MANUAL_MKDN_AMT_LCL,
  T.RET_MANUAL_MKUP_AMT_LCL = S.RET_MANUAL_MKUP_AMT_LCL + T.RET_MANUAL_MKUP_AMT_LCL,
  T.RET_TAX_AMT_LCL = S.RET_TAX_AMT_LCL + T.RET_TAX_AMT_LCL,
  T.RET_EMP_DISC_AMT_LCL = S.RET_EMP_DISC_AMT_LCL + T.RET_EMP_DISC_AMT_LCL,
  T.RET_MANUAL_COUNT = S.RET_MANUAL_COUNT + T.RET_MANUAL_COUNT,
  T.RET_SCAN_COUNT = S.RET_SCAN_COUNT + T.RET_SCAN_COUNT
  
 when not matched
 then insert
   (
   
    T.ROW_WID
                ,T.PROD_WID,
  T.PROD_SCD1_WID,
  T.ORG_WID,
  T.ORG_SCD1_WID,
  T.ORG_DH_WID,
  T.DT_WID,
  T.VOUCHER_FLG,
  T.RTL_TYPE_WID,
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
  T.RTL_TYPE_CODE,
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
  T.BBG_ITEM_LOC_WID,
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
  T.BBG_REFERENCE_FO10
  
     
   )
 values
   (
  
    RADM.W_RTL_SLS_IT_LC_DY_A_SEQ.nextval
    ,S.PROD_WID,
  S.PROD_SCD1_WID,
  S.ORG_WID,
  S.ORG_SCD1_WID,
  S.ORG_DH_WID,
  S.DT_WID,
  S.VOUCHER_FLG,
  S.RTL_TYPE_WID,
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
  S.RTL_TYPE_CODE,
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
  S.BBG_ITEM_LOC_WID,
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
  S.BBG_REFERENCE_FO10
  
   
  )
