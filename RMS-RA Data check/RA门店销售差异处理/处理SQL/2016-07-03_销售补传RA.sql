--2016.7.01（120002），2016.7.02（120089）销售补传RA


--1.清除ODI日志
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
TRUNCATE TABLE RADM.C_LOAD_DATES;

--2.
TRUNCATE TABLE RA_RMS.BBG_XTERN_RDWT;
INSERT /*+PARALLEL(16)*/
INTO RA_RMS.BBG_XTERN_RDWT
  SELECT /*+PARALLEL(16)*/
   *
    FROM RA_RMS.BBG_XTERN_RDWT_HIST
   WHERE LOCATION='0000120089'
	 AND BUSINESS_DT = 20160702;
COMMIT;

--3.清空tmp表
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

--4.修改BBG_RA_ITEM_LOC_SOH_V的日期为重导日期
SELECT * FROM RA_RMS.BBG_RA_ITEM_LOC_SOH_V;

--5.检查W_RTL_SLS_TRX_IT_LC_DY_FS
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;



--6.SIL

--7.PLP

--8.修复移动平台销售

