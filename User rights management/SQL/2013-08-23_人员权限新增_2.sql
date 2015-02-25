insert into rainy_user(user_id,user_name,id) values('R9810103921','刘红玉','2199');
--insert into rainy_user(user_id,user_name,id) values('R7102050056','贺永红','2200');
insert into rainy_user(user_id,user_name,id) values('R7810272056','熊涛','2201');
insert into rainy_user(user_id,user_name,id) values('R710510066X','胡艾玲','2202');
insert into rainy_user(user_id,user_name,id) values('R7804240014','王叶勇','2203');
insert into rainy_user(user_id,user_name,id) values('R7807011549','陈慧','2204');
insert into rainy_user(user_id,user_name,id) values('R8406243343','张丽','2205');
--insert into rainy_user(user_id,user_name,id) values('R8202170035','傅海波','2206');
insert into rainy_user(user_id,user_name,id) values('R7411212861','卢春梅','2207');
insert into rainy_user(user_id,user_name,id) values('R740522601X','黄显送','2208');
insert into rainy_user(user_id,user_name,id) values('R8503121531','范伟','2209');
insert into rainy_user(user_id,user_name,id) values('R8310068032','杨勇','2210');
insert into rainy_user(user_id,user_name,id) values('R7201290926','吴蓉晖','2211');
insert into rainy_user(user_id,user_name,id) values('R6610232546','杨云','2212');
insert into rainy_user(user_id,user_name,id) values('R8902190017','徐斌','2213');
insert into rainy_user(user_id,user_name,id) values('R7506300047','欧阳萍','2214');
insert into rainy_user(user_id,user_name,id) values('R7208164442','彭凉珠','2215');
insert into rainy_user(user_id,user_name,id) values('R6912262820','肖道裕','2216');
insert into rainy_user(user_id,user_name,id) values('R8809011017','石李平','2217');
insert into rainy_user(user_id,user_name,id) values('R8907090015','廖怀泉','2218');
insert into rainy_user(user_id,user_name,id) values('R6212030919','刘建国','2219');
insert into rainy_user(user_id,user_name,id) values('R7410240860','高雪华','2220');
insert into rainy_user(user_id,user_name,id) values('R7210060021','汪卫民','2221');
insert into rainy_user(user_id,user_name,id) values('R7209115427','廖梦华','2222');
insert into rainy_user(user_id,user_name,id) values('R7012142413','袁成武','2223');
insert into rainy_user(user_id,user_name,id) values('R7607310519','李旭','2224');
insert into rainy_user(user_id,user_name,id) values('R830303251X','占双隆','2225');


--修改密码
update rainy_user t
set t.password =( select upper(dbms_random.string ( 'u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value ( 0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where t.password is null



--创建DB用户
--语句在sys用户下执行
SELECT
 'create user ' || ru.user_id || ' identified by ' || ru.password ||
 ' default tablespace RETEK_DATA
temporary tablespace TEMP
quota unlimited on RETEK_DATA
quota unlimited on RETEK_INDEX' || ' ; '    || chr ( 13 ) ||
 'grant alter session,     analyze any, create any view,       create library,create procedure, create sequence,
       create session,  create synonym,    create table,       create trigger,     create view,      create job,delete any table,
   drop any procedure,   drop any view,  drop any table,execute any procedure,execute any type,insert any table,
  select any sequence,select any table,update any table,select any dictionary
to ' || ru.user_id || ' ;' || chr ( 13 ) ||
 
  'grant select on sys.dba_role_privs to ' || ru.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_jobs to '       || ru.user_id || ';' ||chr ( 13) ||
  'grant select on sys.dba_roles to '      || ru.user_id || ';' ||chr ( 13) ||
  'grant execute on dbms_rls to '          || ru.user_id || ';' ||chr ( 13) ||
  'grant execute on sys.dbms_crypto to '   || ru.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_sys_privs to '  || ru.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_alert to '    || ru.user_id || ';' ||chr ( 13) ||
  'grant execute on sys.dbms_lock to '     || ru.user_id || ';' ||chr ( 13) ||
  'grant execute on sys.dbms_system to '   || ru.user_id || ';' ||chr( 13) ||
  'grant AQ_ADMINISTRATOR_ROLE to '        || ru.user_id || ';' ||chr ( 13) ||
  'grant execute on DBMS_AQ to '           || ru.user_id || ';' ||chr ( 13) ||
  'grant execute on DBMS_AQADM to '        || ru.user_id || ';'
  FROM rainy_user ru
  WHERE RU.ID BETWEEN 2199 AND 2225 ;

--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
--insert into rainy_user(user_id,user_name,id) values('R7102050056','贺永红','2200');
--insert into rainy_user(user_id,user_name,id) values('R8202170035','傅海波','2206');
SELECT * FROM RAINY_USER
WHERE USER_ID IN( 'R7102050056','R8202170035') FOR UPDATE;

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
   AND RU.ID BETWEEN 2199 AND 2225;

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
AND RU.ID BETWEEN 2199 AND 2225 ;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2199 AND 2225 ;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2199 AND 2225 ;   
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2199 AND 2225);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2199 AND 2225);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2199 AND 2225);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2199 AND 2225);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2199 AND 2225);


