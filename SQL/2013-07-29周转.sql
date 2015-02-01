select D1.c3 as c1,
     D1.c4 as c2,
     D1.c5 as c3,
     D1.c6 as c4,
     D1.c7 as c5,
     D1.c8 as c6,
     D1.c9 as c7,
     D1.c10 as c8,
     D1.c1 as c9,
     D1.c2 as c10,
     D1.c11 as c11,
     D1.c12 as c12,
     D1.c13 as c13,
     D1.c14 as c14,
     D1.c15 as c15,
     D1.c16 as c16,
     D1.c17 as c17
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
               D1.c12 as c12,
               D1.c13 as c13,
               D1.c14 as c14,
               D1.c15 as c15,
               D1.c16 as c16,
               D1.c17 as c17
          from 
               (select sum(T1013925.SUPP_SALES_COST) as c1,
                         sum(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1013925.SUPP_SALES_COST end ) as c2,
                         case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  as c3,
                         D5.c3 as c4,
                         concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                         concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) as c6,
                         concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) as c7,
                         concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c8,
                         concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') as c9,
                         case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  as c10,
                         D5.c2 as c11,
                         concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c12,
                         T955085.DATASOURCE_NUM_ID as c13,
                         concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c14,
                         concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c15,
                         T964333.DATASOURCE_NUM_ID as c16,
                         cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as c17,
                         ROW_NUMBER() OVER (PARTITION BY T964333.DATASOURCE_NUM_ID, D5.c2, case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end , case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end , cast(T964333.ORG_HIER11_NUM as  INTEGER  ), concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION'), concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME), concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) ORDER BY T964333.DATASOURCE_NUM_ID ASC, D5.c2 ASC, case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  ASC, case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  ASC, cast(T964333.ORG_HIER11_NUM as  INTEGER  ) ASC, concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') ASC, concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) ASC, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ASC, concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) ASC) as c18
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
                         W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                         (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                         W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                         BBG_RA_SLS_IT_LC_DY_A T1013925 /* Fact_BBG_RA_SLS_IT_LC_DY_A */ ,
                         (select distinct D1.c1 + 1 as c1,
                                   D1.c2 as c2
                              from 
                                   (select min(D1.c1) over (partition by D1.c3)  as c1,
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
                                   ) D1
                         ) D7,
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
                         ) D5
                    where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1013925.ORG_WID and T954755.ROW_WID = T1013925.SUPPLIER_WID and T14449.ROW_WID = T1013925.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T1009437.ROW_WID = T1013925.BBG_ITEM_LOC_WID and T1013925.DT_WID = D7.c2 and T964333.ROW_WID = T1013925.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and D5.c1 = D7.c1 and (case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  in ('代销', '经销')) ) 
                    group by T955085.DATASOURCE_NUM_ID, T964333.DATASOURCE_NUM_ID, D5.c2, D5.c3, case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end , case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end , cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T964333.ORG_HIER11_NUM as  INTEGER  ), concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION'), concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME), concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID), concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c18 = 1 ) 
     ) D1
