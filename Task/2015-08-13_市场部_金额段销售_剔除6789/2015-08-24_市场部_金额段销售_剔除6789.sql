--*********************************************************************************************************************
--1.建立小票汇总表
--*********************************************************************************************************************
--1.1.W_RTL_SLS_TRX_LC_DY_A--------------------------------------------------------------------------------------------
--1.1.1.CREATE TABLE 
CREATE TABLE RADM.W_RTL_SLS_TRX_LC_DY_A
( ROW_WID                     NUMBER(10) NOT NULL,
  ORG_WID                     NUMBER(10) NOT NULL,
  ORG_DH_WID                  NUMBER(10) NOT NULL,
  ORG_SCD1_WID                NUMBER(10) NOT NULL,
  DT_WID                      NUMBER(15) NOT NULL,
  MIN_WID                     NUMBER(10) NOT NULL,
  SLS_TRX_ID                  VARCHAR2(30 CHAR) NOT NULL,
  VOUCHER_ID                  VARCHAR2(30 CHAR) NOT NULL,
  EMPLOYEE_WID                NUMBER(10) NOT NULL,
  SLS_QTY                     NUMBER(18,4),
  SLS_AMT_LCL                 NUMBER(20,4),
  SLS_PROFIT_AMT_LCL          NUMBER(20,4),
  SLS_MANUAL_MKDN_AMT_LCL     NUMBER(20,4),
  SLS_MANUAL_MKUP_AMT_LCL     NUMBER(20,4),
  SLS_TAX_AMT_LCL             NUMBER(20,4),
  SLS_EMP_DISC_AMT_LCL        NUMBER(20,4),
  SLS_MANUAL_COUNT            NUMBER(18,4),
  SLS_SCAN_COUNT              NUMBER(18,4),
  RET_QTY                     NUMBER(18,4),
  RET_AMT_LCL                 NUMBER(20,4),
  RET_PROFIT_AMT_LCL          NUMBER(20,4),
  RET_MANUAL_MKDN_AMT_LCL     NUMBER(20,4),
  RET_MANUAL_MKUP_AMT_LCL     NUMBER(20,4),
  RET_TAX_AMT_LCL             NUMBER(20,4),
  RET_EMP_DISC_AMT_LCL        NUMBER(20,4),
  RET_MANUAL_COUNT            NUMBER(18,4),
  RET_SCAN_COUNT              NUMBER(18,4),
  AUX1_CHANGED_ON_DT          DATE,
  AUX2_CHANGED_ON_DT          DATE,
  AUX3_CHANGED_ON_DT          DATE,
  AUX4_CHANGED_ON_DT          DATE,
  CHANGED_BY_WID              NUMBER(10),
  CHANGED_ON_DT               DATE,
  CREATED_BY_WID              NUMBER(10),
  CREATED_ON_DT               DATE,
  DATASOURCE_NUM_ID           NUMBER(10) NOT NULL,
  DELETE_FLG                  CHAR(1 CHAR),
  DOC_CURR_CODE               VARCHAR2(30 CHAR),
  ETL_PROC_WID                NUMBER(10) NOT NULL,
  GLOBAL1_EXCHANGE_RATE       NUMBER(22,7),
  GLOBAL2_EXCHANGE_RATE       NUMBER(22,7),
  GLOBAL3_EXCHANGE_RATE       NUMBER(22,7),
  INTEGRATION_ID              VARCHAR2(80 CHAR) NOT NULL,
  LOC_CURR_CODE               VARCHAR2(30 CHAR),
  LOC_EXCHANGE_RATE           NUMBER(22,7),
  TENANT_ID                   VARCHAR2(80 CHAR),
  W_INSERT_DT                 DATE,
  W_UPDATE_DT                 DATE,
  X_CUSTOM                    VARCHAR2(10 CHAR),
  BBG_CUSTOMER_COUNT          NUMBER(20,4),
  BBG_SERVICE_SATISFACTION    NUMBER(20,4),
  SRC_REF_NO1                 VARCHAR2(250),
  SRC_REF_NO2                 VARCHAR2(250),
  SRC_REF_NO3                 VARCHAR2(250),
  SRC_REF_NO6                 VARCHAR2(250),
  SRC_REF_NO7                 VARCHAR2(250),
  SRC_REF_NO8                 VARCHAR2(250),
  BBG_REFERENCE_DO1           VARCHAR2(250),
  BBG_REFERENCE_DO2           VARCHAR2(250),
  BBG_REFERENCE_DO3           VARCHAR2(250),
  BBG_REFERENCE_DO4           VARCHAR2(250),
  BBG_REFERENCE_DO5           VARCHAR2(250),
  BBG_REFERENCE_FO1           NUMBER(20,4),
  BBG_REFERENCE_FO2           NUMBER(20,4),
  BBG_REFERENCE_FO3           NUMBER(20,4),
  BBG_REFERENCE_FO4           NUMBER(20,4),
  BBG_REFERENCE_FO5           NUMBER(20,4),
  BBG_REFERENCE_FO6           NUMBER(20,4),
  BBG_REFERENCE_FO7           NUMBER(20,4),
  BBG_REFERENCE_FO8           NUMBER(20,4),
  BBG_REFERENCE_FO9           NUMBER(20,4),
  BBG_REFERENCE_FO10          NUMBER(20,4),
  HYK_NO                      VARCHAR2(30),
  VIP_SLS_QTY                 NUMBER(18,4),
  VIP_SLS_AMT_LCL             NUMBER(20,4),
  VIP_SLS_PROFIT_AMT_LCL      NUMBER(20,4),
  VIP_SLS_MANUAL_MKDN_AMT_LCL NUMBER(20,4),
  VIP_SLS_MANUAL_MKUP_AMT_LCL NUMBER(20,4),
  VIP_SLS_TAX_AMT_LCL         NUMBER(20,4),
  VIP_SLS_EMP_DISC_AMT_LCL    NUMBER(20,4),
  VIP_SLS_MANUAL_COUNT        NUMBER(18,4),
  VIP_SLS_SCAN_COUNT          NUMBER(18,4),
  VIP_RET_QTY                 NUMBER(18,4),
  VIP_RET_AMT_LCL             NUMBER(20,4),
  VIP_RET_PROFIT_AMT_LCL      NUMBER(20,4),
  VIP_RET_MANUAL_MKDN_AMT_LCL NUMBER(20,4),
  VIP_RET_MANUAL_MKUP_AMT_LCL NUMBER(20,4),
  VIP_RET_TAX_AMT_LCL         NUMBER(20,4),
  VIP_RET_EMP_DISC_AMT_LCL    NUMBER(20,4),
  VIP_RET_MANUAL_COUNT        NUMBER(18,4),
  VIP_RET_SCAN_COUNT          NUMBER(18,4),
	N69_NET_SALES_AMT           NUMBER(20,4),
	N69_NET_SALES_AMT_INC_TAX   NUMBER(20,4)
	VIP_N69_NET_SALES_AMT       NUMBER(20,4)
	VIP_N69_NET_SALES_AMT_INC_TAX       NUMBER(20,4));
	

	
