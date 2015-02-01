DROP TABLE RADM.JIN_LXJ_TMP;

CREATE TABLE RMS.JIN_LXJ_TMP AS
SELECT * FROM RADM.JIN_LXJ_TMP@RMS_RA;

DROP TABLE RMS.JIN_LXJ_TMP;

CREATE TABLE ZFL.JIN_LXJ_TMP1 AS
SELECT * FROM RMS.JIN_LXJ_TMP@RTK;

DROP TABLE ZFL.JIN_LXJ_TMP;

CREATE TABLE RADM.JIN_LXJ_TMP AS
SELECT SUBSTR(T.DT_WID, 2, 8) DAY,
       O.ORG_NUM LOC,
       P.LVL6ANC_PRODCAT_ID DEPT,
			 SUM(T.SLS_QTY-T.RET_QTY) QTY,
       SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) AMT,
       SUM(T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL) PROFIT
  FROM RADM.W_RTL_SLS_DP_LC_DY_A T,
       RADM.W_INT_ORG_D          O,
       RADM.W_PROD_CAT_DH        P
 WHERE T.ORG_WID = O.ROW_WID
   AND T.PROD_DH_WID = P.ROW_WID
   AND P.LEVEL_NAME = 'DEPT'
   AND T.DT_WID BETWEEN 120130601000 AND 120140531000
 GROUP BY SUBSTR(T.DT_WID, 2, 8), O.ORG_NUM, P.LVL6ANC_PRODCAT_ID
 ORDER BY SUBSTR(T.DT_WID, 2, 8), O.ORG_NUM, P.LVL6ANC_PRODCAT_ID;


SELECT (T.SLS_AMT_LCL - T.RET_AMT_LCL) -
       (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL),
       T.SLS_AMT_LCL,
       T.RET_AMT_LCL,
       T.SLS_TAX_AMT_LCL,
       T.RET_TAX_AMT_LCL,
			 T.INTEGRATION_ID
  FROM RADM.W_RTL_SLS_DP_LC_DY_A T
 WHERE T.DT_WID BETWEEN 120140601000 AND 120150110000
   AND (T.SLS_AMT_LCL - T.RET_AMT_LCL) -
       (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL) = 0;
