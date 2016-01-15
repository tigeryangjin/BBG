/* Formatted on 2016/1/15 16:35:21 (QP5 v5.256.13226.35510) */
/* a5d83a34 */

SELECT DISTINCT 0 AS c1,
                D1.c3 AS c2,
                D1.c2 AS c3,
                D1.c1 AS c4,
                D1.c4 AS c5
  FROM (  SELECT SUM (T1039469.SLS_NOTAX_COST) AS c1,
                 SUM (T1039469.INV_SOH_COST_AMT) AS c2,
                 CAST (T956657.LVL5ANC_PRODCAT_ID AS INTEGER) AS c3,
                 CONCAT (
                    CONCAT (
                       CONCAT (CONCAT ('CLS', '~'), T956657.LVL6ANC_PRODCAT_ID),
                       '~'),
                    T956657.LVL5ANC_PRODCAT_ID)
                    AS c4
            FROM W_MONTH_D T960458 /* Dim_W_MONTH_D_Retail_Gregorian_Calendar */
                                  ,
                 W_PROD_CAT_DH T956657    /* Dim_W_PROD_CAT_DH_Class_As_Was */
                                      ,
                 JIN_RA_INVSLS_BM_CL_LC_MN_FV T1039469 /* Fact_JIN_RA_INVSLS_BM_CL_LC_MN_FV */
           WHERE (    T956657.LEVEL_NAME = 'CLS'
                  AND T956657.ROW_WID = T1039469.PROD_DH_WID
                  AND T960458.ROW_WID = T1039469.MN_WID
                  AND CAST (T956657.LVL5ANC_PRODCAT_ID AS INTEGER) = 214
                  AND '2010' < T960458.CAL_YEAR
                  AND T960458.PER_NAME_MONTH BETWEEN '2015 / 01'
                                                 AND '2015 / 12')
        GROUP BY CAST (T956657.LVL5ANC_PRODCAT_ID AS INTEGER),
                 CONCAT (
                    CONCAT (
                       CONCAT (CONCAT ('CLS', '~'),
                               T956657.LVL6ANC_PRODCAT_ID),
                       '~'),
                    T956657.LVL5ANC_PRODCAT_ID)) D1
