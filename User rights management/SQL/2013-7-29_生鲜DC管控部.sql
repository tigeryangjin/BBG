insert into rainy_user(user_id,user_name,id) values('R6509071546','尹红','1037');
insert into rainy_user(user_id,user_name,id) values('R7908316029','胡爱华','1038');
insert into rainy_user(user_id,user_name,id) values('R7212271014','文峰','1039');


--移除原职位权限
--查询出来的语句在sys用户下执行
SELECT 'revoke ' || rr.role_ext || ' from ' || ru.user_id || ';'
  FROM rainy_role          rr ,
       rainy_user          ru ,
       rainy_user_position rup ,
       rainy_position_role rpr 
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.USER_ID IN ( 'R6509071546','R7908316029','R7212271014');
--RA/BIP权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT 'dn: cn=' || ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
delete: uniquemember
uniquemember: cn='||ru.user_id ||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr ,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.USER_ID IN (  'R6509071546','R7908316029','R7212271014');

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ( 'R6509071546','R7908316029','R7212271014' );



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ( 'R6509071546','R7908316029','R7212271014') ;    
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE WHERE user_id IN ( 'R6509071546','R7908316029','R7212271014' );
DELETE FROM SEC_USER_GROUP WHERE USER_ID IN ( 'R6509071546','R7908316029','R7212271014' );
DELETE FROM RAINY_USER_LOC WHERE USER_ID IN ( 'R6509071546','R7908316029','R7212271014' );
DELETE FROM RAINY_USER_MERCH WHERE USER_ID IN ( 'R6509071546','R7908316029','R7212271014' );
DELETE FROM RAINY_USER_POSITION WHERE USER_ID IN ( 'R6509071546','R7908316029','R7212271014' );


--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID IN ( 'R6509071546','R7908316029','R7212271014' ) FOR UPDATE;

--
insert into rainy_user_position(user_id,position_id) values('R6509071546',16);	
insert into rainy_user_position(user_id,position_id) values('R7908316029',17);
insert into rainy_user_position(user_id,position_id) values('R7212271014',17);

