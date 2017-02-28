/*DROP TABLE RMS.YJ_TMP;

CREATE TABLE RMS.YJ_TMP AS
  SELECT TO_DATE(T.REF_NO26, 'YYYYMMDD') DAY,T.STORE, SUM(T.VALUE) VALUE
    FROM SA_TRAN_HEAD T
   WHERE \*T.STORE = 120033
     AND *\T.REF_NO26 BETWEEN '20160101' AND '20170226'
   GROUP BY T.REF_NO26,T.STORE;*/

SELECT * FROM RMS.YJ_TMP T ORDER BY T.DAY FOR UPDATE;

SELECT T.DAY,
       T.VALUE,
       NVL(SUM(T.VALUE) OVER(ORDER BY T.DAY RANGE between interval '7' day
                preceding and interval '7' day preceding),
           0) LAST_WEEK,
       NVL(SUM(T.VALUE)
           OVER(PARTITION BY TO_CHAR(T.DAY, 'YYYYMM') ORDER BY T.DAY),
           0) MTD
  FROM (SELECT DAY, SUM(VALUE) VALUE FROM YJ_TMP GROUP BY DAY) T
 ORDER BY T.DAY;

SELECT T.DAY,
       T.STORE,
       T.VALUE,
       NVL(SUM(T.VALUE)
           OVER(PARTITION BY T.STORE ORDER BY T.DAY RANGE between interval '7' day
                preceding and interval '7' day preceding),
           0) LAST_WEEK,
       NVL(SUM(T.VALUE)
           OVER(PARTITION BY T.STORE ORDER BY T.DAY RANGE between interval '1'
                month preceding and interval '1' month preceding),
           0),
       NVL(SUM(T.VALUE) OVER(PARTITION BY TO_CHAR(T.DAY, 'YYYYMM'),
                T.STORE ORDER BY T.DAY),
           0) MTD,
       NVL(SUM(T.VALUE) OVER(PARTITION BY TO_CHAR(T.DAY, 'YYYYWW'),
                T.STORE ORDER BY T.DAY),
           0) WTD,
       sum(T.VALUE) OVER(partition by T.STORE ORDER BY T.DAY range BETWEEN T.DAY - trunc(trunc(T.DAY, 'mm') - 1, 'mm') preceding and T.DAY - add_months(T.DAY, -1) preceding)
  FROM YJ_TMP T
 ORDER BY T.DAY, T.STORE;
