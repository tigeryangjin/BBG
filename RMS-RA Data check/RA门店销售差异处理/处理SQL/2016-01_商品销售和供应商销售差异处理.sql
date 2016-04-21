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
