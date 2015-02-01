/* Formatted on 2013-12-2 16:06:15 (QP5 v5.185.11230.41888) */
/* 26241d8e */

  SELECT D1.c1 AS c1,
         D1.c2 AS c2,
         CONCAT (D1.c25, D2.c1) AS c3,
         D1.c3 AS c4,
         D1.c4 AS c5,
         D1.c5 AS c6,
         D1.c6 AS c7,
         D1.c7 AS c8,
         D1.c8 AS c9,
         D1.c21 AS c22,
         D1.c22 AS c23,
         D1.c26 AS c24,
         D1.c23 AS c26,
         D1.c24 AS c27
    FROM    (SELECT 0 AS c1,
                    D1.c5 AS c2,
                    D1.c6 AS c3,
                    D1.c7 AS c4,
                    D1.c4 * 100 / NULLIF (D1.c2 - D1.c1, 0) AS c5,
                    D1.c4 AS c6,
                    D1.c2 - D1.c1 AS c7,
                    D1.c3 AS c8,
                    D1.c8 AS c21,
                    D1.c9 AS c22,
                    D1.c2 AS c23,
                    D1.c1 AS c24,
                    D1.c10 AS c25,
                    D1.c11 AS c26
               FROM (  SELECT SUM (
                                   NVL (T961383.SLS_TAX_AMT_LCL, 0)
                                 - NVL (T961383.RET_TAX_AMT_LCL, 0))
                                 AS c1,
                              SUM (
                                   NVL (T961383.SLS_AMT_LCL, 0)
                                 - NVL (T961383.RET_AMT_LCL, 0))
                                 AS c2,
                              SUM (
                                   NVL (T961383.SLS_QTY, 0)
                                 - NVL (T961383.RET_QTY, 0))
                                 AS c3,
                              SUM (
                                   NVL (T961383.SLS_PROFIT_AMT_LCL, 0)
                                 - NVL (T961383.RET_PROFIT_AMT_LCL, 0))
                                 AS c4,
                              T1009758.RETAIL_GROUP_DESC AS c5,
                              CONCAT (
                                 CONCAT (
                                    CAST (
                                       CAST (T964463.ORG_NUM AS INTEGER) AS VARCHAR (20)),
                                    '-'),
                                 T953980.ORG_NAME)
                                 AS c6,
                              CONCAT (CONCAT ('GRP', '~'),
                                      T956667.LVL7ANC_PRODCAT_ID)
                                 AS c7,
                              CAST (T956667.LVL7ANC_PRODCAT_ID AS INTEGER) AS c8,
                              T1009758.RETAIL_GROUP_ID AS c9,
                              CONCAT (
                                 CAST (
                                    CAST (T956667.LVL7ANC_PRODCAT_ID AS INTEGER) AS VARCHAR (20)),
                                 '-')
                                 AS c10,
                              T956667.DATASOURCE_NUM_ID AS c11
                         FROM BBG_RA_RETAIL_TYPE_D T1009758 /* Dim_BBG_RA_RETAIL_TYPE_D */
                                                           ,
                              (SELECT DATASOURCE_NUM_ID,
                                      INTEGRATION_ID,
                                      ORG_DESCR,
                                      ORG_NAME,
                                      LANGUAGE_CODE
                                 FROM W_INT_ORG_D_TL
                                WHERE LANGUAGE_CODE = 'ZHS') T953980,
                              W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */
                                                  ,
                              W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */
                                                 ,
                              W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                                   ,
                              W_PROD_CAT_DH T956667 /* Dim_W_PROD_CAT_DH_Department_As_Was */
                                                   ,
                              W_RTL_SLS_DP_LC_DY_A T961383 /* Fact_W_RTL_SLS_DP_LC_DY_A */
                        WHERE (    T953980.DATASOURCE_NUM_ID =
                                      T964463.DATASOURCE_NUM_ID
                               AND T953980.INTEGRATION_ID =
                                      T964463.INTEGRATION_ID
                               AND T960506.ROW_WID = T961383.DT_WID
                               AND T956667.ROW_WID = T961383.PROD_DH_WID
                               AND T961383.ORG_DH_WID = T964333.ROW_WID
                               AND T961383.ORG_SCD1_WID = T964463.SCD1_WID
                               AND T956667.LEVEL_NAME = 'DEPT'
                               AND T960506.MCAL_CAL_WID = 1.0
                               AND T961383.BBG_RETAIL_TYPE_WID = T1009758.ROW_WID
                               AND T964333.SCD1_WID = T964463.SCD1_WID
                               --下面条件影响速度
															 AND CONCAT (CONCAT ('GRP', '~'),
                                           T956667.LVL7ANC_PRODCAT_ID) = 'GRP~21'
                               AND '2010' < T960506.CAL_YEAR
                               AND TRUNC (T960506.MCAL_DAY_DT) BETWEEN TO_DATE (
                                                                          '2013-11-28',
                                                                          'YYYY-MM-DD')
                                                                   AND TO_DATE (
                                                                          '2013-11-30',
                                                                          'YYYY-MM-DD'))
                     GROUP BY T956667.DATASOURCE_NUM_ID,
                              T1009758.RETAIL_GROUP_DESC,
                              T1009758.RETAIL_GROUP_ID,
                              CAST (T956667.LVL7ANC_PRODCAT_ID AS INTEGER),
                              CONCAT (
                                 CAST (
                                    CAST (
                                       T956667.LVL7ANC_PRODCAT_ID AS INTEGER) AS VARCHAR (20)),
                                 '-'),
                              CONCAT (
                                 CONCAT (
                                    CAST (
                                       CAST (T964463.ORG_NUM AS INTEGER) AS VARCHAR (20)),
                                    '-'),
                                 T953980.ORG_NAME),
                              CONCAT (CONCAT ('GRP', '~'),
                                      T956667.LVL7ANC_PRODCAT_ID)) D1) D1
         INNER JOIN
            (SELECT T16687.DOMAIN_MEMBER_NAME AS c1,
                    T16687.DOMAIN_MEMBER_CODE AS c2,
                    T16687.DATASOURCE_NUM_ID AS c3
               FROM W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */
              WHERE (    T16687.DOMAIN_CODE = 'MCAT'
                     AND T16687.DOMAIN_TYPE_CODE = 'S'
                     AND T16687.LANGUAGE_CODE = 'ZHS')) D2
         ON D1.c4 = D2.c2 AND D1.c26 = D2.c3
ORDER BY c5,
         c4,
         c3,
         c22,
         c2,
         c23
