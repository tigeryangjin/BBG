select distinct 0 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c1 as c4,
     D1.c4 as c5
from 
     (select sum(T1037172.BBG_CUSTOMER_COUNT) as c1,
                TRUNC(T960506.MCAL_DAY_DT) as c2,
               concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME) as c3,
               T960506.ROW_WID as c4
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
               BBG_RA_CUST_LC_DY_A T1037172 /* Fact_BBG_RA_CUST_LC_DY_A */ 
          where  ( T953980.DATASOURCE_NUM_ID = T964463.DATASOURCE_NUM_ID and T953980.INTEGRATION_ID = T964463.INTEGRATION_ID and T960506.ROW_WID = T1037172.DT_WID and T960506.MCAL_CAL_WID = 1.0 and T964463.SCD1_WID = T1037172.ORG_SCD1_WID and T964333.ROW_WID = T1037172.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR ) 
          group by T960506.ROW_WID,  TRUNC(T960506.MCAL_DAY_DT), concat(concat(cast(cast(T964463.ORG_NUM as  INTEGER  ) as  VARCHAR ( 20 ) ), '-'), T953980.ORG_NAME)
     ) D1
order by c2, c3