insert into rainy_user_position(user_id,position_id) values('R9810103921',85);
insert into rainy_user_position(user_id,position_id) values('R9810103921',86);
insert into rainy_user_position(user_id,position_id) values('R7102050056',85);
insert into rainy_user_position(user_id,position_id) values('R7102050056',86);
insert into rainy_user_position(user_id,position_id) values('R7810272056',85);
insert into rainy_user_position(user_id,position_id) values('R7810272056',86);
insert into rainy_user_position(user_id,position_id) values('R710510066X',85);
insert into rainy_user_position(user_id,position_id) values('R710510066X',86);
insert into rainy_user_position(user_id,position_id) values('R7804240014',85);
insert into rainy_user_position(user_id,position_id) values('R7804240014',86);
insert into rainy_user_position(user_id,position_id) values('R7807011549',85);
insert into rainy_user_position(user_id,position_id) values('R7807011549',86);
insert into rainy_user_position(user_id,position_id) values('R8406243343',85);
insert into rainy_user_position(user_id,position_id) values('R8406243343',86);
insert into rainy_user_position(user_id,position_id) values('R8202170035',85);
insert into rainy_user_position(user_id,position_id) values('R8202170035',86);
insert into rainy_user_position(user_id,position_id) values('R7411212861',85);
insert into rainy_user_position(user_id,position_id) values('R7411212861',86);
insert into rainy_user_position(user_id,position_id) values('R740522601X',85);
insert into rainy_user_position(user_id,position_id) values('R740522601X',86);
insert into rainy_user_position(user_id,position_id) values('R8503121531',85);
insert into rainy_user_position(user_id,position_id) values('R8503121531',86);
insert into rainy_user_position(user_id,position_id) values('R8310068032',85);
insert into rainy_user_position(user_id,position_id) values('R8310068032',86);
insert into rainy_user_position(user_id,position_id) values('R7201290926',85);
insert into rainy_user_position(user_id,position_id) values('R7201290926',86);
insert into rainy_user_position(user_id,position_id) values('R6610232546',85);
insert into rainy_user_position(user_id,position_id) values('R6610232546',86);
insert into rainy_user_position(user_id,position_id) values('R8902190017',85);
insert into rainy_user_position(user_id,position_id) values('R8902190017',86);
insert into rainy_user_position(user_id,position_id) values('R7506300047',85);
insert into rainy_user_position(user_id,position_id) values('R7506300047',86);
insert into rainy_user_position(user_id,position_id) values('R7208164442',85);
insert into rainy_user_position(user_id,position_id) values('R7208164442',86);
insert into rainy_user_position(user_id,position_id) values('R6912262820',85);
insert into rainy_user_position(user_id,position_id) values('R6912262820',86);
insert into rainy_user_position(user_id,position_id) values('R8809011017',85);
insert into rainy_user_position(user_id,position_id) values('R8809011017',86);
insert into rainy_user_position(user_id,position_id) values('R8907090015',85);
insert into rainy_user_position(user_id,position_id) values('R8907090015',86);
insert into rainy_user_position(user_id,position_id) values('R6212030919',85);
insert into rainy_user_position(user_id,position_id) values('R6212030919',86);
insert into rainy_user_position(user_id,position_id) values('R7410240860',85);
insert into rainy_user_position(user_id,position_id) values('R7410240860',86);
insert into rainy_user_position(user_id,position_id) values('R7210060021',85);
insert into rainy_user_position(user_id,position_id) values('R7210060021',86);
insert into rainy_user_position(user_id,position_id) values('R7209115427',85);
insert into rainy_user_position(user_id,position_id) values('R7209115427',86);
insert into rainy_user_position(user_id,position_id) values('R7012142413',85);
insert into rainy_user_position(user_id,position_id) values('R7012142413',86);
insert into rainy_user_position(user_id,position_id) values('R7607310519',85);
insert into rainy_user_position(user_id,position_id) values('R7607310519',86);
insert into rainy_user_position(user_id,position_id) values('R830303251X',85);
insert into rainy_user_position(user_id,position_id) values('R830303251X',86);