--1.1.2.CREATE INDEX
ALTER TABLE RADM.W_RTL_SLS_TRX_LC_DY_A
  ADD CONSTRAINT PK_W_RTL_SLS_TRX_LC_DY_A PRIMARY KEY (SLS_TRX_ID, VOUCHER_ID, DT_WID, ORG_WID)
  USING INDEX 
  TABLESPACE DM_FACT_INDEX
  PCTFREE 10
  INITRANS 12
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );	

--1.1.3.CREATE SEQ
CREATE SEQUENCE W_RTL_SLS_TRX_LC_DY_A_SEQ
MINVALUE 1
MAXVALUE 9999999999999999999999999999
START WITH 1
INCREMENT BY 1
CACHE 20000;

--1.1.4.INSERT TEST DATA
INSERT INTO RADM.W_RTL_SLS_TRX_LC_DY_A
  SELECT W_RTL_SLS_TRX_LC_DY_A_SEQ.NEXTVAL ROW_WID, A.*
    FROM (SELECT F.ORG_WID,
                 F.ORG_DH_WID,
                 F.ORG_SCD1_WID,
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
                 SUM(F.vip_ret_scan_count) vip_ret_scan_count,
                 SUM(F.N69_NET_SALES_AMT) N69_NET_SALES_AMT,
                 SUM(F.N69_NET_SALES_AMT_INC_TAX) N69_NET_SALES_AMT_INC_TAX,
                 SUM(F.VIP_N69_NET_SALES_AMT) VIP_N69_NET_SALES_AMT,
                 SUM(F.VIP_N69_NET_SALES_AMT_INC_TAX) VIP_N69_NET_SALES_AMT_INC_TAX
            FROM (SELECT A.*,
                         (SELECT CASE
                                   WHEN P.PROD_DV_NUM NOT IN (6, 7, 8, 9) THEN
                                    (A.SLS_AMT_LCL - A.RET_AMT_LCL) -
                                    (A.SLS_TAX_AMT_LCL - A.RET_TAX_AMT_LCL)
                                   ELSE
                                    0
                                 END
                            FROM RABATCHER.W_PRODUCT_D_RTL_TMP P
                           WHERE A.PROD_WID = P.PROD_IT_WID) N69_NET_SALES_AMT,
                         (SELECT CASE
                                   WHEN P.PROD_DV_NUM NOT IN (6, 7, 8, 9) THEN
                                    (A.SLS_AMT_LCL - A.RET_AMT_LCL)
                                   ELSE
                                    0
                                 END
                            FROM RABATCHER.W_PRODUCT_D_RTL_TMP P
                           WHERE A.PROD_WID = P.PROD_IT_WID) N69_NET_SALES_AMT_INC_TAX,
                         (SELECT CASE
                                   WHEN P.PROD_DV_NUM NOT IN (6, 7, 8, 9) AND
                                        A.HYK_NO IS NOT NULL THEN
                                    (A.SLS_AMT_LCL - A.RET_AMT_LCL) -
                                    (A.SLS_TAX_AMT_LCL - A.RET_TAX_AMT_LCL)
                                   ELSE
                                    0
                                 END
                            FROM RABATCHER.W_PRODUCT_D_RTL_TMP P
                           WHERE A.PROD_WID = P.PROD_IT_WID) VIP_N69_NET_SALES_AMT,
                         (SELECT CASE
                                   WHEN P.PROD_DV_NUM NOT IN (6, 7, 8, 9) AND
                                        A.HYK_NO IS NOT NULL THEN
                                    (A.SLS_AMT_LCL - A.RET_AMT_LCL)
                                   ELSE
                                    0
                                 END
                            FROM RABATCHER.W_PRODUCT_D_RTL_TMP P
                           WHERE A.PROD_WID = P.PROD_IT_WID) VIP_N69_NET_SALES_AMT_INC_TAX
                    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F A
                   WHERE A.DT_WID = 120150823000) F
           GROUP BY F.ORG_WID,
                    F.ORG_DH_WID,
                    F.ORG_SCD1_WID,
                    F.DT_WID,
                    F.MIN_WID,
                    F.SLS_TRX_ID,
                    F.VOUCHER_ID,
                    F.EMPLOYEE_WID,
                    F.HYK_NO) A;
