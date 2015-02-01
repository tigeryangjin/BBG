[2013-08-14T17:01:04.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 0000K1w3d70ComWFLzYROA1I2EQd0014op] [tid: 452d1940] [requestid: 57e90003] [sessionid: 57e90000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
6453308f
SET VARIABLE QUERY_SRC_CD='Report',SAW_SRC_PATH='/shared/ç©æµéš/éšåºåšèœ¬æ¥è¡š';SELECT
   0 s_0,
   "Retail As-Was"."BBG Item Loc Supp"."Desc Chinese" s_1,
   "Retail As-Was"."BBG Item Loc"."Physical warehouse" s_2,
   "Retail As-Was"."Gregorian Calendar"."Month" s_3,
   "Retail As-Was"."Organization As Was"."Loc" s_4,
   "Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost" s_5,
   (("Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost"+AGO("Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost","Gregorian Calendar"."Time Level"."Month",1))/2)/(TODATE("Retail As-Was"."BBG Supplier Sales"."Sales Cost","Gregorian Calendar"."Time Level"."Month")/30) s_6,
   TODATE("Retail As-Was"."BBG Supplier Inventory Position"."EOH Cost","Gregorian Calendar"."Time Level"."Month") s_7,
   TODATE("Retail As-Was"."BBG Supplier Sales"."Sales Amt","Gregorian Calendar"."Time Level"."Month") s_8
FROM "Retail As-Was"
WHERE
(("Gregorian Calendar"."Month" = '2013 / 07') AND ("Organization As Was"."Loc" = '120033-éæµ·åº'))
ORDER BY 1, 4 ASC NULLS LAST, 5 ASC NULLS LAST, 3 ASC NULLS LAST, 2 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-08-14T17:01:04.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 0000K1w3d70ComWFLzYROA1I2EQd0014op] [tid: 452d1940] [requestid: 57e90003] [sessionid: 57e90000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-08-14T17:01:04.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1w3d70ComWFLzYROA1I2EQd0014op] [tid: 452d1940] [requestid: 57e90003] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5128595>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 6453308f, physical request hash 1117d8a1: [[

select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4,
     D1.c5 as c5,
     D1.c6 as c6
from 
     (select sum(D1.c1) over (partition by D1.c6, D1.c2, D1.c5, D1.c3)  as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               ROW_NUMBER() OVER (PARTITION BY D1.c2, D1.c3, D1.c5, D1.c6 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c5 ASC, D1.c6 ASC) as c7
          from 
               (select sum(case D1.c13 when 1 then D1.c7 else NULL end ) as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6
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
                                   ROW_NUMBER() OVER (PARTITION BY D1.c6, D1.c2, D1.c5, D1.c3, D1.c8, D1.c9, D1.c10, D1.c11, D1.c12 ORDER BY D1.c6 DESC, D1.c2 DESC, D1.c5 DESC, D1.c3 DESC, D1.c8 DESC, D1.c9 DESC, D1.c10 DESC, D1.c11 DESC, D1.c12 DESC) as c13
                              from 
                                   (select T1010474.DESC_CHINESE as c2,
                                             T1009437.REF_NO2 as c3,
                                             D5.c5 as c4,
                                             concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                                             D5.c4 as c6,
                                             LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D5.c4 ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D5.c4 NULLS FIRST, D5.c3 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c7,
                                             T14449.ROW_WID as c8,
                                             T954755.ROW_WID as c9,
                                             T964463.ROW_WID as c10,
                                             T1009437.ROW_WID as c11,
                                             T1010474.ROW_WID as c12
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
                                             (select distinct min(D1.c1) over (partition by D1.c4)  as c1,
                                                       min(D1.c2) over (partition by D1.c4, D1.c3)  as c2,
                                                       D1.c3 as c3,
                                                       D1.c4 as c4,
                                                       D1.c5 as c5
                                                  from 
                                                       (select Case when case D1.c6 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c6 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c1,
                                                                 Case when case D1.c7 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c4 ORDER BY case D1.c7 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c2,
                                                                 D1.c3 as c3,
                                                                 D1.c4 as c4,
                                                                 D1.c5 as c5
                                                            from 
                                                                 (select T960506.ROW_WID as c3,
                                                                           T960506.CAL_MONTH_WID as c4,
                                                                           T960506.PER_NAME_MONTH as c5,
                                                                           ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c6,
                                                                           ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c7
                                                                      from 
                                                                           W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                      where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                 ) D1
                                                       ) D1
                                             ) D5
                                        where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T1010716.DT_WID = D7.c3 and D5.c1 = D7.c1 and D5.c5 = '2013 / 07' and concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) = '120033-éæµ·åº' and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and D5.c2 >= D7.c2 ) 
                                   ) D1
                         ) D1
                    group by D1.c2, D1.c3, D1.c4, D1.c5, D1.c6
               ) D1
     ) D1