insert into rainy_user_merch(user_id,merch) values('R9810103921','12');
insert into rainy_user_merch(user_id,merch) values('R9810103921','13');
insert into rainy_user_merch(user_id,merch) values('R9810103921','14');
insert into rainy_user_merch(user_id,merch) values('R9810103921','15');
insert into rainy_user_merch(user_id,merch) values('R9810103921','16');
insert into rainy_user_merch(user_id,merch) values('R9810103921','17');
insert into rainy_user_merch(user_id,merch) values('R9810103921','18');
insert into rainy_user_merch(user_id,merch) values('R9810103921','19');
insert into rainy_user_merch(user_id,merch) values('R9810103921','21');
insert into rainy_user_merch(user_id,merch) values('R9810103921','22');
insert into rainy_user_merch(user_id,merch) values('R9810103921','23');
insert into rainy_user_merch(user_id,merch) values('R9810103921','24');
insert into rainy_user_merch(user_id,merch) values('R9810103921','25');
insert into rainy_user_merch(user_id,merch) values('R9810103921','26');
insert into rainy_user_merch(user_id,merch) values('R9810103921','29');
insert into rainy_user_merch(user_id,merch) values('R9810103921','76');
insert into rainy_user_merch(user_id,merch) values('R7102050056','27');
insert into rainy_user_merch(user_id,merch) values('R7102050056','30');
insert into rainy_user_merch(user_id,merch) values('R7102050056','31');
insert into rainy_user_merch(user_id,merch) values('R7102050056','32');
insert into rainy_user_merch(user_id,merch) values('R7102050056','33');
insert into rainy_user_merch(user_id,merch) values('R7102050056','34');
insert into rainy_user_merch(user_id,merch) values('R7102050056','35');
insert into rainy_user_merch(user_id,merch) values('R7102050056','36');
insert into rainy_user_merch(user_id,merch) values('R7102050056','37');
insert into rainy_user_merch(user_id,merch) values('R7102050056','38');
insert into rainy_user_merch(user_id,merch) values('R7102050056','39');
insert into rainy_user_merch(user_id,merch) values('R7102050056','40');
insert into rainy_user_merch(user_id,merch) values('R7102050056','41');
insert into rainy_user_merch(user_id,merch) values('R7102050056','42');
insert into rainy_user_merch(user_id,merch) values('R7810272056','27');
insert into rainy_user_merch(user_id,merch) values('R7810272056','30');
insert into rainy_user_merch(user_id,merch) values('R7810272056','31');
insert into rainy_user_merch(user_id,merch) values('R7810272056','32');
insert into rainy_user_merch(user_id,merch) values('R7810272056','33');
insert into rainy_user_merch(user_id,merch) values('R7810272056','34');
insert into rainy_user_merch(user_id,merch) values('R7810272056','35');
insert into rainy_user_merch(user_id,merch) values('R7810272056','36');
insert into rainy_user_merch(user_id,merch) values('R7810272056','37');
insert into rainy_user_merch(user_id,merch) values('R7810272056','38');
insert into rainy_user_merch(user_id,merch) values('R7810272056','39');
insert into rainy_user_merch(user_id,merch) values('R7810272056','40');
insert into rainy_user_merch(user_id,merch) values('R7810272056','41');
insert into rainy_user_merch(user_id,merch) values('R7810272056','42');
insert into rainy_user_merch(user_id,merch) values('R710510066X','12');
insert into rainy_user_merch(user_id,merch) values('R710510066X','13');
insert into rainy_user_merch(user_id,merch) values('R710510066X','14');
insert into rainy_user_merch(user_id,merch) values('R710510066X','15');
insert into rainy_user_merch(user_id,merch) values('R710510066X','16');
insert into rainy_user_merch(user_id,merch) values('R710510066X','17');
insert into rainy_user_merch(user_id,merch) values('R710510066X','18');
insert into rainy_user_merch(user_id,merch) values('R710510066X','19');
insert into rainy_user_merch(user_id,merch) values('R710510066X','21');
insert into rainy_user_merch(user_id,merch) values('R710510066X','22');
insert into rainy_user_merch(user_id,merch) values('R710510066X','23');
insert into rainy_user_merch(user_id,merch) values('R710510066X','24');
insert into rainy_user_merch(user_id,merch) values('R710510066X','25');
insert into rainy_user_merch(user_id,merch) values('R710510066X','26');
insert into rainy_user_merch(user_id,merch) values('R710510066X','29');
insert into rainy_user_merch(user_id,merch) values('R710510066X','76');
insert into rainy_user_merch(user_id,merch) values('R7804240014','27');
insert into rainy_user_merch(user_id,merch) values('R7804240014','30');
insert into rainy_user_merch(user_id,merch) values('R7804240014','31');
insert into rainy_user_merch(user_id,merch) values('R7804240014','32');
insert into rainy_user_merch(user_id,merch) values('R7804240014','33');
insert into rainy_user_merch(user_id,merch) values('R7804240014','34');
insert into rainy_user_merch(user_id,merch) values('R7804240014','35');
insert into rainy_user_merch(user_id,merch) values('R7804240014','36');
insert into rainy_user_merch(user_id,merch) values('R7804240014','37');
insert into rainy_user_merch(user_id,merch) values('R7804240014','38');
insert into rainy_user_merch(user_id,merch) values('R7804240014','39');
insert into rainy_user_merch(user_id,merch) values('R7804240014','40');
insert into rainy_user_merch(user_id,merch) values('R7804240014','41');
insert into rainy_user_merch(user_id,merch) values('R7804240014','42');
insert into rainy_user_merch(user_id,merch) values('R7807011549','12');
insert into rainy_user_merch(user_id,merch) values('R7807011549','13');
insert into rainy_user_merch(user_id,merch) values('R7807011549','14');
insert into rainy_user_merch(user_id,merch) values('R7807011549','15');
insert into rainy_user_merch(user_id,merch) values('R7807011549','16');
insert into rainy_user_merch(user_id,merch) values('R7807011549','17');
insert into rainy_user_merch(user_id,merch) values('R7807011549','18');
insert into rainy_user_merch(user_id,merch) values('R7807011549','19');
insert into rainy_user_merch(user_id,merch) values('R7807011549','21');
insert into rainy_user_merch(user_id,merch) values('R7807011549','22');
insert into rainy_user_merch(user_id,merch) values('R7807011549','23');
insert into rainy_user_merch(user_id,merch) values('R7807011549','24');
insert into rainy_user_merch(user_id,merch) values('R7807011549','25');
insert into rainy_user_merch(user_id,merch) values('R7807011549','26');
insert into rainy_user_merch(user_id,merch) values('R7807011549','29');
insert into rainy_user_merch(user_id,merch) values('R7807011549','76');
insert into rainy_user_merch(user_id,merch) values('R8406243343','12');
insert into rainy_user_merch(user_id,merch) values('R8406243343','13');
insert into rainy_user_merch(user_id,merch) values('R8406243343','14');
insert into rainy_user_merch(user_id,merch) values('R8406243343','15');
insert into rainy_user_merch(user_id,merch) values('R8406243343','16');
insert into rainy_user_merch(user_id,merch) values('R8406243343','17');
insert into rainy_user_merch(user_id,merch) values('R8406243343','18');
insert into rainy_user_merch(user_id,merch) values('R8406243343','19');
insert into rainy_user_merch(user_id,merch) values('R8406243343','21');
insert into rainy_user_merch(user_id,merch) values('R8406243343','22');
insert into rainy_user_merch(user_id,merch) values('R8406243343','23');
insert into rainy_user_merch(user_id,merch) values('R8406243343','24');
insert into rainy_user_merch(user_id,merch) values('R8406243343','25');
insert into rainy_user_merch(user_id,merch) values('R8406243343','26');
insert into rainy_user_merch(user_id,merch) values('R8406243343','29');
insert into rainy_user_merch(user_id,merch) values('R8406243343','76');
insert into rainy_user_merch(user_id,merch) values('R8202170035','27');
insert into rainy_user_merch(user_id,merch) values('R8202170035','30');
insert into rainy_user_merch(user_id,merch) values('R8202170035','31');
insert into rainy_user_merch(user_id,merch) values('R8202170035','32');
insert into rainy_user_merch(user_id,merch) values('R8202170035','33');
insert into rainy_user_merch(user_id,merch) values('R8202170035','34');
insert into rainy_user_merch(user_id,merch) values('R8202170035','35');
insert into rainy_user_merch(user_id,merch) values('R8202170035','36');
insert into rainy_user_merch(user_id,merch) values('R8202170035','37');
insert into rainy_user_merch(user_id,merch) values('R8202170035','38');
insert into rainy_user_merch(user_id,merch) values('R8202170035','39');
insert into rainy_user_merch(user_id,merch) values('R8202170035','40');
insert into rainy_user_merch(user_id,merch) values('R8202170035','41');
insert into rainy_user_merch(user_id,merch) values('R8202170035','42');
insert into rainy_user_merch(user_id,merch) values('R7411212861','12');
insert into rainy_user_merch(user_id,merch) values('R7411212861','13');
insert into rainy_user_merch(user_id,merch) values('R7411212861','14');
insert into rainy_user_merch(user_id,merch) values('R7411212861','15');
insert into rainy_user_merch(user_id,merch) values('R7411212861','16');
insert into rainy_user_merch(user_id,merch) values('R7411212861','17');
insert into rainy_user_merch(user_id,merch) values('R7411212861','18');
insert into rainy_user_merch(user_id,merch) values('R7411212861','19');
insert into rainy_user_merch(user_id,merch) values('R7411212861','21');
insert into rainy_user_merch(user_id,merch) values('R7411212861','22');
insert into rainy_user_merch(user_id,merch) values('R7411212861','23');
insert into rainy_user_merch(user_id,merch) values('R7411212861','24');
insert into rainy_user_merch(user_id,merch) values('R7411212861','25');
insert into rainy_user_merch(user_id,merch) values('R7411212861','26');
insert into rainy_user_merch(user_id,merch) values('R7411212861','29');
insert into rainy_user_merch(user_id,merch) values('R7411212861','76');
insert into rainy_user_merch(user_id,merch) values('R740522601X','27');
insert into rainy_user_merch(user_id,merch) values('R740522601X','30');
insert into rainy_user_merch(user_id,merch) values('R740522601X','31');
insert into rainy_user_merch(user_id,merch) values('R740522601X','32');
insert into rainy_user_merch(user_id,merch) values('R740522601X','33');
insert into rainy_user_merch(user_id,merch) values('R740522601X','34');
insert into rainy_user_merch(user_id,merch) values('R740522601X','35');
insert into rainy_user_merch(user_id,merch) values('R740522601X','36');
insert into rainy_user_merch(user_id,merch) values('R740522601X','37');
insert into rainy_user_merch(user_id,merch) values('R740522601X','38');
insert into rainy_user_merch(user_id,merch) values('R740522601X','39');
insert into rainy_user_merch(user_id,merch) values('R740522601X','40');
insert into rainy_user_merch(user_id,merch) values('R740522601X','41');
insert into rainy_user_merch(user_id,merch) values('R740522601X','42');
insert into rainy_user_merch(user_id,merch) values('R8503121531','12');
insert into rainy_user_merch(user_id,merch) values('R8503121531','13');
insert into rainy_user_merch(user_id,merch) values('R8503121531','14');
insert into rainy_user_merch(user_id,merch) values('R8503121531','15');
insert into rainy_user_merch(user_id,merch) values('R8503121531','16');
insert into rainy_user_merch(user_id,merch) values('R8503121531','17');
insert into rainy_user_merch(user_id,merch) values('R8503121531','18');
insert into rainy_user_merch(user_id,merch) values('R8503121531','19');
insert into rainy_user_merch(user_id,merch) values('R8503121531','21');
insert into rainy_user_merch(user_id,merch) values('R8503121531','22');
insert into rainy_user_merch(user_id,merch) values('R8503121531','23');
insert into rainy_user_merch(user_id,merch) values('R8503121531','24');
insert into rainy_user_merch(user_id,merch) values('R8503121531','25');
insert into rainy_user_merch(user_id,merch) values('R8503121531','26');
insert into rainy_user_merch(user_id,merch) values('R8503121531','29');
insert into rainy_user_merch(user_id,merch) values('R8503121531','76');
insert into rainy_user_merch(user_id,merch) values('R8310068032','27');
insert into rainy_user_merch(user_id,merch) values('R8310068032','30');
insert into rainy_user_merch(user_id,merch) values('R8310068032','31');
insert into rainy_user_merch(user_id,merch) values('R8310068032','32');
insert into rainy_user_merch(user_id,merch) values('R8310068032','33');
insert into rainy_user_merch(user_id,merch) values('R8310068032','34');
insert into rainy_user_merch(user_id,merch) values('R8310068032','35');
insert into rainy_user_merch(user_id,merch) values('R8310068032','36');
insert into rainy_user_merch(user_id,merch) values('R8310068032','37');
insert into rainy_user_merch(user_id,merch) values('R8310068032','38');
insert into rainy_user_merch(user_id,merch) values('R8310068032','39');
insert into rainy_user_merch(user_id,merch) values('R8310068032','40');
insert into rainy_user_merch(user_id,merch) values('R8310068032','41');
insert into rainy_user_merch(user_id,merch) values('R8310068032','42');
insert into rainy_user_merch(user_id,merch) values('R7201290926','27');
insert into rainy_user_merch(user_id,merch) values('R7201290926','30');
insert into rainy_user_merch(user_id,merch) values('R7201290926','31');
insert into rainy_user_merch(user_id,merch) values('R7201290926','32');
insert into rainy_user_merch(user_id,merch) values('R7201290926','33');
insert into rainy_user_merch(user_id,merch) values('R7201290926','34');
insert into rainy_user_merch(user_id,merch) values('R7201290926','35');
insert into rainy_user_merch(user_id,merch) values('R7201290926','36');
insert into rainy_user_merch(user_id,merch) values('R7201290926','37');
insert into rainy_user_merch(user_id,merch) values('R7201290926','38');
insert into rainy_user_merch(user_id,merch) values('R7201290926','39');
insert into rainy_user_merch(user_id,merch) values('R7201290926','40');
insert into rainy_user_merch(user_id,merch) values('R7201290926','41');
insert into rainy_user_merch(user_id,merch) values('R7201290926','42');
insert into rainy_user_merch(user_id,merch) values('R6610232546','12');
insert into rainy_user_merch(user_id,merch) values('R6610232546','13');
insert into rainy_user_merch(user_id,merch) values('R6610232546','14');
insert into rainy_user_merch(user_id,merch) values('R6610232546','15');
insert into rainy_user_merch(user_id,merch) values('R6610232546','16');
insert into rainy_user_merch(user_id,merch) values('R6610232546','17');
insert into rainy_user_merch(user_id,merch) values('R6610232546','18');
insert into rainy_user_merch(user_id,merch) values('R6610232546','19');
insert into rainy_user_merch(user_id,merch) values('R6610232546','21');
insert into rainy_user_merch(user_id,merch) values('R6610232546','22');
insert into rainy_user_merch(user_id,merch) values('R6610232546','23');
insert into rainy_user_merch(user_id,merch) values('R6610232546','24');
insert into rainy_user_merch(user_id,merch) values('R6610232546','25');
insert into rainy_user_merch(user_id,merch) values('R6610232546','26');
insert into rainy_user_merch(user_id,merch) values('R6610232546','29');
insert into rainy_user_merch(user_id,merch) values('R6610232546','76');
insert into rainy_user_merch(user_id,merch) values('R8902190017','12');
insert into rainy_user_merch(user_id,merch) values('R8902190017','13');
insert into rainy_user_merch(user_id,merch) values('R8902190017','14');
insert into rainy_user_merch(user_id,merch) values('R8902190017','15');
insert into rainy_user_merch(user_id,merch) values('R8902190017','16');
insert into rainy_user_merch(user_id,merch) values('R8902190017','17');
insert into rainy_user_merch(user_id,merch) values('R8902190017','18');
insert into rainy_user_merch(user_id,merch) values('R8902190017','19');
insert into rainy_user_merch(user_id,merch) values('R8902190017','21');
insert into rainy_user_merch(user_id,merch) values('R8902190017','22');
insert into rainy_user_merch(user_id,merch) values('R8902190017','23');
insert into rainy_user_merch(user_id,merch) values('R8902190017','24');
insert into rainy_user_merch(user_id,merch) values('R8902190017','25');
insert into rainy_user_merch(user_id,merch) values('R8902190017','26');
insert into rainy_user_merch(user_id,merch) values('R8902190017','29');
insert into rainy_user_merch(user_id,merch) values('R8902190017','76');
insert into rainy_user_merch(user_id,merch) values('R7506300047','27');
insert into rainy_user_merch(user_id,merch) values('R7506300047','30');
insert into rainy_user_merch(user_id,merch) values('R7506300047','31');
insert into rainy_user_merch(user_id,merch) values('R7506300047','32');
insert into rainy_user_merch(user_id,merch) values('R7506300047','33');
insert into rainy_user_merch(user_id,merch) values('R7506300047','34');
insert into rainy_user_merch(user_id,merch) values('R7506300047','35');
insert into rainy_user_merch(user_id,merch) values('R7506300047','36');
insert into rainy_user_merch(user_id,merch) values('R7506300047','37');
insert into rainy_user_merch(user_id,merch) values('R7506300047','38');
insert into rainy_user_merch(user_id,merch) values('R7506300047','39');
insert into rainy_user_merch(user_id,merch) values('R7506300047','40');
insert into rainy_user_merch(user_id,merch) values('R7506300047','41');
insert into rainy_user_merch(user_id,merch) values('R7506300047','42');
insert into rainy_user_merch(user_id,merch) values('R7208164442','12');
insert into rainy_user_merch(user_id,merch) values('R7208164442','13');
insert into rainy_user_merch(user_id,merch) values('R7208164442','14');
insert into rainy_user_merch(user_id,merch) values('R7208164442','15');
insert into rainy_user_merch(user_id,merch) values('R7208164442','16');
insert into rainy_user_merch(user_id,merch) values('R7208164442','17');
insert into rainy_user_merch(user_id,merch) values('R7208164442','18');
insert into rainy_user_merch(user_id,merch) values('R7208164442','19');
insert into rainy_user_merch(user_id,merch) values('R7208164442','21');
insert into rainy_user_merch(user_id,merch) values('R7208164442','22');
insert into rainy_user_merch(user_id,merch) values('R7208164442','23');
insert into rainy_user_merch(user_id,merch) values('R7208164442','24');
insert into rainy_user_merch(user_id,merch) values('R7208164442','25');
insert into rainy_user_merch(user_id,merch) values('R7208164442','26');
insert into rainy_user_merch(user_id,merch) values('R7208164442','29');
insert into rainy_user_merch(user_id,merch) values('R7208164442','76');
insert into rainy_user_merch(user_id,merch) values('R6912262820','12');
insert into rainy_user_merch(user_id,merch) values('R6912262820','13');
insert into rainy_user_merch(user_id,merch) values('R6912262820','14');
insert into rainy_user_merch(user_id,merch) values('R6912262820','15');
insert into rainy_user_merch(user_id,merch) values('R6912262820','16');
insert into rainy_user_merch(user_id,merch) values('R6912262820','17');
insert into rainy_user_merch(user_id,merch) values('R6912262820','18');
insert into rainy_user_merch(user_id,merch) values('R6912262820','19');
insert into rainy_user_merch(user_id,merch) values('R6912262820','21');
insert into rainy_user_merch(user_id,merch) values('R6912262820','22');
insert into rainy_user_merch(user_id,merch) values('R6912262820','23');
insert into rainy_user_merch(user_id,merch) values('R6912262820','24');
insert into rainy_user_merch(user_id,merch) values('R6912262820','25');
insert into rainy_user_merch(user_id,merch) values('R6912262820','26');
insert into rainy_user_merch(user_id,merch) values('R6912262820','29');
insert into rainy_user_merch(user_id,merch) values('R6912262820','76');
insert into rainy_user_merch(user_id,merch) values('R8809011017','27');
insert into rainy_user_merch(user_id,merch) values('R8809011017','30');
insert into rainy_user_merch(user_id,merch) values('R8809011017','31');
insert into rainy_user_merch(user_id,merch) values('R8809011017','32');
insert into rainy_user_merch(user_id,merch) values('R8809011017','33');
insert into rainy_user_merch(user_id,merch) values('R8809011017','34');
insert into rainy_user_merch(user_id,merch) values('R8809011017','35');
insert into rainy_user_merch(user_id,merch) values('R8809011017','36');
insert into rainy_user_merch(user_id,merch) values('R8809011017','37');
insert into rainy_user_merch(user_id,merch) values('R8809011017','38');
insert into rainy_user_merch(user_id,merch) values('R8809011017','39');
insert into rainy_user_merch(user_id,merch) values('R8809011017','40');
insert into rainy_user_merch(user_id,merch) values('R8809011017','41');
insert into rainy_user_merch(user_id,merch) values('R8809011017','42');
insert into rainy_user_merch(user_id,merch) values('R8907090015','12');
insert into rainy_user_merch(user_id,merch) values('R8907090015','13');
insert into rainy_user_merch(user_id,merch) values('R8907090015','14');
insert into rainy_user_merch(user_id,merch) values('R8907090015','15');
insert into rainy_user_merch(user_id,merch) values('R8907090015','16');
insert into rainy_user_merch(user_id,merch) values('R8907090015','17');
insert into rainy_user_merch(user_id,merch) values('R8907090015','18');
insert into rainy_user_merch(user_id,merch) values('R8907090015','19');
insert into rainy_user_merch(user_id,merch) values('R8907090015','21');
insert into rainy_user_merch(user_id,merch) values('R8907090015','22');
insert into rainy_user_merch(user_id,merch) values('R8907090015','23');
insert into rainy_user_merch(user_id,merch) values('R8907090015','24');
insert into rainy_user_merch(user_id,merch) values('R8907090015','25');
insert into rainy_user_merch(user_id,merch) values('R8907090015','26');
insert into rainy_user_merch(user_id,merch) values('R8907090015','29');
insert into rainy_user_merch(user_id,merch) values('R8907090015','76');
insert into rainy_user_merch(user_id,merch) values('R6212030919','27');
insert into rainy_user_merch(user_id,merch) values('R6212030919','30');
insert into rainy_user_merch(user_id,merch) values('R6212030919','31');
insert into rainy_user_merch(user_id,merch) values('R6212030919','32');
insert into rainy_user_merch(user_id,merch) values('R6212030919','33');
insert into rainy_user_merch(user_id,merch) values('R6212030919','34');
insert into rainy_user_merch(user_id,merch) values('R6212030919','35');
insert into rainy_user_merch(user_id,merch) values('R6212030919','36');
insert into rainy_user_merch(user_id,merch) values('R6212030919','37');
insert into rainy_user_merch(user_id,merch) values('R6212030919','38');
insert into rainy_user_merch(user_id,merch) values('R6212030919','39');
insert into rainy_user_merch(user_id,merch) values('R6212030919','40');
insert into rainy_user_merch(user_id,merch) values('R6212030919','41');
insert into rainy_user_merch(user_id,merch) values('R6212030919','42');
insert into rainy_user_merch(user_id,merch) values('R7410240860','12');
insert into rainy_user_merch(user_id,merch) values('R7410240860','13');
insert into rainy_user_merch(user_id,merch) values('R7410240860','14');
insert into rainy_user_merch(user_id,merch) values('R7410240860','15');
insert into rainy_user_merch(user_id,merch) values('R7410240860','16');
insert into rainy_user_merch(user_id,merch) values('R7410240860','17');
insert into rainy_user_merch(user_id,merch) values('R7410240860','18');
insert into rainy_user_merch(user_id,merch) values('R7410240860','19');
insert into rainy_user_merch(user_id,merch) values('R7410240860','21');
insert into rainy_user_merch(user_id,merch) values('R7410240860','22');
insert into rainy_user_merch(user_id,merch) values('R7410240860','23');
insert into rainy_user_merch(user_id,merch) values('R7410240860','24');
insert into rainy_user_merch(user_id,merch) values('R7410240860','25');
insert into rainy_user_merch(user_id,merch) values('R7410240860','26');
insert into rainy_user_merch(user_id,merch) values('R7410240860','29');
insert into rainy_user_merch(user_id,merch) values('R7410240860','76');
insert into rainy_user_merch(user_id,merch) values('R7210060021','27');
insert into rainy_user_merch(user_id,merch) values('R7210060021','30');
insert into rainy_user_merch(user_id,merch) values('R7210060021','31');
insert into rainy_user_merch(user_id,merch) values('R7210060021','32');
insert into rainy_user_merch(user_id,merch) values('R7210060021','33');
insert into rainy_user_merch(user_id,merch) values('R7210060021','34');
insert into rainy_user_merch(user_id,merch) values('R7210060021','35');
insert into rainy_user_merch(user_id,merch) values('R7210060021','36');
insert into rainy_user_merch(user_id,merch) values('R7210060021','37');
insert into rainy_user_merch(user_id,merch) values('R7210060021','38');
insert into rainy_user_merch(user_id,merch) values('R7210060021','39');
insert into rainy_user_merch(user_id,merch) values('R7210060021','40');
insert into rainy_user_merch(user_id,merch) values('R7210060021','41');
insert into rainy_user_merch(user_id,merch) values('R7210060021','42');
insert into rainy_user_merch(user_id,merch) values('R7209115427','12');
insert into rainy_user_merch(user_id,merch) values('R7209115427','13');
insert into rainy_user_merch(user_id,merch) values('R7209115427','14');
insert into rainy_user_merch(user_id,merch) values('R7209115427','15');
insert into rainy_user_merch(user_id,merch) values('R7209115427','16');
insert into rainy_user_merch(user_id,merch) values('R7209115427','17');
insert into rainy_user_merch(user_id,merch) values('R7209115427','18');
insert into rainy_user_merch(user_id,merch) values('R7209115427','19');
insert into rainy_user_merch(user_id,merch) values('R7209115427','21');
insert into rainy_user_merch(user_id,merch) values('R7209115427','22');
insert into rainy_user_merch(user_id,merch) values('R7209115427','23');
insert into rainy_user_merch(user_id,merch) values('R7209115427','24');
insert into rainy_user_merch(user_id,merch) values('R7209115427','25');
insert into rainy_user_merch(user_id,merch) values('R7209115427','26');
insert into rainy_user_merch(user_id,merch) values('R7209115427','29');
insert into rainy_user_merch(user_id,merch) values('R7209115427','76');
insert into rainy_user_merch(user_id,merch) values('R7012142413','27');
insert into rainy_user_merch(user_id,merch) values('R7012142413','30');
insert into rainy_user_merch(user_id,merch) values('R7012142413','31');
insert into rainy_user_merch(user_id,merch) values('R7012142413','32');
insert into rainy_user_merch(user_id,merch) values('R7012142413','33');
insert into rainy_user_merch(user_id,merch) values('R7012142413','34');
insert into rainy_user_merch(user_id,merch) values('R7012142413','35');
insert into rainy_user_merch(user_id,merch) values('R7012142413','36');
insert into rainy_user_merch(user_id,merch) values('R7012142413','37');
insert into rainy_user_merch(user_id,merch) values('R7012142413','38');
insert into rainy_user_merch(user_id,merch) values('R7012142413','39');
insert into rainy_user_merch(user_id,merch) values('R7012142413','40');
insert into rainy_user_merch(user_id,merch) values('R7012142413','41');
insert into rainy_user_merch(user_id,merch) values('R7012142413','42');
insert into rainy_user_merch(user_id,merch) values('R7607310519','12');
insert into rainy_user_merch(user_id,merch) values('R7607310519','13');
insert into rainy_user_merch(user_id,merch) values('R7607310519','14');
insert into rainy_user_merch(user_id,merch) values('R7607310519','15');
insert into rainy_user_merch(user_id,merch) values('R7607310519','16');
insert into rainy_user_merch(user_id,merch) values('R7607310519','17');
insert into rainy_user_merch(user_id,merch) values('R7607310519','18');
insert into rainy_user_merch(user_id,merch) values('R7607310519','19');
insert into rainy_user_merch(user_id,merch) values('R7607310519','21');
insert into rainy_user_merch(user_id,merch) values('R7607310519','22');
insert into rainy_user_merch(user_id,merch) values('R7607310519','23');
insert into rainy_user_merch(user_id,merch) values('R7607310519','24');
insert into rainy_user_merch(user_id,merch) values('R7607310519','25');
insert into rainy_user_merch(user_id,merch) values('R7607310519','26');
insert into rainy_user_merch(user_id,merch) values('R7607310519','29');
insert into rainy_user_merch(user_id,merch) values('R7607310519','76');
insert into rainy_user_merch(user_id,merch) values('R830303251X','27');
insert into rainy_user_merch(user_id,merch) values('R830303251X','30');
insert into rainy_user_merch(user_id,merch) values('R830303251X','31');
insert into rainy_user_merch(user_id,merch) values('R830303251X','32');
insert into rainy_user_merch(user_id,merch) values('R830303251X','33');
insert into rainy_user_merch(user_id,merch) values('R830303251X','34');
insert into rainy_user_merch(user_id,merch) values('R830303251X','35');
insert into rainy_user_merch(user_id,merch) values('R830303251X','36');
insert into rainy_user_merch(user_id,merch) values('R830303251X','37');
insert into rainy_user_merch(user_id,merch) values('R830303251X','38');
insert into rainy_user_merch(user_id,merch) values('R830303251X','39');
insert into rainy_user_merch(user_id,merch) values('R830303251X','40');
insert into rainy_user_merch(user_id,merch) values('R830303251X','41');
insert into rainy_user_merch(user_id,merch) values('R830303251X','42');