order by c1, c7, c16, c3, c8, c11, c4, c5, c17

]]
[2013-07-28T13:20:00.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-2b056751:1401be12197:-8000-000000000006b347] [tid: 45553940] [requestid: 4bdb0061] [sessionid: 4bdb0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1055420>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 45d821fb, physical request hash 44a520ec: [[

select D2.c4 as c1,
     D2.c5 as c2,
     D2.c6 as c3,
     D2.c7 as c4,
     D2.c8 as c5,
     D2.c9 as c6,
     D2.c10 as c7,
     D2.c11 as c8,
     D2.c1 as c9,
     D2.c2 as c10,
     D2.c3 as c11,
     D2.c12 as c12,
     D2.c13 as c13,
     D2.c14 as c14,
     D2.c15 as c15,
     D2.c16 as c16,
     D2.c17 as c17,
     D2.c18 as c18
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
               D1.c12 as c12,
               D1.c13 as c13,
               D1.c14 as c14,
               D1.c15 as c15,
               D1.c16 as c16,
               D1.c17 as c17,
               D1.c18 as c18
          from 
               (select sum(D1.c1) over (partition by D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7)  as c1,
                         sum(D1.c2) over (partition by D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7)  as c2,
                         sum(D1.c3) over (partition by D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7)  as c3,
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
                         D1.c17 as c17,
                         D1.c18 as c18,
                         ROW_NUMBER() OVER (PARTITION BY D1.c4, D1.c6, D1.c7, D1.c8, D1.c10, D1.c11, D1.c12, D1.c17, D1.c18 ORDER BY D1.c4 ASC, D1.c6 ASC, D1.c7 ASC, D1.c8 ASC, D1.c10 ASC, D1.c11 ASC, D1.c12 ASC, D1.c17 ASC, D1.c18 ASC) as c19
                    from 
                         (select sum(case D1.c25 when 1 then D1.c19 else NULL end ) as c1,
                                   sum(case D1.c25 when 1 then D1.c26 else NULL end ) as c2,
                                   sum(case D1.c25 when 1 then D1.c27 else NULL end ) as c3,
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
                                   D1.c17 as c17,
                                   D1.c18 as c18
                              from 
                                   (select D1.c4 as c4,
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
                                             D1.c17 as c17,
                                             D1.c18 as c18,
                                             D1.c19 as c19,
                                             D1.c22 as c20,
                                             D1.c23 as c21,
                                             D1.c24 as c22,
                                             D1.c25 as c23,
                                             D1.c26 as c24,
                                             ROW_NUMBER() OVER (PARTITION BY D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7, D1.c22, D1.c23, D1.c24, D1.c25, D1.c26 ORDER BY D1.c12 DESC, D1.c10 DESC, D1.c17 DESC, D1.c18 DESC, D1.c8 DESC, D1.c4 DESC, D1.c11 DESC, D1.c6 DESC, D1.c7 DESC, D1.c22 DESC, D1.c23 DESC, D1.c24 DESC, D1.c25 DESC, D1.c26 DESC) as c25,
                                             D1.c20 as c26,
                                             D1.c21 as c27
                                        from 
                                             (select case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  as c4,
                                                       D8.c5 as c5,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c6,
                                                       concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) as c7,
                                                       concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) as c8,
                                                       concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c9,
                                                       concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') as c10,
                                                       case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  as c11,
                                                       D8.c4 as c12,
                                                       concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c13,
                                                       T955085.DATASOURCE_NUM_ID as c14,
                                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c15,
                                                       concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c16,
                                                       T964333.DATASOURCE_NUM_ID as c17,
                                                       cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as c18,
                                                       LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D8.c4 ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D8.c4 NULLS FIRST, D8.c3 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c19,
                                                       LAST_VALUE(case  when cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end ) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D8.c4 ORDER BY NVL2(case  when cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end , 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D8.c4 NULLS FIRST, D8.c3 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c20,
                                                       LAST_VALUE(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end ) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D8.c4 ORDER BY NVL2(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end , 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D8.c4 NULLS FIRST, D8.c3 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c21,
                                                       T14449.ROW_WID as c22,
                                                       T954755.ROW_WID as c23,
                                                       T964463.ROW_WID as c24,
                                                       T1009437.ROW_WID as c25,
                                                       T1010474.ROW_WID as c26
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
                                                       ) D10,
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
                                                       ) D8
                                                  where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T1010716.DT_WID = D10.c3 and D8.c1 = D10.c1 and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and D8.c2 = D10.c2 and (case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  in ('代销', '经销')) ) 
                                             ) D1
                                   ) D1
                              group by D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10, D1.c11, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16, D1.c17, D1.c18
                         ) D1
               ) D1
          where  ( D1.c19 = 1 ) 
     ) D2
