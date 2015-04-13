--1
CREATE MATERIALIZED VIEW RADM.W_RTL_SLS_SC_LC_MN_CUR_A1    NOLOGGING refresh complete
AS  
SELECT  /*+ PARALLEL(W_RTL_SLS_SC_LC_DY_CUR_A,20)*/ 
PROD_DH_WID              ,
ORG_WID                  ,
max(ORG_SCD1_WID�� ORG_SCD1_WID             ,
max(ORG_DH_WID��  ORG_DH_WID              ,
SUBSTR(TO_CHAR(DT_WID),2,6) MN_WID    ,
RTL_TYPE_WID             ,
SUM(NVL(SLS_QTY,0))  SLS_QTY                ,
SUM(NVL(SLS_AMT_LCL,0)) SLS_AMT_LCL              ,
SUM(NVL(SLS_PROFIT_AMT_LCL,0)) SLS_PROFIT_AMT_LCL,
SUM(NVL(SLS_MANUAL_MKDN_AMT_LCL,0)) SLS_MANUAL_MKDN_AMT_LCL ,
SUM(NVL(SLS_MANUAL_MKUP_AMT_LCL,0)) SLS_MANUAL_MKUP_AMT_LCL  ,
SUM(NVL(SLS_TAX_AMT_LCL,0))  SLS_TAX_AMT_LCL        ,
SUM(NVL(SLS_EMP_DISC_AMT_LCL,0)) SLS_EMP_DISC_AMT_LCL     ,
SUM(NVL(SLS_MANUAL_COUNT,0)) SLS_MANUAL_COUNT       ,
SUM(NVL(SLS_SCAN_COUNT,0))   SLS_SCAN_COUNT        ,
SUM(NVL(RET_QTY,0))          RET_QTY        ,
SUM(NVL(RET_AMT_LCL,0))      RET_AMT_LCL       ,
SUM(NVL(RET_PROFIT_AMT_LCL,0)) RET_PROFIT_AMT_LCL      ,
SUM(NVL(RET_MANUAL_MKDN_AMT_LCL,0)) RET_MANUAL_MKDN_AMT_LCL ,
SUM(NVL(RET_MANUAL_MKUP_AMT_LCL,0)) RET_MANUAL_MKUP_AMT_LCL ,
SUM(NVL(RET_TAX_AMT_LCL,0))         RET_TAX_AMT_LCL ,
SUM(NVL(RET_EMP_DISC_AMT_LCL,0))    RET_EMP_DISC_AMT_LCL ,
SUM(NVL(RET_MANUAL_COUNT,0))        RET_MANUAL_COUNT ,
SUM(NVL(RET_SCAN_COUNT,0))          RET_SCAN_COUNT ,
max(SUBSTR(INTEGRATION_ID,1,INSTR(INTEGRATION_ID,'~',1,1))||SUBSTR(INTEGRATION_ID,INSTR(INTEGRATION_ID,'~',1,1)+1,INSTR(INTEGRATION_ID,'~',1,2)-INSTR(INTEGRATION_ID,'~',1,1))||SUBSTR(TO_CHAR(DT_WID),2,6)||SUBSTR(INTEGRATION_ID,INSTR(INTEGRATION_ID,'~',1,3),LENGTH(INTEGRATION_ID)-INSTR(INTEGRATION_ID,'~',1,3)+1)�� INTEGRATION_ID           ,
max(GLOBAL1_EXCHANGE_RATE��   GLOBAL1_EXCHANGE_RATE ,
max(GLOBAL2_EXCHANGE_RATE��   GLOBAL2_EXCHANGE_RATE,
max(GLOBAL3_EXCHANGE_RATE��   GLOBAL3_EXCHANGE_RATE ,
max(LOC_EXCHANGE_RATE��       LOC_EXCHANGE_RATE ,
BBG_RETAIL_TYPE_WID      ,
SUM(NVL(BBG_CUSTOMER_COUNT,0))  BBG_CUSTOMER_COUNT     ,
SUM(NVL(BBG_SERVICE_SATISFACTION,0)) BBG_SERVICE_SATISFACTION ,
max(BBG_REFERENCE_DO1)      BBG_REFERENCE_DO1  ,
max(BBG_REFERENCE_DO2)      BBG_REFERENCE_DO2  ,
max(BBG_REFERENCE_DO3)      BBG_REFERENCE_DO3  ,
max(BBG_REFERENCE_DO4)      BBG_REFERENCE_DO4  ,
max(BBG_REFERENCE_DO5)      BBG_REFERENCE_DO5  ,
max(BBG_REFERENCE_FO1)      BBG_REFERENCE_FO1  ,
max(BBG_REFERENCE_FO2)      BBG_REFERENCE_FO2  ,
max(BBG_REFERENCE_FO3)      BBG_REFERENCE_FO3  ,
max(BBG_REFERENCE_FO4)      BBG_REFERENCE_FO4   ,
max(BBG_REFERENCE_FO5)      BBG_REFERENCE_FO5  ,
max(BBG_REFERENCE_FO6)      BBG_REFERENCE_FO6  ,
max(BBG_REFERENCE_FO7)      BBG_REFERENCE_FO7  ,
max(BBG_REFERENCE_FO8)      BBG_REFERENCE_FO8  ,
max(BBG_REFERENCE_FO9)      BBG_REFERENCE_FO9  ,
max(BBG_REFERENCE_FO10)    BBG_REFERENCE_FO10  
FROM 
RADM.W_RTL_SLS_SC_LC_DY_CUR_A   
GROUP BY 
PROD_DH_WID              ,
ORG_WID                  ,
SUBSTR(TO_CHAR(DT_WID),2,6) ,
RTL_TYPE_WID             ,
BBG_RETAIL_TYPE_WID 
--2
BEGIN
	DBMS_MVIEW.REFRESH('W_RTL_SLS_SC_LC_MN_CUR_A1','C');
	END;