insert into rainy_user_loc (user_id,loc)values('R9810103921','120111');
insert into rainy_user_loc (user_id,loc)values('R7102050056','120111');
insert into rainy_user_loc (user_id,loc)values('R7810272056','120088');
insert into rainy_user_loc (user_id,loc)values('R710510066X','120088');
insert into rainy_user_loc (user_id,loc)values('R7804240014','120174');
insert into rainy_user_loc (user_id,loc)values('R7807011549','120174');
insert into rainy_user_loc (user_id,loc)values('R8406243343','120044');
insert into rainy_user_loc (user_id,loc)values('R8202170035','120044');
insert into rainy_user_loc (user_id,loc)values('R7411212861','120043');
insert into rainy_user_loc (user_id,loc)values('R740522601X','120043');
insert into rainy_user_loc (user_id,loc)values('R8503121531','120138');
insert into rainy_user_loc (user_id,loc)values('R8310068032','120138');
insert into rainy_user_loc (user_id,loc)values('R7201290926','120127');
insert into rainy_user_loc (user_id,loc)values('R6610232546','120127');
insert into rainy_user_loc (user_id,loc)values('R8902190017','120152');
insert into rainy_user_loc (user_id,loc)values('R7506300047','120152');
insert into rainy_user_loc (user_id,loc)values('R7208164442','120073');
insert into rainy_user_loc (user_id,loc)values('R6912262820','120073');
insert into rainy_user_loc (user_id,loc)values('R8809011017','120073');
insert into rainy_user_loc (user_id,loc)values('R8907090015','120084');
insert into rainy_user_loc (user_id,loc)values('R6212030919','120084');
insert into rainy_user_loc (user_id,loc)values('R7410240860','120180');
insert into rainy_user_loc (user_id,loc)values('R7210060021','120180');
insert into rainy_user_loc (user_id,loc)values('R7209115427','120148');
insert into rainy_user_loc (user_id,loc)values('R7012142413','120148');
insert into rainy_user_loc (user_id,loc)values('R7607310519','120092');
insert into rainy_user_loc (user_id,loc)values('R830303251X','120092');



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
   AND RU.ID BETWEEN 2199 AND 2225;