COMMIT;

--1.1.5.存储过程
W_RTL_SLS_TRX_LC_DY_A_AGG;

--1.1.6.update W_RTL_SLS_TRX_LC_DY_A
UPDATE RADM.W_RTL_SLS_TRX_LC_DY_A A
   SET A.VIP_N69_NET_SALES_AMT = A.N69_NET_SALES_AMT
 WHERE A.HYK_NO IS NOT NULL
   AND A.VIP_N69_NET_SALES_AMT IS NULL
   AND A.DT_WID = &DTWID;
COMMIT;

UPDATE RADM.W_RTL_SLS_TRX_LC_DY_A A
   SET A.VIP_N69_NET_SALES_AMT = 0
 WHERE A.HYK_NO IS NULL
   AND A.VIP_N69_NET_SALES_AMT IS NULL
   AND A.DT_WID = &DTWID;
COMMIT;

UPDATE RADM.W_RTL_SLS_TRX_LC_DY_A A
   SET A.VIP_N69_NET_SALES_AMT_INC_TAX = A.N69_NET_SALES_AMT_INC_TAX
 WHERE A.HYK_NO IS NOT NULL
   AND A.VIP_N69_NET_SALES_AMT_INC_TAX IS NULL
   AND A.DT_WID = &DTWID;
