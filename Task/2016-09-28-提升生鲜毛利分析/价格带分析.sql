--1.���ۼ۸������
SELECT N1.SALES_PRICE �۸��,
       COUNT(N1.PROD_WID) ���۵�Ʒ��,
       SUM(N1.SALES_AMT) ���۽��,
       RATIO_TO_REPORT(SUM(N1.SALES_AMT)) OVER() ���۽��ռ��,
       SUM(N1.PROFIT_AMT) ë����,
       RATIO_TO_REPORT(SUM(N1.PROFIT_AMT)) OVER() ë����ռ��
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
