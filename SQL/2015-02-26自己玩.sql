SELECT T1.D,
       SUBSTR('0' || T1.M, LENGTH('0' || T1.M) - 3, 2) || ':' ||
       SUBSTR('0' || T1.M, LENGTH('0' || T1.M) - 1, 2) || ':00' M,
       T1.QTY,
       T1.AMT,
       T1.R
  FROM (SELECT /*+PARALLEL(T,20)*/
         TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') D,
         T.MIN_WID M,
         COUNT(1) R,
         SUM(T.SLS_QTY - T.RET_QTY) QTY,
         SUM(T.SLS_AMT_LCL - T.RET_AMT_LCL) AMT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
         GROUP BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD'), T.MIN_WID
         ORDER BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD'), T.MIN_WID) T1
 WHERE T1.D = DATE '2015-02-26';
