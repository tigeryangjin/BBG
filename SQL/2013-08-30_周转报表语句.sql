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
                                                       D7.c4 as c5,
                                                       concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c6,
                                                       concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) as c7,
                                                       concat(concat(concat(concat('CLS', '~'), T955085.LVL6ANC_PRODCAT_ID), '~'), T955085.LVL5ANC_PRODCAT_ID) as c8,
                                                       concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) as c9,
                                                       concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') as c10,
                                                       case  when T1009437.BUSINESS_MODE = 'JX' then '1' when T1009437.BUSINESS_MODE = 'DX' then '2' when T1009437.BUSINESS_MODE = 'LY' then '3' when T1009437.BUSINESS_MODE = 'ZL' then '4' when T1009437.BUSINESS_MODE = 'ZS' then '5' end  as c11,
                                                       D7.c3 as c12,
                                                       concat(cast(cast(T955085.LVL5ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c13,
                                                       T955085.DATASOURCE_NUM_ID as c14,
                                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c15,
                                                       concat(cast(cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-') as c16,
                                                       T964333.DATASOURCE_NUM_ID as c17,
                                                       cast(T964333.ORG_HIER11_NUM as  INTEGER  ) as c18,
                                                       LAST_VALUE(T1010716.SUPP_INV_COST) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D7.c3 ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D7.c3 NULLS FIRST, D7.c5 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c19,
                                                       LAST_VALUE(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end ) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D7.c3 ORDER BY NVL2(case  when not cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end , 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D7.c3 NULLS FIRST, D7.c5 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c20,
                                                       LAST_VALUE(case  when cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end ) OVER (PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T964463.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID, D7.c3 ORDER BY NVL2(case  when cast(T964463.ORG_NUM as  INTEGER  ) < 120001 then T1010716.SUPP_INV_COST end , 1, 0) , T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T964463.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, D7.c3 NULLS FIRST, D7.c5 NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c21,
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
                                                       ) D9,
                                                       (select distinct min(D1.c1) over (partition by D1.c3)  as c1,
                                                                 min(D1.c2) over (partition by D1.c3, D1.c5)  as c2,
                                                                 D1.c3 as c3,
                                                                 D1.c4 as c4,
                                                                 D1.c5 as c5
                                                            from 
                                                                 (select Case when case D1.c6 when 1 then D1.c5 else NULL end  is not null then Rank() OVER ( ORDER BY case D1.c6 when 1 then D1.c5 else NULL end  ASC NULLS LAST ) end as c1,
                                                                           Case when case D1.c7 when 1 then D1.c5 else NULL end  is not null then Rank() OVER ( PARTITION BY D1.c3 ORDER BY case D1.c7 when 1 then D1.c5 else NULL end  ASC NULLS LAST ) end as c2,
                                                                           D1.c3 as c3,
                                                                           D1.c4 as c4,
                                                                           D1.c5 as c5
                                                                      from 
                                                                           (select T960506.CAL_MONTH_WID as c3,
                                                                                     T960506.PER_NAME_MONTH as c4,
                                                                                     T960506.ROW_WID as c5,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID ORDER BY T960506.CAL_MONTH_WID DESC) as c6,
                                                                                     ROW_NUMBER() OVER (PARTITION BY T960506.CAL_MONTH_WID, T960506.ROW_WID ORDER BY T960506.CAL_MONTH_WID DESC, T960506.ROW_WID DESC) as c7
                                                                                from 
                                                                                     W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ 
                                                                                where  ( T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR ) 
                                                                           ) D1
                                                                 ) D1
                                                       ) D7
                                                  where  ( T1009437.ROW_WID = T1010716.BBG_ITEM_LOC_WID and T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T964463.ROW_WID = T1010716.ORG_WID and T954755.ROW_WID = T1010716.SUPPLIER_WID and T14449.ROW_WID = T1010716.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T1010474.ROW_WID = T1010716.BBG_ITEM_LOC_SUPP_WID and T1010716.DT_WID = D9.c3 and D7.c1 = D9.c1 and T964333.ROW_WID = T1010716.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and D7.c2 = D9.c2 and D7.c4 = '2013 / 07' and concat(concat(T964333.ORG_HIER11_NUM, '~'), 'REGION') = '10101~REGION' and concat(concat('DEPT', '~'), T955085.LVL6ANC_PRODCAT_ID) = 'DEPT~21' and (case  when T1009437.BUSINESS_MODE = 'JX' then '经销' when T1009437.BUSINESS_MODE = 'DX' then '代销' when T1009437.BUSINESS_MODE = 'LY' then '联营' when T1009437.BUSINESS_MODE = 'ZL' then '租赁' when T1009437.BUSINESS_MODE = 'ZS' then '招商' end  in ('代销', '经销')) ) 
                                             ) D1
                                   ) D1
                              group by D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10, D1.c11, D1.c12, D1.c13, D1.c14, D1.c15, D1.c16, D1.c17, D1.c18
                         ) D1
               ) D1
          where  ( D1.c19 = 1 ) 
     ) D2
order by c1, c7, c17, c3, c8, c12, c4, c5, c18
