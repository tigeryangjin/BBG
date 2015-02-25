SELECT * FROM RAINY_USER T WHERE T.USER_ID='R921107006X';

insert into rainy_user_position(user_id,position_id) values('R8107025018',85);
insert into rainy_user_position(user_id,position_id) values('R8806100512',86);
insert into rainy_user_position(user_id,position_id) values('R7711090417',86);
insert into rainy_user_position(user_id,position_id) values('R7512112317',86);
insert into rainy_user_position(user_id,position_id) values('R7611160449',86);
insert into rainy_user_position(user_id,position_id) values('R7101100024',86);
insert into rainy_user_position(user_id,position_id) values('R9105100442',86);
insert into rainy_user_position(user_id,position_id) values('R921107006X',95);

1699 1706
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
   AND RU.ID BETWEEN 1699 AND 1706;
   
--RA/BIP权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.ID BETWEEN 1699 AND 1706 ;