--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2199 AND 2225
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2199 AND 2225 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2199 AND 2225
    --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
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
         AND RU.ID BETWEEN 2199 AND 2225
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
uid: ' || ru.user_id || chr (13 ) || 'cn:' || ru.user_id || chr (13 ) ||
        'sn: ' || ru.user_id || chr ( 13) || 'description:' || rp.position ||
        chr( 13 ) || 'givenname: ' || ru.user_id || chr (13 ) || 'superUser: FALSE
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
        ( SELECT rul.loc
           FROM rainy_user_loc rul
          WHERE rul.user_id = ru.user_id
            AND rownum = 1) || ',cn=SIMStores,cn=SIM,dc=bbg,dc=com
userpassword: ' || ru.password || chr (13 ) ||
       to_char ( ( SELECT   wm_concat( 'userstores: storeId=' || rull.loc ||',cn=SIMStores,cn=SIM,dc=bbg' ||chr ( 13 ))
     
           FROM rainy_user_loc rull
          WHERE rull.user_id = ru.user_id
          GROUP BY rull.user_id ))
  FROM rainy_user ru , rainy_user_position rup , rainy_position rp
-- rainy_user_loc      rull
-- RAINY_LOC           rl
WHERE ru.user_id = rup.user_id
   AND rup.position_id = rp.position_id
