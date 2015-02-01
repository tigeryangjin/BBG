/* Formatted on 2013-11-20 10:08:44 (QP5 v5.185.11230.41888) */
/* 16ffc7d0 */

SELECT D1.c1 AS c1,
       D1.c2 AS c2,
       D1.c3 AS c3,
       D1.c4 AS c4,
       D1.c5 AS c5,
       D1.c6 AS c6,
       D1.c7 AS c7,
       D1.c8 AS c8,
       D1.c9 AS c9,
       D1.c10 AS c10,
       D1.c11 AS c11
  FROM (  SELECT SUM (NVL (T956076.SLS_QTY, 0) - NVL (T956076.RET_QTY, 0))
                    AS c1,
                 SUM (
                      NVL (T956076.SLS_PROFIT_AMT_LCL, 0)
                    - NVL (T956076.RET_PROFIT_AMT_LCL, 0))
                    AS c2,
                 SUM (
                      NVL (T956076.SLS_TAX_AMT_LCL, 0)
                    - NVL (T956076.RET_TAX_AMT_LCL, 0))
                    AS c3,
                 SUM (
                    NVL (T956076.SLS_AMT_LCL, 0) - NVL (T956076.RET_AMT_LCL, 0))
                    AS c4,
                 CAST (T955085.LVL6ANC_PRODCAT_ID AS INTEGER) AS c5,
                 T18745.PRODUCT_NAME AS c6,
                 T14449.PROD_NUM AS c7,
                 T953980.ORG_NAME AS c8,
                 CAST (T964463.ORG_NUM AS INTEGER) AS c9,
                 T964463.ROW_WID AS c10,
                 T14449.ROW_WID AS c11,
                 ROW_NUMBER ()
                 OVER (PARTITION BY T14449.ROW_WID, T964463.ROW_WID
                       ORDER BY T14449.ROW_WID ASC, T964463.ROW_WID ASC)
                    AS c12
            FROM (SELECT DATASOURCE_NUM_ID,
                         INTEGRATION_ID,
                         ORG_DESCR,
                         ORG_NAME,
                         LANGUAGE_CODE
                    FROM W_INT_ORG_D_TL
                   WHERE LANGUAGE_CODE = 'ZHS') T953980,
                 W_INT_ORG_DH T964333     /* Dim_W_INT_ORG_DH_Retail_As_Was */
                                     ,
                 W_INT_ORG_D T964463       /* Dim_W_INT_ORG_D_Retail_As_Was */
                                    ,
                 W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                      ,
                 (SELECT T.*
                    FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                   WHERE     T.SCD1_WID = A.SCD1_WID
                         AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                 (SELECT DATASOURCE_NUM_ID,
                         INTEGRATION_ID,
                         PRODUCT_DESCR,
                         PRODUCT_NAME,
                         LANGUAGE_CODE
                    FROM W_PRODUCT_D_TL
                   WHERE LANGUAGE_CODE = 'ZHS') T18745,
                 W_PROD_CAT_DH T955085          /* Dim_W_PROD_CAT_DH_As_Was */
                                      ,
                 W_RTL_SLS_IT_LC_DY_A T956076  /* Fact_W_RTL_SLS_IT_LC_DY_A */
           WHERE (    T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID
                  AND T953980.INTEGRATION_ID = T964463.INTEGRATION_ID
                  AND T956076.DT_WID = T960506.ROW_WID
                  AND T956076.ORG_DH_WID = T964333.ROW_WID
                  AND T956076.ORG_WID = T964463.ROW_WID
                  AND T960506.MCAL_CAL_WID = 1.0
                  AND T964333.SCD1_WID = T964463.SCD1_WID
                  AND CAST (T955085.LVL6ANC_PRODCAT_ID AS INTEGER) = 21
                  AND CAST (T964463.ORG_NUM AS INTEGER) = 120033
                  AND T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID
                  AND T14449.INTEGRATION_ID = T18745.INTEGRATION_ID
                  AND T14449.ROW_WID = T956076.PROD_WID
                  AND T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID
                  AND '2010' < T960506.CAL_YEAR
                  AND TRUNC (T960506.MCAL_DAY_DT) BETWEEN TO_DATE (
                                                             '2013-11-19',
                                                             'YYYY-MM-DD')
                                                      AND TO_DATE (
                                                             '2013-11-19',
                                                             'YYYY-MM-DD'))
        GROUP BY T14449.ROW_WID,
                 T14449.PROD_NUM,
                 T18745.PRODUCT_NAME,
                 T953980.ORG_NAME,
                 T964463.ROW_WID,
                 CAST (T955085.LVL6ANC_PRODCAT_ID AS INTEGER),
                 CAST (T964463.ORG_NUM AS INTEGER)) D1
 WHERE (D1.c12 = 1);
 
 --------------------------------------------------------------------------------------------------
 /* Formatted on 2013-11-20 10:09:57 (QP5 v5.185.11230.41888) */
/* b6ab4b3d */

SELECT D1.c1 AS c1,
       D1.c2 AS c2,
       D1.c3 AS c3,
       D1.c4 AS c4,
       D1.c5 AS c5,
       D1.c6 AS c6,
       D1.c7 AS c7,
       D1.c8 AS c8,
       D1.c9 AS c9,
       D1.c10 AS c10,
       D1.c11 AS c11
  FROM (  SELECT SUM (
                    NVL (T956076.SLS_AMT_LCL, 0) - NVL (T956076.RET_AMT_LCL, 0))
                    AS c1,
                 SUM (
                      NVL (T956076.SLS_TAX_AMT_LCL, 0)
                    - NVL (T956076.RET_TAX_AMT_LCL, 0))
                    AS c2,
                 SUM (
                      NVL (T956076.SLS_PROFIT_AMT_LCL, 0)
                    - NVL (T956076.RET_PROFIT_AMT_LCL, 0))
                    AS c3,
                 SUM (NVL (T956076.SLS_QTY, 0) - NVL (T956076.RET_QTY, 0))
                    AS c4,
                 CAST (T955085.LVL6ANC_PRODCAT_ID AS INTEGER) AS c5,
                 T18745.PRODUCT_NAME AS c6,
                 T14449.PROD_NUM AS c7,
                 T953980.ORG_NAME AS c8,
                 CAST (T964463.ORG_NUM AS INTEGER) AS c9,
                 T964463.ROW_WID AS c10,
                 T14449.ROW_WID AS c11,
                 ROW_NUMBER ()
                 OVER (PARTITION BY T14449.ROW_WID, T964463.ROW_WID
                       ORDER BY T14449.ROW_WID ASC, T964463.ROW_WID ASC)
                    AS c12
            FROM (SELECT DATASOURCE_NUM_ID,
                         INTEGRATION_ID,
                         ORG_DESCR,
                         ORG_NAME,
                         LANGUAGE_CODE
                    FROM W_INT_ORG_D_TL
                   WHERE LANGUAGE_CODE = 'ZHS') T953980,
                 W_INT_ORG_DH T964333     /* Dim_W_INT_ORG_DH_Retail_As_Was */
                                     ,
                 W_INT_ORG_D T964463       /* Dim_W_INT_ORG_D_Retail_As_Was */
                                    ,
                 (SELECT T.*
                    FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                   WHERE     T.SCD1_WID = A.SCD1_WID
                         AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                 (SELECT DATASOURCE_NUM_ID,
                         INTEGRATION_ID,
                         PRODUCT_DESCR,
                         PRODUCT_NAME,
                         LANGUAGE_CODE
                    FROM W_PRODUCT_D_TL
                   WHERE LANGUAGE_CODE = 'ZHS') T18745,
                 W_PROD_CAT_DH T955085          /* Dim_W_PROD_CAT_DH_As_Was */
                                      ,
                 W_RTL_SLS_IT_LC_DY_A T956076  /* Fact_W_RTL_SLS_IT_LC_DY_A */
                                             ,
                 (SELECT DISTINCT D1.c1 + 1 AS c1, D1.c2 AS c2, D1.c3 AS c3
                    FROM (SELECT MIN (D1.c1) OVER (PARTITION BY D1.c4) AS c1,
                                 MIN (D1.c2) OVER (PARTITION BY D1.c4, D1.c3)
                                    AS c2,
                                 D1.c3 AS c3
                            FROM (SELECT CASE
                                            WHEN CASE D1.c5
                                                    WHEN 1 THEN D1.c3
                                                    ELSE NULL
                                                 END
                                                    IS NOT NULL
                                            THEN
                                               RANK ()
                                               OVER (
                                                  ORDER BY
                                                     CASE D1.c5
                                                        WHEN 1 THEN D1.c3
                                                        ELSE NULL
                                                     END ASC NULLS LAST)
                                         END
                                            AS c1,
                                         CASE
                                            WHEN CASE D1.c6
                                                    WHEN 1 THEN D1.c3
                                                    ELSE NULL
                                                 END
                                                    IS NOT NULL
                                            THEN
                                               RANK ()
                                               OVER (
                                                  PARTITION BY D1.c4
                                                  ORDER BY
                                                     CASE D1.c6
                                                        WHEN 1 THEN D1.c3
                                                        ELSE NULL
                                                     END ASC NULLS LAST)
                                         END
                                            AS c2,
                                         D1.c3 AS c3,
                                         D1.c4 AS c4
                                    FROM (SELECT T960506.ROW_WID AS c3,
                                                 T960506.PER_NAME_YEAR AS c4,
                                                 ROW_NUMBER ()
                                                 OVER (
                                                    PARTITION BY T960506.PER_NAME_YEAR
                                                    ORDER BY
                                                       T960506.PER_NAME_YEAR DESC)
                                                    AS c5,
                                                 ROW_NUMBER ()
                                                 OVER (
                                                    PARTITION BY T960506.PER_NAME_YEAR,
                                                                 T960506.ROW_WID
                                                    ORDER BY
                                                       T960506.PER_NAME_YEAR DESC,
                                                       T960506.ROW_WID DESC)
                                                    AS c6
                                            FROM W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                           WHERE (    T960506.MCAL_CAL_WID =
                                                         1.0
                                                  AND '2010' < T960506.CAL_YEAR)) D1) D1) D1) D5,
                 (SELECT DISTINCT
                         MIN (D1.c1) OVER (PARTITION BY D1.c4) AS c1,
                         MIN (D1.c2) OVER (PARTITION BY D1.c4, D1.c5) AS c2,
                         D1.c3 AS c3
                    FROM (SELECT CASE
                                    WHEN CASE D1.c6
                                            WHEN 1 THEN D1.c4
                                            ELSE NULL
                                         END
                                            IS NOT NULL
                                    THEN
                                       RANK ()
                                       OVER (
                                          ORDER BY
                                             CASE D1.c6
                                                WHEN 1 THEN D1.c4
                                                ELSE NULL
                                             END ASC NULLS LAST)
                                 END
                                    AS c1,
                                 CASE
                                    WHEN CASE D1.c7
                                            WHEN 1 THEN D1.c4
                                            ELSE NULL
                                         END
                                            IS NOT NULL
                                    THEN
                                       RANK ()
                                       OVER (
                                          PARTITION BY D1.c5
                                          ORDER BY
                                             CASE D1.c7
                                                WHEN 1 THEN D1.c4
                                                ELSE NULL
                                             END ASC NULLS LAST)
                                 END
                                    AS c2,
                                 D1.c3 AS c3,
                                 D1.c5 AS c4,
                                 D1.c4 AS c5
                            FROM (SELECT T960506.MCAL_DAY_DT AS c3,
                                         T960506.ROW_WID AS c4,
                                         T960506.PER_NAME_YEAR AS c5,
                                         ROW_NUMBER ()
                                         OVER (
                                            PARTITION BY T960506.PER_NAME_YEAR
                                            ORDER BY T960506.PER_NAME_YEAR DESC)
                                            AS c6,
                                         ROW_NUMBER ()
                                         OVER (
                                            PARTITION BY T960506.PER_NAME_YEAR,
                                                         T960506.ROW_WID
                                            ORDER BY
                                               T960506.PER_NAME_YEAR DESC,
                                               T960506.ROW_WID DESC)
                                            AS c7
                                    FROM W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                   WHERE (    T960506.MCAL_CAL_WID = 1.0
                                          AND '2010' < T960506.CAL_YEAR)) D1) D1) D3
           WHERE (    T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID
                  AND T953980.INTEGRATION_ID = T964463.INTEGRATION_ID
                  AND T956076.ORG_DH_WID = T964333.ROW_WID
                  AND T956076.DT_WID = D5.c3
                  AND T956076.ORG_WID = T964463.ROW_WID
                  AND T964333.SCD1_WID = T964463.SCD1_WID
                  /*AND D3.c1 = D5.c1
                  AND D3.c2 = D5.c2*/
									AND D5.C1=2
									AND D5.C2=323
                  AND CAST (T955085.LVL6ANC_PRODCAT_ID AS INTEGER) = 21
                  AND T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID
                  AND T14449.INTEGRATION_ID = T18745.INTEGRATION_ID
                  AND T14449.ROW_WID = T956076.PROD_WID
                  AND T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID
                  AND CAST (T964463.ORG_NUM AS INTEGER) = 120033
                  AND TRUNC (D3.c3) BETWEEN TO_DATE ('2013-11-19',
                                                     'YYYY-MM-DD')
                                        AND TO_DATE ('2013-11-19',
                                                     'YYYY-MM-DD'))
        GROUP BY T14449.ROW_WID,
                 T14449.PROD_NUM,
                 T18745.PRODUCT_NAME,
                 T953980.ORG_NAME,
                 T964463.ROW_WID,
                 CAST (T955085.LVL6ANC_PRODCAT_ID AS INTEGER),
                 CAST (T964463.ORG_NUM AS INTEGER)) D1
 WHERE (D1.c12 = 1);
