/* 539b2c95 */
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
       D1.c11 as c11
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
               D1.c13 as c13,
               D1.c14 as c14,
               D1.c15 as c15
          from (select D1.c1 as c1,
                       D1.c2 as c2,
                       D1.c3 as c3,
                       concat(D1.c14, D2.c1) as c4,
                       D1.c4 as c5,
                       D1.c5 as c6,
                       D1.c6 as c7,
                       D1.c7 as c8,
                       D1.c8 as c9,
                       D1.c9 as c10,
                       D1.c10 as c11,
                       D1.c11 as c12,
                       D1.c12 as c13,
                       D1.c13 as c14,
                       D1.c15 as c15,
                       ROW_NUMBER() OVER(PARTITION BY D1.c2, D1.c3, D1.c4, D1.c5, D1.c6, D1.c7, D1.c8, D1.c9, D1.c11, D1.c12, D1.c13, D1.c15, concat(D1.c14, D2.c1) ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c4 ASC, D1.c5 ASC, D1.c6 ASC, D1.c7 ASC, D1.c8 ASC, D1.c9 ASC, D1.c11 ASC, D1.c12 ASC, D1.c13 ASC, D1.c15 ASC, concat(D1.c14, D2.c1) ASC) as c16
                  from (select 0 as c1,
                               D1.c3 as c2,
                               D1.c4 as c3,
                               D1.c5 as c4,
                               D1.c6 as c5,
                               D1.c7 as c6,
                               D1.c8 as c7,
                               D1.c9 as c8,
                               D1.c6 as c9,
                               D1.c2 - D1.c1 as c10,
                               D1.c10 as c11,
                               D1.c11 as c12,
                               D1.c12 as c13,
                               D1.c13 as c14,
                               D1.c14 as c15
                          from (select sum(nvl(T956076.SLS_TAX_AMT_LCL, 0) -
                                           nvl(T956076.RET_TAX_AMT_LCL, 0)) as c1,
                                       sum(nvl(T956076.SLS_AMT_LCL, 0) -
                                           nvl(T956076.RET_AMT_LCL, 0)) as c2,
                                       T960506.PER_NAME_MONTH as c3,
                                       T960506.PER_NAME_YEAR as c4,
                                       T18745.PRODUCT_NAME as c5,
                                       T14449.PROD_NUM as c6,
                                       T953980.ORG_NAME as c7,
                                       cast(T964463.ORG_NUM as INTEGER) as c8,
                                       concat(concat('DEPT', '~'),
                                              T955085.LVL6ANC_PRODCAT_ID) as c9,
                                       T964463.ROW_WID as c10,
                                       T14449.ROW_WID as c11,
                                       T960506.CAL_MONTH_WID as c12,
                                       concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as
                                                        INTEGER) as VARCHAR(20)),
                                              '-') as c13,
                                       T955085.DATASOURCE_NUM_ID as c14
                                  from (SELECT T.DATASOURCE_NUM_ID,
                                               T.INTEGRATION_ID,
                                               T.ORG_DESCR,
                                               T.ORG_NAME,
                                               NVL(CASE
                                                     WHEN T.INTEGRATION_ID NOT LIKE
                                                          '12%' THEN
                                                      T.ORG_NAME
                                                     ELSE
                                                      (SELECT A.ORG_NAME
                                                         FROM RADM.W_INT_ORG_D_TL A
                                                        WHERE A.INTEGRATION_ID =
                                                              '139' ||
                                                              SUBSTR(T.INTEGRATION_ID,
                                                                     -3,
                                                                     3))
                                                   END,
                                                   T.ORG_NAME) BBG_EXT_ORG_NAME,
                                               T.LANGUAGE_CODE
                                        
                                          FROM W_INT_ORG_D_TL T
                                        
                                         WHERE T.LANGUAGE_CODE = 'ZHS') T953980,
                                       W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */,
                                       W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
                                       W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
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
                                       W_RTL_SLS_IT_LC_DY_A T956076 /* Fact_W_RTL_SLS_IT_LC_DY_A */
                                 where (T953980.DATASOURCE_NUM_ID =
                                       T964463.DATASOURCE_NUM_ID and
                                       T953980.INTEGRATION_ID =
                                       T964463.INTEGRATION_ID and
                                       T956076.DT_WID = T960506.ROW_WID and
                                       T956076.ORG_DH_WID = T964333.ROW_WID and
                                       T956076.ORG_WID = T964463.ROW_WID and
                                       T960506.MCAL_CAL_WID = 1.0 and
                                       T964333.SCD1_WID = T964463.SCD1_WID and
                                       T14449.DATASOURCE_NUM_ID =
                                       T18745.DATASOURCE_NUM_ID and
                                       T14449.INTEGRATION_ID =
                                       T18745.INTEGRATION_ID and
                                       T14449.ROW_WID = T956076.PROD_WID and
                                       T14449.PROD_CAT5_WID_AS_WAS =
                                       T955085.ROW_WID and
                                       '2010' < T960506.CAL_YEAR and
                                       (T960506.PER_NAME_YEAR in
                                       ('2011','2012','2013') and
                                       (cast(T964463.ORG_NUM as INTEGER) in
                                       (120039,120022,120059))) /*AND
                                       T14449.PROD_NUM = '800043746'*/
																			 AND T956076.SLS_TAX_AMT_LCL+T956076.RET_TAX_AMT_LCL=0)
                                 group by T14449.ROW_WID,
                                          T14449.PROD_NUM,
                                          T18745.PRODUCT_NAME,
                                          T953980.ORG_NAME,
                                          T955085.DATASOURCE_NUM_ID,
                                          T960506.CAL_MONTH_WID,
                                          T960506.PER_NAME_MONTH,
                                          T960506.PER_NAME_YEAR,
                                          T964463.ROW_WID,
                                          cast(T955085.LVL6ANC_PRODCAT_ID as
                                               INTEGER),
                                          cast(T964463.ORG_NUM as INTEGER),
                                          concat(cast(cast(T955085.LVL6ANC_PRODCAT_ID as
                                                           INTEGER) as
                                                      VARCHAR(20)),
                                                 '-'),
                                          concat(concat('DEPT', '~'),
                                                 T955085.LVL6ANC_PRODCAT_ID)) D1
                         /*where (D1.c1 = 0 and D1.c2 - D1.c1 <> 0
                               )*/) D1
                 inner join (select T16687.DOMAIN_MEMBER_NAME as c1,
                                   T16687.DOMAIN_MEMBER_CODE as c2,
                                   T16687.DATASOURCE_NUM_ID  as c3
                              from W_DOMAIN_MEMBER_LKP_TL T16687 /* Lookup_W_DOMAIN_MEMBER_LKP_TL */
                             where (T16687.DOMAIN_CODE = 'MCAT' and
                                   T16687.DOMAIN_TYPE_CODE = 'S' and
                                   T16687.LANGUAGE_CODE = 'ZHS')) D2
                    On D1.c8 = D2.c2
                   and D1.c15 = D2.c3) D1
         where (D1.c16 = 1)) D1
 order by c1, c3, c2, c8, c7, c4, c6, c10
