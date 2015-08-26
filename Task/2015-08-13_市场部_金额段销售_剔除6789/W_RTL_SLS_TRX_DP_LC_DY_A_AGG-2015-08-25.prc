CREATE OR REPLACE PROCEDURE W_RTL_SLS_TRX_DP_LC_DY_A_AGG(BDTWID INT,
                                                         EDTWID INT) IS

BEGIN

  BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK';
    INSERT /*+PARALLEL(16)*/
    INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK
      SELECT *
        FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F
       WHERE DT_WID BETWEEN BDTWID AND EDTWID;
    COMMIT;
  END;

  BEGIN
    INSERT /*+PARALLEL(16)*/
    INTO RADM.W_RTL_SLS_TRX_DP_LC_DY_A
      SELECT /*+PARALLEL(16)*/
       W_RTL_SLS_TRX_DP_LC_DY_A_SEQ.NEXTVAL ROW_WID, A.*
        FROM (SELECT /*+PARALLEL(16)*/
               F.ORG_WID,
               F.ORG_DH_WID,
               F.ORG_SCD1_WID,
               P.PROD_DP_WID,
               F.DT_WID,
               F.MIN_WID,
               F.SLS_TRX_ID,
               F.VOUCHER_ID,
               F.EMPLOYEE_WID,
               SUM(F.SLS_QTY) SLS_QTY,
               SUM(F.SLS_AMT_LCL) SLS_AMT_LCL,
               SUM(F.SLS_PROFIT_AMT_LCL) SLS_PROFIT_AMT_LCL,
               SUM(F.SLS_MANUAL_MKDN_AMT_LCL) SLS_MANUAL_MKDN_AMT_LCL,
               SUM(F.SLS_MANUAL_MKUP_AMT_LCL) SLS_MANUAL_MKUP_AMT_LCL,
               SUM(F.SLS_TAX_AMT_LCL) SLS_TAX_AMT_LCL,
               SUM(F.SLS_EMP_DISC_AMT_LCL) SLS_EMP_DISC_AMT_LCL,
               SUM(F.SLS_MANUAL_COUNT) SLS_MANUAL_COUNT,
               SUM(F.SLS_SCAN_COUNT) SLS_SCAN_COUNT,
               SUM(F.RET_QTY) RET_QTY,
               SUM(F.RET_AMT_LCL) RET_AMT_LCL,
               SUM(F.RET_PROFIT_AMT_LCL) RET_PROFIT_AMT_LCL,
               SUM(F.RET_MANUAL_MKDN_AMT_LCL) RET_MANUAL_MKDN_AMT_LCL,
               SUM(F.RET_MANUAL_MKUP_AMT_LCL) RET_MANUAL_MKUP_AMT_LCL,
               SUM(F.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
               SUM(F.RET_EMP_DISC_AMT_LCL) RET_EMP_DISC_AMT_LCL,
               SUM(F.RET_MANUAL_COUNT) RET_MANUAL_COUNT,
               SUM(F.RET_SCAN_COUNT) RET_SCAN_COUNT,
               '' AUX1_CHANGED_ON_DT,
               '' AUX2_CHANGED_ON_DT,
               '' AUX3_CHANGED_ON_DT,
               '' AUX4_CHANGED_ON_DT,
               -1 CHANGED_BY_WID,
               SYSDATE CHANGED_ON_DT,
               -1 CREATED_BY_WID,
               SYSDATE CREATED_ON_DT,
               1 DATASOURCE_NUM_ID,
               '' DELETE_FLG,
               'CNY' DOC_CURR_CODE,
               100 ETL_PROC_WID,
               '' GLOBAL1_EXCHANGE_RATE,
               '' GLOBAL2_EXCHANGE_RATE,
               '' GLOBAL3_EXCHANGE_RATE,
               F.SLS_TRX_ID || '~' || F.VOUCHER_ID || '~' ||
               TO_CHAR(TO_DATE(SUBSTR(F.DT_WID, 2, 8), 'YYYYMMDD'),
                       'DD-MON-YY',
                       'NLS_DATE_LANGUAGE=American') INTEGRATION_ID,
               'CNY' LOC_CURR_CODE,
               1 LOC_EXCHANGE_RATE,
               '' TENANT_ID,
               SYSDATE W_INSERT_DT,
               SYSDATE W_UPDATE_DT,
               '' X_CUSTOM,
               1 BBG_CUSTOMER_COUNT,
               MAX(BBG_SERVICE_SATISFACTION) BBG_SERVICE_SATISFACTION,
               '' SRC_REF_NO1,
               '' SRC_REF_NO2,
               '' SRC_REF_NO3,
               '' SRC_REF_NO6,
               '' SRC_REF_NO7,
               '' SRC_REF_NO8,
               '' BBG_REFERENCE_DO1,
               '' BBG_REFERENCE_DO2,
               '' BBG_REFERENCE_DO3,
               '' BBG_REFERENCE_DO4,
               '' BBG_REFERENCE_DO5,
               '' BBG_REFERENCE_FO1,
               '' BBG_REFERENCE_FO2,
               '' BBG_REFERENCE_FO3,
               '' BBG_REFERENCE_FO4,
               '' BBG_REFERENCE_FO5,
               '' BBG_REFERENCE_FO6,
               '' BBG_REFERENCE_FO7,
               '' BBG_REFERENCE_FO8,
               '' BBG_REFERENCE_FO9,
               '' BBG_REFERENCE_FO10,
               F.HYK_NO,
               SUM(F.vip_sls_qty) vip_sls_qty,
               SUM(F.vip_sls_amt_lcl) vip_sls_amt_lcl,
               SUM(F.vip_sls_profit_amt_lcl) vip_sls_profit_amt_lcl,
               SUM(F.vip_sls_manual_mkdn_amt_lcl) vip_sls_manual_mkdn_amt_lcl,
               SUM(F.vip_sls_manual_mkup_amt_lcl) vip_sls_manual_mkup_amt_lcl,
               SUM(F.vip_sls_tax_amt_lcl) vip_sls_tax_amt_lcl,
               SUM(F.vip_sls_emp_disc_amt_lcl) vip_sls_emp_disc_amt_lcl,
               SUM(F.vip_sls_manual_count) vip_sls_manual_count,
               SUM(F.vip_sls_scan_count) vip_sls_scan_count,
               SUM(F.vip_ret_qty) vip_ret_qty,
               SUM(F.vip_ret_amt_lcl) vip_ret_amt_lcl,
               SUM(F.vip_ret_profit_amt_lcl) vip_ret_profit_amt_lcl,
               SUM(F.vip_ret_manual_mkdn_amt_lcl) vip_ret_manual_mkdn_amt_lcl,
               SUM(F.vip_ret_manual_mkup_amt_lcl) vip_ret_manual_mkup_amt_lcl,
               SUM(F.vip_ret_tax_amt_lcl) vip_ret_tax_amt_lcl,
               SUM(F.vip_ret_emp_disc_amt_lcl) vip_ret_emp_disc_amt_lcl,
               SUM(F.vip_ret_manual_count) vip_ret_manual_count,
               SUM(F.vip_ret_scan_count) vip_ret_scan_count
                FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK F,
                     RABATCHER.W_PRODUCT_D_RTL_TMP     P
               WHERE F.PROD_WID = P.PROD_IT_WID
                 AND F.DT_WID BETWEEN
                     1 || TO_CHAR(P.SRC_EFF_FROM_DT, 'YYYYMMDD') || '000' AND
                     1 || TO_CHAR(P.SRC_EFF_TO_DT, 'YYYYMMDD') || '000'
                 AND F.DT_WID BETWEEN BDTWID AND EDTWID
                 AND NOT EXISTS (SELECT /*+PARALLEL(16)*/
                       1
                        FROM RADM.W_RTL_SLS_TRX_DP_LC_DY_A A
                       WHERE F.DT_WID = A.DT_WID)
               GROUP BY F.ORG_WID,
                        F.ORG_DH_WID,
                        F.ORG_SCD1_WID,
                        F.DT_WID,
                        F.MIN_WID,
                        F.SLS_TRX_ID,
                        F.VOUCHER_ID,
                        F.EMPLOYEE_WID,
                        F.HYK_NO,
                        P.PROD_DP_WID) A;
    COMMIT;
  END;

END;
/
