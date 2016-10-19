--1.TOTAL CHECK
SELECT SLS.C4,
       SLS.C2 SLS_NOTAX_AMT,
       SUPPSLS.C1 SUPP_SLS_NOTAX_AMT,
       SLS.C2 - SUPPSLS.C1 AMT_DIFF
  FROM (SELECT D1.c2 AS c2, D1.c3 AS c3, D1.c4 AS c4
          FROM (SELECT SUM(NVL(T961218.SLS_AMT_LCL, 0) -
                           NVL(T961218.RET_AMT_LCL, 0)) -
                       (SUM(NVL(T961218.SLS_TAX_AMT_LCL, 0) -
                            NVL(T961218.RET_TAX_AMT_LCL, 0))) AS c2,
                       TRUNC(T960506.MCAL_DAY_DT) AS c3,
                       T960506.ROW_WID AS c4,
                       ROW_NUMBER() OVER(PARTITION BY T960506.ROW_WID ORDER BY T960506.ROW_WID ASC) AS c5
                  FROM W_INT_ORG_ATTR_D  T957687 /* Dim_W_INT_ORG_ATTR_D_Retail */,
                       W_INT_ORG_D       T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
                       W_MCAL_DAY_DV     T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
                       W_RTL_SLS_LC_DY_A T961218 /* Fact_W_RTL_SLS_LC_DY_A */
                 WHERE (T957687.SCD1_WID = T964463.SCD1_WID AND
                       T957687.ORG_ATTR23_NAME = '1' AND
                       T960506.ROW_WID = T961218.DT_WID AND
                       T960506.MCAL_CAL_WID = 1.0 AND
                       T961218.ORG_SCD1_WID = T964463.SCD1_WID AND
                       '2010' < T960506.CAL_YEAR AND
                       TRUNC(T960506.MCAL_DAY_DT) BETWEEN
                       TO_DATE('2016-01-01', 'YYYY-MM-DD') AND
                       TO_DATE('2016-03-31', 'YYYY-MM-DD'))
                 GROUP BY T960506.ROW_WID, TRUNC(T960506.MCAL_DAY_DT)) D1
         WHERE (D1.c5 = 1)) SLS,
       (SELECT D1.c1 AS c1, D1.c2 AS c2, D1.c3 AS c3
          FROM (SELECT SUM(T1014905.SUPP_SALES_AMT) AS c1,
                       TRUNC(T960506.MCAL_DAY_DT) AS c2,
                       T960506.ROW_WID AS c3,
                       ROW_NUMBER() OVER(PARTITION BY T960506.ROW_WID ORDER BY T960506.ROW_WID ASC) AS c4
                  FROM W_INT_ORG_ATTR_D   T957687 /* Dim_W_INT_ORG_ATTR_D_Retail */,
                       W_INT_ORG_D        T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
                       W_MCAL_DAY_DV      T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
                       BBG_RA_SLS_LC_DY_A T1014905 /* Fact_BBG_RA_SLS_LC_DY_A */
                 WHERE (T957687.SCD1_WID = T964463.SCD1_WID AND
                       T957687.ORG_ATTR23_NAME = '1' AND
                       T960506.ROW_WID = T1014905.DT_WID AND
                       T960506.MCAL_CAL_WID = 1.0 AND
                       T964463.ROW_WID = T1014905.ORG_WID AND
                       '2010' < T960506.CAL_YEAR AND
                       TRUNC(T960506.MCAL_DAY_DT) BETWEEN
                       TO_DATE('2016-01-01', 'YYYY-MM-DD') AND
                       TO_DATE('2016-03-31', 'YYYY-MM-DD'))
                 GROUP BY T960506.ROW_WID, TRUNC(T960506.MCAL_DAY_DT)) D1
         WHERE (D1.c4 = 1)) SUPPSLS
 WHERE SLS.C4 = SUPPSLS.C3(+)
 ORDER BY SLS.C4;

