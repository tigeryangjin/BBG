select distinct 0 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c4 as c4,
     D1.c1 as c5,
     D1.c5 as c6
from 
     (select sum(T1011514.ADJ_COST) as c1,
               T1011493.REASON as c2,
               cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ) as c3,
               cast(T964463.ORG_NUM as  INTEGER  ) as c4,
               T964463.ROW_WID as c5
          from 
               BBG_RA_AJUSTMENT_REASON_D T1011493 /* Dim_BBG_RA_AJUSTMENT_REASON_D */ ,
               W_INT_ORG_DH T964333 /* Dim_W_INT_ORG_DH_Retail_As_Was */ ,
               W_INT_ORG_D T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */ ,
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               (SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449,
               W_PROD_CAT_DH T955085 /* Dim_W_PROD_CAT_DH_As_Was */ ,
               BBG_RA_INVADJ_IT_LC_DY_F T1011514 /* Fact_BBG_RA_INVADJ_IT_LC_DY_F */ 
          where  ( T964463.ROW_WID = T1011514.ORG_WID and T960506.ROW_WID = T1011514.DT_WID and T14449.ROW_WID = T1011514.PROD_WID and T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID and T960506.MCAL_CAL_WID = 1.0 and T960506.PER_NAME_MONTH = '2013 / 07' and T1011493.ROW_WID = T1011514.ADJUSTMENT_REASON_WID and T964333.ROW_WID = T1011514.ORG_DH_WID and T964333.SCD1_WID = T964463.SCD1_WID and '2010' < T960506.CAL_YEAR and (T1011493.REASON in ('2', '87', '88')) ) 
          group by T964463.ROW_WID, T1011493.REASON, cast(T955085.LVL6ANC_PRODCAT_ID as  INTEGER  ), cast(T964463.ORG_NUM as  INTEGER  )
     ) D1
order by c3, c4, 
c2

--SELECT * FROM W_INT_ORG_D
select * from BBG_RA_AJUSTMENT_REASON_D
