[2013-08-14T17:02:16.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 0000K1w3udkComWFLzYROA1I2EQd0014qT] [tid: 452d1940] [requestid: 57e90004] [sessionid: 57e90000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
ac76f2c1
SET VARIABLE QUERY_SRC_CD='Report',SAW_SRC_PATH='/shared/ç©æµéš/ééçŽéå°èŽ§çè¡š';SELECT s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26 FROM (
SELECT
   0 s_0,
   "Retail As-Was"."Gregorian Calendar"."Date" s_1,
   "Retail As-Was"."Organization As Was"."Loc" s_2,
   "Retail As-Was"."BBG Inventory Transfer"."Direct Order Cost" s_3,
   "Retail As-Was"."BBG Inventory Transfer"."Direct Order Qty" s_4,
   "Retail As-Was"."BBG Inventory Transfer"."Direct Out Cost" s_5,
   "Retail As-Was"."BBG Inventory Transfer"."Direct Out Cost"*100/"Retail As-Was"."BBG Inventory Transfer"."Direct Order Cost" s_6,
   "Retail As-Was"."BBG Inventory Transfer"."Direct Out Qty" s_7,
   "Retail As-Was"."BBG Inventory Transfer"."Direct Out Qty"*100/"Retail As-Was"."BBG Inventory Transfer"."Direct Order Qty" s_8,
   "Retail As-Was"."BBG Inventory Transfer"."Transfer Order Cost" s_9,
   "Retail As-Was"."BBG Inventory Transfer"."Transfer Order Qty" s_10,
   "Retail As-Was"."BBG Inventory Transfer"."Transfer Out Cost" s_11,
   "Retail As-Was"."BBG Inventory Transfer"."Transfer Out Cost"*100/"Retail As-Was"."BBG Inventory Transfer"."Transfer Order Cost" s_12,
   "Retail As-Was"."BBG Inventory Transfer"."Transfer Out Qty" s_13,
   "Retail As-Was"."BBG Inventory Transfer"."Transfer Out Qty"*100/"Retail As-Was"."BBG Inventory Transfer"."Transfer Order Qty" s_14,
   REPORT_AGGREGATE("Retail As-Was"."BBG Inventory Transfer"."Direct Out Cost"*100/"Retail As-Was"."BBG Inventory Transfer"."Direct Order Cost" BY "Retail As-Was"."Gregorian Calendar"."Date") s_15,
   REPORT_AGGREGATE("Retail As-Was"."BBG Inventory Transfer"."Direct Out Qty"*100/"Retail As-Was"."BBG Inventory Transfer"."Direct Order Qty" BY "Retail As-Was"."Gregorian Calendar"."Date") s_16,
   REPORT_AGGREGATE("Retail As-Was"."BBG Inventory Transfer"."Transfer Out Cost"*100/"Retail As-Was"."BBG Inventory Transfer"."Transfer Order Cost" BY "Retail As-Was"."Gregorian Calendar"."Date") s_17,
   REPORT_AGGREGATE("Retail As-Was"."BBG Inventory Transfer"."Transfer Out Qty"*100/"Retail As-Was"."BBG Inventory Transfer"."Transfer Order Qty" BY "Retail As-Was"."Gregorian Calendar"."Date") s_18,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Direct Order Cost" BY "Retail As-Was"."Gregorian Calendar"."Date") s_19,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Direct Order Qty" BY "Retail As-Was"."Gregorian Calendar"."Date") s_20,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Direct Out Cost" BY "Retail As-Was"."Gregorian Calendar"."Date") s_21,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Direct Out Qty" BY "Retail As-Was"."Gregorian Calendar"."Date") s_22,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Transfer Order Cost" BY "Retail As-Was"."Gregorian Calendar"."Date") s_23,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Transfer Order Qty" BY "Retail As-Was"."Gregorian Calendar"."Date") s_24,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Transfer Out Cost" BY "Retail As-Was"."Gregorian Calendar"."Date") s_25,
   REPORT_SUM("Retail As-Was"."BBG Inventory Transfer"."Transfer Out Qty" BY "Retail As-Was"."Gregorian Calendar"."Date") s_26
