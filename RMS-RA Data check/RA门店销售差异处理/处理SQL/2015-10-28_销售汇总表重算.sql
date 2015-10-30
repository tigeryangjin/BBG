--1.DEL PLP SALES TABLE
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_CL_DY_CUR_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_CL_LC_DY_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_CL_LC_DY_CUR_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_DP_DY_CUR_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_DP_LC_DY_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_DP_LC_DY_CUR_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_IT_DY_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_IT_DY_SN_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_IT_LC_DY_A T
 WHERE T.DT_WID = 120151028000; --此表数据量很大，需要分批删除。
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_IT_LC_DY_SN_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_LC_DY_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_SC_DY_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_SC_DY_CUR_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_SC_LC_DY_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_SC_LC_DY_CUR_A T
 WHERE T.DT_WID = 120151028000;
COMMIT;
DELETE /*+PARALLEL(T,16)*/
W_RTL_SLS_TRX_IT_LC_DY_F T
 WHERE T.DT_WID = 120151028000;
COMMIT;
--2.
--清空BBG_XTERN_RDWT
TRUNCATE TABLE RA_RMS.BBG_XTERN_RDWT;

--从BBG_XTERN_RDWT_HIST插入BBG_XTERN_RDWT
INSERT INTO /*+PARALLEL(T,20)*/RA_RMS.BBG_XTERN_RDWT
SELECT /*+PARALLEL(T,20)*/ * FROM RA_RMS.BBG_XTERN_RDWT_HIST WHERE BUSINESS_DT= '20151028';
COMMIT;

--清空ODI日志
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
TRUNCATE TABLE RADM.C_LOAD_DATES;

--清空tmp表
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_SN_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_IT_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_CUR_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_RC_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_SC_LC_DY_TMP;
TRUNCATE TABLE RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP;

--修改BBG_RA_ITEM_LOC_SOH_V的日期为重导日期
SELECT * FROM RA_RMS.BBG_RA_ITEM_LOC_SOH_V;

--检查W_RTL_SLS_TRX_IT_LC_DY_FS数据
SELECT DISTINCT T.DAY_DT FROM W_RTL_SLS_TRX_IT_LC_DY_FS T;

--检查W_RTL_SLS_TRX_IT_LC_DY_TMP数据
SELECT DISTINCT T.DT_WID FROM RABATCHER.W_RTL_SLS_TRX_IT_LC_DY_TMP T;

