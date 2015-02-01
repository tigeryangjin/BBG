[2013-08-14T16:44:36.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 0000K1vzrvXComWFLzYROA1I2EQd0014Fs] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
76038aa1
SET VARIABLE QUERY_SRC_CD='ValuePrompt';SELECT "Gregorian Calendar"."Month" saw_0 FROM "Retail As-Was" ORDER BY saw_0

]]
[2013-08-14T16:44:36.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 0000K1vzrvXComWFLzYROA1I2EQd0014Fs] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-08-14T16:44:36.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-34] [] [ecid: 0000K1vzrvXComWFLzYROA1I2EQd0014Fs] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Query Status: Successful Completion [[

]]
[2013-08-14T16:44:36.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-29] [] [ecid: 0000K1vzrvXComWFLzYROA1I2EQd0014Fs] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Physical Query Summary Stats: Number of physical queries 1, Cumulative time 0, DB-connect time 0 (seconds) [[

]]
[2013-08-14T16:44:36.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-24] [] [ecid: 0000K1vzrvXComWFLzYROA1I2EQd0014Fs] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Rows returned to Client 120 [[

]]
[2013-08-14T16:44:36.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-33] [] [ecid: 0000K1vzrvXComWFLzYROA1I2EQd0014Fs] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Logical Query Summary Stats: Elapsed time 0, Response time 0, Compilation time 0 (seconds) [[

]]
[2013-08-14T16:45:01.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
532ef644
SET VARIABLE QUERY_SRC_CD='Report',SAW_SRC_PATH='/shared/ç©æµéš/éšåºå€§ç±»åšèœ¬æ¥è¡š';SELECT
   0 s_0,
   "Retail As-Was"."BBG Item Loc Supp"."Desc Chinese" s_1,
   "Retail As-Was"."BBG Item Loc"."Physical warehouse" s_2,
   "Retail As-Was"."Gregorian Calendar"."Month" s_3,
   "Retail As-Was"."Item As Was"."Department" s_4,
   "Retail As-Was"."Organization As Was"."Loc" s_5,
   DESCRIPTOR_IDOF("Retail As-Was"."Item As Was"."Department") s_6,
   "Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost" s_7,
   (("Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost"+AGO("Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost","Gregorian Calendar"."Time Level"."Month",1))/2)/(TODATE("Retail As-Was"."BBG Supplier Sales"."Sales Cost","Gregorian Calendar"."Time Level"."Month")/30) s_8,
   TODATE("Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost","Gregorian Calendar"."Time Level"."Month") s_9,
   TODATE("Retail As-Was"."BBG Supplier Sales"."Sales Amt","Gregorian Calendar"."Time Level"."Month") s_10
FROM "Retail As-Was"
WHERE
(("Gregorian Calendar"."Month" = '2013 / 07') AND ("Organization As Was"."Loc" = '120055-èŽºåååº'))
ORDER BY 1, 4 ASC NULLS LAST, 6 ASC NULLS LAST, 3 ASC NULLS LAST, 5 ASC NULLS LAST, 2 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-08-14T16:45:01.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-08-14T16:45:02.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5076791>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 532ef644, physical request hash 174658c9: [[

select D1.c2 as c1,
     D1.c3 as c2,
     D1.c4 as c3,
     D1.c5 as c4,
     D1.c6 as c5,
     D1.c1 as c6,
     D1.c7 as c7,
     D1.c8 as c8,
     D1.c9 as c9,
     D1.c10 as c10
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9,
               D1.c10 as c10
          from 
               (select sum(D1.c1) over (partition by D1.c7, D1.c10, D1.c2, D1.c5, D1.c3)  as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         D1.c8 as c8,
                         D1.c9 as c9,
                         D1.c10 as c10,
                         ROW_NUMBER() OVER (PARTITION BY D1.c2, D1.c3, D1.c5, D1.c7, D1.c10 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c5 ASC, D1.c7 ASC, D1.c10 ASC) as c11
                    from 
                         (select sum(case D1.c17 when 1 then D1.c11 else NULL end ) as c1,
                                   D1.c2 as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8,
                                   D1.c9 as c9,
                                   D1.c10 as c10
                              from 
                                   (select D1.c2 as c2,
                                             D1.c3 as c3,
                                             D1.c4 as c4,
                                             D1.c5 as c5,
                                             D1.c6 as c6,
                                             D1.c7 as c7,
                                             D1.c8 as c8,
                                             D1.c9 as c9,
                                             D1.c10 as c10,
                                             D1.c11 as c11,
                                             D1.c12 as c12,
                                             D1.c13 as c13,
                                             D1.c14 as c14,
                                             D1.c15 as c15,
                                             D1.c16 as c16,
                                             ROW_NUMBER() OVER (PARTITION BY D1.c7, D1.c10, D1.c2, D1.c5, D1.c3, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16 ORDER BY D1.c7 DESC, D1.c10 DESC, D1.c2 DESC, D1.c5 DESC, D1.c3 DESC, D1.c12 DESC, D1.c13 DESC, D1.c14 DESC, D1.c15 DESC, D1.c16 DESC) as c17
                                        from 
                                             (select T1010474.DESC_CHINESE as c2,
                                                       T1009437.REF_NO2 as c3,
                                                       D5.c5 as c4,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                                                       concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c6,
                                                       D5.c3 as c7,
                                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                                                       T955085.DATASOURCE_NUM_ID as c9,
                                                       cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c10,
                                                       LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D5.c3 ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D5.c3 NULLS FIRST, D5.c4 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c11,
                                                       T14449.ROW_WID as c12,
                                                       T954755.ROW_WID as c13,
                                                       T964463.ROW_WID as c14,
                                                       T1009437.ROW_WID as c15,
                                                       T1010474.ROW_WID as c16
                                                  from 
                                                       BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
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
                                                       W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                                                       (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                                       W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                                                       BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ ,
                                                       (select distinct min(D1.c1) over (partition by D1.c4)  as c1,
                                                                 min(D1.c2) over (partition by D1.c4, D1.c3)  as c2,
                                                                 D1.c3 as c3
                                                            from 
                                                                 (select Case when case D1.c5 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c5 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c1,
                                                                           Case when case D1.c6 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c4 ORDER BY case D1.c6 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c2,
                                                                           D1.c3 as c3,
                                                                           D1.c4 as c4
                                                                      from 
                                                                           (select T960506.ROW_WID as c3,
                                                                                     T960506.CAL_MONTH_WID as c4,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c5,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c6
                                                                                from 
                                                                                     W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                                where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                           ) D1
                                                                 ) D1
                                                       ) D7,
                                                       (select distinct min(D1.c1) over (partition by D1.c3)  as c1,
                                                                 min(D1.c2) over (partition by D1.c3, D1.c4)  as c2,
                                                                 D1.c3 as c3,
                                                                 D1.c4 as c4,
                                                                 D1.c5 as c5
                                                            from 
                                                                 (select Case when case D1.c6 when 1 then D1.c4 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c6 when 1 then D1.c4 else NULL end  ASC NULLS LAST ) end as c1,
                                                                           Case when case D1.c7 when 1 then D1.c4 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c3 ORDER BY case D1.c7 when 1 then D1.c4 else NULL end  ASC NULLS LAST ) end as c2,
                                                                           D1.c3 as c3,
                                                                           D1.c4 as c4,
                                                                           D1.c5 as c5
                                                                      from 
                                                                           (select T960506.CAL_MONTH_WID as c3,
                                                                                     T960506.ROW_WID as c4,
                                                                                     T960506.PER_NAME_MONTH as c5,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c6,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c7
                                                                                from 
                                                                                     W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                                where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                           ) D1
                                                                 ) D1
                                                       ) D5
                                                  where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T1010716.DT_WID = D7.c3 and D5.c1 = D7.c1 and D5.c5 = '2013 / 07' and concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) = '120055-èŽºåååº' and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and D5.c2 >= D7.c2 ) 
                                             ) D1
                                   ) D1
                              group by D1.c2, D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10
                         ) D1
               ) D1
          where  ( D1.c11 = 1 ) 
     ) D1
