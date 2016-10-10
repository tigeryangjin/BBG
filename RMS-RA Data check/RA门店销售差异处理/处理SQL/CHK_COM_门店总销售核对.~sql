SELECT
--t.DEPT,
 t.TRAN_DATE,
 T.LOCATION,
 --t.ITEM,
 SUM(T.UNITS) QTY,
 SUM(T.TOTAL_RETAIL / (1 + (CASE
       WHEN T.TRAN_CODE = 3 THEN
        T.VAT_RATE / 100
       ELSE
        0
     END))) + SUM(NVL(C.coupon_amt, 0)) AMT,
 SUM(T.TOTAL_COST / (1 + (CASE
       WHEN T.TRAN_CODE = 3 THEN
        (SELECT VAT_RATE / 100
           FROM VAT_ITEM
          WHERE ACTIVE_DATE = (SELECT MAX(V.ACTIVE_DATE)
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
                       WHERE ACTIVE_DATE = (SELECT MAX(V.ACTIVE_DATE)
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
          WHERE ACTIVE_DATE = (SELECT MAX(V.ACTIVE_DATE)
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
                                WHERE ACTIVE_DATE = (SELECT MAX(V.ACTIVE_DATE)
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
                           END)))) / SUM(T.TOTAL_RETAIL / (1 + (CASE
                                           WHEN T.TRAN_CODE = 3 THEN
                                            T.VAT_RATE / 100
                                           ELSE
                                            0
                                         END)))) PROFIT_RATE
  FROM RA_RMS.TRAN_DATA_HISTORY_PACK_V T,
       (SELECT ssd.business_date,
               ssd.store,
               sti.item,
               SUM(std.qty * unit_discount_amt /
                   (1 + (SELECT VAT_RATE / 100
                           FROM VAT_ITEM
                          WHERE ACTIVE_DATE =
                                (SELECT MAX(V.ACTIVE_DATE)
                                   FROM VAT_ITEM V
                                  WHERE V.ITEM = STI.ITEM
                                    AND V.VAT_REGION = 1000
                                    AND V.VAT_TYPE IN ('R', 'B')
                                    AND V.ACTIVE_DATE <= ssd.Business_Date)
                            AND ITEM = STI.ITEM
                            AND VAT_REGION = 1000
                            AND VAT_TYPE IN ('R', 'B')))) coupon_amt
          FROM sa_store_day ssd,
               sa_tran_head sth,
               sa_tran_item sti,
               sa_tran_disc std
         WHERE ssd.business_date = &TRAN_DATE
              --and ssd.store = 120033
           and ssd.store_day_seq_no = sth.store_day_seq_no
           AND ssd.store = sth.store
           AND ssd.day = sth.day
           AND sth.tran_seq_no = sti.tran_seq_no
           AND sth.store = sti.store
           AND sth.day = sti.day
           AND sti.tran_seq_no = std.tran_seq_no
           AND sti.store = std.store
           AND sti.day = std.day
           AND sti.item_seq_no = std.item_seq_no
           AND std.rms_promo_type IN (50, 51, 52)
         GROUP BY ssd.business_date, ssd.store, sti.item) C
 WHERE T.TRAN_CODE IN (2, 3)
   AND T.ITEM = C.ITEM(+)
   AND T.LOCATION = C.STORE(+)
   AND T.TRAN_DATE = C.business_date(+)
      --AND T.TOTAL_RETAIL<>0
   AND T.TRAN_DATE BETWEEN DATE '2016-08-12' AND DATE '2016-08-12'
--and t.LOCATION='120001'
--AND T.DEPT IN ('29')
--AND T.LOCATION IN ('120036','120063','120113','120144','120191')
--AND T.LOCATION = '120194'
--and t.ITEM in ('800002917','700005803')
 GROUP BY t.TRAN_DATE, t.location --t.DEPT --,t.ITEM
 ORDER BY t.TRAN_DATE, t.location;
