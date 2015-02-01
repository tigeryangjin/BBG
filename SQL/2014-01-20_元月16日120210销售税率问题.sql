/*----------------------------------------------------------*/
--2014.01.16日门店120210因为设置成未税的门店(RMS.STORE.VAT_INCLUDE_IND),导致当日销售没有税额,然后在1月17日调整

--SA_TRAN-含税销售金额
SELECT SD.BUSINESS_DATE, SUM(SH.VALUE)
	FROM SA_TRAN_HEAD SH, SA_STORE_DAY SD
 WHERE SH.STORE_DAY_SEQ_NO = SD.STORE_DAY_SEQ_NO
	 AND SH.STORE = '120210'
	 AND SH.DAY IN (17, 16)
	 AND SD.BUSINESS_DATE BETWEEN DATE '2014-01-16' AND DATE
 '2014-01-17'
 GROUP BY SD.BUSINESS_DATE;

--TRAN_DATA 不含税
SELECT tran_date, SUM(total_retail)
	from tran_data_history t
 WHERE LOCATION = 120210
	 AND tran_date BETWEEN DATE '2014-01-16' AND DATE
 '2014-01-17'
	 AND tran_code IN (2, 5)
 GROUP BY tran_date;

--TRAN_DATA 含税
SELECT tran_date, SUM(total_retail)
	from tran_data_history t
 WHERE LOCATION = 120210
	 AND tran_date BETWEEN DATE '2014-01-16' AND DATE
 '2014-01-17'
	 AND tran_code IN (1, 3)
 GROUP BY tran_date;

--BBG_XTERN_RDWT_HIST
SELECT SUM(Case
						 When XTERN_RDWT.SALES_SIGN = 'P' Then
							XTERN_RDWT.TOT_TRANSACTION_VAL / 10000
						 When XTERN_RDWT.SALES_SIGN = 'N' Then
							(XTERN_RDWT.TOT_TRANSACTION_VAL / 10000) * -1
						 Else
							NULL
					 End)
	FROM RA_RMS.BBG_XTERN_RDWT_HIST XTERN_RDWT
 WHERE XTERN_RDWT.LOCATION = '0000120210'
	 AND XTERN_RDWT.BUSINESS_DT = '20140116';

SELECT * FROM STORE;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--删除销售表数据
DELETE W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP T
 WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_CL_DY_CUR_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_CL_LC_DY_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_CL_LC_DY_CUR_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_DP_DY_CUR_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_DP_LC_DY_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_DP_LC_DY_CUR_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_IT_DY_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_IT_DY_SN_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_IT_LC_DY_A T WHERE T.DT_WID = '120140116000'; --此表数据量很大，需要分批删除。
COMMIT;
DELETE W_RTL_SLS_IT_LC_DY_SN_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_LC_DY_A T WHERE T.DT_WID = '120140116000';
COMMIT;
DELETE W_RTL_SLS_SC_DY_A T WHERE T.DT_WID = '120140116000'; --
COMMIT;
DELETE W_RTL_SLS_SC_DY_CUR_A T WHERE T.DT_WID = '120140116000'; --
COMMIT;
DELETE W_RTL_SLS_SC_LC_DY_A T WHERE T.DT_WID = '120140116000'; --
COMMIT;
DELETE W_RTL_SLS_SC_LC_DY_CUR_A T WHERE T.DT_WID = '120140116000'; --
COMMIT;
DELETE W_RTL_SLS_CUST_IT_LC_DY_F T WHERE T.DT_WID = '120140116000';
COMMIT;
--2013.01.16门店120210销售数据重传
TRUNCATE TABLE RA_RMS.BBG_XTERN_RDWT;

INSERT INTO RA_RMS.BBG_XTERN_RDWT
	SELECT *
		FROM RA_RMS.BBG_XTERN_RDWT_HIST T
	 WHERE T.BUSINESS_DT = '20140116'
		 /*AND T.LOCATION = '0000120210'*/;

TRUNCATE TABLE ra_rms.C_LOAD_DATES;

--修改RA_RMS.BBG_RA_ITEM_LOC_SOH_V视图的日期条件,之后要记住修改回来!!!
RA_RMS.BBG_RA_ITEM_LOC_SOH_V;

SELECT * FROM W_RTL_SLS_TRX_IT_LC_DY_FS;

TRUNCATE TABLE RADM.C_LOAD_DATES;

--删除W_RTL_SLS_TRX_IT_LC_DY_F的120210门店的销售(2014.01.16)
CREATE TABLE RADM.W_RTL_SLS_TRX_IT_LC_DY_F_40116 AS
	SELECT *
		FROM W_RTL_SLS_TRX_IT_LC_DY_F T
	 WHERE T.ORG_WID = 100006
		 AND T.DT_WID = '120140116000';

DELETE W_RTL_SLS_TRX_IT_LC_DY_F T
 WHERE T.ORG_WID = 100006
	 AND T.DT_WID = '120140116000';

SELECT * FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;
SELECT * FROM W_RTL_SLS_TRX_IT_LC_DY_F;
SELECT * FROM W_INT_ORG_D T;

--检查税率
SELECT *
	FROM W_RTL_SLS_IT_LC_DY_A T
 WHERE T.ORG_WID = 100006
	 AND T.DT_WID = '120140116000';