--
insert into rainy_user_merch(user_id,merch) values('R6509071546','12');
insert into rainy_user_merch(user_id,merch) values('R6509071546','13');
insert into rainy_user_merch(user_id,merch) values('R6509071546','14');
insert into rainy_user_merch(user_id,merch) values('R6509071546','15');
insert into rainy_user_merch(user_id,merch) values('R6509071546','16');
insert into rainy_user_merch(user_id,merch) values('R6509071546','17');
insert into rainy_user_merch(user_id,merch) values('R6509071546','18');
insert into rainy_user_merch(user_id,merch) values('R6509071546','19');
insert into rainy_user_merch(user_id,merch) values('R6509071546','21');
insert into rainy_user_merch(user_id,merch) values('R6509071546','22');
insert into rainy_user_merch(user_id,merch) values('R6509071546','23');
insert into rainy_user_merch(user_id,merch) values('R6509071546','24');
insert into rainy_user_merch(user_id,merch) values('R6509071546','25');
insert into rainy_user_merch(user_id,merch) values('R6509071546','26');
insert into rainy_user_merch(user_id,merch) values('R6509071546','27');
insert into rainy_user_merch(user_id,merch) values('R6509071546','29');
insert into rainy_user_merch(user_id,merch) values('R6509071546','30');
insert into rainy_user_merch(user_id,merch) values('R6509071546','31');
insert into rainy_user_merch(user_id,merch) values('R6509071546','32');
insert into rainy_user_merch(user_id,merch) values('R6509071546','33');
insert into rainy_user_merch(user_id,merch) values('R6509071546','34');
insert into rainy_user_merch(user_id,merch) values('R6509071546','35');
insert into rainy_user_merch(user_id,merch) values('R6509071546','36');
insert into rainy_user_merch(user_id,merch) values('R6509071546','37');
insert into rainy_user_merch(user_id,merch) values('R6509071546','38');
insert into rainy_user_merch(user_id,merch) values('R6509071546','39');
insert into rainy_user_merch(user_id,merch) values('R6509071546','40');
insert into rainy_user_merch(user_id,merch) values('R6509071546','41');
insert into rainy_user_merch(user_id,merch) values('R6509071546','42');
insert into rainy_user_merch(user_id,merch) values('R7908316029','12');
insert into rainy_user_merch(user_id,merch) values('R7908316029','13');
insert into rainy_user_merch(user_id,merch) values('R7908316029','14');
insert into rainy_user_merch(user_id,merch) values('R7908316029','15');
insert into rainy_user_merch(user_id,merch) values('R7908316029','16');
insert into rainy_user_merch(user_id,merch) values('R7908316029','17');
insert into rainy_user_merch(user_id,merch) values('R7908316029','18');
insert into rainy_user_merch(user_id,merch) values('R7908316029','19');
insert into rainy_user_merch(user_id,merch) values('R7908316029','21');
insert into rainy_user_merch(user_id,merch) values('R7908316029','22');
insert into rainy_user_merch(user_id,merch) values('R7908316029','23');
insert into rainy_user_merch(user_id,merch) values('R7908316029','24');
insert into rainy_user_merch(user_id,merch) values('R7908316029','25');
insert into rainy_user_merch(user_id,merch) values('R7908316029','26');
insert into rainy_user_merch(user_id,merch) values('R7908316029','27');
insert into rainy_user_merch(user_id,merch) values('R7908316029','29');
insert into rainy_user_merch(user_id,merch) values('R7908316029','30');
insert into rainy_user_merch(user_id,merch) values('R7908316029','31');
insert into rainy_user_merch(user_id,merch) values('R7908316029','32');
insert into rainy_user_merch(user_id,merch) values('R7908316029','33');
insert into rainy_user_merch(user_id,merch) values('R7908316029','34');
insert into rainy_user_merch(user_id,merch) values('R7908316029','35');
insert into rainy_user_merch(user_id,merch) values('R7908316029','36');
insert into rainy_user_merch(user_id,merch) values('R7908316029','37');
insert into rainy_user_merch(user_id,merch) values('R7908316029','38');
insert into rainy_user_merch(user_id,merch) values('R7908316029','39');
insert into rainy_user_merch(user_id,merch) values('R7908316029','40');
insert into rainy_user_merch(user_id,merch) values('R7908316029','41');
insert into rainy_user_merch(user_id,merch) values('R7908316029','42');
insert into rainy_user_merch(user_id,merch) values('R7212271014','27');
insert into rainy_user_merch(user_id,merch) values('R7212271014','30');
insert into rainy_user_merch(user_id,merch) values('R7212271014','31');
insert into rainy_user_merch(user_id,merch) values('R7212271014','32');
insert into rainy_user_merch(user_id,merch) values('R7212271014','33');
insert into rainy_user_merch(user_id,merch) values('R7212271014','34');
insert into rainy_user_merch(user_id,merch) values('R7212271014','35');
insert into rainy_user_merch(user_id,merch) values('R7212271014','36');
insert into rainy_user_merch(user_id,merch) values('R7212271014','37');
insert into rainy_user_merch(user_id,merch) values('R7212271014','38');
insert into rainy_user_merch(user_id,merch) values('R7212271014','39');
insert into rainy_user_merch(user_id,merch) values('R7212271014','40');
insert into rainy_user_merch(user_id,merch) values('R7212271014','41');
insert into rainy_user_merch(user_id,merch) values('R7212271014','42');

--
insert into rainy_user_loc (user_id,loc)values('R6509071546','118001');

