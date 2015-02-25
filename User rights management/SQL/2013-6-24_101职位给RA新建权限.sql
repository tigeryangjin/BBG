insert into RAINY_POSITION_ROLE(role_id,position_id) values(182,101);

insert into RAINY_POSITION_ROLE(role_id,position_id) values(184,101);


SELECT * FROM RAINY_POSITION_ROLE WHERE POSITION_ID=101 AND ROLE_ID=184;
SELECT * FROM RAINY_ROLE WHERE ROLE_ID=184;
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID IN ( 'R7001140022','R7409071024');
SELECT * FROM RAINY_USER WHERE USER_ID='R8106091516';
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID = 'R8106091516';
SELECT * FROM RAINY_POSITION_ROLE WHERE POSITION_ID=14 ORDER BY ROLE_ID;
--RA/BIP权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。R7001140022  R7409071024
--R8106091516  ASjqt682 此账号有RA新建的权限
SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.USER_ID IN ( 'R7001140022','R7409071024')
AND RA.ROLE_ID=184
