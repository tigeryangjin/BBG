SELECT * FROM RADM.W_RTL_INV_IT_LC_G T WHERE T.INV_SOH_QTY = 5000000;

SELECT /*+PARALLEL(T,12) PARALLEL(O,12)*/
 O.ORG_NUM LOC,
 TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
 SUM(T.INV_SOH_COST_AMT_LCL) INV_SOH_COST_AMT_LCL
  FROM RADM.W_RTL_INV_IT_LC_DY_FV T, RADM.W_INT_ORG_D O
 WHERE T.ORG_WID = O.ROW_WID
   AND T.DT_WID BETWEEN 120150101000 AND 120150331000
   AND O.ORG_NUM NOT LIKE '110%'
   AND O.ORG_NUM NOT IN (118003,
                         118005,
                         118006,
                         118010,
                         118011,
                         118012,
                         118015,
                         118016,
                         118023)
   AND T.INV_SOH_QTY <> 5000000
 GROUP BY O.ORG_NUM, TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')
 ORDER BY O.ORG_NUM, TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD');
