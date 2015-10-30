WITH M1 AS
 (SELECT T.DAYS,
         SUM(T.NET_SALES_AMT) M1_NSA,
         SUM(T.VIP_NET_SALES_AMT) M1_VNSA
    FROM MAR01@CSMBDB T
   GROUP BY T.DAYS
   ORDER BY T.DAYS),
M3 AS
 (SELECT T.DAYS,
         SUM(T.NET_SALES_AMT) M3_NSA,
         SUM(T.VIP_NET_SALES_AMT) M3_VNSA,
         SUM(T.CUST) M3_CUST,
         SUM(T.VIP_CUST) M3_VCUST
    FROM MAR03@CSMBDB T
   GROUP BY T.DAYS
   ORDER BY T.DAYS),
M4 AS
 (SELECT T.DAYS,
         SUM(T.NET_SALES_AMT) M4_NSA,
         SUM(T.VIP_NET_SALES_AMT) M4_VNSA
    FROM MAR04@CSMBDB T
   GROUP BY T.DAYS
   ORDER BY T.DAYS),
M5 AS
 (SELECT T.DAYS,
         SUM(T.NET_SALES_AMT) M5_NSA,
         SUM(T.VIP_NET_SALES_AMT) M5_VNSA,
         SUM(T.CUST) M5_CUST,
         SUM(T.VIP_CUST) M5_VCUST
    FROM MAR05@CSMBDB T
   GROUP BY T.DAYS
   ORDER BY T.DAYS)
SELECT M1.DAYS,
       M1.M1_NSA,
       M1.M1_VNSA,
       M3.M3_NSA,
       M3.M3_VNSA,
       M3.M3_CUST,
       M3.M3_VCUST,
       M4.M4_NSA,
       M4.M4_VNSA,
       M5.M5_NSA,
       M5.M5_VNSA,
       M5.M5_CUST,
       M5.M5_VCUST

  FROM M1, M3, M4, M5
 WHERE M1.DAYS = M3.DAYS
   AND M1.DAYS = M4.DAYS
   AND M1.DAYS = M5.DAYS;

--有销售而无客流
SELECT /*+PARALLEL(16)*/
DISTINCT A.DT_WID
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F A
 WHERE NOT EXISTS (SELECT /*+PARALLEL(16)*/
         1
          FROM RADM.BBG_RA_CUST_LC_DY_A B
         WHERE A.ORG_WID = B.ORG_WID
           AND A.DT_WID = B.DT_WID)
 ORDER BY A.DT_WID;
--生成执行语句
SELECT 'CALL JIN_UPD_CUST_PROC(' || C.DT_WID || ');'
  FROM (SELECT /*+PARALLEL(16)*/
        DISTINCT A.DT_WID
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F A
         WHERE NOT EXISTS (SELECT /*+PARALLEL(16)*/
                 1
                  FROM RADM.BBG_RA_CUST_LC_DY_A B
                 WHERE A.ORG_WID = B.ORG_WID
                   AND A.DT_WID = B.DT_WID)
         ORDER BY A.DT_WID) C;
