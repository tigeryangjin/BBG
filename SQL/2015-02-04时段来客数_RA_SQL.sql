/* Formatted on 2015/2/4 14:03:56 (QP5 v5.256.13226.35510) */
/* 3bdb3717 */

SELECT D1.c1 AS c1,
       D1.c2 AS c2,
       D1.c3 AS c3,
       D1.c4 AS c4,
       D1.c5 AS c5,
       D1.c6 AS c6,
       D1.c7 AS c7,
       D1.c8 AS c8
  FROM (SELECT SUM(NVL(T954142.SLS_TAX_AMT_LCL, 0) -
                   NVL(T954142.RET_TAX_AMT_LCL, 0)) AS c1,
               SUM(NVL(T954142.SLS_AMT_LCL, 0) - NVL(T954142.RET_AMT_LCL, 0)) AS c2,
               TRUNC(T960506.MCAL_DAY_DT) AS c3,
               CAST(T955085.LVL6ANC_PRODCAT_ID AS INTEGER) AS c4,
               CAST(T964463.ORG_NUM AS INTEGER) AS c5,
               CASE
                 WHEN T958080.MINUTE_NUM < 15 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS VARCHAR(2)),
                                       ':00 - '),
                                CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                         ':14')
                 WHEN T958080.MINUTE_NUM BETWEEN 15 AND 29 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS VARCHAR(2)),
                                       ':15 - '),
                                CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                         ':29')
                 WHEN T958080.MINUTE_NUM BETWEEN 30 AND 44 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS VARCHAR(2)),
                                       ':30 - '),
                                CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                         ':44')
                 ELSE
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS VARCHAR(2)),
                                       ':45 - '),
                                CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                         ':59')
               END AS c6,
               T964463.ROW_WID AS c7,
               T960506.ROW_WID AS c8,
               ROW_NUMBER() OVER(PARTITION BY T960506.ROW_WID, T964463.ROW_WID,CASE
                 WHEN T958080.MINUTE_NUM < 15 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':00 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':14')
                 WHEN T958080.MINUTE_NUM BETWEEN 15 AND 29 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':15 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':29')
                 WHEN T958080.MINUTE_NUM BETWEEN 30 AND 44 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':30 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':44')
                 ELSE
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':45 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':59')
               END, CAST(T955085.LVL6ANC_PRODCAT_ID AS INTEGER) ORDER BY T960506.ROW_WID ASC, T964463.ROW_WID ASC,CASE
                 WHEN T958080.MINUTE_NUM < 15 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':00 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':14')
                 WHEN T958080.MINUTE_NUM BETWEEN 15 AND 29 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':15 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':29')
                 WHEN T958080.MINUTE_NUM BETWEEN 30 AND 44 THEN
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':30 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':44')
                 ELSE
                  CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                            VARCHAR(2)),
                                       ':45 - '),
                                CAST(T958080.HOUR_24_NUM AS
                                     VARCHAR(2))),
                         ':59')
               END ASC, CAST(T955085.LVL6ANC_PRODCAT_ID AS INTEGER) ASC) AS c9
          FROM W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
               W_MINUTE_OF_DAY_D T958080 /* Dim_W_MINUTE_OF_DAY_D */,
               (SELECT T.*
                  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                 WHERE T.SCD1_WID = A.SCD1_WID
                   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */,
               W_RTL_SLS_TRX_IT_LC_DY_F T954142 /* Fact_W_RTL_SLS_TRX_IT_LC_DY_F */
         WHERE (T954142.ORG_DH_WID = T964333.ROW_WID AND
               T954142.ORG_WID = T964463.ROW_WID AND
               T954142.DT_WID = T960506.ROW_WID AND
               T954142.MIN_WID = T958080.ROW_WID AND
               T14449.ROW_WID = T954142.PROD_WID AND
               T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID AND
               T960506.MCAL_CAL_WID = 1.0 AND
               T964333.SCD1_WID = T964463.SCD1_WID AND
               CAST(T955085.LVL7ANC_PRODCAT_ID AS INTEGER) = 29 AND
               CAST(T964463.ORG_NUM AS INTEGER) = 120056 AND
               '2010' < T960506.CAL_YEAR AND
               (TRUNC(T960506.MCAL_DAY_DT) IN
               (TO_DATE('2015-02-02', 'YYYY-MM-DD'),
                  TO_DATE('2015-02-03', 'YYYY-MM-DD'))))
         GROUP BY T960506.ROW_WID,
                  T964463.ROW_WID,
                  CASE
                    WHEN T958080.MINUTE_NUM < 15 THEN
                     CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                               VARCHAR(2)),
                                          ':00 - '),
                                   CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                            ':14')
                    WHEN T958080.MINUTE_NUM BETWEEN 15 AND 29 THEN
                     CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                               VARCHAR(2)),
                                          ':15 - '),
                                   CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                            ':29')
                    WHEN T958080.MINUTE_NUM BETWEEN 30 AND 44 THEN
                     CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                               VARCHAR(2)),
                                          ':30 - '),
                                   CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                            ':44')
                    ELSE
                     CONCAT(CONCAT(CONCAT(CAST(T958080.HOUR_24_NUM AS
                                               VARCHAR(2)),
                                          ':45 - '),
                                   CAST(T958080.HOUR_24_NUM AS VARCHAR(2))),
                            ':59')
                  END,
                  CAST(T955085.LVL6ANC_PRODCAT_ID AS INTEGER),
                  CAST(T964463.ORG_NUM AS INTEGER),
                  TRUNC(T960506.MCAL_DAY_DT)) D1
 WHERE (D1.c9 = 1)