order by c1, c4, c2, c7, c10

]]
[2013-08-14T16:45:02.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5076892>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 532ef644, physical request hash fae5a0fe: [[

select D2.c3 as c1,
     D2.c4 as c2,
     D2.c5 as c3,
     D2.c6 as c4,
     D2.c7 as c5,
     D2.c1 as c6,
     D2.c2 as c7,
     D2.c8 as c8,
     D2.c9 as c9,
     D2.c10 as c10,
     D2.c11 as c11
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9,
               D1.c10 as c10,
               D1.c11 as c11
          from 
               (select sum(T1013925.SUPP_SALES_COST) as c1,
                         sum(T1013925.SUPP_SALES_AMT) as c2,
                         T1010474.DESC_CHINESE as c3,
                         T1009437.REF_NO2 as c4,
                         D8.c3 as c5,
                         concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c6,
                         concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c7,
                         D8.c2 as c8,
                         concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c9,
                         T955085.DATASOURCE_NUM_ID as c10,
                         cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c11,
                         ROW_NUMBER() OVER (PARTITION BY T1009437.REF_NO2, T1010474.DESC_CHINESE, D8.c2, cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ORDER BY T1009437.REF_NO2 ASC, T1010474.DESC_CHINESE ASC, D8.c2 ASC, cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ASC) as c12
                    from 
                         BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
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
                         (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                         W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                         BBG_RA_SLS_IT_LC_DY_A T1013925 /* Fact_BBG_RA_SLS_IT_LC_DY_A */ ,
                         (select distinct min(D1.c1) over (partition by D1.c3)  as c1,
                                   D1.c2 as c2
                              from 
                                   (select Case when case D1.c4 when 1 then D1.c2 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c4 when 1 then D1.c2 else NULL end  ASC NULLS LAST ) end as c1,
                                             D1.c2 as c2,
                                             D1.c3 as c3
                                        from 
                                             (select T960506.ROW_WID as c2,
                                                       T960506.CAL_MONTH_WID as c3,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c4
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D10,
                         (select distinct min(D1.c1) over (partition by D1.c2)  as c1,
                                   D1.c2 as c2,
                                   D1.c3 as c3
                              from 
                                   (select Case when case D1.c5 when 1 then D1.c4 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c5 when 1 then D1.c4 else NULL end  ASC NULLS LAST ) end as c1,
                                             D1.c2 as c2,
                                             D1.c3 as c3
                                        from 
                                             (select T960506.CAL_MONTH_WID as c2,
                                                       T960506.PER_NAME_MONTH as c3,
                                                       T960506.ROW_WID as c4,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c5
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D8
                    where  ( T1009437.ROW_WID = T1013925.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1013925.ORG_WID and T14449.ROW_WID = T1013925.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T1010474.ROW_WID = T1013925.BBG_ITEM_LOC_SUPP_WID and T1013925.DT_WID = D10.c2 and D8.c1 = D10.c1 and D8.c3 = '2013 / 07' and T964333.ROW_WID = T1013925.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) = '120055-èŽºåååº' ) 
                    group by T955085.DATASOURCE_NUM_ID, T1009437.REF_NO2, T1010474.DESC_CHINESE, D8.c2, D8.c3, cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ), concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME), concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c12 = 1 ) 
     ) D2
order by c1, c4, c2, c8, c11

]]
[2013-08-14T16:45:02.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5077219>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 532ef644, physical request hash 61bcb49f: [[

select D3.c2 as c1,
     D3.c3 as c2,
     D3.c4 as c3,
     D3.c5 as c4,
     D3.c6 as c5,
     D3.c1 as c6,
     D3.c7 as c7,
     D3.c8 as c8,
     D3.c9 as c9,
     D3.c10 as c10
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9,
               D1.c10 as c10
          from 
               (select sum(D1.c1) over (partition by D1.c7, D1.c10, D1.c2, D1.c5, D1.c3)  as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         D1.c8 as c8,
                         D1.c9 as c9,
                         D1.c10 as c10,
                         ROW_NUMBER() OVER (PARTITION BY D1.c2, D1.c3, D1.c5, D1.c7, D1.c10 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c5 ASC, D1.c7 ASC, D1.c10 ASC) as c11
                    from 
                         (select sum(case D1.c17 when 1 then D1.c11 else NULL end ) as c1,
                                   D1.c2 as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8,
                                   D1.c9 as c9,
                                   D1.c10 as c10
                              from 
                                   (select D1.c2 as c2,
                                             D1.c3 as c3,
                                             D1.c4 as c4,
                                             D1.c5 as c5,
                                             D1.c6 as c6,
                                             D1.c7 as c7,
                                             D1.c8 as c8,
                                             D1.c9 as c9,
                                             D1.c10 as c10,
                                             D1.c11 as c11,
                                             D1.c12 as c12,
                                             D1.c13 as c13,
                                             D1.c14 as c14,
                                             D1.c15 as c15,
                                             D1.c16 as c16,
                                             ROW_NUMBER() OVER (PARTITION BY D1.c7, D1.c10, D1.c2, D1.c5, D1.c3, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16 ORDER BY D1.c7 DESC, D1.c10 DESC, D1.c2 DESC, D1.c5 DESC, D1.c3 DESC, D1.c12 DESC, D1.c13 DESC, D1.c14 DESC, D1.c15 DESC, D1.c16 DESC) as c17
                                        from 
                                             (select T1010474.DESC_CHINESE as c2,
                                                       T1009437.REF_NO2 as c3,
                                                       D11.c5 as c4,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                                                       concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c6,
                                                       D11.c3 as c7,
                                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                                                       T955085.DATASOURCE_NUM_ID as c9,
                                                       cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c10,
                                                       LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D11.c3 ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D11.c3 NULLS FIRST, D11.c4 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c11,
                                                       T14449.ROW_WID as c12,
                                                       T954755.ROW_WID as c13,
                                                       T964463.ROW_WID as c14,
                                                       T1009437.ROW_WID as c15,
                                                       T1010474.ROW_WID as c16
                                                  from 
                                                       BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
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
                                                       W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                                                       (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                                       W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                                                       BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ ,
                                                       (select distinct D1.c1 + 1 as c1,
                                                                 D1.c2 as c2,
                                                                 D1.c3 as c3
                                                            from 
                                                                 (select min(D1.c1) over (partition by D1.c4)  as c1,
                                                                           min(D1.c2) over (partition by D1.c4, D1.c3)  as c2,
                                                                           D1.c3 as c3
                                                                      from 
                                                                           (select Case when case D1.c5 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c5 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c1,
                                                                                     Case when case D1.c6 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c4 ORDER BY case D1.c6 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c2,
                                                                                     D1.c3 as c3,
                                                                                     D1.c4 as c4
                                                                                from 
                                                                                     (select T960506.ROW_WID as c3,
                                                                                               T960506.CAL_MONTH_WID as c4,
                                                                                               ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c5,
                                                                                               ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c6
                                                                                          from 
                                                                                               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                                          where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                                     ) D1
                                                                           ) D1
                                                                 ) D1
                                                       ) D13,
                                                       (select distinct min(D1.c1) over (partition by D1.c3)  as c1,
                                                                 min(D1.c2) over (partition by D1.c3, D1.c4)  as c2,
                                                                 D1.c3 as c3,
                                                                 D1.c4 as c4,
                                                                 D1.c5 as c5
                                                            from 
                                                                 (select Case when case D1.c6 when 1 then D1.c4 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c6 when 1 then D1.c4 else NULL end  ASC NULLS LAST ) end as c1,
                                                                           Case when case D1.c7 when 1 then D1.c4 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c3 ORDER BY case D1.c7 when 1 then D1.c4 else NULL end  ASC NULLS LAST ) end as c2,
                                                                           D1.c3 as c3,
                                                                           D1.c4 as c4,
                                                                           D1.c5 as c5
                                                                      from 
                                                                           (select T960506.CAL_MONTH_WID as c3,
                                                                                     T960506.ROW_WID as c4,
                                                                                     T960506.PER_NAME_MONTH as c5,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c6,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c7
                                                                                from 
                                                                                     W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                                where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                           ) D1
                                                                 ) D1
                                                       ) D11
                                                  where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T1010716.DT_WID = D13.c3 and D11.c1 = D13.c1 and D11.c2 = D13.c2 and D11.c5 = '2013 / 07' and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) = '120055-èŽºåååº' ) 
                                             ) D1
                                   ) D1
                              group by D1.c2, D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10
                         ) D1
               ) D1
          where  ( D1.c11 = 1 ) 
     ) D3
order by c1, c4, c2, c7, c10

]]
[2013-08-14T16:45:02.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5077547>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 532ef644, physical request hash f872e24d: [[

select D4.c2 as c1,
     D4.c3 as c2,
     D4.c4 as c3,
     D4.c5 as c4,
     D4.c6 as c5,
     D4.c1 as c6,
     D4.c7 as c7,
     D4.c8 as c8,
     D4.c9 as c9,
     D4.c10 as c10
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9,
               D1.c10 as c10
          from 
               (select sum(D1.c1) over (partition by D1.c7, D1.c10, D1.c2, D1.c5, D1.c3)  as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         D1.c8 as c8,
                         D1.c9 as c9,
                         D1.c10 as c10,
                         ROW_NUMBER() OVER (PARTITION BY D1.c2, D1.c3, D1.c5, D1.c7, D1.c10 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c5 ASC, D1.c7 ASC, D1.c10 ASC) as c11
                    from 
                         (select sum(case D1.c17 when 1 then D1.c11 else NULL end ) as c1,
                                   D1.c2 as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8,
                                   D1.c9 as c9,
                                   D1.c10 as c10
                              from 
                                   (select D1.c2 as c2,
                                             D1.c3 as c3,
                                             D1.c4 as c4,
                                             D1.c5 as c5,
                                             D1.c6 as c6,
                                             D1.c7 as c7,
                                             D1.c8 as c8,
                                             D1.c9 as c9,
                                             D1.c10 as c10,
                                             D1.c11 as c11,
                                             D1.c12 as c12,
                                             D1.c13 as c13,
                                             D1.c14 as c14,
                                             D1.c15 as c15,
                                             D1.c16 as c16,
                                             ROW_NUMBER() OVER (PARTITION BY D1.c7, D1.c10, D1.c2, D1.c5, D1.c3, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16 ORDER BY D1.c7 DESC, D1.c10 DESC, D1.c2 DESC, D1.c5 DESC, D1.c3 DESC, D1.c12 DESC, D1.c13 DESC, D1.c14 DESC, D1.c15 DESC, D1.c16 DESC) as c17
                                        from 
                                             (select T1010474.DESC_CHINESE as c2,
                                                       T1009437.REF_NO2 as c3,
                                                       T960506.PER_NAME_MONTH as c4,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                                                       concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c6,
                                                       T960506.CAL_MONTH_WID as c7,
                                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                                                       T955085.DATASOURCE_NUM_ID as c9,
                                                       cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c10,
                                                       LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, T960506.CAL_MONTH_WID ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.CAL_MONTH_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c11,
                                                       T14449.ROW_WID as c12,
                                                       T954755.ROW_WID as c13,
                                                       T964463.ROW_WID as c14,
                                                       T1009437.ROW_WID as c15,
                                                       T1010474.ROW_WID as c16
                                                  from 
                                                       BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */ ,
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
                                                       W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                                                       (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                                       W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                                                       BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */ 
                                                  where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T960506.ROW_WID = T1010716.DT_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T960506.MCAL_CAL_WID = 1.0 and T960506.PER_NAME_MONTH = '2013 / 07' and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) = '120055-èŽºåååº' and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                              group by D1.c2, D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10
                         ) D1
               ) D1
          where  ( D1.c11 = 1 ) 
     ) D4
order by c1, c4, c2, c7, c10

]]
[2013-08-14T16:45:02.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1vzy69ComWFLzYROA1I2EQd0014G6] [tid: 452d1940] [requestid: 57e90001] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5076638>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 532ef644, physical request hash 19535c6c: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'MCAT' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
