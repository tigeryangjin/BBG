SELECT T.SUPPLIER_NUM
  FROM W_PARTY_ORG_D T
 GROUP BY T.SUPPLIER_NUM
HAVING COUNT(*) > 1;
SELECT T.ORG_NUM FROM W_INT_ORG_D T GROUP BY T.ORG_NUM HAVING COUNT(*) > 1;
SELECT T.PROD_NUM
  FROM W_PRODUCT_D T
 GROUP BY T.PROD_NUM
HAVING COUNT(*) > 1;
SELECT T.PROMO_EVENT_ID,
       T.PROMO_DETAIL_ID,
       T.PROMO_COMPONENT_ID
  FROM RADM.W_RTL_PROMO_D T
 GROUP BY T.PROMO_EVENT_ID,
          T.PROMO_DETAIL_ID,
          T.PROMO_COMPONENT_ID
HAVING COUNT(*) > 1;