FROM "Retail As-Was"
WHERE
(("Organization As Was"."Loc" IN ('118001-æ­¥æ­¥é«ç©æµäž­å¿è¡¥èŽ§ä»', '118004-æ±è¥¿ééäž­å¿è¡¥èŽ§ä»')) AND ("Gregorian Calendar"."Date" BETWEEN date '2013-07-01' AND date '2013-07-31'))
) djm ORDER BY 1, 2 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-08-14T17:02:16.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 0000K1w3udkComWFLzYROA1I2EQd0014qT] [tid: 452d1940] [requestid: 57e90004] [sessionid: 57e90000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-08-14T17:02:16.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1w3udkComWFLzYROA1I2EQd0014qT] [tid: 452d1940] [requestid: 57e90004] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5156019>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash ac76f2c1, physical request hash 20fd0e15: [[

select distinct 0 as c1,
     D1.c9 as c2,
     D1.c10 as c3,
     D1.c7 as c4,
     D1.c5 as c5,
     D1.c8 as c6,
     D1.c8 * 100 / nullif( D1.c7, 0) as c7,
     D1.c6 as c8,
     D1.c6 * 100 / nullif( D1.c5, 0) as c9,
     D1.c3 as c10,
     D1.c1 as c11,
     D1.c4 as c12,
     D1.c4 * 100 / nullif( D1.c3, 0) as c13,
     D1.c2 as c14,
     D1.c2 * 100 / nullif( D1.c1, 0) as c15,
     0 as c16,
     0 as c17,
     0 as c18,
     0 as c19,
     0 as c20,
     0 as c21,
     0 as c22,
     0 as c23,
     0 as c24,
     0 as c25,
     0 as c26,
     0 as c27,
     D1.c11 as c28
from 
     (select sum(T1011789.BBG_REFERENCE_FO1) as c1,
               sum(T1011789.TRANSFER_QTY) as c2,
               sum(T1011789.BBG_REFERENCE_FO2) as c3,
               sum(T1011789.TRANSFER_COST) as c4,
               sum(T1011789.BBG_REFERENCE_FO5) as c5,
               sum(T1011789.BBG_REFERENCE_FO3) as c6,
               sum(T1011789.BBG_REFERENCE_FO6) as c7,
               sum(T1011789.BBG_REFERENCE_FO4) as c8,
                TRUNC(T960506.MCAL_DAY_DT) as c9,
               concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c10,
               T960506.ROW_WID as c11
          from 
               (SELECT
  DATASOURCE_NUM_ID,
  INTEGRATION_ID,
  ORG_DESCR,
  ORG_NAME,
  LANGUAGE_CODE

FROM 
  W_INT_ORG_D_TL

WHERE
  LANGUAGE_CODE = 'ZHS') T953980,
               W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               BBG_RA_INVTSF_IT_LC_DY_F T1011789 /* Fact_BBG_RA_INVTSF_IT_LC_DY_F_IN */ 
          where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T960506.ROW_WID = T1011789.DT_WID and T964333.ROW_WID = T1011789.ORG_DH_WID and T960506.MCAL_CAL_WID = 1.0 and T964333.SCD1_WID = T964463.SCD1_WID and T964463.ROW_WID = T1011789.ORG_WID and T1011789.BBG_REFERENCE_DO1 = 'IN' and '2010' < T960506.CAL_YEAR and (concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) in ('118001-æ­¥æ­¥é«ç©æµäž­å¿è¡¥èŽ§ä»', '118004-æ±è¥¿ééäž­å¿è¡¥èŽ§ä»')) and  TRUNC(T960506.MCAL_DAY_DT) between TO_DATE('2013-07-01' , 'YYYY-MM-DD') and TO_DATE('2013-07-31' , 'YYYY-MM-DD') ) 
          group by T960506.ROW_WID,  TRUNC(T960506.MCAL_DAY_DT), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME)
     ) D1
order by c2, c28, c3

]]