COMMIT;

UPDATE RADM.W_RTL_SLS_TRX_LC_DY_A A
   SET A.VIP_N69_NET_SALES_AMT_INC_TAX = 0
 WHERE A.HYK_NO IS NULL
   AND A.VIP_N69_NET_SALES_AMT_INC_TAX IS NULL
   AND A.DT_WID = &DTWID;
COMMIT;

--1.2.W_RTL_SLS_TRX_DP_LC_DY_A------------------------------------------------------------------------
--1.2.1.CREATE TABLE
CREATE TABLE RADM.W_RTL_SLS_TRX_DP_LC_DY_A
( ROW_WID                     NUMBER(10) NOT NULL,
  ORG_WID                     NUMBER(10) NOT NULL,
  ORG_DH_WID                  NUMBER(10) NOT NULL,
  ORG_SCD1_WID                NUMBER(10) NOT NULL,
	PROD_DH_WID                 NUMBER(10) NOT NULL,
  DT_WID                      NUMBER(15) NOT NULL,
  MIN_WID                     NUMBER(10) NOT NULL,
  SLS_TRX_ID                  VARCHAR2(30 CHAR) NOT NULL,
  VOUCHER_ID                  VARCHAR2(30 CHAR) NOT NULL,
  EMPLOYEE_WID                NUMBER(10) NOT NULL,
  SLS_QTY                     NUMBER(18,4),
  SLS_AMT_LCL                 NUMBER(20,4),
  SLS_PROFIT_AMT_LCL          NUMBER(20,4),
  SLS_MANUAL_MKDN_AMT_LCL     NUMBER(20,4),
  SLS_MANUAL_MKUP_AMT_LCL     NUMBER(20,4),
  SLS_TAX_AMT_LCL             NUMBER(20,4),
  SLS_EMP_DISC_AMT_LCL        NUMBER(20,4),
  SLS_MANUAL_COUNT            NUMBER(18,4),
  SLS_SCAN_COUNT              NUMBER(18,4),
  RET_QTY                     NUMBER(18,4),
  RET_AMT_LCL                 NUMBER(20,4),
  RET_PROFIT_AMT_LCL          NUMBER(20,4),
  RET_MANUAL_MKDN_AMT_LCL     NUMBER(20,4),
  RET_MANUAL_MKUP_AMT_LCL     NUMBER(20,4),
  RET_TAX_AMT_LCL             NUMBER(20,4),
  RET_EMP_DISC_AMT_LCL        NUMBER(20,4),
  RET_MANUAL_COUNT            NUMBER(18,4),
  RET_SCAN_COUNT              NUMBER(18,4),
  AUX1_CHANGED_ON_DT          DATE,
  AUX2_CHANGED_ON_DT          DATE,
  AUX3_CHANGED_ON_DT          DATE,
  AUX4_CHANGED_ON_DT          DATE,
  CHANGED_BY_WID              NUMBER(10),
  CHANGED_ON_DT               DATE,
  CREATED_BY_WID              NUMBER(10),
  CREATED_ON_DT               DATE,
  DATASOURCE_NUM_ID           NUMBER(10) NOT NULL,
  DELETE_FLG                  CHAR(1 CHAR),
  DOC_CURR_CODE               VARCHAR2(30 CHAR),
  ETL_PROC_WID                NUMBER(10) NOT NULL,
  GLOBAL1_EXCHANGE_RATE       NUMBER(22,7),
  GLOBAL2_EXCHANGE_RATE       NUMBER(22,7),
  GLOBAL3_EXCHANGE_RATE       NUMBER(22,7),
  INTEGRATION_ID              VARCHAR2(80 CHAR) NOT NULL,
  LOC_CURR_CODE               VARCHAR2(30 CHAR),
  LOC_EXCHANGE_RATE           NUMBER(22,7),
  TENANT_ID                   VARCHAR2(80 CHAR),
  W_INSERT_DT                 DATE,
  W_UPDATE_DT                 DATE,
  X_CUSTOM                    VARCHAR2(10 CHAR),
  BBG_CUSTOMER_COUNT          NUMBER(20,4),
  BBG_SERVICE_SATISFACTION    NUMBER(20,4),
  SRC_REF_NO1                 VARCHAR2(250),
  SRC_REF_NO2                 VARCHAR2(250),
  SRC_REF_NO3                 VARCHAR2(250),
  SRC_REF_NO6                 VARCHAR2(250),
  SRC_REF_NO7                 VARCHAR2(250),
  SRC_REF_NO8                 VARCHAR2(250),
  BBG_REFERENCE_DO1           VARCHAR2(250),
  BBG_REFERENCE_DO2           VARCHAR2(250),
  BBG_REFERENCE_DO3           VARCHAR2(250),
  BBG_REFERENCE_DO4           VARCHAR2(250),
  BBG_REFERENCE_DO5           VARCHAR2(250),
  BBG_REFERENCE_FO1           NUMBER(20,4),
  BBG_REFERENCE_FO2           NUMBER(20,4),
  BBG_REFERENCE_FO3           NUMBER(20,4),
  BBG_REFERENCE_FO4           NUMBER(20,4),
  BBG_REFERENCE_FO5           NUMBER(20,4),
  BBG_REFERENCE_FO6           NUMBER(20,4),
  BBG_REFERENCE_FO7           NUMBER(20,4),
  BBG_REFERENCE_FO8           NUMBER(20,4),
  BBG_REFERENCE_FO9           NUMBER(20,4),
  BBG_REFERENCE_FO10          NUMBER(20,4),
  HYK_NO                      VARCHAR2(30),
  VIP_SLS_QTY                 NUMBER(18,4),
  VIP_SLS_AMT_LCL             NUMBER(20,4),
  VIP_SLS_PROFIT_AMT_LCL      NUMBER(20,4),
  VIP_SLS_MANUAL_MKDN_AMT_LCL NUMBER(20,4),
  VIP_SLS_MANUAL_MKUP_AMT_LCL NUMBER(20,4),
  VIP_SLS_TAX_AMT_LCL         NUMBER(20,4),
  VIP_SLS_EMP_DISC_AMT_LCL    NUMBER(20,4),
  VIP_SLS_MANUAL_COUNT        NUMBER(18,4),
  VIP_SLS_SCAN_COUNT          NUMBER(18,4),
  VIP_RET_QTY                 NUMBER(18,4),
  VIP_RET_AMT_LCL             NUMBER(20,4),
  VIP_RET_PROFIT_AMT_LCL      NUMBER(20,4),
  VIP_RET_MANUAL_MKDN_AMT_LCL NUMBER(20,4),
  VIP_RET_MANUAL_MKUP_AMT_LCL NUMBER(20,4),
  VIP_RET_TAX_AMT_LCL         NUMBER(20,4),
  VIP_RET_EMP_DISC_AMT_LCL    NUMBER(20,4),
  VIP_RET_MANUAL_COUNT        NUMBER(18,4),
  VIP_RET_SCAN_COUNT          NUMBER(18,4));
