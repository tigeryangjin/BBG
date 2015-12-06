--1.ÉÌÆ·¿â´æÇåÁã
UPDATE /*+PARALLEL(16)*/ RADM.W_RTL_INV_IT_LC_DY_F A
   SET A.INV_SOH_QTY          = 0,
       A.INV_SOH_RTL_AMT_LCL  = 0,
       A.INV_SOH_COST_AMT_LCL = 0
 WHERE A.INV_SOH_QTY >= 4960000
   AND EXISTS (SELECT 1
          FROM RADM.W_INT_ORG_D O
         WHERE A.ORG_WID = O.ROW_WID
           AND O.ORG_NUM IN (110023,
                             118012,
                             118010,
                             110012,
                             110011,
                             118011,
                             110015,
                             118015,
                             838001,
                             110010,
                             830001));
COMMIT;

SELECT /*+PARALLEL(16)*/
 *
  FROM RADM.W_RTL_INV_IT_LC_DY_F T
 WHERE T.INV_SOH_QTY >= 5000000
   AND T.TO_DT_WID = 999999999999999
   AND EXISTS (SELECT 1
          FROM RADM.W_INT_ORG_D O
         WHERE T.ORG_WID = O.ROW_WID
           AND O.ORG_NUM IN (110023,
                             118012,
                             118010,
                             110012,
                             110011,
                             118011,
                             110015,
                             118015,
                             838001,
                             110010,
                             830001));

SELECT * FROM RADM.W_RTL_INV_IT_LC_G T WHERE T.INV_SOH_QTY = 5000000;
SELECT * FROM RADM.W_INT_ORG_D;
SELECT * FROM RADM.W_INT_ORG_ATTR_D;

SELECT * FROM RADM.W_RTL_INV_IT_LC_G T ORDER BY T.INV_SOH_QTY DESC;
