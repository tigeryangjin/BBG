--上面的语句放入BBG_RA_SALES_DATA_V视图中
--DEPT部门、QTY数量、AMT销售金额、COST成本、PROFIT毛利、PROFIT_RAT毛利率
/* SELECT * FROM RA_RMS.BBG_RA_SALES_DATA_V
ORDER BY DEPT;*/
SELECT T.DEPT,
       SUM(T.UNITS) QTY,
       SUM(T.TOTAL_RETAIL / (1 + (CASE
             WHEN T.TRAN_CODE = 3 THEN
              T.VAT_RATE / 100
             ELSE
              0
           END))) AMT,
       SUM(T.TOTAL_COST / (1 + (CASE
             WHEN T.TRAN_CODE = 3 THEN
              (SELECT VAT_RATE / 100
                 FROM VAT_ITEM
                WHERE ACTIVE_DATE =
                      (SELECT MAX(V.ACTIVE_DATE)
                         FROM VAT_ITEM V
                        WHERE V.ITEM = T.ITEM
                          AND V.VAT_REGION = 1000
                          AND V.VAT_TYPE IN ('C', 'B')
                          AND V.ACTIVE_DATE <= T.TRAN_DATE)
                  AND ITEM = T.ITEM
                  AND VAT_REGION = 1000
                  AND VAT_TYPE IN ('C', 'B'))
             ELSE
              0
           END))) COST,
       SUM(T.TOTAL_RETAIL / (1 + (CASE
             WHEN T.TRAN_CODE = 3 THEN
              T.VAT_RATE / 100
             ELSE
              0
           END))) - SUM(T.TOTAL_COST / (1 + (CASE
                          WHEN T.TRAN_CODE = 3 THEN
                           (SELECT VAT_RATE / 100
                              FROM VAT_ITEM
                             WHERE ACTIVE_DATE =
                                   (SELECT MAX(V.ACTIVE_DATE)
                                      FROM VAT_ITEM V
                                     WHERE V.ITEM = T.ITEM
                                       AND V.VAT_REGION = 1000
                                       AND V.VAT_TYPE IN ('C', 'B')
                                       AND V.ACTIVE_DATE <= T.TRAN_DATE)
                               AND ITEM = T.ITEM
                               AND VAT_REGION = 1000
                               AND VAT_TYPE IN ('C', 'B'))
                          ELSE
                           0
                        END))) PROFIT,
       SUM(T.TOTAL_COST / (1 + (CASE
             WHEN T.TRAN_CODE = 3 THEN
              (SELECT VAT_RATE / 100
                 FROM VAT_ITEM
                WHERE ACTIVE_DATE =
                      (SELECT MAX(V.ACTIVE_DATE)
                         FROM VAT_ITEM V
                        WHERE V.ITEM = T.ITEM
                          AND V.VAT_REGION = 1000
                          AND V.VAT_TYPE IN ('C', 'B')
                          AND V.ACTIVE_DATE <= T.TRAN_DATE)
                  AND ITEM = T.ITEM
                  AND VAT_REGION = 1000
                  AND VAT_TYPE IN ('C', 'B'))
             ELSE
              0
           END))) COST,
       DECODE(SUM(T.TOTAL_RETAIL / (1 + (CASE
                    WHEN T.TRAN_CODE = 3 THEN
                     T.VAT_RATE / 100
                    ELSE
                     0
                  END))),
              0,
              0,
              (SUM(T.TOTAL_RETAIL / (1 + (CASE
                     WHEN T.TRAN_CODE = 3 THEN
                      T.VAT_RATE / 100
                     ELSE
                      0
                   END))) - SUM(T.TOTAL_COST / (1 + (CASE
                                   WHEN T.TRAN_CODE = 3 THEN
                                    (SELECT VAT_RATE / 100
                                       FROM VAT_ITEM
                                      WHERE ACTIVE_DATE =
                                            (SELECT MAX(V.ACTIVE_DATE)
                                               FROM VAT_ITEM V
                                              WHERE V.ITEM = T.ITEM
                                                AND V.VAT_REGION = 1000
                                                AND V.VAT_TYPE IN ('C', 'B')
                                                AND V.ACTIVE_DATE <= T.TRAN_DATE)
                                        AND ITEM = T.ITEM
                                        AND VAT_REGION = 1000
                                        AND VAT_TYPE IN ('C', 'B'))
                                   ELSE
                                    0
                                 END)))) /
              SUM(T.TOTAL_RETAIL / (1 + (CASE
                    WHEN T.TRAN_CODE = 3 THEN
                     T.VAT_RATE / 100
                    ELSE
                     0
                  END)))) PROFIT_RATE
  FROM RA_RMS.TRAN_DATA_HISTORY_PACK_V T
 WHERE T.TRAN_CODE IN (2, 3)
   AND T.TRAN_DATE = &TRAN_DATE
--AND T.DEPT<>40
--AND T.LOCATION<>'120016'
 GROUP BY T.DEPT
 ORDER BY T.DEPT;