order by c1, c7, c17, c3, c8, c12, c4, c5, c18

]]
[2013-07-28T13:20:00.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-2b056751:1401be12197:-8000-000000000006b347] [tid: 45553940] [requestid: 4bdb0061] [sessionid: 4bdb0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1056306>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 45d821fb, physical request hash e98c1407: [[

select D3.c4 as c1,
     D3.c5 as c2,
     D3.c6 as c3,
     D3.c7 as c4,
     D3.c8 as c5,
     D3.c9 as c6,
     D3.c10 as c7,
     D3.c11 as c8,
     D3.c1 as c9,
     D3.c2 as c10,
     D3.c3 as c11,
     D3.c12 as c12,
     D3.c13 as c13,
     D3.c14 as c14,
     D3.c15 as c15,
     D3.c16 as c16,
     D3.c17 as c17,
     D3.c18 as c18
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
               D1.c12 as c12,
               D1.c13 as c13,
               D1.c14 as c14,
               D1.c15 as c15,
               D1.c16 as c16,
               D1.c17 as c17,
               D1.c18 as c18
          from 
               (select sum(D1.c1) over (partition by D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7)  as c1,
                         sum(D1.c2) over (partition by D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7)  as c2,
                         sum(D1.c3) over (partition by D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7)  as c3,
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
                         D1.c17 as c17,
                         D1.c18 as c18,
                         ROW_NUMBER() OVER (PARTITION BY D1.c4, D1.c6, D1.c7, D1.c8, D1.c10, D1.c11, D1.c12, D1.c17, D1.c18 ORDER BY D1.c4 ASC, D1.c6 ASC, D1.c7 ASC, D1.c8 ASC, D1.c10 ASC, D1.c11 ASC, D1.c12 ASC, D1.c17 ASC, D1.c18 ASC) as c19
                    from 
                         (select sum(case D1.c25 when 1 then D1.c19 else NULL end ) as c1,
                                   sum(case D1.c25 when 1 then D1.c26 else NULL end ) as c2,
                                   sum(case D1.c25 when 1 then D1.c27 else NULL end ) as c3,
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
                                   D1.c17 as c17,
                                   D1.c18 as c18
                              from 
                                   (select D1.c4 as c4,
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
                                             D1.c17 as c17,
                                             D1.c18 as c18,
                                             D1.c19 as c19,
                                             D1.c22 as c20,
                                             D1.c23 as c21,
                                             D1.c24 as c22,
                                             D1.c25 as c23,
                                             D1.c26 as c24,
                                             ROW_NUMBER() OVER (PARTITION BY D1.c12, D1.c10, D1.c17, D1.c18, D1.c8, D1.c4, D1.c11, D1.c6, D1.c7, D1.c22, D1.c23, D1.c24, D1.c25, D1.c26 ORDER BY D1.c12 DESC, D1.c10 DESC, D1.c17 DESC, D1.c18 DESC, D1.c8 DESC, D1.c4 DESC, D1.c11 DESC, D1.c6 DESC, D1.c7 DESC, D1.c22 DESC, D1.c23 DESC, D1.c24 DESC, D1.c25 DESC, D1.c26 DESC) as c25,
                                             D1.c20 as c26,
                                             D1.c21 as c27
                                        from 
                                             (select case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  as c4,
                                                       T960506.PER_NAME_MONTH as c5,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c6,
                                                       concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) as c7,
                                                       concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) as c8,
                                                       concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c9,
                                                       concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') as c10,
                                                       case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  as c11,
                                                       T960506.CAL_MONTH_WID as c12,
                                                       concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c13,
                                                       T955085.DATASOURCE_NUM_ID as c14,
                                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c15,
                                                       concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c16,
                                                       T964333.DATASOURCE_NUM_ID as c17,
                                                       cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as c18,
                                                       LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, T960506.CAL_MONTH_WID ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.CAL_MONTH_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c19,
                                                       LAST_VALUE(case  when cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end ) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, T960506.CAL_MONTH_WID ORDER BY NVL2(case  when cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end , 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.CAL_MONTH_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c20,
                                                       LAST_VALUE(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end ) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, T960506.CAL_MONTH_WID ORDER BY NVL2(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end , 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.CAL_MONTH_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c21,
                                                       T14449.ROW_WID as c22,
                                                       T954755.ROW_WID as c23,
                                                       T964463.ROW_WID as c24,
                                                       T1009437.ROW_WID as c25,
                                                       T1010474.ROW_WID as c26
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
                                                  where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T960506.ROW_WID = T1010716.DT_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T960506.MCAL_CAL_WID = 1.0 and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR and (case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  in ('代销', '经销')) ) 
                                             ) D1
                                   ) D1
                              group by D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10, D1.c11, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16, D1.c17, D1.c18
                         ) D1
               ) D1
          where  ( D1.c19 = 1 ) 
     ) D3
order by c7, c3, c17, c1, c4, c5, c8, c12, c18

]]
[2013-07-28T13:20:00.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-2b056751:1401be12197:-8000-000000000006b347] [tid: 45553940] [requestid: 4bdb0061] [sessionid: 4bdb0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1057005>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 45d821fb, physical request hash 9b9124c0: [[

select D4.c3 as c1,
     D4.c4 as c2,
     D4.c5 as c3,
     D4.c6 as c4,
     D4.c7 as c5,
     D4.c8 as c6,
     D4.c9 as c7,
     D4.c10 as c8,
     D4.c1 as c9,
     D4.c2 as c10,
     D4.c11 as c11,
     D4.c12 as c12,
     D4.c13 as c13,
     D4.c14 as c14,
     D4.c15 as c15,
     D4.c16 as c16,
     D4.c17 as c17
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
               D1.c12 as c12,
               D1.c13 as c13,
               D1.c14 as c14,
               D1.c15 as c15,
               D1.c16 as c16,
               D1.c17 as c17
          from 
               (select sum(T1013925.SUPP_SALES_COST) as c1,
                         sum(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1013925.SUPP_SALES_COST end ) as c2,
                         case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  as c3,
                         T960506.PER_NAME_MONTH as c4,
                         concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c5,
                         concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) as c6,
                         concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) as c7,
                         concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c8,
                         concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') as c9,
                         case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  as c10,
                         T960506.CAL_MONTH_WID as c11,
                         concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c12,
                         T955085.DATASOURCE_NUM_ID as c13,
                         concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c14,
                         concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c15,
                         T964333.DATASOURCE_NUM_ID as c16,
                         cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as c17,
                         ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T964333.DATASOURCE_NUM_ID, case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end , case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end , cast(T964333.ORG_HIER11_NUM as  INTEGER  ), concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION'), concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME), concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) ORDER BY T960506.CAL_MONTH_WID ASC, T964333.DATASOURCE_NUM_ID ASC, case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  ASC, case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  ASC, cast(T964333.ORG_HIER11_NUM as  INTEGER  ) ASC, concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') ASC, concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) ASC, concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) ASC, concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) ASC) as c18
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
                         W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
                         (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
                         W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
                         BBG_RA_SLS_IT_LC_DY_A T1013925 /* Fact_BBG_RA_SLS_IT_LC_DY_A */ 
                    where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1013925.ORG_WID and T960506.ROW_WID = T1013925.DT_WID and T954755.ROW_WID = T1013925.SUPPLIER_WID and T14449.ROW_WID = T1013925.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T960506.MCAL_CAL_WID = 1.0 and T1009437.ROW_WID = T1013925.BBG_ITEM_LOC_WID and T964333.ROW_WID = T1013925.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR and (case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  in ('代销', '经销')) ) 
                    group by T955085.DATASOURCE_NUM_ID, T960506.CAL_MONTH_WID, T960506.PER_NAME_MONTH, T964333.DATASOURCE_NUM_ID, case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end , case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end , cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T964333.ORG_HIER11_NUM as  INTEGER  ), concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION'), concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME), concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID), concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID)
               ) D1
          where  ( D1.c18 = 1 ) 
     ) D4
