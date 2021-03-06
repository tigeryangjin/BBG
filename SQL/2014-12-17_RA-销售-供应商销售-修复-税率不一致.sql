SELECT P.PROD_NUM,
       T3.PROD_WID,
       T3.DT_WID,
       T3.WQTY,
       T3.SQTY,
       T3.WAMT,
       T3.SAMT,
       T3.DIFF
  FROM (SELECT /*+PARALLEL(W,20) PARALLEL(B,20)*/
         W.PROD_WID,
         W.DT_WID,
         W.WQTY,
         B.SQTY,
         W.WAMT,
         B.SAMT,
         ABS(W.WAMT - B.SAMT) DIFF
          FROM (SELECT /*+PARALLEL(T1,20)*/
                 T1.PROD_WID,
                 T1.DT_WID,
                 ROUND(SUM(T1.SLS_QTY - T1.RET_QTY), 4) WQTY,
                 ROUND(SUM((T1.SLS_AMT_LCL - T1.RET_AMT_LCL) -
                           (T1.SLS_TAX_AMT_LCL - T1.RET_TAX_AMT_LCL)),
                       4) WAMT
                  FROM RADM.W_RTL_SLS_IT_DY_A T1
                 WHERE T1.DT_WID BETWEEN 120140118000 AND 120140826000
                 GROUP BY T1.PROD_WID, T1.DT_WID) W,
               (SELECT /*+PARALLEL(T2,20)*/
                 T2.PROD_WID,
                 T2.DT_WID,
                 ROUND(SUM(T2.SUPP_SALES_QTY), 4) SQTY,
                 ROUND(SUM(T2.SUPP_SALES_AMT), 4) SAMT
                  FROM RADM.BBG_RA_SLS_IT_DY_A T2
                 WHERE T2.DT_WID BETWEEN 120140118000 AND 120140826000
                 GROUP BY T2.PROD_WID, T2.DT_WID) B
         WHERE W.PROD_WID = B.PROD_WID
           AND W.DT_WID = B.DT_WID
           AND W.WQTY = B.SQTY
           AND ABS(W.WAMT - B.SAMT) > 0.1) T3,
       RADM.W_PRODUCT_D P
 WHERE T3.PROD_WID = P.ROW_WID;

SELECT * FROM RADM.W_RTL_SLS_IT_DY_A T WHERE T.DT_WID = 120140826000;

SELECT * FROM RADM.BBG_RA_SLS_IT_DY_A T WHERE T.DT_WID = 120140826000;

SELECT T.PROD_WID, T.DT_WID, COUNT(1)
  FROM RADM.W_RTL_SLS_IT_DY_A T
 WHERE T.DT_WID = 120140826000
 GROUP BY T.PROD_WID, T.DT_WID
HAVING COUNT(1) > 1;
