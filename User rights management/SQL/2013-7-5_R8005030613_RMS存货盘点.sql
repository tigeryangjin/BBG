--衡阳祁东店：RMS系统库存中没有“存货盘点”的权限，用户名：R8005030613  姓名：李伟   岗位：信息经理

SELECT * FROM RAINY_USER WHERE USER_ID='R8005030613';
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID='R8005030613';
SELECT * FROM RAINY_USER_POSITION WHERE POSITION_ID=95;
SELECT * FROM RAINY_POSITION_ROLE WHERE POSITION_ID=95 ORDER BY ROLE_ID;


--RMS系统权限
--查询出来的数据用sys用户名执行
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr  ,
       rainy_user          ru  ,
       rainy_user_position rup ,
       rainy_position_role rpr 
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.USER_ID IN ('R8005030613' )
   AND RPR.ROLE_ID IN (120,121,122);


