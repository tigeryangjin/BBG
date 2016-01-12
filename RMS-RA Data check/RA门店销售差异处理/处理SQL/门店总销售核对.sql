SELECT 
t.DEPT,
       --T.LOCATION,
       --t.ITEM,
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
      --AND T.TOTAL_RETAIL<>0
   AND T.TRAN_DATE BETWEEN DATE '2015-11-01' AND DATE '2015-11-30'
	 and t.LOCATION='120232'
--AND T.DEPT IN ('29')
--AND T.LOCATION IN ('120036','120063','120113','120144','120191')
--AND T.LOCATION = '120194'
--and t.ITEM in ('800002917','700005803')
 GROUP BY  t.DEPT --,t.ITEM
 ORDER BY t.DEPT ;


