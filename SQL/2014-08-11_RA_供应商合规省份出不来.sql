--供应商合规，省份出不来
/* Formatted on 2014/8/11 14:12:29 (QP5 v5.256.13226.35510) */
/* 47ace965 */

  SELECT DISTINCT 0 AS c1,
                  D1.c3 AS c2,
                  D1.c4 AS c3,
                  D1.c5 AS c4,
                  D1.c2 AS c5,
                  D1.c1 AS c6,
                  D1.c6 AS c7
    FROM (  SELECT SUM (T1039043.ORDERED_QTY) AS c1,
                   SUM (T1039043.BBG_REFERENCE_FO1) AS c2,
                   T960506.PER_NAME_MONTH AS c3,
                   CAST (T964333.ORG_HIER12_NUM AS INTEGER) AS c4,
                   T954755.SUPPLIER_NUM AS c5,
                   T960506.CAL_MONTH_WID AS c6
              FROM W_INT_ORG_DH T964333   /* Dim_W_INT_ORG_DH_Retail_As_Was */
                                       ,
                   W_INT_ORG_D T964463     /* Dim_W_INT_ORG_D_Retail_As_Was */
                                      ,
                   W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                        ,
                   W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */
                                        ,
                   W_RTL_SUPPCM_IT_LC_AD_MV T1039043 /* Fact_W_RTL_SUPPCM_IT_LC_AD_F */
             WHERE (    T964333.ROW_WID = T1039043.ORG_DH_WID
                    AND T960506.ROW_WID = T1039043.DT_WID
                    AND T954755.ROW_WID = T1039043.SUPPLIER_WID
                    AND T964333.SCD1_WID = T964463.SCD1_WID
                    AND T954755.SUPPLIER_NUM = '29000531'
                    AND T960506.MCAL_CAL_WID = 1.0
                    AND T960506.PER_NAME_MONTH = '2014 / 07'
                    AND T964463.ROW_WID = T1039043.ORG_WID
                    AND '2010' < T960506.CAL_YEAR)
          GROUP BY T954755.SUPPLIER_NUM,
                   T960506.CAL_MONTH_WID,
                   T960506.PER_NAME_MONTH,
                   CAST (T964333.ORG_HIER12_NUM AS INTEGER)) D1
ORDER BY c2, c3, c4;

--供应商销售，省份可以出来
/* Formatted on 2014/8/11 14:16:57 (QP5 v5.256.13226.35510) */
/* e0572057 */

  SELECT DISTINCT 0 AS c1,
                  D1.c2 AS c2,
                  D1.c3 AS c3,
                  D1.c4 AS c4,
                  D1.c1 AS c5,
                  D1.c5 AS c6
    FROM (  SELECT SUM (T1026009.SUPP_SALES_QTY) AS c1,
                   T960458.PER_NAME_MONTH AS c2,
                   CAST (T964333.ORG_HIER12_NUM AS INTEGER) AS c3,
                   T954755.SUPPLIER_NUM AS c4,
                   T960458.ROW_WID AS c5
              FROM W_INT_ORG_DH T964333   /* Dim_W_INT_ORG_DH_Retail_As_Was */
                                       ,
                   W_INT_ORG_D T964463     /* Dim_W_INT_ORG_D_Retail_As_Was */
                                      ,
                   W_MONTH_D T960458 /* Dim_W_MONTH_D_Retail_Gregorian_Calendar */
                                    ,
                   W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */
                                        ,
                   BBG_RA_SLS_LC_MN_A T1026009   /* Fact_BBG_RA_SLS_LC_MN_A */
             WHERE (    T964333.ROW_WID = T1026009.ORG_DH_WID
                    AND T960458.ROW_WID = T1026009.MN_WID
                    AND T954755.ROW_WID = T1026009.SUPPLIER_WID
                    AND T964333.SCD1_WID = T964463.SCD1_WID
                    AND T954755.SUPPLIER_NUM = '29000531'
                    AND T960458.PER_NAME_MONTH = '2014 / 07'
                    AND T964463.ROW_WID = T1026009.ORG_WID
                    AND '2010' < T960458.CAL_YEAR)
          GROUP BY T954755.SUPPLIER_NUM,
                   T960458.ROW_WID,
                   T960458.PER_NAME_MONTH,
                   CAST (T964333.ORG_HIER12_NUM AS INTEGER)) D1
ORDER BY c2, c3, c4;

SELECT *
  FROM RADM.W_INT_ORG_DH D
 WHERE D.ROW_WID IN
       (SELECT DISTINCT T.ORG_DH_WID FROM W_RTL_SUPPCM_IT_LC_AD_MV T);
SELECT *
  FROM RADM.W_INT_ORG_DH D
 WHERE D.ROW_WID IN
       (SELECT DISTINCT T.ORG_DH_WID FROM BBG_RA_SLS_LC_MN_A T);
			 
SELECT * FROM RMS.CMX_ITEM_SUPP_COUNTRY_LOC T WHERE T.SUPPLIER=29000531;