--2.ITEM DIFF CHECK
SELECT /*+PARALLEL(20)*/
 T1.ITEM,
 T1.LOC,
 T1.DT_WID,
 T1.SLS_NOTAX_AMT,
 T2.SUPP_NOTAX_SALES_AMT,
 ABS(NVL(T1.SLS_NOTAX_AMT, 0) - NVL(T2.SUPP_NOTAX_SALES_AMT, 0)) NOTAX_AMT_DIFF
  FROM (SELECT /*+PARALLEL(T20)*/
         T3.ITEM,
         T3.LOC,
         T3.DT_WID,
         SUM(T3.SLS_QTY) SLS_QTY,
         SUM(SLS_AMT) SLS_AMT,
         SUM(SLS_NOTAX_AMT) SLS_NOTAX_AMT
          FROM (SELECT /*+PARALLEL(20)*/
                 CASE
                   WHEN PK.ITEM IS NULL THEN
                    P.PROD_IT_NUM
                   ELSE
                    PK.ITEM
                 END ITEM,
                 O.ORG_NUM LOC,
                 W.DT_WID,
                 SUM((NVL(W.SLS_QTY, 0) - NVL(W.RET_QTY, 0)) *
                     NVL(PK.PACK_QTY, 1)) SLS_QTY,
                 SUM((NVL(W.SLS_AMT_LCL, 0) - NVL(W.RET_AMT_LCL, 0)) /
                     NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) SLS_AMT,
                 SUM(((NVL(W.SLS_AMT_LCL, 0) - NVL(W.RET_AMT_LCL, 0)) -
                     (NVL(W.SLS_TAX_AMT_LCL, 0) - NVL(W.RET_TAX_AMT_LCL, 0))) /
                     NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) SLS_NOTAX_AMT
                  FROM RADM.W_RTL_SLS_IT_LC_DY_A W,
                       RABATCHER.W_INT_ORG_D_RTL_TMP O,
                       RABATCHER.W_PRODUCT_D_RTL_TMP P,
                       RADM.PACKITEM PK,
                       (SELECT /*+PARALLEL(20)*/
                         PACK_NO, SUM(PK1.PACK_QTY) PACK_QTY
                          FROM PACKITEM PK1
                         GROUP BY PACK_NO) PK2
                 WHERE W.PROD_WID = P.PROD_IT_WID
                   AND W.ORG_WID = O.ORG_WID
                   AND W.DT_WID = &DT_WID
                   AND PK.PACK_NO(+) = P.PROD_IT_NUM
                      /*AND P.PROD_IT_NUM IN ('100075536', '800207722', '100844024')*/
                   AND PK2.PACK_NO(+) = PK.PACK_NO
                 GROUP BY P.PROD_IT_NUM, O.ORG_NUM, W.DT_WID, PK.ITEM) T3
         GROUP BY T3.ITEM, T3.LOC, T3.DT_WID) T1,
       (SELECT /*+PARALLEL(20)*/
         P.PROD_IT_NUM ITEM,
         O.ORG_NUM LOC,
         B.DT_WID,
         SUM(B.SUPP_SALES_QTY) SUPP_SALES_QTY,
         SUM(B.SUPP_SALES_AMT) SUPP_NOTAX_SALES_AMT
          FROM RADM.BBG_RA_SLS_IT_LC_DY_A    B,
               RABATCHER.W_INT_ORG_D_RTL_TMP O,
               RABATCHER.W_PRODUCT_D_RTL_TMP P
         WHERE B.PROD_WID = P.PROD_IT_WID
           AND B.ORG_WID = O.ORG_WID
           AND B.DT_WID = &DT_WID
         GROUP BY P.PROD_IT_NUM, O.ORG_NUM, B.DT_WID) T2
 WHERE T1.ITEM = T2.ITEM(+)
   AND T1.LOC = T2.LOC(+)
   AND T1.DT_WID = T2.DT_WID(+)
   AND ABS(NVL(T1.SLS_NOTAX_AMT, 0) - NVL(T2.SUPP_NOTAX_SALES_AMT, 0)) > 0.1
   AND T1.LOC = &LOCATION;
