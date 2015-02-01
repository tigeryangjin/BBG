[2013-08-26T15:12:45.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 0000K2tTvQJComWFLzYROA1I6e_Q000Q0W] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
138856e0
SET VARIABLE QUERY_SRC_CD='Report',SAW_SRC_PATH='/users/raadmin/YJ/NBOéšåºæ±æ»_ch';SELECT
   0 s_0,
   "Retail As-Was"."Organization As Was"."Chain" s_1,
   "Retail As-Was"."Organization As Was"."Loc" s_2,
   DESCRIPTOR_IDOF("Retail As-Was"."Organization As Was"."Chain") s_3,
   "Retail As-Was"."BBG NBO Item Count by Loc"."NBO_INV_SKU" s_4,
   "Retail As-Was"."BBG NBO Item Count by Loc"."NBO_NOORDER_SKU" s_5,
   "Retail As-Was"."BBG NBO Item Count by Loc"."NBO_SKU" s_6,
   FILTER("Retail As-Was"."Last Inventory Position"."INV_ON_ORD_QTY" USING ("Retail As-Was"."BBG Item Loc"."BBG NBO Flag" ='Y')) s_7,
   FILTER("Retail As-Was"."Last Inventory Position"."INV_SOH_QTY" USING ("Retail As-Was"."BBG Item Loc"."BBG NBO Flag" ='Y')) s_8,
   PERIODROLLING("Retail As-Was"."Sales"."Net Sales Qty",-2,0) s_9
FROM "Retail As-Was"
WHERE
("Gregorian Calendar"."Date" = date '2013-08-25')
ORDER BY 1, 2 ASC NULLS LAST, 3 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-08-26T15:12:45.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 0000K2tTvQJComWFLzYROA1I6e_Q000Q0W] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-08-26T15:12:45.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-52] [] [ecid: 0000K2tTvQJComWFLzYROA1I6e_Q000Q0W] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Expression 'PeriodRolling(Net Sales Qty:[DAggr(Fact - Retail Sales.Net Sales Qty by [ Dim â Retail Organization As Was.Chain Lookup, cast(Dim â Retail Organization As Was.Chain Number as  VARCHAR ( 20 ))  || '-' || lookup( DENSE Lookup - Domain Source.Domain Member Name, 'RTL_ORG', Dim â Retail Organization As Was.Chain Lookup, VALUEOF(NQ_SESSION.USER_LANGUAGE_CODE), Dim â Retail Organization As Was.Source Id) , Dim â Retail Organization As Was.Chain Number, Dim â Retail Organization As Was.Loc Number Name] )], -2, 0)' converted to NULL because a query using PeriodRolling must reference a Time dimension.
[2013-08-26T15:12:45.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2tTvQJComWFLzYROA1I6e_Q000Q0W] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1779781>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 138856e0, physical request hash 86f8e356: [[

select concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c1,
     concat(concat(T964333.ORG_HIER13_NUM, '~'), 'CHAIN') as c2,
     sum(T1030932.INV_ON_ORD_QTY) as c3,
     sum(T1030932.INV_SOH_QTY) as c4,
     cast(T964333.ORG_HIER13_NUM as  INTEGER  ) as c5,
     concat(cast(cast(T964333.ORG_HIER13_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c6,
     T964333.DATASOURCE_NUM_ID as c7
from 
     BBG_RA_ITEM_LOC_D T1009437 /* Dim_BBG_ITEM_LOC */ ,
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
     W_RTL_INV_IT_LC_GV T1030932 /* Fact_W_RTL_INV_IT_LC_G */ 
where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1030932.ORG_WID and T960506.ROW_WID = T1030932.DT_WID and T964333.ROW_WID = T1030932.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and T960506.MCAL_CAL_WID = 1.0 and T1009437.NBO = 'Y' and T1009437.ROW_WID = T1030932.BBG_ITEM_LOC_WID and  TRUNC(T960506.MCAL_DAY_DT) = TO_DATE('2013-08-25' , 'YYYY-MM-DD') and '2010' < T960506.CAL_YEAR ) 
group by T964333.DATASOURCE_NUM_ID, cast(T964333.ORG_HIER13_NUM as  INTEGER  ), concat(concat(T964333.ORG_HIER13_NUM, '~'), 'CHAIN'), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME)
order by c2, c1, c7, c5

]]
[2013-08-26T15:12:45.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2tTvQJComWFLzYROA1I6e_Q000Q0W] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1780024>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 138856e0, physical request hash a469c3bc: [[

select concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c1,
     concat(concat(T964333.ORG_HIER13_NUM, '~'), 'CHAIN') as c2,
     sum(T1033279.NBO_INV_SKU) as c3,
     sum(T1033279.NBO_NOORDER_SKU) as c4,
     sum(T1033279.NBO_SKU) as c5,
     cast(T964333.ORG_HIER13_NUM as  INTEGER  ) as c6,
     concat(cast(cast(T964333.ORG_HIER13_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c7,
     T964333.DATASOURCE_NUM_ID as c8
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
     BBG_RA_NBOSTORECOUNTOFITEM_A T1033279 /* Fact_BBG_RA_NBOSTORECOUNTOFITEM_A */ 
where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T960506.ROW_WID = T1033279.DT_WID and T964333.SCD1_WID = T964463.SCD1_WID and T960506.MCAL_CAL_WID = 1.0 and T964463.ORG_NUM = T1033279.LOC and  TRUNC(T960506.MCAL_DAY_DT) = TO_DATE('2013-08-25' , 'YYYY-MM-DD') and '2010' < T960506.CAL_YEAR ) 
group by T964333.DATASOURCE_NUM_ID, cast(T964333.ORG_HIER13_NUM as  INTEGER  ), concat(concat(T964333.ORG_HIER13_NUM, '~'), 'CHAIN'), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME)
order by c2, c1, c8, c6

]]
[2013-08-26T15:12:45.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2tTvQJComWFLzYROA1I6e_Q000Q0W] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1780373>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 138856e0, physical request hash b1711efa: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'RTL_ORG' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-34] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Query Status: Successful Completion [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Rows 139, bytes 621608 retrieved from database query id: <<1780024>> [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<1780024>> [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Rows 161, bytes 718704 retrieved from database query id: <<1779781>> [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Physical query response time 48 (seconds), id <<1779781>> [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Rows 3, bytes 6216 retrieved from database query id: <<1780373>> [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<1780373>> [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-29] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Physical Query Summary Stats: Number of physical queries 3, Cumulative time 48, DB-connect time 0 (seconds) [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-24] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Rows returned to Client 158 [[

]]
[2013-08-26T15:13:34.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-33] [] [ecid: 0000K2tU7MhComWFLzYROA1I6e_Q000Q84] [tid: 45786940] [requestid: 4b370028] [sessionid: 4b370000] [username: RAADMIN] -------------------- Logical Query Summary Stats: Elapsed time 49, Response time 48, Compilation time 0 (seconds) [[

]]
