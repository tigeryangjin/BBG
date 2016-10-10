--1.销售价格带分析
SELECT N1.SALES_PRICE 价格带,
       COUNT(N1.PROD_WID) 销售单品数,
       SUM(N1.SALES_AMT) 销售金额,
       RATIO_TO_REPORT(SUM(N1.SALES_AMT)) OVER() 销售金额占比,
       SUM(N1.PROFIT_AMT) 毛利额,
       RATIO_TO_REPORT(SUM(N1.PROFIT_AMT)) OVER() 毛利额占比
  FROM (SELECT T.PROD_WID,
               SUM(T.SLS_QTY - T.RET_QTY) SALES_QTY,
               SUM(T.SLS_AMT_LCL - T.RET_AMT_LCL) SALES_AMT,
               SUM(T.SLS_PROFIT_AMT_LCL - T.RET_PROFIT_AMT_LCL) PROFIT_AMT,
               TRUNC(DECODE(SUM(T.SLS_QTY - T.RET_QTY),
                            0,
                            0,
                            SUM(T.SLS_AMT_LCL - T.RET_AMT_LCL) /
                            SUM(T.SLS_QTY - T.RET_QTY)),
                     -1) SALES_PRICE
          FROM RADM.W_RTL_SLS_IT_DY_A T
         WHERE T.DT_WID BETWEEN 120150101000 AND 120150831000
           AND EXISTS
         (SELECT 1
                  FROM RADM.W_PROD_CAT_DH CAT, RADM.W_PRODUCT_D P
                 WHERE T.PROD_WID = P.ROW_WID
                   AND P.PROD_CAT5_WID_AS_WAS = CAT.ROW_WID
                   AND CAT.LVL5ANC_PRODCAT_ID IN (271, 363, 371, 382))
         GROUP BY T.PROD_WID) N1
 GROUP BY N1.SALES_PRICE
 ORDER BY 1;

--2.
