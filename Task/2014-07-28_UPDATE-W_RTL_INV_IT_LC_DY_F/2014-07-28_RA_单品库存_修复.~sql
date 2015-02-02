--
SELECT DISTINCT T.LOC FROM RADM.RMS_RA_INV_CHECK_DIFF T;

SELECT * FROM RADM.W_INT_ORG_D T WHERE T.ORG_NUM = '120004';

SELECT *
  FROM RADM.W_RTL_INV_IT_LC_DY_F T
 WHERE T.PROD_WID = 282252
   AND T.ORG_WID = 68;
--
SELECT T.ROW_WID,
       T.PROD_WID,
       T.PROD_SCD1_WID,
       T.ORG_WID,
       T.ORG_DH_WID,
       T.ORG_SCD1_WID,
       T.FROM_DT_WID,
       T.TO_DT_WID,
       CASE
         WHEN '1' || TO_CHAR(TO_DATE(SUBSTR(LEAD(T.FROM_DT_WID)
                                            OVER(partition by T.ORG_SCD1_WID
                                                 ORDER BY T.FROM_DT_WID),
                                            2,
                                            8),
                                     'YYYYMMDD') - 1,
                             'YYYYMMDD') || '000' = '1000' THEN
          '999999999999999'
         ELSE
          '1' || TO_CHAR(TO_DATE(SUBSTR(LEAD(T.FROM_DT_WID)
                                        OVER(partition by T.ORG_SCD1_WID
                                             ORDER BY T.FROM_DT_WID),
                                        2,
                                        8),
                                 'YYYYMMDD') - 1,
                         'YYYYMMDD') || '000'
       END NEW_TO_DT_WID
  FROM RADM.W_RTL_INV_IT_LC_DY_F T
 WHERE T.PROD_WID = 282252
   AND T.ORG_WID IN (68, 113, 20)
 ORDER BY T.ORG_SCD1_WID, T.FROM_DT_WID;

--创建视图——new TO_DT_WID
CREATE OR REPLACE VIEW RADM.JIN_INV_ILD_F_NEW_TO_DT_WID AS
  SELECT T.ROW_WID,
         T.PROD_WID,
         T.PROD_SCD1_WID,
         T.ORG_WID,
         T.ORG_DH_WID,
         T.ORG_SCD1_WID,
         T.FROM_DT_WID,
         T.TO_DT_WID,
         CASE
           WHEN '1' ||
                TO_CHAR(TO_DATE(SUBSTR(LEAD(T.FROM_DT_WID)
                                       OVER(partition by T.ORG_SCD1_WID,
                                            T.PROD_SCD1_WID ORDER BY
                                            T.FROM_DT_WID),
                                       2,
                                       8),
                                'YYYYMMDD') - 1,
                        'YYYYMMDD') || '000' = '1000' THEN
            '999999999999999'
           ELSE
            '1' || TO_CHAR(TO_DATE(SUBSTR(LEAD(T.FROM_DT_WID)
                                          OVER(partition by T.ORG_SCD1_WID,
                                               T.PROD_SCD1_WID ORDER BY
                                               T.FROM_DT_WID),
                                          2,
                                          8),
                                   'YYYYMMDD') - 1,
                           'YYYYMMDD') || '000'
         END NEW_TO_DT_WID
    FROM RADM.W_RTL_INV_IT_LC_DY_F T
   ORDER BY T.ORG_SCD1_WID, T.FROM_DT_WID;

--有二条999999999999999记录的库存
SELECT T.PROD_SCD1_WID, T.ORG_SCD1_WID, COUNT(*)
  FROM RADM.w_rtl_inv_it_lc_dy_f T
 WHERE T.TO_DT_WID = 999999999999999
 GROUP BY T.PROD_SCD1_WID, T.ORG_SCD1_WID
HAVING COUNT(*) > 1;

--最后一条记录不为9999999999999999的库存
SELECT *
  FROM RADM.W_RTL_INV_IT_LC_DY_F T
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.W_RTL_INV_IT_LC_DY_F F
         WHERE T.PROD_SCD1_WID = F.PROD_SCD1_WID
           AND T.ORG_SCD1_WID = F.ORG_SCD1_WID
           AND F.TO_DT_WID = 999999999999999);

--需要修护的数据行
CREATE TABLE RADM.JIN_INV_TO_DT_WID_DIFF AS
  select *
    from JIN_INV_ILD_F_NEW_TO_DT_WID t
   WHERE T.NEW_TO_DT_WID <> T.TO_DT_WID;

--RA中单品库存在每日传入RA时，ODI接口只根据PROD_WID,ORG_WID来更新TO_DT_WID日期，而没有根据渐变维度SCD来更新
UPDATE RADM.W_RTL_INV_IT_LC_DY_F F
   SET F.TO_DT_WID =
       (SELECT D.NEW_TO_DT_WID
          FROM RADM.JIN_INV_TO_DT_WID_DIFF D
         WHERE F.ROW_WID = D.ROW_WID
           AND F.TO_DT_WID <> D.NEW_TO_DT_WID)
 WHERE EXISTS (SELECT 1
          FROM RADM.JIN_INV_TO_DT_WID_DIFF I
         WHERE F.ROW_WID = I.ROW_WID
           AND F.TO_DT_WID <> I.NEW_TO_DT_WID)
   AND F.PROD_SCD1_WID = 308742
   AND F.ORG_SCD1_WID = 100;
