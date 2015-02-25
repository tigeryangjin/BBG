insert into RAINY_POSITION_ROLE(role_id,position_id) values(120,95);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(121,95);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(122,95);

SELECT * FROM RAINY_POSITION_ROLE WHERE POSITION_id=95 AND ROLE_ID IN(120,121,122);

--添加新职位权限
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
   AND RR.ROLE_ID IN (120,121,122);
   /*AND RU.USER_ID IN ('R9012281325', 'R7402050629','R8210267147' )*/;

