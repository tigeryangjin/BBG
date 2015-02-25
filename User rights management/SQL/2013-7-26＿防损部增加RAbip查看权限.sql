R7609268516
R8201170555
R7307190015
R7712053531
R8012193316
R7609015214
R7502104015
R7804298473
R7702180034

SELECT RR.*
FROM RAINY_ROLE RR,RAINY_POSITION_ROLE RPR,RAINY_USER_POSITION RUP
WHERE RR.ROLE_ID=RPR.ROLE_ID AND RPR.POSITION_ID=RUP.POSITION_ID AND RUP.USER_ID = 'R7609268516';

insert into RAINY_POSITION_ROLE(role_id,position_id) values(170,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(171,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(172,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(173,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(176,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(180,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(185,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(187,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(188,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(189,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(190,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(191,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(192,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(193,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(194,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(197,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(198,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(199,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(200,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(202,83);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(203,83);


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
AND RPR.POSITION_ID = 83
AND RPR.ROLE_ID BETWEEN 170 AND 203;

