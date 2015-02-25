R8705252210

SELECT * FROM RAINY_USER T WHERE T.USER_ID='R8705252210';
SELECT * FROM Rainy_User_Position T WHERE T.USER_ID='R8705252210';
SELECT * FROM RAINY_USER_MERCH T WHERE T.USER_ID='R8705252210';
SELECT * FROM RAINY_USER_LOC T WHERE T.USER_ID='R8705252210';

insert into rainy_user_position(user_id,position_id) values('R8705252210',124);


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
   AND RU.USER_ID IN ('R8705252210' );
