CREATE OR REPLACE VIEW BBG_RA_ITEM_LOC_JL_V AS
SELECT "ITEM",
       "LOC",
       "SRC_EFF_FROM_DT",
       "NBB",
       "NBO",
       "SALE_TYPE",
       "STANDARD_GROSS_MARGIN",
       "PROMO_GROSS_MARGIN",
       "BUSINESS_MODE",
       "ZC_IND",
       "BBG_ZG_IND",
       "HERO_ITEM_IND",
       "START_DATE",
       "END_DATE",
       "NEW_ITEM_FLAG",
       "REF_NO1",
       "REF_NO2",
       "REF_NO3",
       "REF_NO4"
  FROM (
        --金立系统同一商品地点，有不同的经验属性，而且日期可能是同一天，所以先取最大日期的记录，
        --然后在按照经销、代销、联谊来排序，只取第一条记录。
        SELECT B.ITEM,
                B.LOC,
                B.SRC_EFF_FROM_DT,
                B.NBB,
                B.NBO,
                B.SALE_TYPE,
                B.STANDARD_GROSS_MARGIN,
                B.PROMO_GROSS_MARGIN,
                B.BUSINESS_MODE,
                B.ZC_IND,
                B.BBG_ZG_IND,
                B.HERO_ITEM_IND,
                B.START_DATE,
                B.END_DATE,
                B.NEW_ITEM_FLAG,
                B.REF_NO1,
                B.REF_NO2,
                B.REF_NO3,
                B.REF_NO4
          FROM (SELECT TRIM(A.ITEM) ITEM,
                        TRIM(A.LOC) LOC,
                        A.SRC_EFF_FROM_DT,
                        TRIM(A.NBB) NBB,
                        TRIM(A.NBO) NBO,
                        '' SALE_TYPE,
                        A.STANDARD_GROSS_MARGIN,
                        A.PROMO_GROSS_MARGIN,
                        TRIM(A.BUSINESS_MODE) BUSINESS_MODE,
                        TRIM(A.ZC_IND) ZC_IND,
                        TRIM(A.BBG_ZG_IND) BBG_ZG_IND,
                        TRIM(A.HERO_ITEM_IND) HERO_ITEM_IND,
                        '' START_DATE,
                        '' END_DATE,
                        TRIM(A.NEW_ITEM_FLAG) NEW_ITEM_FLAG,
                        '' REF_NO1,
                        TRIM(A.REF_NO2) REF_NO2,
                        '' REF_NO3,
                        '' REF_NO4,
                        RANK() OVER(PARTITION BY A.ITEM, A.LOC ORDER BY DECODE(A.BUSINESS_MODE, 'JX', 1, 'DX', 2, 'LY', 3), A.ZC_IND) RANK_NO
                   FROM RA_RMS.BBG_JL_ITEM_LOC_MV A
                  WHERE EXISTS
                  (SELECT 1
                           FROM (SELECT B.ITEM,
                                        B.LOC,
                                        MAX(B.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT
                                   FROM RA_RMS.BBG_JL_ITEM_LOC_MV B
                                  GROUP BY B.ITEM, B.LOC) C
                          WHERE A.ITEM = C.ITEM
                            AND A.LOC = C.LOC
                            AND A.SRC_EFF_FROM_DT = C.SRC_EFF_FROM_DT)) B
         WHERE B.RANK_NO = 1
        /*SELECT A.ITEM,
              A.LOC,
              MAX(A.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT,
              MAX(A.NBB) NBB,
              MAX(A.NBO) NBO,
              MAX(A.SALE_TYPE) SALE_TYPE,
              MAX(A.STANDARD_GROSS_MARGIN) STANDARD_GROSS_MARGIN,
              MAX(A.PROMO_GROSS_MARGIN) PROMO_GROSS_MARGIN,
              MAX(A.BUSINESS_MODE) BUSINESS_MODE,
              MAX(A.ZC_IND) ZC_IND,
              MAX(A.BBG_ZG_IND) BBG_ZG_IND,
              MAX(A.HERO_ITEM_IND) HERO_ITEM_IND,
              MAX(A.START_DATE) START_DATE,
              MAX(A.END_DATE) END_DATE,
              MAX(A.NEW_ITEM_FLAG) NEW_ITEM_FLAG,
              MAX(A.REF_NO1) REF_NO1,
              MAX(A.REF_NO2) REF_NO2,
              MAX(A.REF_NO3) REF_NO3,
              MAX(A.REF_NO4) REF_NO4
         FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL A
        GROUP BY A.ITEM, A.LOC*/
        
        )

--部分销售的商品-地点维度缺失,需要补全
/*UNION ALL
SELECT A.PROD_IT_NUM ITEM,
       A.ORG_NUM LOC,
       TRUNC(SYSDATE) SRC_EFF_FROM_DT,
       'N' NBB,
       'N' NBO,
       NULL SALE_TYPE,
       0 STANDARD_GROSS_MARGIN,
       0 PROMO_GROSS_MARGIN,
       'LY' BUSINESS_MODE,
       'N' ZC_IND,
       'N' BBG_ZG_IND,
       'N' HERO_ITEM_IND,
       NULL START_DATE,
       NULL END_DATE,
       'N' NEW_ITEM_FLAG,
       NULL REF_NO1,
       NULL REF_NO2,
       NULL REF_NO3,
       NULL REF_NO4
  FROM BBG_RA_SLS_TRX_JL_V@RMS_JL A
 WHERE NOT EXISTS (SELECT 1
          FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL C
         WHERE A.PROD_IT_NUM = C.ITEM
           AND A.ORG_NUM = C.LOC)*/
;
