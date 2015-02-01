
--CREATE TABLE RADM.JIN_PRODUCT_SCD1_WID AS
SELECT T.INTEGRATION_ID, T.PROD_NUM, T.SCD1_WID
  FROM RADM.W_PRODUCT_D T
 WHERE T.INTEGRATION_ID IN ('100229769',
                            '100800558',
                            '100869061',
                            '100886566',
                            '100886582',
                            '100886591',
                            '100886620',
                            '101019173',
                            '101123325',
                            '700001752',
                            '800261235',
                            '89354')
   AND T.CURRENT_FLG = 'N'
 ORDER BY T.INTEGRATION_ID, T.SCD1_WID
   FOR UPDATE;