--注意下面条件，当用户地点权限为ALL时才是=，不是ALL就是<>
   AND EXISTS( SELECT 1 FROM RAINY_USER_LOC RULL WHERE RULL.USER_ID=RU.USER_ID AND RULL.LOC<> 'ALL')
   --AND ru.user_id NOT IN (SELECT rull.user_id FROM rainy_user_loc rull WHERE rull.loc <> 'ALL')
   AND RU.ID BETWEEN 2199 AND 2225;

--SIM系统导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--注意：userRoleStores为ALL时要替换。。。替换整行。。。
SELECT rr.role_name, ru.user_id, 'dn: roleName=' || rr.role_name || ',cn=' || ru.user_id ||
        ',cn=Users,dc=bbg
changetype: add
objectclass: simUserRole
roleName: ' || rr.role_name || chr (13 ) || 'userRole: roleName=' ||
        rr.role_name || ',cn=SIMRoles,cn=SIM,dc=bbg
userRoleStores: ' || wm_concat( 'storeId=' || rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg' ||chr ( 13 ))
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
AND RU.ID BETWEEN 2199 AND 2225
GROUP BY    rr.role_name, ru.user_id;

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
AND RU.ID BETWEEN 2199 AND 2225 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2199 AND 2225 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2199 AND 2225 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2199 AND 2225 
ORDER BY RU.ID;

