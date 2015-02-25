insert into RAINY_POSITION_ROLE(role_id,position_id) values(136,24);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(136,25);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(137,24);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(137,25);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(138,24);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(138,25);


select * from rainy_user t where USER_ID IN ('R6708041534','R8707132567','R8805240427','R7507194023');
SELECT * FROM RAINY_USER WHERE USER_NAME LIKE '%宋%'
select * from RAINY_USER_POSITION T WHERE POSITION_ID=55;
select * from rainy_user_position where user_id='R8910142740'

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
   AND RPR.POSITION_ID IN (24,25)
   AND RPR.ROLE_ID IN (136,137,138);
   