where  ( D1.c7 = 1 ) 

]]
[2013-08-14T17:01:04.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1w3d70ComWFLzYROA1I2EQd0014op] [tid: 452d1940] [requestid: 57e90003] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5129080>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 6453308f, physical request hash da648f90: [[

select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4,
     D1.c5 as c5,
     D1.c6 as c6,
     D1.c7 as c7
from 
     (select sum(T1013925.SUPP_SALES_COST) as c1,
               sum(T1013925.SUPP_SALES_AMT) as c2,
               T1010474.DESC_CHINESE as c3,
               T1009437.REF_NO2 as c4,
               D8.c2 as c5,
               concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c6,
               D8.c3 as c7,
               ROW_NUMBER() OVER (PARTITION BY T1009437.REF_NO2, T1010474.DESC_CHINESE, D8.c3, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ORDER BY T1009437.REF_NO2 ASC, T1010474.DESC_CHINESE ASC, D8.c3 ASC, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ASC) as c8
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
               (select distinct min(D1.c1) over (partition by D1.c3)  as c1,
                         D1.c2 as c2,
                         D1.c3 as c3
                    from 
                         (select Case when case D1.c5 when 1 then D1.c4 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c5 when 1 then D1.c4 else NULL end  ASC NULLS LAST ) end as c1,
                                   D1.c2 as c2,
                                   D1.c3 as c3
                              from 
                                   (select T960506.PER_NAME_MONTH as c2,
                                             T960506.CAL_MONTH_WID as c3,
                                             T960506.ROW_WID as c4,
                                             ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c5
                                        from 
                                             W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                        where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                   ) D1
                         ) D1
               ) D8
          where  ( T1009437.ROW_WID = T1013925.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1013925.ORG_WID and T1010474.ROW_WID = T1013925.BBG_ITEM_LOC_SUPP_WID and T1013925.DT_WID = D10.c2 and T964333.ROW_WID = T1013925.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and D8.c1 = D10.c1 and D8.c2 = '2013 / 07' and concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) = '120033-éæµ·åº' ) 
          group by T1009437.REF_NO2, T1010474.DESC_CHINESE, D8.c2, D8.c3, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME)
     ) D1
where  ( D1.c8 = 1 ) 

]]
[2013-08-14T17:01:04.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K1w3d70ComWFLzYROA1I2EQd0014op] [tid: 452d1940] [requestid: 57e90003] [sessionid: 57e90000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<5129917>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 6453308f, physical request hash 91ce961d: [[

select D1.c1 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4,
     D1.c5 as c5,
     D1.c6 as c6
from 
     (select sum(D1.c1) over (partition by D1.c6, D1.c2, D1.c5, D1.c3)  as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               ROW_NUMBER() OVER (PARTITION BY D1.c2, D1.c3, D1.c5, D1.c6 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c5 ASC, D1.c6 ASC) as c7
          from 
               (select sum(case D1.c13 when 1 then D1.c7 else NULL end ) as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6
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
                                   ROW_NUMBER() OVER (PARTITION BY D1.c6, D1.c2, D1.c5, D1.c3, D1.c8, D1.c9, D1.c10, D1.c11, D1.c12 ORDER BY D1.c6 DESC, D1.c2 DESC, D1.c5 DESC, D1.c3 DESC, D1.c8 DESC, D1.c9 DESC, D1.c10 DESC, D1.c11 DESC, D1.c12 DESC) as c13
                              from 
                                   (select T1010474.DESC_CHINESE as c2,
                                             T1009437.REF_NO2 as c3,
                                             D11.c3 as c4,
                                             concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                                             D11.c4 as c6,
                                             LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D11.c4 ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D11.c4 NULLS FIRST, D11.c5 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c7,
                                             T14449.ROW_WID as c8,
                                             T954755.ROW_WID as c9,
                                             T964463.ROW_WID as c10,
                                             T1009437.ROW_WID as c11,
                                             T1010474.ROW_WID as c12
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
                                             (select distinct min(D1.c1) over (partition by D1.c4)  as c1,
                                                       min(D1.c2) over (partition by D1.c4, D1.c5)  as c2,
                                                       D1.c3 as c3,
                                                       D1.c4 as c4,
                                                       D1.c5 as c5
                                                  from 
                                                       (select Case when case D1.c6 when 1 then D1.c5 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c6 when 1 then D1.c5 else NULL end  ASC NULLS LAST ) end as c1,
                                                                 Case when case D1.c7 when 1 then D1.c5 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c4 ORDER BY case D1.c7 when 1 then D1.c5 else NULL end  ASC NULLS LAST ) end
