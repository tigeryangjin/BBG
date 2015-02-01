MERGE /*+APPEND*/
INTO RADM.W_RTL_SLS_DP_DY_CUR_A T
USING (SELECT /*+PARALLEL(A,20)*/
        A.PROD_DH_WID,
        A.DT_WID,
        A.RTL_TYPE_WID,
        SUM(A.SLS_QTY) SLS_QTY,
        SUM(A.SLS_AMT_LCL) SLS_AMT_LCL,
        SUM(A.SLS_PROFIT_AMT_LCL) SLS_PROFIT_AMT_LCL,
        SUM(A.SLS_TAX_AMT_LCL) SLS_TAX_AMT_LCL,
        SUM(A.SLS_EMP_DISC_AMT_LCL) SLS_EMP_DISC_AMT_LCL,
        SUM(A.SLS_MANUAL_MKDN_AMT_LCL) SLS_MANUAL_MKDN_AMT_LCL,
        SUM(A.SLS_MANUAL_MKUP_AMT_LCL) SLS_MANUAL_MKUP_AMT_LCL,
        SUM(A.RET_QTY) RET_QTY,
        SUM(A.RET_AMT_LCL) RET_AMT_LCL,
        SUM(A.RET_PROFIT_AMT_LCL) RET_PROFIT_AMT_LCL,
        SUM(A.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
        SUM(A.RET_EMP_DISC_AMT_LCL) RET_EMP_DISC_AMT_LCL,
        SUM(A.RET_MANUAL_MKDN_AMT_LCL) RET_MANUAL_MKDN_AMT_LCL,
        SUM(A.RET_MANUAL_MKUP_AMT_LCL) RET_MANUAL_MKUP_AMT_LCL,
        SUM(A.SLS_AMT_LCL) SLS_AMT,
        NULL SLS_AMT_GLOBAL1,
        NULL SLS_AMT_GLOBAL2,
        NULL SLS_AMT_GLOBAL3,
        SUM(A.SLS_PROFIT_AMT_LCL) SLS_PROFIT_AMT,
        NULL SLS_PROFIT_AMT_GLOBAL1,
        NULL SLS_PROFIT_AMT_GLOBAL2,
        NULL SLS_PROFIT_AMT_GLOBAL3,
        SUM(A.SLS_TAX_AMT_LCL) SLS_TAX_AMT,
        NULL SLS_TAX_AMT_GLOBAL1,
        NULL SLS_TAX_AMT_GLOBAL2,
        NULL SLS_TAX_AMT_GLOBAL3,
        SUM(A.SLS_EMP_DISC_AMT_LCL) SLS_EMP_DISC_AMT,
        NULL SLS_EMP_DISC_AMT_GLOBAL1,
        NULL SLS_EMP_DISC_AMT_GLOBAL2,
        NULL SLS_EMP_DISC_AMT_GLOBAL3,
        SUM(A.SLS_MANUAL_MKDN_AMT_LCL) SLS_MANUAL_MKDN_AMT,
        NULL SLS_MANUAL_MKDN_AMT_GLOBAL1,
        NULL SLS_MANUAL_MKDN_AMT_GLOBAL2,
        NULL SLS_MANUAL_MKDN_AMT_GLOBAL3,
        SUM(A.SLS_MANUAL_MKUP_AMT_LCL) SLS_MANUAL_MKUP_AMT,
        NULL SLS_MANUAL_MKUP_AMT_GLOBAL1,
        NULL SLS_MANUAL_MKUP_AMT_GLOBAL2,
        NULL SLS_MANUAL_MKUP_AMT_GLOBAL3,
        SUM(A.RET_AMT_LCL) RET_AMT,
        NULL RET_AMT_GLOBAL1,
        NULL RET_AMT_GLOBAL2,
        NULL RET_AMT_GLOBAL3,
        SUM(A.RET_PROFIT_AMT_LCL) RET_PROFIT_AMT,
        NULL RET_PROFIT_AMT_GLOBAL1,
        NULL RET_PROFIT_AMT_GLOBAL2,
        NULL RET_PROFIT_AMT_GLOBAL3,
        SUM(A.RET_TAX_AMT_LCL) RET_TAX_AMT,
        NULL RET_TAX_AMT_GLOBAL1,
        NULL RET_TAX_AMT_GLOBAL2,
        NULL RET_TAX_AMT_GLOBAL3,
        SUM(A.RET_EMP_DISC_AMT_LCL) RET_EMP_DISC_AMT,
        NULL RET_EMP_DISC_AMT_GLOBAL1,
        NULL RET_EMP_DISC_AMT_GLOBAL2,
        NULL RET_EMP_DISC_AMT_GLOBAL3,
        SUM(A.RET_MANUAL_MKDN_AMT_LCL) RET_MANUAL_MKDN_AMT,
        NULL RET_MANUAL_MKDN_AMT_GLOBAL1,
        NULL RET_MANUAL_MKDN_AMT_GLOBAL2,
        NULL RET_MANUAL_MKDN_AMT_GLOBAL3,
        SUM(A.RET_MANUAL_MKUP_AMT_LCL) RET_MANUAL_MKUP_AMT,
        NULL RET_MANUAL_MKUP_AMT_GLOBAL1,
        NULL RET_MANUAL_MKUP_AMT_GLOBAL2,
        NULL RET_MANUAL_MKUP_AMT_GLOBAL3,
        SUM(A.SLS_MANUAL_COUNT) SLS_MANUAL_COUNT,
        SUM(A.SLS_SCAN_COUNT) SLS_SCAN_COUNT,
        SUM(A.RET_MANUAL_COUNT) RET_MANUAL_COUNT,
        SUM(A.RET_SCAN_COUNT) RET_SCAN_COUNT,
        MAX(A.DATASOURCE_NUM_ID) DATASOURCE_NUM_ID,
        MAX(A.DELETE_FLG) DELETE_FLG,
        MAX(A.ETL_PROC_WID) ETL_PROC_WID,
        MAX(SUBSTR(A.INTEGRATION_ID, 1, 3) ||
            SUBSTR(A.INTEGRATION_ID, 10, 21)) INTEGRATION_ID,
        MAX(A.TENANT_ID) TENANT_ID,
        SYSDATE W_INSERT_DT,
        SYSDATE W_UPDATE_DT,
        MAX(A.X_CUSTOM) X_CUSTOM,
        A.BBG_RETAIL_TYPE_WID,
        SUM(A.BBG_CUSTOMER_COUNT) BBG_CUSTOMER_COUNT,
        SUM(A.BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION,
        MAX(A.BBG_REFERENCE_DO1) BBG_REFERENCE_DO1,
        MAX(A.BBG_REFERENCE_DO2) BBG_REFERENCE_DO2,
        MAX(A.BBG_REFERENCE_DO3) BBG_REFERENCE_DO3,
        MAX(A.BBG_REFERENCE_DO4) BBG_REFERENCE_DO4,
        MAX(A.BBG_REFERENCE_DO5) BBG_REFERENCE_DO5,
        SUM(A.BBG_REFERENCE_FO1) BBG_REFERENCE_FO1,
        SUM(A.BBG_REFERENCE_FO2) BBG_REFERENCE_FO2,
        SUM(A.BBG_REFERENCE_FO3) BBG_REFERENCE_FO3,
        SUM(A.BBG_REFERENCE_FO4) BBG_REFERENCE_FO4,
        SUM(A.BBG_REFERENCE_FO5) BBG_REFERENCE_FO5,
        SUM(A.BBG_REFERENCE_FO6) BBG_REFERENCE_FO6,
        SUM(A.BBG_REFERENCE_FO7) BBG_REFERENCE_FO7,
        SUM(A.BBG_REFERENCE_FO8) BBG_REFERENCE_FO8,
        SUM(A.BBG_REFERENCE_FO9) BBG_REFERENCE_FO9,
        SUM(A.BBG_REFERENCE_FO10) BBG_REFERENCE_FO10
         FROM RADM.W_RTL_SLS_DP_LC_DY_A A
        WHERE A.DT_WID BETWEEN 120140901000 AND 120140930000
        GROUP BY A.PROD_DH_WID,
                 A.DT_WID,
                 A.RTL_TYPE_WID,
                 A.BBG_RETAIL_TYPE_WID) S
ON (T.PROD_DH_WID = S.PROD_DH_WID AND T.DT_WID = S.DT_WID AND T.RTL_TYPE_WID = S.RTL_TYPE_WID AND T.BBG_RETAIL_TYPE_WID = S.BBG_RETAIL_TYPE_WID)
WHEN MATCHED THEN
  UPDATE
     SET T.SLS_QTY                     = S.SLS_QTY,
         T.SLS_AMT_LCL                 = S.SLS_AMT_LCL,
         T.SLS_PROFIT_AMT_LCL          = S.SLS_PROFIT_AMT_LCL,
         T.SLS_TAX_AMT_LCL             = S.SLS_TAX_AMT_LCL,
         T.SLS_EMP_DISC_AMT_LCL        = S.SLS_EMP_DISC_AMT_LCL,
         T.SLS_MANUAL_MKDN_AMT_LCL     = S.SLS_MANUAL_MKDN_AMT_LCL,
         T.SLS_MANUAL_MKUP_AMT_LCL     = S.SLS_MANUAL_MKUP_AMT_LCL,
         T.RET_QTY                     = S.RET_QTY,
         T.RET_AMT_LCL                 = S.RET_AMT_LCL,
         T.RET_PROFIT_AMT_LCL          = S.RET_PROFIT_AMT_LCL,
         T.RET_TAX_AMT_LCL             = S.RET_TAX_AMT_LCL,
         T.RET_EMP_DISC_AMT_LCL        = S.RET_EMP_DISC_AMT_LCL,
         T.RET_MANUAL_MKDN_AMT_LCL     = S.RET_MANUAL_MKDN_AMT_LCL,
         T.RET_MANUAL_MKUP_AMT_LCL     = S.RET_MANUAL_MKUP_AMT_LCL,
         T.SLS_AMT                     = S.SLS_AMT,
         T.SLS_AMT_GLOBAL1             = S.SLS_AMT_GLOBAL1,
         T.SLS_AMT_GLOBAL2             = S.SLS_AMT_GLOBAL2,
         T.SLS_AMT_GLOBAL3             = S.SLS_AMT_GLOBAL3,
         T.SLS_PROFIT_AMT              = S.SLS_PROFIT_AMT,
         T.SLS_PROFIT_AMT_GLOBAL1      = S.SLS_PROFIT_AMT_GLOBAL1,
         T.SLS_PROFIT_AMT_GLOBAL2      = S.SLS_PROFIT_AMT_GLOBAL2,
         T.SLS_PROFIT_AMT_GLOBAL3      = S.SLS_PROFIT_AMT_GLOBAL3,
         T.SLS_TAX_AMT                 = S.SLS_TAX_AMT,
         T.SLS_TAX_AMT_GLOBAL1         = S.SLS_TAX_AMT_GLOBAL1,
         T.SLS_TAX_AMT_GLOBAL2         = S.SLS_TAX_AMT_GLOBAL2,
         T.SLS_TAX_AMT_GLOBAL3         = S.SLS_TAX_AMT_GLOBAL3,
         T.SLS_EMP_DISC_AMT            = S.SLS_EMP_DISC_AMT,
         T.SLS_EMP_DISC_AMT_GLOBAL1    = S.SLS_EMP_DISC_AMT_GLOBAL1,
         T.SLS_EMP_DISC_AMT_GLOBAL2    = S.SLS_EMP_DISC_AMT_GLOBAL2,
         T.SLS_EMP_DISC_AMT_GLOBAL3    = S.SLS_EMP_DISC_AMT_GLOBAL3,
         T.SLS_MANUAL_MKDN_AMT         = S.SLS_MANUAL_MKDN_AMT,
         T.SLS_MANUAL_MKDN_AMT_GLOBAL1 = S.SLS_MANUAL_MKDN_AMT_GLOBAL1,
         T.SLS_MANUAL_MKDN_AMT_GLOBAL2 = S.SLS_MANUAL_MKDN_AMT_GLOBAL2,
         T.SLS_MANUAL_MKDN_AMT_GLOBAL3 = S.SLS_MANUAL_MKDN_AMT_GLOBAL3,
         T.SLS_MANUAL_MKUP_AMT         = S.SLS_MANUAL_MKUP_AMT,
         T.SLS_MANUAL_MKUP_AMT_GLOBAL1 = S.SLS_MANUAL_MKUP_AMT_GLOBAL1,
         T.SLS_MANUAL_MKUP_AMT_GLOBAL2 = S.SLS_MANUAL_MKUP_AMT_GLOBAL2,
         T.SLS_MANUAL_MKUP_AMT_GLOBAL3 = S.SLS_MANUAL_MKUP_AMT_GLOBAL3,
         T.RET_AMT                     = S.RET_AMT,
         T.RET_AMT_GLOBAL1             = S.RET_AMT_GLOBAL1,
         T.RET_AMT_GLOBAL2             = S.RET_AMT_GLOBAL2,
         T.RET_AMT_GLOBAL3             = S.RET_AMT_GLOBAL3,
         T.RET_PROFIT_AMT              = S.RET_PROFIT_AMT,
         T.RET_PROFIT_AMT_GLOBAL1      = S.RET_PROFIT_AMT_GLOBAL1,
         T.RET_PROFIT_AMT_GLOBAL2      = S.RET_PROFIT_AMT_GLOBAL2,
         T.RET_PROFIT_AMT_GLOBAL3      = S.RET_PROFIT_AMT_GLOBAL3,
         T.RET_TAX_AMT                 = S.RET_TAX_AMT,
         T.RET_TAX_AMT_GLOBAL1         = S.RET_TAX_AMT_GLOBAL1,
         T.RET_TAX_AMT_GLOBAL2         = S.RET_TAX_AMT_GLOBAL2,
         T.RET_TAX_AMT_GLOBAL3         = S.RET_TAX_AMT_GLOBAL3,
         T.RET_EMP_DISC_AMT            = S.RET_EMP_DISC_AMT,
         T.RET_EMP_DISC_AMT_GLOBAL1    = S.RET_EMP_DISC_AMT_GLOBAL1,
         T.RET_EMP_DISC_AMT_GLOBAL2    = S.RET_EMP_DISC_AMT_GLOBAL2,
         T.RET_EMP_DISC_AMT_GLOBAL3    = S.RET_EMP_DISC_AMT_GLOBAL3,
         T.RET_MANUAL_MKDN_AMT         = S.RET_MANUAL_MKDN_AMT,
         T.RET_MANUAL_MKDN_AMT_GLOBAL1 = S.RET_MANUAL_MKDN_AMT_GLOBAL1,
         T.RET_MANUAL_MKDN_AMT_GLOBAL2 = S.RET_MANUAL_MKDN_AMT_GLOBAL2,
         T.RET_MANUAL_MKDN_AMT_GLOBAL3 = S.RET_MANUAL_MKDN_AMT_GLOBAL3,
         T.RET_MANUAL_MKUP_AMT         = S.RET_MANUAL_MKUP_AMT,
         T.RET_MANUAL_MKUP_AMT_GLOBAL1 = S.RET_MANUAL_MKUP_AMT_GLOBAL1,
         T.RET_MANUAL_MKUP_AMT_GLOBAL2 = S.RET_MANUAL_MKUP_AMT_GLOBAL2,
         T.RET_MANUAL_MKUP_AMT_GLOBAL3 = S.RET_MANUAL_MKUP_AMT_GLOBAL3,
         T.SLS_MANUAL_COUNT            = S.SLS_MANUAL_COUNT,
         T.SLS_SCAN_COUNT              = S.SLS_SCAN_COUNT,
         T.RET_MANUAL_COUNT            = S.RET_MANUAL_COUNT,
         T.RET_SCAN_COUNT              = S.RET_SCAN_COUNT,
         T.DATASOURCE_NUM_ID           = S.DATASOURCE_NUM_ID,
         T.DELETE_FLG                  = S.DELETE_FLG,
         T.ETL_PROC_WID                = S.ETL_PROC_WID,
         T.INTEGRATION_ID              = S.INTEGRATION_ID,
         T.TENANT_ID                   = S.TENANT_ID,
         T.W_UPDATE_DT                 = S.W_UPDATE_DT,
         T.X_CUSTOM                    = S.X_CUSTOM,
         T.BBG_CUSTOMER_COUNT          = S.BBG_CUSTOMER_COUNT,
         T.BBG_SERVICE_SATISFACTION    = S.BBG_SERVICE_SATISFACTION,
         T.BBG_REFERENCE_DO1           = S.BBG_REFERENCE_DO1,
         T.BBG_REFERENCE_FO1           = S.BBG_REFERENCE_FO1,
         T.BBG_REFERENCE_FO2           = S.BBG_REFERENCE_FO2
WHEN NOT MATCHED THEN
  INSERT
    (T.ROW_WID,
     T.PROD_DH_WID,
     T.DT_WID,
     T.RTL_TYPE_WID,
     T.SLS_QTY,
     T.SLS_AMT_LCL,
     T.SLS_PROFIT_AMT_LCL,
     T.SLS_TAX_AMT_LCL,
     T.SLS_EMP_DISC_AMT_LCL,
     T.SLS_MANUAL_MKDN_AMT_LCL,
     T.SLS_MANUAL_MKUP_AMT_LCL,
     T.RET_QTY,
     T.RET_AMT_LCL,
     T.RET_PROFIT_AMT_LCL,
     T.RET_TAX_AMT_LCL,
     T.RET_EMP_DISC_AMT_LCL,
     T.RET_MANUAL_MKDN_AMT_LCL,
     T.RET_MANUAL_MKUP_AMT_LCL,
     T.SLS_AMT,
     T.SLS_AMT_GLOBAL1,
     T.SLS_AMT_GLOBAL2,
     T.SLS_AMT_GLOBAL3,
     T.SLS_PROFIT_AMT,
     T.SLS_PROFIT_AMT_GLOBAL1,
     T.SLS_PROFIT_AMT_GLOBAL2,
     T.SLS_PROFIT_AMT_GLOBAL3,
     T.SLS_TAX_AMT,
     T.SLS_TAX_AMT_GLOBAL1,
     T.SLS_TAX_AMT_GLOBAL2,
     T.SLS_TAX_AMT_GLOBAL3,
     T.SLS_EMP_DISC_AMT,
     T.SLS_EMP_DISC_AMT_GLOBAL1,
     T.SLS_EMP_DISC_AMT_GLOBAL2,
     T.SLS_EMP_DISC_AMT_GLOBAL3,
     T.SLS_MANUAL_MKDN_AMT,
     T.SLS_MANUAL_MKDN_AMT_GLOBAL1,
     T.SLS_MANUAL_MKDN_AMT_GLOBAL2,
     T.SLS_MANUAL_MKDN_AMT_GLOBAL3,
     T.SLS_MANUAL_MKUP_AMT,
     T.SLS_MANUAL_MKUP_AMT_GLOBAL1,
     T.SLS_MANUAL_MKUP_AMT_GLOBAL2,
     T.SLS_MANUAL_MKUP_AMT_GLOBAL3,
     T.RET_AMT,
     T.RET_AMT_GLOBAL1,
     T.RET_AMT_GLOBAL2,
     T.RET_AMT_GLOBAL3,
     T.RET_PROFIT_AMT,
     T.RET_PROFIT_AMT_GLOBAL1,
     T.RET_PROFIT_AMT_GLOBAL2,
     T.RET_PROFIT_AMT_GLOBAL3,
     T.RET_TAX_AMT,
     T.RET_TAX_AMT_GLOBAL1,
     T.RET_TAX_AMT_GLOBAL2,
     T.RET_TAX_AMT_GLOBAL3,
     T.RET_EMP_DISC_AMT,
     T.RET_EMP_DISC_AMT_GLOBAL1,
     T.RET_EMP_DISC_AMT_GLOBAL2,
     T.RET_EMP_DISC_AMT_GLOBAL3,
     T.RET_MANUAL_MKDN_AMT,
     T.RET_MANUAL_MKDN_AMT_GLOBAL1,
     T.RET_MANUAL_MKDN_AMT_GLOBAL2,
     T.RET_MANUAL_MKDN_AMT_GLOBAL3,
     T.RET_MANUAL_MKUP_AMT,
     T.RET_MANUAL_MKUP_AMT_GLOBAL1,
     T.RET_MANUAL_MKUP_AMT_GLOBAL2,
     T.RET_MANUAL_MKUP_AMT_GLOBAL3,
     T.SLS_MANUAL_COUNT,
     T.SLS_SCAN_COUNT,
     T.RET_MANUAL_COUNT,
     T.RET_SCAN_COUNT,
     T.DATASOURCE_NUM_ID,
     T.DELETE_FLG,
     T.ETL_PROC_WID,
     T.INTEGRATION_ID,
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
  VALUES
    (RADM.W_RTL_SLS_DP_DY_CUR_A_SEQ.NEXTVAL,
     S.PROD_DH_WID,
     S.DT_WID,
     S.RTL_TYPE_WID,
     S.SLS_QTY,
     S.SLS_AMT_LCL,
     S.SLS_PROFIT_AMT_LCL,
     S.SLS_TAX_AMT_LCL,
     S.SLS_EMP_DISC_AMT_LCL,
     S.SLS_MANUAL_MKDN_AMT_LCL,
     S.SLS_MANUAL_MKUP_AMT_LCL,
     S.RET_QTY,
     S.RET_AMT_LCL,
     S.RET_PROFIT_AMT_LCL,
     S.RET_TAX_AMT_LCL,
     S.RET_EMP_DISC_AMT_LCL,
     S.RET_MANUAL_MKDN_AMT_LCL,
     S.RET_MANUAL_MKUP_AMT_LCL,
     S.SLS_AMT,
     S.SLS_AMT_GLOBAL1,
     S.SLS_AMT_GLOBAL2,
     S.SLS_AMT_GLOBAL3,
     S.SLS_PROFIT_AMT,
     S.SLS_PROFIT_AMT_GLOBAL1,
     S.SLS_PROFIT_AMT_GLOBAL2,
     S.SLS_PROFIT_AMT_GLOBAL3,
     S.SLS_TAX_AMT,
     S.SLS_TAX_AMT_GLOBAL1,
     S.SLS_TAX_AMT_GLOBAL2,
     S.SLS_TAX_AMT_GLOBAL3,
     S.SLS_EMP_DISC_AMT,
     S.SLS_EMP_DISC_AMT_GLOBAL1,
     S.SLS_EMP_DISC_AMT_GLOBAL2,
     S.SLS_EMP_DISC_AMT_GLOBAL3,
     S.SLS_MANUAL_MKDN_AMT,
     S.SLS_MANUAL_MKDN_AMT_GLOBAL1,
     S.SLS_MANUAL_MKDN_AMT_GLOBAL2,
     S.SLS_MANUAL_MKDN_AMT_GLOBAL3,
     S.SLS_MANUAL_MKUP_AMT,
     S.SLS_MANUAL_MKUP_AMT_GLOBAL1,
     S.SLS_MANUAL_MKUP_AMT_GLOBAL2,
     S.SLS_MANUAL_MKUP_AMT_GLOBAL3,
     S.RET_AMT,
     S.RET_AMT_GLOBAL1,
     S.RET_AMT_GLOBAL2,
     S.RET_AMT_GLOBAL3,
     S.RET_PROFIT_AMT,
     S.RET_PROFIT_AMT_GLOBAL1,
     S.RET_PROFIT_AMT_GLOBAL2,
     S.RET_PROFIT_AMT_GLOBAL3,
     S.RET_TAX_AMT,
     S.RET_TAX_AMT_GLOBAL1,
     S.RET_TAX_AMT_GLOBAL2,
     S.RET_TAX_AMT_GLOBAL3,
     S.RET_EMP_DISC_AMT,
     S.RET_EMP_DISC_AMT_GLOBAL1,
     S.RET_EMP_DISC_AMT_GLOBAL2,
     S.RET_EMP_DISC_AMT_GLOBAL3,
     S.RET_MANUAL_MKDN_AMT,
     S.RET_MANUAL_MKDN_AMT_GLOBAL1,
     S.RET_MANUAL_MKDN_AMT_GLOBAL2,
     S.RET_MANUAL_MKDN_AMT_GLOBAL3,
     S.RET_MANUAL_MKUP_AMT,
     S.RET_MANUAL_MKUP_AMT_GLOBAL1,
     S.RET_MANUAL_MKUP_AMT_GLOBAL2,
     S.RET_MANUAL_MKUP_AMT_GLOBAL3,
     S.SLS_MANUAL_COUNT,
     S.SLS_SCAN_COUNT,
     S.RET_MANUAL_COUNT,
     S.RET_SCAN_COUNT,
     S.DATASOURCE_NUM_ID,
     S.DELETE_FLG,
     S.ETL_PROC_WID,
     S.INTEGRATION_ID,
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