insert into rainy_user_loc (user_id,loc)values('R6509071546','118005');
insert into rainy_user_loc (user_id,loc)values('R6509071546','118011');
insert into rainy_user_loc (user_id,loc)values('R6509071546','118012');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120001');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120002');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120003');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120004');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120006');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120008');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120009');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120010');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120011');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120012');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120013');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120014');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120015');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120016');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120017');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120020');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120021');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120022');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120023');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120024');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120025');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120026');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120027');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120028');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120029');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120030');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120032');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120033');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120034');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120035');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120036');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120038');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120039');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120040');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120041');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120043');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120044');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120045');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120051');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120053');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120055');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120056');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120057');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120058');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120059');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120060');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120062');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120063');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120064');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120065');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120066');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120067');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120068');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120070');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120071');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120072');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120073');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120074');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120075');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120077');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120078');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120080');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120081');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120082');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120083');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120084');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120085');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120086');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120087');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120088');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120089');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120090');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120092');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120094');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120095');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120096');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120097');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120098');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120100');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120101');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120102');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120103');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120104');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120105');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120106');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120107');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120108');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120109');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120110');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120111');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120113');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120114');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120115');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120116');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120119');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120120');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120121');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120122');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120123');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120124');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120125');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120127');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120129');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120131');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120134');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120135');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120136');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120137');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120138');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120140');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120141');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120144');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120145');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120146');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120148');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120149');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120151');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120152');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120153');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120154');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120155');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120156');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120157');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120158');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120159');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120160');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120161');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120162');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120163');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120164');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120165');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120166');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120167');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120168');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120169');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120170');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120171');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120172');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120173');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120174');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120175');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120176');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120177');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120178');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120179');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120180');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120181');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120182');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120183');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120184');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120185');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120186');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120187');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120188');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120189');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120190');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120191');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120192');
insert into rainy_user_loc (user_id,loc)values('R6509071546','120194');
insert into rainy_user_loc (user_id,loc)values('R7908316029','118001');
insert into rainy_user_loc (user_id,loc)values('R7908316029','118005');
insert into rainy_user_loc (user_id,loc)values('R7908316029','118011');
insert into rainy_user_loc (user_id,loc)values('R7908316029','118012');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120001');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120002');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120003');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120004');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120006');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120008');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120009');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120010');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120011');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120012');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120013');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120014');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120015');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120016');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120017');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120020');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120021');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120022');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120023');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120024');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120025');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120026');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120027');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120028');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120029');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120030');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120032');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120033');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120034');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120035');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120036');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120038');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120039');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120040');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120041');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120043');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120044');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120045');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120051');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120053');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120055');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120056');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120057');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120058');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120059');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120060');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120062');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120063');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120064');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120065');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120066');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120067');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120068');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120070');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120071');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120072');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120073');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120074');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120075');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120077');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120078');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120080');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120081');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120082');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120083');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120084');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120085');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120086');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120087');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120088');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120089');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120090');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120092');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120094');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120095');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120096');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120097');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120098');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120100');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120101');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120102');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120103');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120104');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120105');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120106');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120107');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120108');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120109');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120110');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120111');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120113');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120114');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120115');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120116');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120119');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120120');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120121');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120122');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120123');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120124');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120125');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120127');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120129');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120131');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120134');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120135');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120136');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120137');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120138');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120140');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120141');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120144');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120145');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120146');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120148');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120149');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120151');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120152');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120153');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120154');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120155');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120156');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120157');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120158');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120159');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120160');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120161');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120162');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120163');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120164');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120165');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120166');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120167');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120168');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120169');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120170');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120171');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120172');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120173');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120174');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120175');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120176');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120177');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120178');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120179');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120180');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120181');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120182');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120183');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120184');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120185');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120186');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120187');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120188');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120189');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120190');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120191');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120192');
insert into rainy_user_loc (user_id,loc)values('R7908316029','120194');
insert into rainy_user_loc (user_id,loc)values('R7212271014','118001');
insert into rainy_user_loc (user_id,loc)values('R7212271014','118005');
insert into rainy_user_loc (user_id,loc)values('R7212271014','118011');
insert into rainy_user_loc (user_id,loc)values('R7212271014','118012');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120001');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120002');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120003');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120004');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120006');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120008');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120009');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120010');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120011');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120012');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120013');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120014');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120015');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120016');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120017');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120020');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120021');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120022');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120023');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120024');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120025');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120026');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120027');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120028');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120029');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120030');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120032');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120033');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120034');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120035');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120036');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120038');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120039');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120040');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120041');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120043');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120044');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120045');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120051');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120053');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120055');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120056');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120057');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120058');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120059');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120060');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120062');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120063');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120064');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120065');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120066');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120067');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120068');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120070');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120071');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120072');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120073');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120074');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120075');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120077');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120078');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120080');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120081');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120082');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120083');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120084');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120085');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120086');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120087');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120088');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120089');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120090');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120092');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120094');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120095');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120096');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120097');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120098');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120100');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120101');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120102');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120103');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120104');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120105');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120106');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120107');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120108');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120109');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120110');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120111');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120113');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120114');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120115');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120116');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120119');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120120');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120121');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120122');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120123');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120124');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120125');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120127');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120129');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120131');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120134');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120135');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120136');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120137');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120138');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120140');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120141');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120144');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120145');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120146');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120148');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120149');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120151');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120152');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120153');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120154');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120155');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120156');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120157');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120158');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120159');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120160');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120161');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120162');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120163');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120164');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120165');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120166');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120167');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120168');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120169');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120170');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120171');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120172');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120173');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120174');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120175');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120176');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120177');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120178');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120179');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120180');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120181');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120182');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120183');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120184');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120185');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120186');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120187');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120188');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120189');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120190');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120191');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120192');
insert into rainy_user_loc (user_id,loc)values('R7212271014','120194');

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
   AND RU.USER_ID IN ( 'R6509071546','R7908316029','R7212271014');
--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where USER_ID IN ( 'R6509071546','R7908316029','R7212271014')
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.USER_ID IN ('R6509071546','R7908316029','R7212271014' );
--Department大类    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.USER_ID IN ('R6509071546','R7908316029','R7212271014' )
     group by sg.group_id,ru.user_id;

--插入RSM_USER_ROLE表
--RPM系统权限写入
insert into RSM_USER_ROLE
select  rsm_user_role_seq.nextval, a.user_id, a.role_ext, SYSDATE - 720, null
from ( SELECT ru.user_id user_id ,ra.role_ext role_ext     
        FROM rainy_user ru , rainy_user_position rup , rainy_position_role rpr,RAINY_ROLE ra
       WHERE ru.user_id = rup.user_id
         AND rup.position_id = rpr.position_id
         and rpr.role_id =ra.role_id and ra.appl ='RPM'
         --注意以下条件
         AND RU.USER_ID IN ('R6509071546','R7908316029','R7212271014' )
         group  by ru.user_id ,ra.role_ext ) a 
