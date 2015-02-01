[2013-11-22T08:14:27.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 117010e66f1dee37:-6eb0d535:1426930c60c:-8000-0000000000199a1c] [tid: 44eba940] [requestid: 487d0011] [sessionid: 487d0000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
8a90ab2d
SET VARIABLE QUERY_SRC_CD='Report',SAW_SRC_PATH='/users/raadmin/YJ/ç©æµååå€§ç±»åšèœ¬æ¥è¡š';SELECT
   0 s_0,
   "Retail As-Was"."Item As Was"."Item Number" s_1,
   "Retail As-Was"."Item As Was"."Subclass" s_2,
   "Retail As-Was"."Organization As Was"."Loc" s_3,
   DESCRIPTOR_IDOF("Retail As-Was"."Item As Was"."Subclass") s_4,
   "Retail As-Was"."Inventory Position"."EOH Cost" s_5,
   "Retail As-Was"."Inventory Position"."EOH Qty" s_6,
   (("Retail As-Was"."Inventory Position"."EOH Cost"+AGO("Retail As-Was"."Inventory Position"."EOH Cost","Gregorian Calendar"."Time Level"."Month",1))/2)/((TODATE("Retail As-Was"."Sales"."Net Sales Amt","Gregorian Calendar"."Time Level"."Month")-TODATE("Retail As-Was"."Sales"."Net Profit","Gregorian Calendar"."Time Level"."Month"))/30) s_7
FROM "Retail As-Was"
WHERE
(("Gregorian Calendar"."Month" = '2013 / 09') AND ((("Inventory Position"."EOH Cost"+AGO("Inventory Position"."EOH Cost", "Gregorian Calendar"."Time Level"."Month", 1))/2)/((TODATE("Sales"."Net Sales Amt","Gregorian Calendar"."Time Level"."Month")-TODATE("Sales"."Net Profit", "Gregorian Calendar"."Time Level"."Month"))/30) <> 0))
ORDER BY 1, 4 ASC NULLS LAST, 3 ASC NULLS LAST, 2 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-11-22T08:14:27.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 117010e66f1dee37:-6eb0d535:1426930c60c:-8000-0000000000199a1c] [tid: 44eba940] [requestid: 487d0011] [sessionid: 487d0000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-11-22T08:14:28.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-6eb0d535:1426930c60c:-8000-0000000000199a1c] [tid: 44eba940] [requestid: 487d0011] [sessionid: 487d0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<357082>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 8a90ab2d, physical request hash 34399b9: [[

select D1.c4 as c1,
     D1.c5 as c2,
     D1.c6 as c3,
     D1.c1 as c4,
     D1.c2 as c5,
     D1.c3 as c6,
     D1.c7 as c7,
     D1.c8 as c8,
     D1.c9 as c9
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9
          from 
               (select sum(nvl(T956076.SLS_AMT_LCL , 0) - nvl(T956076.RET_AMT_LCL , 0)) as c1,
                         sum(nvl(T956076.SLS_TAX_AMT_LCL , 0) - nvl(T956076.RET_TAX_AMT_LCL , 0)) as c2,
                         sum(nvl(T956076.SLS_PROFIT_AMT_LCL , 0) - nvl(T956076.RET_PROFIT_AMT_LCL , 0)) as c3,
                         T14449.PROD_NUM as c4,
                         concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                         concat(concat(concat(concat(concat(concat('SBC', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID), '~'), T955085.LVL4ANC_PRODCAT_ID) as c6,
                         T14449.ROW_WID as c7,
                         concat(cast(cast(T955085.LVL4ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                         T955085.DATASOURCE_NUM_ID as c9,
                         ROW_NUMBER() OVER (PARTITION BY T14449.ROW_WID, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ORDER BY T14449.ROW_WID ASC, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ASC) as c10
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
                         (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                         W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                         W_RTL_SLS_IT_LC_DY_A T956076 /* Fact_W_RTL_SLS_IT_LC_DY_A */ ,
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
                         ) D6,
                         (select distinct min(D1.c1) over (partition by D1.c3)  as c1,
                                   D1.c2 as c2
                              from 
                                   (select Case when case D1.c5 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c5 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c1,
                                             D1.c2 as c2,
                                             D1.c4 as c3
                                        from 
                                             (select T960506.PER_NAME_MONTH as c2,
                                                       T960506.ROW_WID as c3,
                                                       T960506.CAL_MONTH_WID as c4,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c5
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D4
                    where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T14449.ROW_WID = T956076.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T956076.DT_WID = D6.c2 and T956076.ORG_WID = T964463.ROW_WID and D4.c1 = D6.c1 and T956076.ORG_DH_WID = T964333.ROW_WID and T964333.SCD1_WID = T964463.SCD1_WID and D4.c2 = '2013 / 09' ) 
                    group by T14449.ROW_WID, T14449.PROD_NUM, T955085.DATASOURCE_NUM_ID, concat(cast(cast(T955085.LVL4ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME), concat(concat(concat(concat(concat(concat('SBC', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID), '~'), T955085.LVL4ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c10 = 1 ) 
     ) D1
order by c2, c7

]]
[2013-11-22T08:14:28.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-6eb0d535:1426930c60c:-8000-0000000000199a1c] [tid: 44eba940] [requestid: 487d0011] [sessionid: 487d0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<357146>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 8a90ab2d, physical request hash 72c0f5cb: [[

select D2.c2 as c1,
     D2.c3 as c2,
     D2.c4 as c3,
     D2.c1 as c4,
     D2.c5 as c5,
     D2.c6 as c6,
     D2.c7 as c7
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7
          from 
               (select sum(D1.c1) over (partition by D1.c5, D1.c3)  as c1,
                         D1.c2 as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         ROW_NUMBER() OVER (PARTITION BY D1.c3, D1.c5 ORDER BY D1.c3 ASC, D1.c5 ASC) as c8
                    from 
                         (select sum(case D1.c11 when 1 then D1.c8 else NULL end ) as c1,
                                   D1.c2 as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7
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
                                             ROW_NUMBER() OVER (PARTITION BY D1.c5, D1.c3, D1.c9, D1.c10 ORDER BY D1.c5 DESC, D1.c3 DESC, D1.c9 DESC, D1.c10 DESC) as c11
                                        from 
                                             (select T14449.PROD_NUM as c2,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c3,
                                                       concat(concat(concat(concat(concat(concat('SBC', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID), '~'), T955085.LVL4ANC_PRODCAT_ID) as c4,
                                                       T14449.ROW_WID as c5,
                                                       concat(cast(cast(T955085.LVL4ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c6,
                                                       T955085.DATASOURCE_NUM_ID as c7,
                                                       LAST_VALUE(T963640.INV_SOH_COST_AMT_LCL) OVER (PARTITION BY T14449.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID ORDER BY NVL2(T963640.INV_SOH_COST_AMT_LCL, 1, 0) , T14449.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, D7.c3 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c8,
                                                       T964463.ROW_WID as c9,
                                                       T1009437.ROW_WID as c10
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
                                                       (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                                       W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                                                       W_RTL_INV_IT_LC_DY_FV T963640 /* Fact_W_RTL_INV_IT_LC_DY_F */ ,
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
                                                       ) D9,
                                                       (select distinct min(D1.c1) over (partition by D1.c5)  as c1,
                                                                 min(D1.c2) over (partition by D1.c5, D1.c3)  as c2,
                                                                 D1.c3 as c3,
                                                                 D1.c4 as c4
                                                            from 
                                                                 (select Case when case D1.c6 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c6 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c1,
                                                                           Case when case D1.c7 when 1 then D1.c3 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c5 ORDER BY case D1.c7 when 1 then D1.c3 else NULL end  ASC NULLS LAST ) end as c2,
                                                                           D1.c3 as c3,
                                                                           D1.c4 as c4,
                                                                           D1.c5 as c5
                                                                      from 
                                                                           (select T960506.ROW_WID as c3,
                                                                                     T960506.PER_NAME_MONTH as c4,
                                                                                     T960506.CAL_MONTH_WID as c5,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c6,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c7
                                                                                from 
                                                                                     W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                                where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                           ) D1
                                                                 ) D1
                                                       ) D7
                                                  where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T963640.ORG_WID = T964463.ROW_WID and T14449.ROW_WID = T963640.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T963640.DT_WID = D9.c3 and T963640.BBG_ITEM_LOC_WID = T1009437.ROW_WID and D7.c1 = D9.c1 and D7.c2 = D9.c2 and T963640.ORG_DH_WID = T964333.ROW_WID and T964333.SCD1_WID = T964463.SCD1_WID and D7.c4 = '2013 / 09' ) 
                                             ) D1
                                   ) D1
                              group by D1.c2, D1.c3, D1.c4, D1.c5, D1.c6, D1.c7
                         ) D1
               ) D1
          where  ( D1.c8 = 1 ) 
     ) D2
order by c2, c5

]]
[2013-11-22T08:14:28.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-6eb0d535:1426930c60c:-8000-0000000000199a1c] [tid: 44eba940] [requestid: 487d0011] [sessionid: 487d0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<357321>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 8a90ab2d, physical request hash e1689020: [[

select D3.c3 as c1,
     D3.c4 as c2,
     D3.c5 as c3,
     D3.c1 as c4,
     D3.c2 as c5,
     D3.c6 as c6,
     D3.c7 as c7,
     D3.c8 as c8
from 
     (select D1.c1 as c1,
               D1.c2 as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8
          from 
               (select sum(D1.c1) over (partition by D1.c6, D1.c4)  as c1,
                         sum(D1.c2) over (partition by D1.c6, D1.c4)  as c2,
                         D1.c3 as c3,
                         D1.c4 as c4,
                         D1.c5 as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         D1.c8 as c8,
                         ROW_NUMBER() OVER (PARTITION BY D1.c4, D1.c6 ORDER BY D1.c4 ASC, D1.c6 ASC) as c9
                    from 
                         (select sum(case D1.c12 when 1 then D1.c9 else NULL end ) as c1,
                                   sum(case D1.c12 when 1 then D1.c13 else NULL end ) as c2,
                                   D1.c3 as c3,
                                   D1.c4 as c4,
                                   D1.c5 as c5,
                                   D1.c6 as c6,
                                   D1.c7 as c7,
                                   D1.c8 as c8
                              from 
                                   (select D1.c3 as c3,
                                             D1.c4 as c4,
                                             D1.c5 as c5,
                                             D1.c6 as c6,
                                             D1.c7 as c7,
                                             D1.c8 as c8,
                                             D1.c9 as c9,
                                             D1.c11 as c10,
                                             D1.c12 as c11,
                                             ROW_NUMBER() OVER (PARTITION BY D1.c6, D1.c4, D1.c11, D1.c12 ORDER BY D1.c6 DESC, D1.c4 DESC, D1.c11 DESC, D1.c12 DESC) as c12,
                                             D1.c10 as c13
                                        from 
                                             (select T14449.PROD_NUM as c3,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c4,
                                                       concat(concat(concat(concat(concat(concat('SBC', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID), '~'), T955085.LVL4ANC_PRODCAT_ID) as c5,
                                                       T14449.ROW_WID as c6,
                                                       concat(cast(cast(T955085.LVL4ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c7,
                                                       T955085.DATASOURCE_NUM_ID as c8,
                                                       LAST_VALUE(T963640.INV_SOH_COST_AMT_LCL) OVER (PARTITION BY T14449.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID ORDER BY NVL2(T963640.INV_SOH_COST_AMT_LCL, 1, 0) , T14449.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c9,
                                                       LAST_VALUE(T963640.INV_SOH_QTY) OVER (PARTITION BY T14449.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID ORDER BY NVL2(T963640.INV_SOH_QTY, 1, 0) , T14449.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c10,
                                                       T964463.ROW_WID as c11,
                                                       T1009437.ROW_WID as c12
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
                                                       (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                                                       W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                                                       W_RTL_INV_IT_LC_DY_FV T963640 /* Fact_W_RTL_INV_IT_LC_DY_F */ 
                                                  where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T963640.ORG_WID = T964463.ROW_WID and T960506.ROW_WID = T963640.DT_WID and T14449.ROW_WID = T963640.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T960506.MCAL_CAL_WID = 1.0 and T960506.PER_NAME_MONTH = '2013 / 09' and T963640.BBG_ITEM_LOC_WID = T1009437.ROW_WID and T963640.ORG_DH_WID = T964333.ROW_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                              group by D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8
                         ) D1
               ) D1
          where  ( D1.c9 = 1 ) 
     ) D3
order by c2, c6

]]
[2013-11-22T08:14:28.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-6eb0d535:1426930c60c:-8000-0000000000199a1c] [tid: 44eba940] [requestid: 487d0011] [sessionid: 487d0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<356945>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 8a90ab2d, physical request hash 19535c6c: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'MCAT' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
