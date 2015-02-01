/* Formatted on 2014/7/23 17:01:52 (QP5 v5.256.13226.35510) */
/* acf2242e */
SELECT DISTINCT 0 AS c1,
                D1.c4 AS c2,
                D1.c5 AS c3,
                D1.c3 - D1.c2 AS c4,
                D1.c1 AS c5,
                D1.c6 AS c6
  FROM (SELECT SUM(NVL(T961218.SLS_QTY, 0) - NVL(T961218.RET_QTY, 0)) AS c1,
               SUM(NVL(T961218.SLS_TAX_AMT_LCL, 0) -
                   NVL(T961218.RET_TAX_AMT_LCL, 0)) AS c2,
               SUM(NVL(T961218.SLS_AMT_LCL, 0) - NVL(T961218.RET_AMT_LCL, 0)) AS c3,
               TRUNC(T960506.MCAL_DAY_DT) AS c4,
               CAST(T964333.ORG_HIER11_NUM AS INTEGER) AS c5,
               T960506.ROW_WID AS c6
          FROM W_INT_ORG_DH      T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */,
               W_INT_ORG_D       T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
               W_MCAL_DAY_DV     T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               W_RTL_SLS_LC_DY_A T961218 /* Fact_W_RTL_SLS_LC_DY_A */
         WHERE (T961218.ORG_DH_WID = T964333.ROW_WID AND
               T961218.ORG_SCD1_WID = T964463.SCD1_WID AND
               T960506.ROW_WID = T961218.DT_WID AND
               T960506.MCAL_CAL_WID = 1.0 AND
               T964333.SCD1_WID = T964463.SCD1_WID AND
               CAST(T964463.ORG_NUM AS INTEGER) = 130024 AND
               '2010' < T960506.CAL_YEAR)
         GROUP BY T960506.ROW_WID,
                  CAST(T964333.ORG_HIER11_NUM AS INTEGER),
                  TRUNC(T960506.MCAL_DAY_DT)) D1
 ORDER BY c2, c3