--1.2.2.CREATE INDEX
ALTER TABLE RADM.W_RTL_SLS_TRX_DP_LC_DY_A
  ADD CONSTRAINT PK_W_RTL_SLS_TRX_DP_LC_DY_A PRIMARY KEY (SLS_TRX_ID, VOUCHER_ID, DT_WID, PROD_DH_WID, ORG_WID)
  USING INDEX 
  TABLESPACE DM_FACT_INDEX
  PCTFREE 10
  INITRANS 12
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );	
--1.2.3.CREATE SEQ
CREATE SEQUENCE W_RTL_SLS_TRX_DP_LC_DY_A_SEQ
MINVALUE 1
MAXVALUE 9999999999999999999999999999
START WITH 1
INCREMENT BY 1
CACHE 20000;
--1.2.4.INSERT TEST DATA
INSERT INTO RADM.W_RTL_SLS_TRX_DP_LC_DY_A
  SELECT W_RTL_SLS_TRX_DP_LC_DY_A_SEQ.NEXTVAL ROW_WID, A.*
    FROM (SELECT F.ORG_WID,
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
            FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F F,
                 RABATCHER.W_PRODUCT_D_RTL_TMP P
           WHERE F.PROD_WID = P.PROD_IT_WID
             AND F.DT_WID BETWEEN
                 1 || TO_CHAR(P.SRC_EFF_FROM_DT, 'YYYYMMDD') || '000' AND
                 1 || TO_CHAR(P.SRC_EFF_TO_DT, 'YYYYMMDD') || '000'
             AND F.DT_WID = 120150823000
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

--1.2.5.存储出过程
W_RTL_SLS_TRX_DP_LC_DY_A_AGG;

--1.3.W_RTL_SLS_TRX_CL_LC_DY_A-------------------------------------------------------------------------
--1.4.W_RTL_SLS_TRX_SC_LC_DY_A-------------------------------------------------------------------------

--*********************************************************************************************************************
--2.RPD模型中文说明
--*********************************************************************************************************************
/*
CN_Retail_As-Was_BBG_Sales_trx_by_Segment
CD_Retail_As-Was_BBG_Sales_trx_by_Segment
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_Net_Sales_Amt_Inc_Tax_EQ
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_Net_Sales_Amt_Inc_Tax_EQ
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_Net_Sales_Amt_Inc_Tax
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_Net_Sales_Amt_Inc_Tax
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_Net_Sales_Amt_Inc_Tax_EQ
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_Net_Sales_Amt_Inc_Tax_EQ
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_Net_Sales_Amt_Inc_Tax
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_Net_Sales_Amt_Inc_Tax
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_N69_Net_Sales_Amt_Inc_Tax_EQ
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_N69_Net_Sales_Amt_Inc_Tax_EQ
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_N69_Net_Sales_Amt_Inc_Tax
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_N69_Net_Sales_Amt_Inc_Tax
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_N69_Net_Sales_Amt_Inc_Tax_EQ
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_N69_Net_Sales_Amt_Inc_Tax_EQ
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_N69_Net_Sales_Amt_Inc_Tax
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_N69_Net_Sales_Amt_Inc_Tax
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_Customer_Count
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_Customer_Count
CN_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_Customer_Count
CD_Retail_As-Was_BBG_Sales_trx_by_Segment_VIP_Customer_Count
*/

SELECT * FROM RADM.W_LOCALIZED_STRING_G T WHERE T.MSG_NUM LIKE '%Retail_As-Was_BBG_Sales_trx_by_Segment%' FOR UPDATE;

--*********************************************************************************************************************
--3.ODI新增接口定义
--*********************************************************************************************************************
--3.1.PLP_RetailSalesTRXDpLcDyLoad
--source：RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP
--target：RADM.W_RTL_SLS_TRX_DP_LC_DY_A
SELECT * FROM RADM.W_RTL_SLS_TRX_DP_LC_DY_A;

--3.2.PLP_RetailSalesTRXLcDyLoad
--source：RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP
--target：RADM.W_RTL_SLS_TRX_LC_DY_A
SELECT * FROM RADM.W_RTL_SLS_TRX_LC_DY_A;
