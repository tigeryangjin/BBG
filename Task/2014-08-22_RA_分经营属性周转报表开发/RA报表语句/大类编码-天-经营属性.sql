/* Formatted on 2014/11/10 9:44:46 (QP5 v5.256.13226.35510) */
/* 312e4768 */

SELECT DISTINCT 0 AS c1, D1.c2 AS c2, D1.c3 AS c3, D1.c4 AS c4, D1.c1 AS c5
  FROM (SELECT SUM(T1014736.SUPP_SALES_AMT) AS c1,
               CASE
                 WHEN T1039862.BUSINESS_MODE = 'JX' THEN
                  '经销'
                 WHEN T1039862.BUSINESS_MODE = 'DX' THEN
                  '代销'
                 WHEN T1039862.BUSINESS_MODE = 'LY' THEN
                  '联营'
                 WHEN T1039862.BUSINESS_MODE = 'ZL' THEN
                  '租赁'
                 WHEN T1039862.BUSINESS_MODE = 'ZS' THEN
                  '招商'
               END AS c2,
               CAST(T956667.LVL6ANC_PRODCAT_ID AS INTEGER) AS c3,
               CASE
                 WHEN T1039862.BUSINESS_MODE = 'JX' THEN
                  '1'
                 WHEN T1039862.BUSINESS_MODE = 'DX' THEN
                  '2'
                 WHEN T1039862.BUSINESS_MODE = 'LY' THEN
                  '3'
                 WHEN T1039862.BUSINESS_MODE = 'ZL' THEN
                  '4'
                 WHEN T1039862.BUSINESS_MODE = 'ZS' THEN
                  '5'
               END AS c4
          FROM (SELECT DISTINCT T.BUSINESS_MODE,
                                CASE
                                  WHEN T.BUSINESS_MODE = 'JX' THEN
                                   '经销'
                                  WHEN T.BUSINESS_MODE = 'DX' THEN
                                   '代销'
                                  WHEN T.BUSINESS_MODE = 'LY' THEN
                                   '联营'
                                  WHEN T.BUSINESS_MODE = 'ZL' THEN
                                   '租赁'
                                  WHEN T.BUSINESS_MODE = 'ZS' THEN
                                   '招商'
                                  ELSE
                                   NULL
                                END BUSINESS_MODE_DESC
                  FROM RADM.BBG_RA_ITEM_LOC_D T) T1039862,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               W_PROD_CAT_DH T956667 /* Dim_W_PROD_CAT_DH_Department_As_Was */,
               BBG_RA_SLS_DP_LC_DY_A T1014736 /* Fact_BBG_RA_SLS_DP_LC_DY_A */
         WHERE (T956667.ROW_WID = T1014736.PROD_DH_WID AND
               T960506.ROW_WID = T1014736.DT_WID AND
               T956667.LEVEL_NAME = 'DEPT' AND T960506.MCAL_CAL_WID = 1.0 AND
               T1014736.BBG_REFERENCE_DO1 = T1039862.BUSINESS_MODE AND
               TRUNC(T960506.MCAL_DAY_DT) =
               TO_DATE('2014-11-08', 'YYYY-MM-DD') AND
               '2010' < T960506.CAL_YEAR)
         GROUP BY CASE
                    WHEN T1039862.BUSINESS_MODE = 'JX' THEN
                     '1'
                    WHEN T1039862.BUSINESS_MODE = 'DX' THEN
                     '2'
                    WHEN T1039862.BUSINESS_MODE = 'LY' THEN
                     '3'
                    WHEN T1039862.BUSINESS_MODE = 'ZL' THEN
                     '4'
                    WHEN T1039862.BUSINESS_MODE = 'ZS' THEN
                     '5'
                  END,
                  CASE
                    WHEN T1039862.BUSINESS_MODE = 'JX' THEN
                     '经销'
                    WHEN T1039862.BUSINESS_MODE = 'DX' THEN
                     '代销'
                    WHEN T1039862.BUSINESS_MODE = 'LY' THEN
                     '联营'
                    WHEN T1039862.BUSINESS_MODE = 'ZL' THEN
                     '租赁'
                    WHEN T1039862.BUSINESS_MODE = 'ZS' THEN
                     '招商'
                  END,
                  CAST(T956667.LVL6ANC_PRODCAT_ID AS INTEGER)) D1
 ORDER BY c3, c4
