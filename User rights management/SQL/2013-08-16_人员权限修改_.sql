insert into rainy_user_position(user_id,position_id) values('R7805090065',84);
insert into rainy_user_position(user_id,position_id) values('R7901262021',85);
insert into rainy_user_position(user_id,position_id) values('R7001082527',86);
insert into rainy_user_position(user_id,position_id) values('R7001130924',86);
insert into rainy_user_position(user_id,position_id) values('R661005253x',86);
insert into rainy_user_position(user_id,position_id) values('R7708085882',85);
insert into rainy_user_position(user_id,position_id) values('R7207080017',86);
insert into rainy_user_position(user_id,position_id) values('R7209050023',86);
insert into rainy_user_position(user_id,position_id) values('R7703263525',86);
insert into rainy_user_position(user_id,position_id) values('R7301255026',85);
insert into rainy_user_position(user_id,position_id) values('R6812261546',86);
insert into rainy_user_position(user_id,position_id) values('R7406073522',86);
insert into rainy_user_position(user_id,position_id) values('R7112227448',86);
insert into rainy_user_position(user_id,position_id) values('R7608076786',86);
insert into rainy_user_position(user_id,position_id) values('R8203070098',95);

SELECT * FROM RAINY_USER WHERE USER_ID LIKE 'R661005253x';
SELECT * FROM RAINY_USER_LOC WHERE USER_ID LIKE 'R661005253x';
SELECT * FROM RAINY_USER_MERCH WHERE USER_ID LIKE 'R661005253x';
1526 1540

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
   AND RU.ID BETWEEN 1526 AND 1540;
   
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
AND RU.ID BETWEEN 1526 AND 1540 ;

SELECT * 
FROM RAINY_USER T WHERE T.USER_ID IN ('R7209050023','R7708085882','R7301255026','R6812261546');


