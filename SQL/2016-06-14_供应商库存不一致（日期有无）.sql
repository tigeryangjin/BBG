/* f1dd7097 */
select D1.c1  as c1,
       D1.c2  as c2,
       D1.c3  as c3,
       D1.c4  as c4,
       D1.c5  as c5,
       D1.c6  as c6,
       D1.c7  as c7,
       D1.c8  as c8,
       D1.c9  as c9,
       D1.c10 as c10,
       D1.c11 as c11,
       D1.c12 as c12,
       D1.c13 as c13
  from (select D1.c1  as c1,
               D1.c2  as c2,
               D1.c3  as c3,
               D1.c4  as c4,
               D1.c5  as c5,
               D1.c6  as c6,
               D1.c7  as c7,
               D1.c8  as c8,
               D1.c9  as c9,
               D1.c10 as c10,
               D1.c11 as c11,
               D1.c12 as c12,
               D1.c13 as c13
          from (select 0 as c1,
                       D1.c3 as c2,
                       D1.c4 as c3,
                       D1.c5 as c4,
                       D1.c6 as c5,
                       D1.c7 as c6,
                       D1.c8 as c7,
                       D1.c6 as c8,
                       D1.c2 as c9,
                       D1.c1 as c10,
                       D1.c9 as c11,
                       D1.c10 as c12,
                       D1.c11 as c13,
                       ROW_NUMBER() OVER(PARTITION BY D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c10, D1.c11 ORDER BY D1.c3 ASC, D1.c4 ASC, D1.c5 ASC, D1.c6 ASC, D1.c7 ASC, D1.c8 ASC, D1.c9 ASC, D1.c10 ASC, D1.c11 ASC) as c14
                  from (select distinct T1013326.SUPP_INV_QTY as c1,
                                        T1013326.SUPP_INV_COST as c2,
                                        TRUNC(T960506.MCAL_DAY_DT) as c3,
                                        cast(T955085.LVL6ANC_PRODCAT_ID as
                                             INTEGER) as c4,
                                        T18745.PRODUCT_NAME as c5,
                                        T14449.PROD_NUM as c6,
                                        T954755.ORG_NAME as c7,
                                        T954755.SUPPLIER_NUM as c8,
                                        T14449.ROW_WID as c9,
                                        T954755.ROW_WID as c10,
                                        T960506.ROW_WID as c11
                          from W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
                               W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */,
                               (SELECT T.*
                                  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                                 WHERE T.SCD1_WID = A.SCD1_WID
                                   AND A.PRODUCT_ATTR12_NAME =
                                       A.PRODUCT_ATTR11_NAME) T14449,
                               (SELECT DATASOURCE_NUM_ID,
                                       INTEGRATION_ID,
                                       PRODUCT_DESCR,
                                       PRODUCT_NAME,
                                       LANGUAGE_CODE
                                  FROM W_PRODUCT_D_TL
                                 WHERE LANGUAGE_CODE = 'ZHS') T18745,
                               W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */,
                               BBG_RA_SUPP_INV_IT_DY_A T1013326 /* Fact_BBG_RA_SUPP_INV_IT_DY_A */
                         where (T954755.ROW_WID = T1013326.SUPPLIER_WID and
                               T14449.PROD_NUM = '102316196' and
                               T954755.SUPPLIER_NUM = '21001420' and
                               T960506.ROW_WID = T1013326.DT_WID and
                               T960506.MCAL_CAL_WID = 1.0 and
                               TRUNC(T960506.MCAL_DAY_DT) =
                               TO_DATE('2016-06-13', 'YYYY-MM-DD') and
                               T14449.DATASOURCE_NUM_ID =
                               T18745.DATASOURCE_NUM_ID and
                               T14449.INTEGRATION_ID = T18745.INTEGRATION_ID and
                               T14449.ROW_WID = T1013326.PROD_WID and
                               T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and
                               '2010' < T960506.CAL_YEAR)) D1) D1
         where (D1.c14 = 1)) D1
 order by c1, c3, c5, c8, c7, c6, c2;

