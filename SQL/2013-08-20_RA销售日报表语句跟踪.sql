[2013-08-20T08:17:14.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-0] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] ############################################## [[
-------------------- SQL Request, logical request hash:
b5f92086
SET VARIABLE QUERY_SRC_CD='Report',SAW_DASHBOARD='/shared/BBG_RA/_portal/ååéå®åæ¯å©',SAW_DASHBOARD_PG='éå®æ¥æ¥è¡š',SAW_SRC_PATH='/shared/BBG_RA/Reports/R0214-éå®æ¥æ¥è¡š';SELECT s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32, s_33, s_34, s_35, s_36, s_37, s_38, s_39 FROM (
SELECT
   0 s_0,
   "Retail As-Was"."Gregorian Calendar"."Date" s_1,
   "Retail As-Was"."Item As Was"."Group" s_2,
   DESCRIPTOR_IDOF("Retail As-Was"."Item As Was"."Group") s_3,
   "Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count LD" s_4,
   "Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count Var LD" s_5,
   "Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT" s_6,
   "Retail As-Was"."Sales Budget"."Sales Budget Amt Var" s_7,
   "Retail As-Was"."Sales Budget"."Sales Budget Amt" s_8,
   "Retail As-Was"."Sales"."Net Profit LY" s_9,
   "Retail As-Was"."Sales"."Net Profit to Sales Amt LY" s_10,
   "Retail As-Was"."Sales"."Net Profit to Sales Amt" s_11,
   "Retail As-Was"."Sales"."Net Profit Var LY" s_12,
   "Retail As-Was"."Sales"."Net Profit" s_13,
   "Retail As-Was"."Sales"."Net Sales Amt LY" s_14,
   "Retail As-Was"."Sales"."Net Sales Amt MTD" s_15,
   "Retail As-Was"."Sales"."Net Sales Amt Var LY" s_16,
   "Retail As-Was"."Sales"."Net Sales Amt YTD" s_17,
   "Retail As-Was"."Sales"."Net Sales Amt" s_18,
   "Retail As-Was"."Sales"."Net Sales Amt"/"Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT" s_19,
   ("Retail As-Was"."Sales"."Net Sales Amt"/"Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT"-AGO("Retail As-Was"."Sales"."Net Sales Amt","Gregorian Calendar"."Time Level"."Day",1)/"Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count LD")/("Retail As-Was"."Sales"."Net Sales Amt"/"Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT")*100 s_20,
   AGO("Retail As-Was"."Sales"."Net Sales Amt","Gregorian Calendar"."Time Level"."Day",1)/"Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count LD" s_21,
   REPORT_AGGREGATE("Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count Var LD" BY ) s_22,
   REPORT_AGGREGATE("Retail As-Was"."Sales Budget"."Sales Budget Amt Var" BY ) s_23,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Profit to Sales Amt LY" BY ) s_24,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Profit to Sales Amt" BY ) s_25,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Profit Var LY" BY ) s_26,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Sales Amt LY" BY ) s_27,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Sales Amt MTD" BY ) s_28,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Sales Amt Var LY" BY ) s_29,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Sales Amt YTD" BY ) s_30,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Sales Amt" BY ) s_31,
   REPORT_AGGREGATE("Retail As-Was"."Sales"."Net Sales Amt"/"Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT" BY ) s_32,
   REPORT_AGGREGATE(("Retail As-Was"."Sales"."Net Sales Amt"/"Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT"-AGO("Retail As-Was"."Sales"."Net Sales Amt","Gregorian Calendar"."Time Level"."Day",1)/"Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count LD")/("Retail As-Was"."Sales"."Net Sales Amt"/"Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT")*100 BY ) s_33,
   REPORT_AGGREGATE(AGO("Retail As-Was"."Sales"."Net Sales Amt","Gregorian Calendar"."Time Level"."Day",1)/"Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count LD" BY ) s_34,
   REPORT_SUM("Retail As-Was"."Fact_Retail Customer Count"."BBG Customer Count LD" BY ) s_35,
   REPORT_SUM("Retail As-Was"."Fact_Retail Customer Count"."BBG_CUSTOMER_COUNT" BY ) s_36,
   REPORT_SUM("Retail As-Was"."Sales Budget"."Sales Budget Amt" BY ) s_37,
   REPORT_SUM("Retail As-Was"."Sales"."Net Profit LY" BY ) s_38,
   REPORT_SUM("Retail As-Was"."Sales"."Net Profit" BY ) s_39