order by c7, c3, c16, c1, c4, c5, c8, c11, c17

]]
[2013-07-28T13:20:00.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-2b056751:1401be12197:-8000-000000000006b347] [tid: 45553940] [requestid: 4bdb0061] [sessionid: 4bdb0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1057566>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 45d821fb, physical request hash 19535c6c: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'MCAT' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
[2013-07-28T13:20:00.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-2b056751:1401be12197:-8000-000000000006b347] [tid: 45553940] [requestid: 4bdb0061] [sessionid: 4bdb0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1057605>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 45d821fb, physical request hash 19535c6c: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'MCAT' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
[2013-07-28T13:20:00.000+00:00] [OracleBIServerComponent] [TRACE:2] [USER-18] [] [ecid: 117010e66f1dee37:-2b056751:1401be12197:-8000-000000000006b347] [tid: 45553940] [requestid: 4bdb0061] [sessionid: 4bdb0000] [username: RAADMIN] -------------------- Sending query to database named BBG_ANALIZE (id: <<1057644>>), connection pool named Oracle Data Warehouse Connection Pool, logical request hash 45d821fb, physical request hash b1711efa: [[

select T16687.DOMAIN_MEMBER_NAME as c1,
     T16687.DOMAIN_MEMBER_CODE as c2,
     T16687.DATASOURCE_NUM_ID as c3
from 
     W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */ 
where  ( T16687.DOMAIN_CODE = 'RTL_ORG' and T16687.DOMAIN_TYPE_CODE = 'S' and T16687.LANGUAGE_CODE = 'ZHS' and (T16687.DOMAIN_MEMBER_CODE = :PARAM1 and T16687.DATASOURCE_NUM_ID = :PARAM2 or T16687.DOMAIN_MEMBER_CODE = :PARAM3 and T16687.DATASOURCE_NUM_ID = :PARAM4 or T16687.DOMAIN_MEMBER_CODE = :PARAM5 and T16687.DATASOURCE_NUM_ID = :PARAM6 or T16687.DOMAIN_MEMBER_CODE = :PARAM7 and T16687.DATASOURCE_NUM_ID = :PARAM8 or T16687.DOMAIN_MEMBER_CODE = :PARAM9 and T16687.DATASOURCE_NUM_ID = :PARAM10 or T16687.DOMAIN_MEMBER_CODE = :PARAM11 and T16687.DATASOURCE_NUM_ID = :PARAM12 or T16687.DOMAIN_MEMBER_CODE = :PARAM13 and T16687.DATASOURCE_NUM_ID = :PARAM14 or T16687.DOMAIN_MEMBER_CODE = :PARAM15 and T16687.DATASOURCE_NUM_ID = :PARAM16 or T16687.DOMAIN_MEMBER_CODE = :PARAM17 and T16687.DATASOURCE_NUM_ID = :PARAM18 or T16687.DOMAIN_MEMBER_CODE = :PARAM19 and T16687.DATASOURCE_NUM_ID = :PARAM20 or T16687.DOMAIN_MEMBER_CODE = :PARAM21 and T16687.DATASOURCE_NUM_ID = :PARAM22 or T16687.DOMAIN_MEMBER_CODE = :PARAM23 and T16687.DATASOURCE_NUM_ID = :PARAM24 or T16687.DOMAIN_MEMBER_CODE = :PARAM25 and T16687.DATASOURCE_NUM_ID = :PARAM26 or T16687.DOMAIN_MEMBER_CODE = :PARAM27 and T16687.DATASOURCE_NUM_ID = :PARAM28 or T16687.DOMAIN_MEMBER_CODE = :PARAM29 and T16687.DATASOURCE_NUM_ID = :PARAM30 or T16687.DOMAIN_MEMBER_CODE = :PARAM31 and T16687.DATASOURCE_NUM_ID = :PARAM32 or T16687.DOMAIN_MEMBER_CODE = :PARAM33 and T16687.DATASOURCE_NUM_ID = :PARAM34 or T16687.DOMAIN_MEMBER_CODE = :PARAM35 and T16687.DATASOURCE_NUM_ID = :PARAM36 or T16687.DOMAIN_MEMBER_CODE = :PARAM37 and T16687.DATASOURCE_NUM_ID = :PARAM38 or T16687.DOMAIN_MEMBER_CODE = :PARAM39 and T16687.DATASOURCE_NUM_ID = :PARAM40 or T16687.DOMAIN_MEMBER_CODE = :PARAM41 and T16687.DATASOURCE_NUM_ID = :PARAM42 or T16687.DOMAIN_MEMBER_CODE = :PARAM43 and T16687.DATASOURCE_NUM_ID = :PARAM44 or T16687.DOMAIN_MEMBER_CODE = :PARAM45 and T16687.DATASOURCE_NUM_ID = :PARAM46 or T16687.DOMAIN_MEMBER_CODE = :PARAM47 and T16687.DATASOURCE_NUM_ID = :PARAM48 or T16687.DOMAIN_MEMBER_CODE = :PARAM49 and T16687.DATASOURCE_NUM_ID = :PARAM50 or T16687.DOMAIN_MEMBER_CODE = :PARAM51 and T16687.DATASOURCE_NUM_ID = :PARAM52 or T16687.DOMAIN_MEMBER_CODE = :PARAM53 and T16687.DATASOURCE_NUM_ID = :PARAM54 or T16687.DOMAIN_MEMBER_CODE = :PARAM55 and T16687.DATASOURCE_NUM_ID = :PARAM56 or T16687.DOMAIN_MEMBER_CODE = :PARAM57 and T16687.DATASOURCE_NUM_ID = :PARAM58 or T16687.DOMAIN_MEMBER_CODE = :PARAM59 and T16687.DATASOURCE_NUM_ID = :PARAM60 or T16687.DOMAIN_MEMBER_CODE = :PARAM61 and T16687.DATASOURCE_NUM_ID = :PARAM62 or T16687.DOMAIN_MEMBER_CODE = :PARAM63 and T16687.DATASOURCE_NUM_ID = :PARAM64 or T16687.DOMAIN_MEMBER_CODE = :PARAM65 and T16687.DATASOURCE_NUM_ID = :PARAM66 or T16687.DOMAIN_MEMBER_CODE = :PARAM67 and T16687.DATASOURCE_NUM_ID = :PARAM68 or T16687.DOMAIN_MEMBER_CODE = :PARAM69 and T16687.DATASOURCE_NUM_ID = :PARAM70 or T16687.DOMAIN_MEMBER_CODE = :PARAM71 and T16687.DATASOURCE_NUM_ID = :PARAM72 or T16687.DOMAIN_MEMBER_CODE = :PARAM73 and T16687.DATASOURCE_NUM_ID = :PARAM74 or T16687.DOMAIN_MEMBER_CODE = :PARAM75 and T16687.DATASOURCE_NUM_ID = :PARAM76 or T16687.DOMAIN_MEMBER_CODE = :PARAM77 and T16687.DATASOURCE_NUM_ID = :PARAM78 or T16687.DOMAIN_MEMBER_CODE = :PARAM79 and T16687.DATASOURCE_NUM_ID = :PARAM80 or T16687.DOMAIN_MEMBER_CODE = :PARAM81 and T16687.DATASOURCE_NUM_ID = :PARAM82 or T16687.DOMAIN_MEMBER_CODE = :PARAM83 and T16687.DATASOURCE_NUM_ID = :PARAM84 or T16687.DOMAIN_MEMBER_CODE = :PARAM85 and T16687.DATASOURCE_NUM_ID = :PARAM86 or T16687.DOMAIN_MEMBER_CODE = :PARAM87 and T16687.DATASOURCE_NUM_ID = :PARAM88 or T16687.DOMAIN_MEMBER_CODE = :PARAM89 and T16687.DATASOURCE_NUM_ID = :PARAM90 or T16687.DOMAIN_MEMBER_CODE = :PARAM91 and T16687.DATASOURCE_NUM_ID = :PARAM92 or T16687.DOMAIN_MEMBER_CODE = :PARAM93 and T16687.DATASOURCE_NUM_ID = :PARAM94 or T16687.DOMAIN_MEMBER_CODE = :PARAM95 and T16687.DATASOURCE_NUM_ID = :PARAM96 or T16687.DOMAIN_MEMBER_CODE = :PARAM97 and T16687.DATASOURCE_NUM_ID = :PARAM98 or T16687.DOMAIN_MEMBER_CODE = :PARAM99 and T16687.DATASOURCE_NUM_ID = :PARAM100) ) 
order by c2, c3

]]
