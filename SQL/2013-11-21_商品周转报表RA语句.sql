/* Formatted on 2013/11/21 21:02:44 (QP5 v5.115.810.9015) */
/* cf228964 */

  SELECT   D2.c2 AS c1,
           D2.c3 AS c2,
           D2.c4 AS c3,
           D2.c5 AS c4,
           D2.c1 AS c5,
           D2.c6 AS c6,
           D2.c7 AS c7,
           D2.c8 AS c8
    FROM   (SELECT   D1.c1 AS c1,
                     D1.c2 AS c2,
                     D1.c3 AS c3,
                     D1.c4 AS c4,
                     D1.c5 AS c5,
                     D1.c6 AS c6,
                     D1.c7 AS c7,
                     D1.c8 AS c8
              FROM   (SELECT   SUM (D1.c1) OVER (PARTITION BY D1.c6, D1.c4)
                                  AS c1,
                               D1.c2 AS c2,
                               D1.c3 AS c3,
                               D1.c4 AS c4,
                               D1.c5 AS c5,
                               D1.c6 AS c6,
                               D1.c7 AS c7,
                               D1.c8 AS c8,
                               ROW_NUMBER ()
                                  OVER (PARTITION BY D1.c4, D1.c6
                                        ORDER BY D1.c4 ASC, D1.c6 ASC)
                                  AS c9
                        FROM   (  SELECT   SUM(CASE D1.c12
                                                  WHEN 1 THEN D1.c9
                                                  ELSE NULL
                                               END)
                                              AS c1,
                                           D1.c2 AS c2,
                                           D1.c3 AS c3,
                                           D1.c4 AS c4,
                                           D1.c5 AS c5,
                                           D1.c6 AS c6,
                                           D1.c7 AS c7,
                                           D1.c8 AS c8
                                    FROM   (SELECT   D1.c2 AS c2,
                                                     D1.c3 AS c3,
                                                     D1.c4 AS c4,
                                                     D1.c5 AS c5,
                                                     D1.c6 AS c6,
                                                     D1.c7 AS c7,
                                                     D1.c8 AS c8,
                                                     D1.c9 AS c9,
                                                     D1.c10 AS c10,
                                                     D1.c11 AS c11,
                                                     ROW_NUMBER ()
                                                        OVER (
                                                           PARTITION BY D1.c6,
                                                                        D1.c4,
                                                                        D1.c10,
                                                                        D1.c11
                                                           ORDER BY D1.c6 DESC,
                                                                    D1.c4 DESC,
                                                                    D1.c10 DESC,
                                                                    D1.c11 DESC
                                                        )
                                                        AS c12
                                              FROM   (SELECT   T18745.PRODUCT_NAME
                                                                  AS c2,
                                                               T14449.PROD_NUM
                                                                  AS c3,
                                                               CONCAT (
                                                                  CONCAT (
                                                                     CAST (
                                                                        CAST (
                                                                           W_INT_ORG_D.ORG_NUM AS INTEGER
                                                                        ) AS VARCHAR (20)
                                                                     ),
                                                                     '-'
                                                                  ),
                                                                  T953980.ORG_NAME
                                                               )
                                                                  AS c4,
                                                               CONCAT (
                                                                  CONCAT ('DEPT',
                                                                          '~'),
                                                                  W_PROD_CAT_DH.LVL6ANC_PRODCAT_ID
                                                               )
                                                                  AS c5,
                                                               T14449.ROW_WID
                                                                  AS c6,
                                                               CONCAT (
                                                                  CAST (
                                                                     CAST (
                                                                        W_PROD_CAT_DH.LVL6ANC_PRODCAT_ID AS INTEGER
                                                                     ) AS VARCHAR (20)
                                                                  ),
                                                                  '-'
                                                               )
                                                                  AS c7,
                                                               W_PROD_CAT_DH.DATASOURCE_NUM_ID
                                                                  AS c8,
                                                               LAST_VALUE(W_RTL_INV_IT_LC_DY_FV.INV_SOH_COST_AMT_LCL)
                                                                  OVER (
                                                                     PARTITION BY T14449.ROW_WID,
                                                                                  W_INT_ORG_D.ROW_WID,
                                                                                  BBG_RA_ITEM_LOC_D.ROW_WID
                                                                     ORDER BY
                                                                        NVL2 (
                                                                           W_RTL_INV_IT_LC_DY_FV.INV_SOH_COST_AMT_LCL,
                                                                           1,
                                                                           0
                                                                        ),
                                                                        T14449.ROW_WID NULLS FIRST,
                                                                        W_INT_ORG_D.ROW_WID NULLS FIRST,
                                                                        BBG_RA_ITEM_LOC_D.ROW_WID NULLS FIRST,
                                                                        D7.c3 NULLS FIRST
                                                                     ROWS BETWEEN UNBOUNDED PRECEDING
                                                                     AND     UNBOUNDED FOLLOWING
                                                                  )
                                                                  AS c9,
                                                               W_INT_ORG_D.ROW_WID
                                                                  AS c10,
                                                               BBG_RA_ITEM_LOC_D.ROW_WID
                                                                  AS c11
                                                        FROM   BBG_RA_ITEM_LOC_D BBG_RA_ITEM_LOC_D /* Dim_BBG_ITEM_LOC */
                                                                                         ,
                                                               (SELECT   DATASOURCE_NUM_ID,
                                                                         INTEGRATION_ID,
                                                                         ORG_DESCR,
                                                                         ORG_NAME,
                                                                         LANGUAGE_CODE
                                                                  FROM   W_INT_ORG_D_TL
                                                                 WHERE   LANGUAGE_CODE =
                                                                            'ZHS')
                                                               T953980,
                                                               W_INT_ORG_DH W_INT_ORG_DH /* Dim_W_INT_ORG_DH_Retail_As_Was */
                                                                                   ,
                                                               W_INT_ORG_D W_INT_ORG_D /* Dim_W_INT_ORG_D_Retail_As_Was */
                                                                                  ,
                                                               (SELECT   T.*
                                                                  FROM   W_PRODUCT_D T,
                                                                         W_PRODUCT_ATTR_D A
                                                                 WHERE   T.SCD1_WID =
                                                                            A.SCD1_WID
                                                                         AND A.PRODUCT_ATTR12_NAME =
                                                                               A.PRODUCT_ATTR11_NAME)
                                                               T14449,
                                                               (SELECT   DATASOURCE_NUM_ID,
                                                                         INTEGRATION_ID,
                                                                         PRODUCT_DESCR,
                                                                         PRODUCT_NAME,
                                                                         LANGUAGE_CODE
                                                                  FROM   W_PRODUCT_D_TL
                                                                 WHERE   LANGUAGE_CODE =
                                                                            'ZHS')
                                                               T18745,
                                                               W_PROD_CAT_DH W_PROD_CAT_DH /* Dim_W_PROD_CAT_DH_As_Was */
                                                                                    ,
                                                               W_RTL_INV_IT_LC_DY_FV W_RTL_INV_IT_LC_DY_FV /* Fact_W_RTL_INV_IT_LC_DY_F */
                                                                                            ,
                                                               (SELECT   DISTINCT
                                                                         D1.c1
                                                                         + 1
                                                                            AS c1,
                                                                         D1.c2
                                                                            AS c2,
                                                                         D1.c3
                                                                            AS c3
                                                                  FROM   (SELECT   MIN(D1.c1)
                                                                                      OVER (
                                                                                         PARTITION BY D1.c4
                                                                                      )
                                                                                      AS c1,
                                                                                   MIN(D1.c2)
                                                                                      OVER (
                                                                                         PARTITION BY D1.c4,
                                                                                                      D1.c3
                                                                                      )
                                                                                      AS c2,
                                                                                   D1.c3
                                                                                      AS c3
                                                                            FROM   (SELECT   CASE
                                                                                                WHEN CASE D1.c5
                                                                                                        WHEN 1
                                                                                                        THEN
                                                                                                           D1.c3
                                                                                                        ELSE
                                                                                                           NULL
                                                                                                     END IS NOT NULL
                                                                                                THEN
                                                                                                   RANK ()
                                                                                                      OVER (
                                                                                                         ORDER BY
                                                                                                            CASE D1.c5
                                                                                                               WHEN 1
                                                                                                               THEN
                                                                                                                  D1.c3
                                                                                                               ELSE
                                                                                                                  NULL
                                                                                                            END ASC NULLS LAST
                                                                                                      )
                                                                                             END
                                                                                                AS c1,
                                                                                             CASE
                                                                                                WHEN CASE D1.c6
                                                                                                        WHEN 1
                                                                                                        THEN
                                                                                                           D1.c3
                                                                                                        ELSE
                                                                                                           NULL
                                                                                                     END IS NOT NULL
                                                                                                THEN
                                                                                                   RANK ()
                                                                                                      OVER (
                                                                                                         PARTITION BY D1.c4
                                                                                                         ORDER BY
                                                                                                            CASE D1.c6
                                                                                                               WHEN 1
                                                                                                               THEN
                                                                                                                  D1.c3
                                                                                                               ELSE
                                                                                                                  NULL
                                                                                                            END ASC NULLS LAST
                                                                                                      )
                                                                                             END
                                                                                                AS c2,
                                                                                             D1.c3
                                                                                                AS c3,
                                                                                             D1.c4
                                                                                                AS c4
                                                                                      FROM   (SELECT   T960506.ROW_WID
                                                                                                          AS c3,
                                                                                                       T960506.CAL_MONTH_WID
                                                                                                          AS c4,
                                                                                                       ROW_NUMBER ()
                                                                                                          OVER (
                                                                                                             PARTITION BY T960506.CAL_MONTH_WID
                                                                                                             ORDER BY
                                                                                                                T960506.CAL_MONTH_WID DESC
                                                                                                          )
                                                                                                          AS c5,
                                                                                                       ROW_NUMBER ()
                                                                                                          OVER (
                                                                                                             PARTITION BY T960506.CAL_MONTH_WID,
                                                                                                                          T960506.ROW_WID
                                                                                                             ORDER BY
                                                                                                                T960506.CAL_MONTH_WID DESC,
                                                                                                                T960506.ROW_WID DESC
                                                                                                          )
                                                                                                          AS c6
                                                                                                FROM   W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                                                                               WHERE   (T960506.MCAL_CAL_WID =
                                                                                                           1.0
                                                                                                        AND '2010' <
                                                                                                              T960506.CAL_YEAR))
                                                                                             D1)
                                                                                   D1)
                                                                         D1) D9,
                                                               (SELECT   DISTINCT
                                                                         MIN(D1.c1)
                                                                            OVER (
                                                                               PARTITION BY D1.c5
                                                                            )
                                                                            AS c1,
                                                                         MIN(D1.c2)
                                                                            OVER (
                                                                               PARTITION BY D1.c5,
                                                                                            D1.c3
                                                                            )
                                                                            AS c2,
                                                                         D1.c3
                                                                            AS c3,
                                                                         D1.c4
                                                                            AS c4
                                                                  FROM   (SELECT   CASE
                                                                                      WHEN CASE D1.c6
                                                                                              WHEN 1
                                                                                              THEN
                                                                                                 D1.c3
                                                                                              ELSE
                                                                                                 NULL
                                                                                           END IS NOT NULL
                                                                                      THEN
                                                                                         RANK ()
                                                                                            OVER (
                                                                                               ORDER BY
                                                                                                  CASE D1.c6
                                                                                                     WHEN 1
                                                                                                     THEN
                                                                                                        D1.c3
                                                                                                     ELSE
                                                                                                        NULL
                                                                                                  END ASC NULLS LAST
                                                                                            )
                                                                                   END
                                                                                      AS c1,
                                                                                   CASE
                                                                                      WHEN CASE D1.c7
                                                                                              WHEN 1
                                                                                              THEN
                                                                                                 D1.c3
                                                                                              ELSE
                                                                                                 NULL
                                                                                           END IS NOT NULL
                                                                                      THEN
                                                                                         RANK ()
                                                                                            OVER (
                                                                                               PARTITION BY D1.c5
                                                                                               ORDER BY
                                                                                                  CASE D1.c7
                                                                                                     WHEN 1
                                                                                                     THEN
                                                                                                        D1.c3
                                                                                                     ELSE
                                                                                                        NULL
                                                                                                  END ASC NULLS LAST
                                                                                            )
                                                                                   END
                                                                                      AS c2,
                                                                                   D1.c3
                                                                                      AS c3,
                                                                                   D1.c4
                                                                                      AS c4,
                                                                                   D1.c5
                                                                                      AS c5
                                                                            FROM   (SELECT   T960506.ROW_WID
                                                                                                AS c3,
                                                                                             T960506.PER_NAME_MONTH
                                                                                                AS c4,
                                                                                             T960506.CAL_MONTH_WID
                                                                                                AS c5,
                                                                                             ROW_NUMBER ()
                                                                                                OVER (
                                                                                                   PARTITION BY T960506.CAL_MONTH_WID
                                                                                                   ORDER BY
                                                                                                      T960506.CAL_MONTH_WID DESC
                                                                                                )
                                                                                                AS c6,
                                                                                             ROW_NUMBER ()
                                                                                                OVER (
                                                                                                   PARTITION BY T960506.CAL_MONTH_WID,
                                                                                                                T960506.ROW_WID
                                                                                                   ORDER BY
                                                                                                      T960506.CAL_MONTH_WID DESC,
                                                                                                      T960506.ROW_WID DESC
                                                                                                )
                                                                                                AS c7
                                                                                      FROM   W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                                                                     WHERE   (T960506.MCAL_CAL_WID =
                                                                                                 1.0
                                                                                              AND '2010' <
                                                                                                    T960506.CAL_YEAR))
                                                                                   D1)
                                                                         D1) D7
WHERE   (T953980.DATASOURCE_NUM_ID = W_INT_ORG_D.DATASOURCE_NUM_ID
     AND T953980.INTEGRATION_ID = W_INT_ORG_D.INTEGRATION_ID
     AND W_RTL_INV_IT_LC_DY_FV.ORG_WID = W_INT_ORG_D.ROW_WID
     AND W_RTL_INV_IT_LC_DY_FV.ORG_DH_WID = W_INT_ORG_DH.ROW_WID
     AND W_RTL_INV_IT_LC_DY_FV.BBG_ITEM_LOC_WID = BBG_RA_ITEM_LOC_D.ROW_WID
     AND W_RTL_INV_IT_LC_DY_FV.DT_WID = D9.c3
     AND W_INT_ORG_DH.SCD1_WID = W_INT_ORG_D.SCD1_WID
     AND D7.c1 = D9.c1
     AND D7.c2 = D9.c2
     AND T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID
     AND T14449.INTEGRATION_ID = T18745.INTEGRATION_ID
     AND T14449.ROW_WID = W_RTL_INV_IT_LC_DY_FV.PROD_WID
     AND T14449.PROD_CAT5_WID_AS_WAS = W_PROD_CAT_DH.ROW_WID
                                                                AND D7.c4 =
                                                                      '2013 / 09'
                                                                AND (CONCAT (
                                                                        CONCAT (
                                                                           CAST (
                                                                              CAST (
                                                                                 W_INT_ORG_D.ORG_NUM AS INTEGER
                                                                              ) AS VARCHAR (20)
                                                                           ),
                                                                           '-'
                                                                        ),
                                                                        T953980.ORG_NAME
                                                                     ) IN
                                                                           ('120002-ÔÀÌÁµê',
                                                                            '120004-Ìï ÐÄµê',
                                                                            '120008-°åÌÁµê',
                                                                            '120011-»ù½¨Óªµê³¬ÊÐ',
                                                                            '12001 4-¹ãÔÆµê',
                                                                            '120024-Ò×Ë×ºÓµê',
                                                                            '120027-ÏæÏçµê',
                                                                            '120157 -ä¯Ñô²½ÐÐ½Öµê',
                                                                            '120158-ÒæÑô½ðÉ½Â·µê',
                                                                            '120161-ä¯ ÑôÀñ»¨Â·µê'))))
                                                     D1) D1
                                GROUP BY   D1.c2,
                                           D1.c3,
                                           D1.c4,
                                           D1.c5,
                                           D1.c6,
                                           D1.c7,
                                           D1.c8) D1) D1
             WHERE   (D1.c9 = 1)) D2
ORDER BY   c3, c6