where a.role_ext is not null ;
--LDAP建用户
--SIM系统,RA/BIP系统共用一个用户，建立一个就OK了。
--SIM系统中LOC为ALL的，在建用户和权限导入时要分店别或类别进行
--注意：userstores: storeId=ALL 时要替换。。。替换整行。。。
SELECT 'dn: cn=' || ru.user_id || ',cn=Users,dc=bbg
changetype: add
#RPM
objectclass: retailUser
#SIM
objectclass: simUser
#General
objectclass: inetOrgPerson
objectclass: orclUser
objectclass: orclUserV2
objectclass: organizationalPerson
objectclass: person
objectclass: top
uid: ' || ru.user_id || chr (13 ) || 'cn:' || ru.user_id || chr(13 ) ||
        'sn: ' || ru.user_id || chr( 13) || 'description:' || rp.position ||
        chr( 13) || 'givenname: ' || ru.user_id || chr (13 ) || 'superUser: FALSE
empStatus: 0
preferredCountry: CN
preferredLanguage: zh
middleName: M1
mail: user0010@bbg.com
telephoneNumber: 800-111-2222
externalId: ' || ru.user_id || chr (13 ) || 'supervisor: X
startTimestamp: 20071026000000Z
#endTimestamp:
#defaultStore: storeId=' ||
        (SELECT rul.loc
           FROM rainy_user_loc rul
          WHERE rul.user_id = ru.user_id
            AND rownum = 1) || ',cn=SIMStores,cn=SIM,dc=bbg,dc=com
userpassword: ' || ru.password || chr (13 ) ||
         (SELECT   wm_concat( 'userstores: storeId=' || rull.loc ||',cn=SIMStores,cn=SIM,dc=bbg' ||chr (13 ))
      
           FROM rainy_user_loc rull
          WHERE rull.user_id = ru.user_id
          GROUP BY rull.user_id )
  FROM rainy_user ru , rainy_user_position rup , rainy_position rp
-- rainy_user_loc      rull
-- RAINY_LOC           rl
WHERE ru.user_id = rup.user_id
   AND rup.position_id = rp.position_id
--注意下面条件，当用户地点权限为ALL时才是=，不是ALL就是<>
   AND EXISTS( SELECT 1 FROM RAINY_USER_LOC RULL WHERE RULL.USER_ID=RU.USER_ID AND RULL.LOC<> 'ALL')
   --AND ru.user_id NOT IN (SELECT rull.user_id FROM rainy_user_loc rull WHERE rull.loc <> 'ALL')
   AND RU.USER_ID IN ('R6509071546','R7908316029','R7212271014');

--SIM系统导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--注意：userRoleStores为ALL时要替换。。。替换整行。。。 
SELECT rr.role_name, ru.user_id, 'dn: roleName=' || rr.role_name || ',cn=' || ru.user_id ||
        ',cn=Users,dc=bbg
changetype: add
objectclass: simUserRole
roleName: ' || rr.role_name || chr (13 ) || 'userRole: roleName=' ||
        rr.role_name || ',cn=SIMRoles,cn=SIM,dc=bbg
userRoleStores: ' || wm_concat( 'storeId=' || rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg'||chr (13 ))
        /*(SELECT wm_concat(decode(rul.loc,
                                 'ALL',
                                 'storeId='||rl.loc_id || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13),
                                 'storeId='|| rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13)))
           FROM rainy_loc rl)*/ text
  FROM rainy_role          rr ,
       rainy_user          ru ,
       rainy_user_position rup ,
       rainy_position_role rpr ,
       rainy_user_loc      rul
--  rainy_loc           rl
 WHERE rr.appl = 'SIM'
   AND ru.user_id = rup.user_id
   AND rr.role_id = rpr.role_id
   AND rup.position_id = rpr.position_id
   AND ru.user_id = rul.user_id
--注意下面条件，当用户地点权限为ALL时才是=，不是ALL就是<>
and rul.loc <> 'ALL'
AND RU.USER_ID IN ( 'R6509071546','R7908316029','R7212271014' )
GROUP BY   rr.role_name, ru.user_id;

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
AND RU.USER_ID IN ( 'R6509071546','R7908316029','R7212271014' );

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@'||MERCH|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.USER_ID IN ('R6509071546','R7908316029','R7212271014' );



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'||a.LOC|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.USER_ID IN ('R6509071546','R7908316029','R7212271014' ) ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER
WHERE ID BETWEEN 1037 AND 1039;



