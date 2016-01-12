/* Formatted on 2016/1/5 20:28:30 (QP5 v5.256.13226.35510) */
/* cde01302 */
--此语句是ago函数在RA中的SQL
--2012/1/1 对应的销售其实是2011/1/1的销售。
SELECT D1.c1 AS c1, D1.c2 AS c2, D1.c3 AS c3
  FROM (SELECT SUM(NVL(T956124.SLS_QTY, 0) - NVL(T956124.RET_QTY, 0)) AS c1,
               TRUNC(D3.c4) AS c2,
               D3.c3 AS c3,
               ROW_NUMBER() OVER(PARTITION BY D3.c3 ORDER BY D3.c3 ASC) AS c4
          FROM W_RTL_SLS_SC_DY_A T956124 /* Fact_W_RTL_SLS_SC_DY_A */,
               (SELECT DISTINCT D1.c1 + 1 AS c1, D1.c2 AS c2, D1.c3 AS c3
                  FROM (SELECT MIN(D1.c1) OVER(PARTITION BY D1.c4) AS c1,
                               MIN(D1.c2) OVER(PARTITION BY D1.c4, D1.c3) AS c2,
                               D1.c3 AS c3
                          FROM (SELECT CASE
                                         WHEN CASE D1.c5
                                                WHEN 1 THEN
                                                 D1.c3
                                                ELSE
                                                 NULL
                                              END IS NOT NULL THEN
                                          RANK() OVER(ORDER BY CASE D1.c5
                                                        WHEN 1 THEN
                                                         D1.c3
                                                        ELSE
                                                         NULL
                                                      END ASC NULLS LAST)
                                       END AS c1,
                                       CASE
                                         WHEN CASE D1.c6
                                                WHEN 1 THEN
                                                 D1.c3
                                                ELSE
                                                 NULL
                                              END IS NOT NULL THEN
                                          RANK() OVER(PARTITION BY D1.c4 ORDER BY
                                                      CASE D1.c6
                                                        WHEN 1 THEN
                                                         D1.c3
                                                        ELSE
                                                         NULL
                                                      END ASC NULLS LAST)
                                       END AS c2,
                                       D1.c3 AS c3,
                                       D1.c4 AS c4
                                  FROM (SELECT T960506.ROW_WID AS c3,
                                               T960506.PER_NAME_YEAR AS c4,
                                               ROW_NUMBER() OVER(PARTITION BY T960506.PER_NAME_YEAR ORDER BY T960506.PER_NAME_YEAR DESC) AS c5,
                                               ROW_NUMBER() OVER(PARTITION BY T960506.PER_NAME_YEAR, T960506.ROW_WID ORDER BY T960506.PER_NAME_YEAR DESC, T960506.ROW_WID DESC) AS c6
                                          FROM W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                         WHERE (T960506.MCAL_CAL_WID = 1.0 AND
                                               '2010' < T960506.CAL_YEAR)) D1) D1) D1) D5,
               (SELECT DISTINCT MIN(D1.c1) OVER(PARTITION BY D1.c5) AS c1,
                                MIN(D1.c2) OVER(PARTITION BY D1.c5, D1.c3) AS c2,
                                D1.c3 AS c3,
                                D1.c4 AS c4
                  FROM (SELECT CASE
                                 WHEN CASE D1.c6
                                        WHEN 1 THEN
                                         D1.c3
                                        ELSE
                                         NULL
                                      END IS NOT NULL THEN
                                  RANK() OVER(ORDER BY CASE D1.c6
                                                WHEN 1 THEN
                                                 D1.c3
                                                ELSE
                                                 NULL
                                              END ASC NULLS LAST)
                               END AS c1,
                               CASE
                                 WHEN CASE D1.c7
                                        WHEN 1 THEN
                                         D1.c3
                                        ELSE
                                         NULL
                                      END IS NOT NULL THEN
                                  RANK()
                                  OVER(PARTITION BY D1.c5 ORDER BY CASE D1.c7
                                         WHEN 1 THEN
                                          D1.c3
                                         ELSE
                                          NULL
                                       END ASC NULLS LAST)
                               END AS c2,
                               D1.c3 AS c3,
                               D1.c4 AS c4,
                               D1.c5 AS c5
                          FROM (SELECT T960506.ROW_WID AS c3,
                                       T960506.MCAL_DAY_DT AS c4,
                                       T960506.PER_NAME_YEAR AS c5,
                                       ROW_NUMBER() OVER(PARTITION BY T960506.PER_NAME_YEAR ORDER BY T960506.PER_NAME_YEAR DESC) AS c6,
                                       ROW_NUMBER() OVER(PARTITION BY T960506.PER_NAME_YEAR, T960506.ROW_WID ORDER BY T960506.PER_NAME_YEAR DESC, T960506.ROW_WID DESC) AS c7
                                  FROM W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */
                                 WHERE (T960506.MCAL_CAL_WID = 1.0 AND
                                       '2010' < T960506.CAL_YEAR)) D1) D1) D3
         WHERE (T956124.DT_WID = D5.c3 AND D3.c1 = D5.c1 AND D3.c2 = D5.c2)
         GROUP BY D3.c3, TRUNC(D3.c4)) D1
 WHERE (D1.c4 = 1)