/* 50b36866 ÓÐ´íÎó*/
select distinct 0     as c1,
                D1.c3 as c2,
                D1.c4 as c3,
                D1.c5 as c4,
                D1.c6 as c5,
                D1.c7 as c6,
                D1.c5 as c7,
                D1.c2 as c8,
                D1.c1 as c9,
                D1.c8 as c10,
                D1.c9 as c11
  from (select sum(D1.c1) over(partition by D1.c8, D1.c9) as c1,
               sum(D1.c2) over(partition by D1.c8, D1.c9) as c2,
               D1.c3 as c3,
               D1.c4 as c4,
               D1.c5 as c5,
               D1.c6 as c6,
               D1.c7 as c7,
               D1.c8 as c8,
               D1.c9 as c9
          from (select sum(case D1.c14
                             when 1 then
                              D1.c10
                             else
                              NULL
                           end) as c1,
                       sum(case D1.c14
                             when 1 then
                              D1.c15
                             else
                              NULL
                           end) as c2,
                       D1.c3 as c3,
                       D1.c4 as c4,
                       D1.c5 as c5,
                       D1.c6 as c6,
                       D1.c7 as c7,
                       D1.c8 as c8,
                       D1.c9 as c9
                  from (select D1.c3 as c3,
                               D1.c4 as c4,
                               D1.c5 as c5,
                               D1.c6 as c6,
                               D1.c7 as c7,
                               D1.c8 as c8,
                               D1.c9 as c9,
                               D1.c10 as c10,
                               D1.c12 as c11,
                               D1.c13 as c12,
                               D1.c14 as c13,
                               ROW_NUMBER() OVER(PARTITION BY D1.c8, D1.c9, D1.c12, D1.c13, D1.c14 ORDER BY D1.c8 DESC, D1.c9 DESC, D1.c12 DESC, D1.c13 DESC, D1.c14 DESC) as c14,
                               D1.c11 as c15
                          from (select distinct cast(T955085.LVL6ANC_PRODCAT_ID as
                                                     INTEGER) as c3,
                                                T18745.PRODUCT_NAME as c4,
                                                T14449.PROD_NUM as c5,
                                                T954755.ORG_NAME as c6,
                                                T954755.SUPPLIER_NUM as c7,
                                                T14449.ROW_WID as c8,
                                                T954755.ROW_WID as c9,
                                                LAST_VALUE(T1010716.SUPP_INV_QTY) OVER(PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T957587.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID ORDER BY NVL2(T1010716.SUPP_INV_QTY, 1, 0), T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T957587.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c10,
                                                LAST_VALUE(T1010716.SUPP_INV_COST) OVER(PARTITION BY T14449.ROW_WID, T954755.ROW_WID, T957587.ROW_WID, T1009437.ROW_WID, T1010474.ROW_WID ORDER BY NVL2(T1010716.SUPP_INV_COST, 1, 0), T14449.ROW_WID NULLS FIRST, T954755.ROW_WID NULLS FIRST, T957587.ROW_WID NULLS FIRST, T1009437.ROW_WID NULLS FIRST, T1010474.ROW_WID NULLS FIRST, T960506.ROW_WID NULLS FIRST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as c11,
                                                T957587.ROW_WID as c12,
                                                T1009437.ROW_WID as c13,
                                                T1010474.ROW_WID as c14
                                  from BBG_RA_ITEM_LOC_SUPP_D T1010474 /* Dim_BBG_RA_ITEM_LOC_SUPP_D */,
                                       BBG_RA_ITEM_LOC_D T1009437 /* Dim_BBG_ITEM_LOC */,
                                       W_RTL_LOC_LIST_D T957587 /* Dim_W_RTL_LOC_LIST_D */,
                                       W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
                                       W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */,
                                       (SELECT T.*
                                          FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
                                         WHERE T.SCD1_WID = A.SCD1_WID
                                           AND A.PRODUCT_ATTR12_NAME =
                                               A.PRODUCT_ATTR11_NAME) T14449,
                                       (SELECT DATASOURCE_NUM_ID,
                                               INTEGRATION_ID,
                                               PRODUCT_DESCR,
                                               PRODUCT_NAME,
                                               LANGUAGE_CODE
                                          FROM W_PRODUCT_D_TL
                                         WHERE LANGUAGE_CODE = 'ZHS') T18745,
                                       W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */,
                                       BBG_RA_SUPP_INV_IT_LC_DY_FV T1010716 /* Fact_BBG_RA_SUPP_INV_IT_LC_DY_F */
                                 where (T957587.SCD1_WID = T964463.SCD1_WID and
                                       T964463.ROW_WID = T1010716.ORG_WID and
                                       T960506.ROW_WID = T1010716.DT_WID and
                                       T954755.ROW_WID = T1010716.SUPPLIER_WID and
                                       T1009437.ROW_WID =
                                       T1010716.BBG_ITEM_LOC_WID and
                                       T14449.PROD_NUM = '102316196' and
                                       T954755.SUPPLIER_NUM = '21001420' and
                                       T960506.MCAL_CAL_WID = 1.0 and
                                       T1010474.CURRENT_FLG = 'Y' and
                                       T1010474.ROW_WID =
                                       T1010716.BBG_ITEM_LOC_SUPP_WID and
                                       TRUNC(T960506.MCAL_DAY_DT) =
                                       TO_DATE('2016-06-13', 'YYYY-MM-DD') and
                                       T14449.DATASOURCE_NUM_ID =
                                       T18745.DATASOURCE_NUM_ID and
                                       T14449.INTEGRATION_ID =
                                       T18745.INTEGRATION_ID and
                                       T14449.ROW_WID = T1010716.PROD_WID and
                                       T14449.PROD_CAT5_WID_AS_WAS =
                                       T955085.ROW_WID and
                                       '2010' < T960506.CAL_YEAR)) D1) D1
                 group by D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9) D1) D1
 order by c2, c4, c6, c5;
