--VIP_TMP2
CREATE TABLE RADM.VIP_TMP2 AS
  SELECT /*+PARALLEL(16)*/
   P.PROD_CL_WID,
   B.RTL_TYPE_WID,
   B.DT_WID,
   B.BBG_RETAIL_TYPE_WID,
   SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
   SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
   SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_RET_QTY) VIP_RET_QTY,
   SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
   SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
   SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_SLS_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_AMT,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL1,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL2,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL3,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL1,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL2,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL3,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_TAX_AMT,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL1,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL2,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL3,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL1,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL2,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKDN_AMT,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL1,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL2,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKUP_AMT,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL1,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL2,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL3,
   SUM(B.VIP_RET_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_AMT,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL1,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL2,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL3,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_PROFIT_AMT,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL1,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL2,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL3,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_TAX_AMT,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL1,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL2,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL3,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL1,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL2,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKDN_AMT,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL1,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL2,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKUP_AMT,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL1,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL2,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
   SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
   SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
   SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
    FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
   WHERE B.PROD_SCD1_WID = P.PROD_SCD1_WID
     AND P.CURRENT_FLG = 'Y'
   GROUP BY P.PROD_CL_WID, B.RTL_TYPE_WID, B.DT_WID, B.BBG_RETAIL_TYPE_WID;
	 
--VIP_TMP3
CREATE TABLE RADM.VIP_TMP3 AS
  SELECT /*+PARALLEL(16)*/
   P.PROD_CL_WID,
   B.ORG_WID,
   B.RTL_TYPE_WID,
   B.DT_WID,
   B.BBG_RETAIL_TYPE_WID,
   SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
   SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
   SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
   SUM(B.VIP_RET_QTY) VIP_RET_QTY,
   SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
   SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
   SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
   SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
   SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
   SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
    FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
   WHERE B.PROD_WID = P.PROD_IT_WID
   GROUP BY P.PROD_CL_WID,
            B.ORG_WID,
            B.RTL_TYPE_WID,
            B.DT_WID,
            B.BBG_RETAIL_TYPE_WID;
						
--VIP_TMP4
CREATE TABLE RADM.VIP_TMP4 AS
    SELECT /*+PARALLEL(16)*/
     P.PROD_CL_WID,
     B.ORG_WID,
     B.RTL_TYPE_WID,
     B.DT_WID,
     B.BBG_RETAIL_TYPE_WID,
     SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
     SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
     SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
     SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
     SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
     SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
     SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
     SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
     SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
     SUM(B.VIP_RET_QTY) VIP_RET_QTY,
     SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
     SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
     SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
     SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
     SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
     SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
     SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
     SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
      FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
     WHERE B.PROD_SCD1_WID = P.PROD_SCD1_WID
       AND P.CURRENT_FLG = 'Y'
     GROUP BY P.PROD_CL_WID,
              B.ORG_WID,
              B.RTL_TYPE_WID,
              B.DT_WID,
              B.BBG_RETAIL_TYPE_WID;
							
--VIP_TMP5
CREATE TABLE RADM.VIP_TMP5 AS
  SELECT /*+PARALLEL(16)*/
   P.PROD_DP_WID,
   B.RTL_TYPE_WID,
   B.DT_WID,
   B.BBG_RETAIL_TYPE_WID,
   SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
   SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
   SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_RET_QTY) VIP_RET_QTY,
   SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
   SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
   SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_SLS_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_AMT,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL1,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL2,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL3,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL1,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL2,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL3,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_TAX_AMT,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL1,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL2,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL3,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL1,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL2,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKDN_AMT,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL1,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL2,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKUP_AMT,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL1,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL2,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL3,
   SUM(B.VIP_RET_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_AMT,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL1,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL2,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL3,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_PROFIT_AMT,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL1,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL2,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL3,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_TAX_AMT,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL1,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL2,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL3,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL1,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL2,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKDN_AMT,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL1,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL2,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKUP_AMT,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL1,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL2,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
   SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
   SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
   SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
    FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
   WHERE B.PROD_SCD1_WID = P.PROD_SCD1_WID
     AND P.CURRENT_FLG = 'Y'
   GROUP BY P.PROD_DP_WID, B.RTL_TYPE_WID, B.DT_WID, B.BBG_RETAIL_TYPE_WID;
	 
--VIP_TMP6
CREATE TABLE RADM.VIP_TMP6 AS
SELECT /*+PARALLEL(16)*/
 P.PROD_DP_WID,
 B.ORG_WID,
 B.RTL_TYPE_WID,
 B.DT_WID,
 B.BBG_RETAIL_TYPE_WID,
 SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
 SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
 SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
 SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
 SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
 SUM(B.VIP_RET_QTY) VIP_RET_QTY,
 SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
 SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
 SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
 SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
 SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
 SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
 SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
 SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
 SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
 SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
 SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
 SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
 WHERE B.PROD_WID = P.PROD_IT_WID
 GROUP BY P.PROD_DP_WID,
          B.ORG_WID,
          B.RTL_TYPE_WID,
          B.DT_WID,
          B.BBG_RETAIL_TYPE_WID;
					
--VIP_TMP7
CREATE TABLE RADM.VIP_TMP7 AS
                        SELECT /*+PARALLEL(16)*/
                         P.PROD_DP_WID,
                         B.ORG_WID,
                         B.RTL_TYPE_WID,
                         B.DT_WID,
                         B.BBG_RETAIL_TYPE_WID,
                         SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
                         SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
                         SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
                         SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
                         SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
                         SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
                         SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
                         SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
                         SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
                         SUM(B.VIP_RET_QTY) VIP_RET_QTY,
                         SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
                         SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
                         SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
                         SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
                         SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
                         SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
                         SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
                         SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
                          FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B,
                               RABATCHER.W_PRODUCT_D_RTL_TMP P
                         WHERE B.PROD_SCD1_WID = P.PROD_SCD1_WID
                           AND P.CURRENT_FLG = 'Y'
                         GROUP BY P.PROD_DP_WID,
                                  B.ORG_WID,
                                  B.RTL_TYPE_WID,
                                  B.DT_WID,
                                  B.BBG_RETAIL_TYPE_WID;
																	
--VIP_TMP11
CREATE TABLE RADM.VIP_TMP11 AS
  SELECT /*+PARALLEL(16)*/
   B.PROD_WID,
   B.ORG_WID,
   B.RTL_TYPE_WID,
   B.DT_WID,
   S.SEASON_WID,
   B.BBG_RETAIL_TYPE_WID,
   SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
   SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
   SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
   SUM(B.VIP_RET_QTY) VIP_RET_QTY,
   SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
   SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
   SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL
    FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RADM.W_RTL_SEASON_IT_D S
   WHERE B.PROD_WID = S.PROD_WID
   GROUP BY B.PROD_WID,
            B.ORG_WID,
            B.RTL_TYPE_WID,
            B.DT_WID,
            S.SEASON_WID,
            B.BBG_RETAIL_TYPE_WID;
						
--VIP_TMP12
CREATE TABLE RADM.VIP_TMP12 AS
  SELECT /*+PARALLEL(16)*/
   B.ORG_WID,
   B.RTL_TYPE_WID,
   B.DT_WID,
   B.BBG_RETAIL_TYPE_WID,
   SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
   SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
   0 VIP_SLS_TRX_COUNT,
   SUM(B.VIP_RET_QTY) VIP_RET_QTY,
   SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
   SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
   0 VIP_RET_TRX_COUNT
    FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B
   GROUP BY B.ORG_WID,
            B.RTL_TYPE_WID,
            B.DT_WID,
            B.BBG_RETAIL_TYPE_WID;
						
--VIP_TMP13
CREATE TABLE RADM.VIP_TMP13 AS
  SELECT /*+PARALLEL(16)*/
   P.PROD_SC_WID,
   B.RTL_TYPE_WID,
   B.DT_WID,
   B.BBG_RETAIL_TYPE_WID,
   SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
   SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
   SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
   SUM(B.VIP_RET_QTY) VIP_RET_QTY,
   SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
   SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
   SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
   SUM(B.VIP_SLS_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_AMT,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL1,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL2,
   SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL3,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL1,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL2,
   SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKDN_AMT,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKUP_AMT,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_TAX_AMT,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL1,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL2,
   SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL3,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL1,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL2,
   SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL3,
   SUM(B.VIP_RET_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_AMT,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL1,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL2,
   SUM(B.VIP_RET_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL3,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_PROFIT_AMT,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL1,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL2,
   SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKDN_AMT,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKUP_AMT,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_TAX_AMT,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL1,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL2,
   SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL3,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL1,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL2,
   SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
   SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
   SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
   SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL1,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL2,
   SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL3,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL1,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL2,
   SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL1,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL2,
   SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL3,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL1,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL2,
   SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL3
    FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
   WHERE B.PROD_WID = P.PROD_IT_WID
   GROUP BY P.PROD_SC_WID, B.RTL_TYPE_WID, B.DT_WID, B.BBG_RETAIL_TYPE_WID;
	 
--VIP_TMP14
CREATE TABLE RADM.VIP_TMP14 AS
                    SELECT /*+PARALLEL(16)*/
                     P.PROD_SC_WID,
                     B.RTL_TYPE_WID,
                     B.DT_WID,
                     B.BBG_RETAIL_TYPE_WID,
                     SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
                     SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
                     SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
                     SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
                     SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
                     SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
                     SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
                     SUM(B.VIP_RET_QTY) VIP_RET_QTY,
                     SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
                     SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
                     SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
                     SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
                     SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
                     SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
                     SUM(B.VIP_SLS_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_AMT,
                     SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL1,
                     SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL2,
                     SUM(B.VIP_SLS_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_AMT_GLOBAL3,
                     SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT,
                     SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL1,
                     SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL2,
                     SUM(B.VIP_SLS_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_PROFIT_AMT_GLOBAL3,
                     SUM(B.VIP_SLS_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_TAX_AMT,
                     SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL1,
                     SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL2,
                     SUM(B.VIP_SLS_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_TAX_AMT_GLOBAL3,
                     SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT,
                     SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL1,
                     SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL2,
                     SUM(B.VIP_SLS_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_SLS_EMP_DISC_AMT_GLOBAL3,
                     SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKDN_AMT,
                     SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_SLS_MANUAL_MKUP_AMT,
                     SUM(B.VIP_RET_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_AMT,
                     SUM(B.VIP_RET_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL1,
                     SUM(B.VIP_RET_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL2,
                     SUM(B.VIP_RET_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_AMT_GLOBAL3,
                     SUM(B.VIP_RET_PROFIT_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_PROFIT_AMT,
                     SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL1,
                     SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL2,
                     SUM(B.VIP_RET_PROFIT_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_PROFIT_AMT_GLOBAL3,
                     SUM(B.VIP_RET_TAX_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_TAX_AMT,
                     SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL1,
                     SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL2,
                     SUM(B.VIP_RET_TAX_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_TAX_AMT_GLOBAL3,
                     SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT,
                     SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL1,
                     SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL2,
                     SUM(B.VIP_RET_EMP_DISC_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) VIP_RET_EMP_DISC_AMT_GLOBAL3,
                     SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKDN_AMT,
                     SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.LOC_EXCHANGE_RATE) VIP_RET_MANUAL_MKUP_AMT,
                     SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
                     SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
                     SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
                     SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT,
                     SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL1,
                     SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL2,
                     SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKDN_AMT_GLOBAL3,
                     SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL1,
                     SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL2,
                     SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_SLS_MANUAL_MKUP_AMT_GLOBAL3,
                     SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL1,
                     SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL2,
                     SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKDN_AMT_GLOBAL3,
                     SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL1_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL1,
                     SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL2_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL2,
                     SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL / B.GLOBAL3_EXCHANGE_RATE) V_RET_MANUAL_MKUP_AMT_GLOBAL3
                      FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
                     WHERE B.PROD_SCD1_WID = P.PROD_SCD1_WID
                       AND P.CURRENT_FLG = 'Y'
                     GROUP BY P.PROD_SC_WID, B.RTL_TYPE_WID, B.DT_WID, B.BBG_RETAIL_TYPE_WID;
										 
--VIP_TMP15
CREATE TABLE RADM.VIP_TMP15 AS
                        SELECT P.PROD_SC_WID,
                               B.ORG_WID,
                               B.RTL_TYPE_WID,
                               B.DT_WID,
                               B.BBG_RETAIL_TYPE_WID,
                               SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
                               SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
                               SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
                               SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
                               SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
                               SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
                               SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
                               SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
                               SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
                               SUM(B.VIP_RET_QTY) VIP_RET_QTY,
                               SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
                               SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
                               SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
                               SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
                               SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
                               SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
                               SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
                               SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
                          FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B,
                               RABATCHER.W_PRODUCT_D_RTL_TMP P
                         WHERE B.PROD_WID = P.PROD_IT_WID
                         GROUP BY P.PROD_SC_WID,
                                  B.ORG_WID,
                                  B.RTL_TYPE_WID,
                                  B.DT_WID,
                                  B.BBG_RETAIL_TYPE_WID;
																	
--VIP_TMP16
CREATE TABLE RADM.VIP_TMP16 AS
                                SELECT /*+PARALLEL(16)*/
                                 P.PROD_SC_WID,
                                 B.ORG_WID,
                                 B.RTL_TYPE_WID,
                                 B.DT_WID,
                                 B.BBG_RETAIL_TYPE_WID,
                                 SUM(B.VIP_SLS_QTY) VIP_SLS_QTY,
                                 SUM(B.VIP_SLS_AMT_LCL) VIP_SLS_AMT_LCL,
                                 SUM(B.VIP_SLS_PROFIT_AMT_LCL) VIP_SLS_PROFIT_AMT_LCL,
                                 SUM(B.VIP_SLS_MANUAL_MKDN_AMT_LCL) VIP_SLS_MANUAL_MKDN_AMT_LCL,
                                 SUM(B.VIP_SLS_MANUAL_MKUP_AMT_LCL) VIP_SLS_MANUAL_MKUP_AMT_LCL,
                                 SUM(B.VIP_SLS_TAX_AMT_LCL) VIP_SLS_TAX_AMT_LCL,
                                 SUM(B.VIP_SLS_EMP_DISC_AMT_LCL) VIP_SLS_EMP_DISC_AMT_LCL,
                                 SUM(B.VIP_SLS_MANUAL_COUNT) VIP_SLS_MANUAL_COUNT,
                                 SUM(B.VIP_SLS_SCAN_COUNT) VIP_SLS_SCAN_COUNT,
                                 SUM(B.VIP_RET_QTY) VIP_RET_QTY,
                                 SUM(B.VIP_RET_AMT_LCL) VIP_RET_AMT_LCL,
                                 SUM(B.VIP_RET_PROFIT_AMT_LCL) VIP_RET_PROFIT_AMT_LCL,
                                 SUM(B.VIP_RET_MANUAL_MKDN_AMT_LCL) VIP_RET_MANUAL_MKDN_AMT_LCL,
                                 SUM(B.VIP_RET_MANUAL_MKUP_AMT_LCL) VIP_RET_MANUAL_MKUP_AMT_LCL,
                                 SUM(B.VIP_RET_TAX_AMT_LCL) VIP_RET_TAX_AMT_LCL,
                                 SUM(B.VIP_RET_EMP_DISC_AMT_LCL) VIP_RET_EMP_DISC_AMT_LCL,
                                 SUM(B.VIP_RET_MANUAL_COUNT) VIP_RET_MANUAL_COUNT,
                                 SUM(B.VIP_RET_SCAN_COUNT) VIP_RET_SCAN_COUNT
                                  FROM RADM.W_RTL_SLS_IT_LC_DY_F_BAK B, RABATCHER.W_PRODUCT_D_RTL_TMP P
                                 WHERE B.PROD_SCD1_WID = P.PROD_SCD1_WID
                                   AND P.CURRENT_FLG = 'Y'
                                 GROUP BY P.PROD_SC_WID,
                                          B.ORG_WID,
                                          B.RTL_TYPE_WID,
                                          B.DT_WID,
                                          B.BBG_RETAIL_TYPE_WID;