FROM "Retail As-Was"
WHERE
("Gregorian Calendar"."Date" = date '2013-08-19')
) djm ORDER BY 1, 2 ASC NULLS LAST, 3 ASC NULLS LAST
FETCH FIRST 10000000 ROWS ONLY


]]
[2013-08-20T08:17:14.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-23] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- General Query Info: [[
Repository: Star, Subject Area: RA, Presentation: Retail As-Was

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<305351>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash 3f35f3ea: [[

select D1.c2 as c1,
     D1.c3 as c2,
     D1.c1 as c3,
     D1.c4 as c4,
     D1.c5 as c5,
     D1.c6 as c6,
     D1.c7 as c7,
     D1.c8 as c8
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
               (select sum(T1027898.SLS_BUDGET_AMT_LCL) as c1,
                          TRUNC(T960506.MCAL_DAY_DT) as c2,
                         concat(concat('GRP', '~'), T956667.LVL7ANC_PRODCAT_ID) as c3,
                         cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c4,
                         cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c5,
                         T960506.ROW_WID as c6,
                         concat(cast(cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c7,
                         T956667.DATASOURCE_NUM_ID as c8,
                         ROW_NUMBER() OVER (PARTITION BY T960506.ROW_WID, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY T960506.ROW_WID ASC, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c9
                    from 
                         W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
                         W_PROD_CAT_DH T956667 /* Dim_W_PROD_CAT_DH_Department_As_Was */ ,
                         BBG_RA_SLSFC_DP_LC_DY_F T1027898 /* Fact_BBG_RA_SLSFC_DP_LC_DY_F */ 
                    where  ( T956667.ROW_WID = T1027898.PROD_DH_WID and T956667.LEVEL_NAME = 'DEPT' and T960506.ROW_WID = T1027898.DT_WID and T960506.MCAL_CAL_WID = 1.0 and  TRUNC(T960506.MCAL_DAY_DT) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') and '2010' < T960506.CAL_YEAR ) 
                    group by T956667.DATASOURCE_NUM_ID, T960506.ROW_WID, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(T960506.MCAL_DAY_DT), concat(cast(cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T956667.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c9 = 1 ) 
     ) D1
order by c6, c4

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<305450>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash e16b58f5: [[

select D2.c3 as c1,
     D2.c4 as c2,
     D2.c1 as c3,
     D2.c2 as c4,
     D2.c5 as c5,
     D2.c6 as c6,
     D2.c7 as c7,
     D2.c8 as c8,
     D2.c9 as c9
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
               (select sum(nvl(T956124.SLS_AMT_LCL , 0) - nvl(T956124.RET_AMT_LCL , 0)) as c1,
                         sum(nvl(T956124.SLS_TAX_AMT_LCL , 0) - nvl(T956124.RET_TAX_AMT_LCL , 0)) as c2,
                          TRUNC(D9.c3) as c3,
                         concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID) as c4,
                         cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c5,
                         cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c6,
                         D9.c2 as c7,
                         concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                         T955052.DATASOURCE_NUM_ID as c9,
                         ROW_NUMBER() OVER (PARTITION BY D9.c2, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY D9.c2 ASC, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c10
                    from 
                         W_PROD_CAT_DH T955052 /* Dim_W_PROD_CAT_DH_Subclass_As_Was */ ,
                         W_RTL_SLS_SC_DY_A T956124 /* Fact_W_RTL_SLS_SC_DY_A */ ,
                         (select distinct D1.c1 + 1 as c1,
                                   D1.c2 as c2
                              from 
                                   (select DENSE_RANK() OVER ( ORDER BY T960506.ROW_WID ASC NULLS LAST ) as c1,
                                             T960506.ROW_WID as c2
                                        from 
                                             W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                        where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                   ) D1
                         ) D11,
                         (select DENSE_RANK() OVER ( ORDER BY T960506.ROW_WID ASC NULLS LAST ) as c1,
                                   T960506.ROW_WID as c2,
                                   T960506.MCAL_DAY_DT as c3
                              from 
                                   W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                              where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                         ) D9
                    where  ( T955052.ROW_WID = T956124.PROD_DH_WID and T956124.DT_WID = D11.c2 and T955052.LEVEL_NAME = 'SBC' and D9.c1 = D11.c1 and  TRUNC(D9.c3) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') ) 
                    group by T955052.DATASOURCE_NUM_ID, D9.c2, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(D9.c3), concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c10 = 1 ) 
     ) D2
order by c7, c5

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<305768>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash fe62738c: [[

select D3.c3 as c1,
     D3.c4 as c2,
     D3.c1 as c3,
     D3.c2 as c4,
     D3.c5 as c5,
     D3.c6 as c6,
     D3.c7 as c7,
     D3.c8 as c8,
     D3.c9 as c9
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
               (select sum(nvl(T956124.SLS_AMT_LCL , 0) - nvl(T956124.RET_AMT_LCL , 0)) as c1,
                         sum(nvl(T956124.SLS_TAX_AMT_LCL , 0) - nvl(T956124.RET_TAX_AMT_LCL , 0)) as c2,
                          TRUNC(D12.c4) as c3,
                         concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID) as c4,
                         cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c5,
                         cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c6,
                         D12.c3 as c7,
                         concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                         T955052.DATASOURCE_NUM_ID as c9,
                         ROW_NUMBER() OVER (PARTITION BY D12.c3, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY D12.c3 ASC, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c10
                    from 
                         W_PROD_CAT_DH T955052 /* Dim_W_PROD_CAT_DH_Subclass_As_Was */ ,
                         W_RTL_SLS_SC_DY_A T956124 /* Fact_W_RTL_SLS_SC_DY_A */ ,
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
                                                       T960506.PER_NAME_YEAR as c4,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR ORDER BY T960506.PER_NAME_YEAR DESC) as c5,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR, T960506.ROW_WID ORDER BY T960506.PER_NAME_YEAR DESC, T960506.ROW_WID DESC) as c6
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D14,
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
                                                       T960506.MCAL_DAY_DT as c4,
                                                       T960506.PER_NAME_YEAR as c5,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR ORDER BY T960506.PER_NAME_YEAR DESC) as c6,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR, T960506.ROW_WID ORDER BY T960506.PER_NAME_YEAR DESC, T960506.ROW_WID DESC) as c7
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D12
                    where  ( T955052.ROW_WID = T956124.PROD_DH_WID and T955052.LEVEL_NAME = 'SBC' and T956124.DT_WID = D14.c3 and D12.c1 = D14.c1 and  TRUNC(D12.c4) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') and D12.c2 >= D14.c2 ) 
                    group by T955052.DATASOURCE_NUM_ID, D12.c3, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(D12.c4), concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c10 = 1 ) 
     ) D3
order by c7, c5

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<306143>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash d60a5c05: [[

select D4.c3 as c1,
     D4.c4 as c2,
     D4.c1 as c3,
     D4.c2 as c4,
     D4.c5 as c5,
     D4.c6 as c6,
     D4.c7 as c7,
     D4.c8 as c8,
     D4.c9 as c9
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
               (select sum(nvl(T956124.SLS_AMT_LCL , 0) - nvl(T956124.RET_AMT_LCL , 0)) as c1,
                         sum(nvl(T956124.SLS_TAX_AMT_LCL , 0) - nvl(T956124.RET_TAX_AMT_LCL , 0)) as c2,
                          TRUNC(D15.c4) as c3,
                         concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID) as c4,
                         cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c5,
                         cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c6,
                         D15.c3 as c7,
                         concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c8,
                         T955052.DATASOURCE_NUM_ID as c9,
                         ROW_NUMBER() OVER (PARTITION BY D15.c3, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY D15.c3 ASC, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c10
                    from 
                         W_PROD_CAT_DH T955052 /* Dim_W_PROD_CAT_DH_Subclass_As_Was */ ,
                         W_RTL_SLS_SC_DY_A T956124 /* Fact_W_RTL_SLS_SC_DY_A */ ,
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
                         ) D17,
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
                                                       T960506.MCAL_DAY_DT as c4,
                                                       T960506.CAL_MONTH_WID as c5,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c6,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c7
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D15
                    where  ( T955052.ROW_WID = T956124.PROD_DH_WID and T955052.LEVEL_NAME = 'SBC' and T956124.DT_WID = D17.c3 and D15.c1 = D17.c1 and  TRUNC(D15.c4) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') and D15.c2 >= D17.c2 ) 
                    group by T955052.DATASOURCE_NUM_ID, D15.c3, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(D15.c4), concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c10 = 1 ) 
     ) D4
order by c7, c5

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<306563>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash 63bf58a8: [[

select D5.c4 as c1,
     D5.c5 as c2,
     D5.c1 as c3,
     D5.c2 as c4,
     D5.c3 as c5,
     D5.c6 as c6,
     D5.c7 as c7,
     D5.c8 as c8,
     D5.c9 as c9,
     D5.c10 as c10
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
               (select sum(nvl(T956124.SLS_PROFIT_AMT_LCL , 0) - nvl(T956124.RET_PROFIT_AMT_LCL , 0)) as c1,
                         sum(nvl(T956124.SLS_AMT_LCL , 0) - nvl(T956124.RET_AMT_LCL , 0)) as c2,
                         sum(nvl(T956124.SLS_TAX_AMT_LCL , 0) - nvl(T956124.RET_TAX_AMT_LCL , 0)) as c3,
                          TRUNC(D18.c4) as c4,
                         concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID) as c5,
                         cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c6,
                         cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c7,
                         D18.c3 as c8,
                         concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c9,
                         T955052.DATASOURCE_NUM_ID as c10,
                         ROW_NUMBER() OVER (PARTITION BY D18.c3, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY D18.c3 ASC, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c11
                    from 
                         W_PROD_CAT_DH T955052 /* Dim_W_PROD_CAT_DH_Subclass_As_Was */ ,
                         W_RTL_SLS_SC_DY_A T956124 /* Fact_W_RTL_SLS_SC_DY_A */ ,
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
                                                                 T960506.PER_NAME_YEAR as c4,
                                                                 ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR ORDER BY T960506.PER_NAME_YEAR DESC) as c5,
                                                                 ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR, T960506.ROW_WID ORDER BY T960506.PER_NAME_YEAR DESC, T960506.ROW_WID DESC) as c6
                                                            from 
                                                                 W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                            where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                       ) D1
                                             ) D1
                                   ) D1
                         ) D20,
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
                                                       T960506.MCAL_DAY_DT as c4,
                                                       T960506.PER_NAME_YEAR as c5,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR ORDER BY T960506.PER_NAME_YEAR DESC) as c6,
                                                       ROW_NUMBER() OVER (PARTITION BY T960506.PER_NAME_YEAR, T960506.ROW_WID ORDER BY T960506.PER_NAME_YEAR DESC, T960506.ROW_WID DESC) as c7
                                                  from 
                                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                  where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                             ) D1
                                   ) D1
                         ) D18
                    where  ( T955052.ROW_WID = T956124.PROD_DH_WID and T955052.LEVEL_NAME = 'SBC' and T956124.DT_WID = D20.c3 and D18.c1 = D20.c1 and D18.c2 = D20.c2 and  TRUNC(D18.c4) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') ) 
                    group by T955052.DATASOURCE_NUM_ID, D18.c3, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(D18.c4), concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c11 = 1 ) 
     ) D5
order by c8, c6

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<307042>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash 77f654f8: [[

select D6.c2 as c1,
     D6.c3 as c2,
     D6.c1 as c3,
     D6.c4 as c4,
     D6.c5 as c5,
     D6.c6 as c6,
     D6.c7 as c7,
     D6.c8 as c8
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
               (select sum(T1030058.BBG_CUSTOMER_COUNT) as c1,
                          TRUNC(D21.c3) as c2,
                         concat(concat('GRP', '~'), T956667.LVL7ANC_PRODCAT_ID) as c3,
                         cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c4,
                         cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c5,
                         D21.c2 as c6,
                         concat(cast(cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c7,
                         T956667.DATASOURCE_NUM_ID as c8,
                         ROW_NUMBER() OVER (PARTITION BY D21.c2, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY D21.c2 ASC, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c9
                    from 
                         W_PROD_CAT_DH T956667 /* Dim_W_PROD_CAT_DH_Department_As_Was */ ,
                         BBG_RA_CUST_DP_LC_DY_A T1030058 /* Fact_BBG_RA_CUST_DP_LC_DY_A */ ,
                         (select distinct D1.c1 + 1 as c1,
                                   D1.c2 as c2
                              from 
                                   (select DENSE_RANK() OVER ( ORDER BY T960506.ROW_WID ASC NULLS LAST ) as c1,
                                             T960506.ROW_WID as c2
                                        from 
                                             W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                        where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                   ) D1
                         ) D23,
                         (select DENSE_RANK() OVER ( ORDER BY T960506.ROW_WID ASC NULLS LAST ) as c1,
                                   T960506.ROW_WID as c2,
                                   T960506.MCAL_DAY_DT as c3
                              from 
                                   W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                              where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                         ) D21
                    where  ( T956667.ROW_WID = T1030058.PROD_DH_WID and T1030058.DT_WID = D23.c2 and T956667.LEVEL_NAME = 'DEPT' and D21.c1 = D23.c1 and  TRUNC(D21.c3) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') ) 
                    group by T956667.DATASOURCE_NUM_ID, D21.c2, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(D21.c3), concat(cast(cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T956667.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c9 = 1 ) 
     ) D6
order by c6, c4

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<307517>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash 12dc9838: [[

select D7.c2 as c1,
     D7.c3 as c2,
     D7.c1 as c3,
     D7.c4 as c4,
     D7.c5 as c5,
     D7.c6 as c6,
     D7.c7 as c7,
     D7.c8 as c8
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
               (select sum(T1030058.BBG_CUSTOMER_COUNT) as c1,
                          TRUNC(T960506.MCAL_DAY_DT) as c2,
                         concat(concat('GRP', '~'), T956667.LVL7ANC_PRODCAT_ID) as c3,
                         cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c4,
                         cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c5,
                         T960506.ROW_WID as c6,
                         concat(cast(cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c7,
                         T956667.DATASOURCE_NUM_ID as c8,
                         ROW_NUMBER() OVER (PARTITION BY T960506.ROW_WID, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) ORDER BY T960506.ROW_WID ASC, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ) ASC) as c9
                    from 
                         W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
                         W_PROD_CAT_DH T956667 /* Dim_W_PROD_CAT_DH_Department_As_Was */ ,
                         BBG_RA_CUST_DP_LC_DY_A T1030058 /* Fact_BBG_RA_CUST_DP_LC_DY_A */ 
                    where  ( T956667.ROW_WID = T1030058.PROD_DH_WID and T956667.LEVEL_NAME = 'DEPT' and T960506.ROW_WID = T1030058.DT_WID and T960506.MCAL_CAL_WID = 1.0 and  TRUNC(T960506.MCAL_DAY_DT) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') and '2010' < T960506.CAL_YEAR ) 
                    group by T956667.DATASOURCE_NUM_ID, T960506.ROW_WID, cast(T956667.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(T960506.MCAL_DAY_DT), concat(cast(cast(T956667.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T956667.LVL7ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c9 = 1 ) 
     ) D7
order by c6, c4

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<307992>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash ff9eae0a: [[

select D8.c6 as c1,
     D8.c7 as c2,
     D8.c5 as c3,
     D8.c4 as c4,
     D8.c3 as c5,
     D8.c2 as c6,
     D8.c1 as c7,
     D8.c8 as c8,
     D8.c9 as c9,
     D8.c10 as c10,
     D8.c11 as c11,
     D8.c12 as c12
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
               D1.c11 as c11,
               D1.c12 as c12
          from 
               (select sum(D1.c1) over (partition by D1.c8, D1.c9, D1.c10)  as c1,
                         sum(D1.c2) over (partition by D1.c8, D1.c9, D1.c10)  as c2,
                         sum(D1.c3) over (partition by D1.c8, D1.c9, D1.c10)  as c3,
                         sum(D1.c1) over (partition by D1.c8, D1.c10)  as c4,
                         sum(D1.c2) over (partition by D1.c8, D1.c10)  as c5,
                         D1.c6 as c6,
                         D1.c7 as c7,
                         D1.c8 as c8,
                         D1.c9 as c9,
                         D1.c10 as c10,
                         D1.c11 as c11,
                         D1.c12 as c12,
                         ROW_NUMBER() OVER (PARTITION BY D1.c8, D1.c10 ORDER BY D1.c8 ASC, D1.c10 ASC) as c13
                    from 
                         (select sum(nvl(T956124.SLS_TAX_AMT_LCL , 0) - nvl(T956124.RET_TAX_AMT_LCL , 0)) as c1,
                                   sum(nvl(T956124.SLS_AMT_LCL , 0) - nvl(T956124.RET_AMT_LCL , 0)) as c2,
                                   sum(nvl(T956124.SLS_PROFIT_AMT_LCL , 0) - nvl(T956124.RET_PROFIT_AMT_LCL , 0)) as c3,
                                    TRUNC(T960506.MCAL_DAY_DT) as c6,
                                   concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID) as c7,
                                   cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c8,
                                   cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as c9,
                                   T960506.ROW_WID as c10,
                                   concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c11,
                                   T955052.DATASOURCE_NUM_ID as c12
                              from 
                                   W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
                                   W_PROD_CAT_DH T955052 /* Dim_W_PROD_CAT_DH_Subclass_As_Was */ ,
                                   W_RTL_SLS_SC_DY_A T956124 /* Fact_W_RTL_SLS_SC_DY_A */ 
                              where  ( T955052.ROW_WID = T956124.PROD_DH_WID and T955052.LEVEL_NAME = 'SBC' and T956124.DT_WID = T960506.ROW_WID and T960506.MCAL_CAL_WID = 1.0 and  TRUNC(T960506.MCAL_DAY_DT) = TO_DATE('2013-08-19' , 'YYYY-MM-DD') and '2010' < T960506.CAL_YEAR ) 
                              group by T955052.DATASOURCE_NUM_ID, T960506.ROW_WID, cast(T955052.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ),  TRUNC(T960506.MCAL_DAY_DT), concat(cast(cast(T955052.LVL7ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat('GRP', '~'), T955052.LVL7ANC_PRODCAT_ID)
                         ) D1
               ) D1
          where  ( D1.c13 = 1 ) 
     ) D8
order by c10, c8

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<304795>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash b5f92086, physical request hash 19535c6c: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'MCAT' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-34] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Query Status: Successful Completion [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 33, bytes 39864 retrieved from database query id: <<305351>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<305351>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 30, bytes 36480 retrieved from database query id: <<305450>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<305450>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 31, bytes 37696 retrieved from database query id: <<305768>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<305768>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 31, bytes 37696 retrieved from database query id: <<306143>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<306143>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 0, bytes 0 retrieved from database query id: <<306563>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<306563>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 30, bytes 36240 retrieved from database query id: <<307042>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<307042>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 30, bytes 36240 retrieved from database query id: <<307517>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<307517>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 30, bytes 37440 retrieved from database query id: <<307992>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<307992>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-26] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows 36, bytes 74592 retrieved from database query id: <<304795>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-28] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical query response time 0 (seconds), id <<304795>> [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-29] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Physical Query Summary Stats: Number of physical queries 9, Cumulative time 0, DB-connect time 0 (seconds) [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-24] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Rows returned to Client 36 [[

]]
[2013-08-20T08:17:15.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-33] [] [ecid: 0000K2P5IH7ComWFLzYROA1I2EQd003bYP] [tid: 45e8e940] [requestid: 49320001] [sessionid: 49320000] [username: RAADMIN] -------------------- Logical Query Summary Stats: Elapsed time 1, Response time 1, Compilation time 1 (seconds) [[

]]
