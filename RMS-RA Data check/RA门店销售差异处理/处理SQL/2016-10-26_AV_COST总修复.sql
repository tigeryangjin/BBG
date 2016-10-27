--7 days must fix
--2016/10/10
--2016/10/19
--2016/10/20
--2016/10/21
--2016/10/22
--2016/10/23
--2016/10/24

--1.w_rtl_sls_trx_it_lc_dy_fs_bak
--TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK;
TRUNCATE TABLE RA_RMS.BBG_XTERN_RDWT;
INSERT INTO RA_RMS.BBG_XTERN_RDWT
SELECT /*+PARALLEL(16)*/ * FROM RA_RMS.BBG_XTERN_RDWT_HIST T WHERE T.BUSINESS_DT=20161010;
COMMIT;

--1.1.modify date
SELECT * FROM RA_RMS.BBG_RA_ITEM_LOC_SOH_V;
SELECT * FROM RADM.BBG_RA_SLS_TRX_JL_VI;

--1.3.Master_SDE_BBG_Retail_SalesTransactionFact_FIX
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;

SELECT DISTINCT DAY_DT FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
SELECT COUNT(1) FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;


INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK
  SELECT /*+PARALLEL(16)*/
   *
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
COMMIT;

--2.SIL
--2.1.delete w_rtl_sls_trx_it_lc_dy_f
ALTER SESSION ENABLE PARALLEL DML;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161010000;
COMMIT;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161019000;
COMMIT;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161020000;
COMMIT;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161021000;
COMMIT;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161022000;
COMMIT;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161023000;
COMMIT;
DELETE /*+PARALLEL(16)*/ RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID=120161024000;
COMMIT;
ALTER SESSION DISABLE PARALLEL DML;

--2.2.BBG_SIL_Retail_SalesTransactionFact
TRUNCATE TABLE RADM.C_LOAD_DATES;
TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
  SELECT /*+PARALLEL(16)*/
   *
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK T
   WHERE T.DAY_DT = DATE '2016-10-10';
COMMIT;

--2.3.bakcup 
SELECT DISTINCT DT_WID FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

TRUNCATE TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP_BK;
INSERT INTO RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP_BK
SELECT /*+PARALLEL(16)*/ * FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;
COMMIT;

--3.plp
--3.1.delete agg table
CALL BBG_RA_DEL_SLS_DT(120161010000);
CALL BBG_RA_DEL_SLS_DT(120161019000);
CALL BBG_RA_DEL_SLS_DT(120161020000);
CALL BBG_RA_DEL_SLS_DT(120161021000);
CALL BBG_RA_DEL_SLS_DT(120161022000);
CALL BBG_RA_DEL_SLS_DT(120161023000);
CALL BBG_RA_DEL_SLS_DT(120161024000);

--3.2.insert into W_RTL_SLS_TRX_IT_LC_DY_TMP
TRUNCATE TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;
INSERT INTO RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP
SELECT /*+PARALLEL(32)*/ * FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP_BK;
COMMIT;

--4.PLP_SALES_TRANSACTION

--5.

--6.

--*********************************************************************
--second fix 
--*********************************************************************
--1.confirm item_loc list
--2016/10/19 item:103526030 loc:130008 
SELECT *
  FROM (SELECT /*+PARALLEL(16)*/
         T.TRAN_DATE,
         T.TRAN_CODE,
         T.LOCATION,
         T.ITEM,
         SUM(T.UNITS) UNITS,
         SUM(T.TOTAL_COST) TOTAL_COST
          FROM TRAN_DATA_HISTORY T
         WHERE T.TRAN_CODE = 3
           AND T.TRAN_DATE = DATE '2016-10-20'
         GROUP BY T.TRAN_DATE, T.TRAN_CODE, T.LOCATION, T.ITEM) A
 WHERE A.UNITS = 0
   AND A.TOTAL_COST <> 0;

--2.
SELECT /*+PARALLEL(16)*/
 T.DAY_DT,
 T.ORG_NUM,
 T.PROD_IT_NUM,
 SUM(T.RET_PROFIT_AMT_LCL) RET_PROFIT_AMT_LCL,
 SUM(T.RET_AMT_LCL - T.RET_TAX_AMT_LCL) NOTAX_RET_AMT,
 SUM(T.RET_AMT_LCL - T.RET_TAX_AMT_LCL) - SUM(T.RET_PROFIT_AMT_LCL) DIFF_COST
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK T
 WHERE T.DAY_DT = DATE '2016-10-20'
   AND T.ORG_NUM = '130008'
   AND T.PROD_IT_NUM = '103526030'
 GROUP BY T.DAY_DT, T.ORG_NUM, T.PROD_IT_NUM;
 
--2.1 
TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
  SELECT *
    FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_BAK T
   WHERE T.DAY_DT = DATE '2016-10-20'
     AND T.ORG_NUM = '120129'
     AND T.PROD_IT_NUM = '102673847'
		 AND T.RET_QTY<>0;
COMMIT;

SELECT T.DAY_DT,
       T.ORG_NUM,
       T.PROD_IT_NUM,
       T.SLS_QTY,
       T.SLS_AMT_LCL,
       T.SLS_PROFIT_AMT_LCL,
       T.SLS_TAX_AMT_LCL,
       T.RET_QTY,
       T.RET_AMT_LCL,
       T.RET_PROFIT_AMT_LCL,
       T.RET_TAX_AMT_LCL,
			 T.RET_AMT_LCL-T.RET_TAX_AMT_LCL NOTAX_RET_AMT,
			 T.RET_AMT_LCL-T.RET_TAX_AMT_LCL-T.RET_PROFIT_AMT_LCL DIFF_AMT
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS T;
--2.2
UPDATE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS T
   SET T.RET_PROFIT_AMT_LCL      = T.RET_AMT_LCL - T.RET_TAX_AMT_LCL -
                                   T.RET_PROFIT_AMT_LCL,
       T.SLS_QTY                 = 0,
       T.SLS_AMT_LCL             = 0,
       T.SLS_PROFIT_AMT_LCL      = 0,
       T.SLS_MANUAL_MKDN_AMT_LCL = 0,
       T.SLS_MANUAL_MKUP_AMT_LCL = 0,
       T.SLS_TAX_AMT_LCL         = 0,
       T.SLS_EMP_DISC_AMT_LCL    = 0,
       T.SLS_MANUAL_COUNT        = 0,
       T.SLS_SCAN_COUNT          = 0,
       T.RET_QTY                 = 0,
       T.RET_AMT_LCL             = 0,
       T.RET_MANUAL_MKDN_AMT_LCL = 0,
       T.RET_MANUAL_MKUP_AMT_LCL = 0,
       T.RET_TAX_AMT_LCL         = 0,
       T.RET_EMP_DISC_AMT_LCL    = 0,
       T.RET_MANUAL_COUNT        = 0,
       T.RET_SCAN_COUNT          = 0,
       T.SLS_COUPON_AMT_LCL      = 0,
       T.RET_COUPON_AMT_LCL      = 0,
       T.SLS_TAX_COUPON_AMT_LCL  = 0,
       T.RET_TAX_COUPON_AMT_LCL  = 0
 WHERE T.RET_QTY <> 0;

SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;

--3.backup fs
CREATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_COST AS
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
TRUNCATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_COST;

INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_COST
  SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
COMMIT;

SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS_COST;

--4.

--5.
