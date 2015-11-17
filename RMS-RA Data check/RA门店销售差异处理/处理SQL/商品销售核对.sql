SELECT T.LOCATION,
       T.ITEM,
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
           END))) COST
  FROM RA_RMS.TRAN_DATA_HISTORY_PACK_V T
 WHERE T.TRAN_CODE IN (2, 3)
      --AND T.TOTAL_RETAIL<>0
   AND T.TRAN_DATE = DATE '2013-05-08'
   AND T.DEPT IN ('76')
-- AND T.LOCATION IN ('120036','120113','120151','120170')
--AND T.LOCATION='120122'
--and t.ITEM='800333348'
 GROUP BY T.LOCATION, T.ITEM
 ORDER BY T.LOCATION, T.ITEM;
