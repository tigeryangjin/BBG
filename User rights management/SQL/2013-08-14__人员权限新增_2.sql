--insert into rainy_user(user_id,user_name,id) values('R8812051740','喻丽娟','2025');
--insert into rainy_user(user_id,user_name,id) values('R8309061528','高翠兰','2026');
--insert into rainy_user(user_id,user_name,id) values('R8306223527','康松英','2027');
insert into rainy_user(user_id,user_name,id) values('R8608232570','范军','2028');
insert into rainy_user(user_id,user_name,id) values('R7403224534','杨凯','2029');
insert into rainy_user(user_id,user_name,id) values('R7709098335','文乐弦','2030');
insert into rainy_user(user_id,user_name,id) values('R7512261544','胡小莉','2031');
insert into rainy_user(user_id,user_name,id) values('R8509179020','刘晓庆','2032');
--insert into rainy_user(user_id,user_name,id) values('R7111011012','胡新平','2033');
insert into rainy_user(user_id,user_name,id) values('R8202172013','王春翔','2034');
insert into rainy_user(user_id,user_name,id) values('R7302022328','蒋先明','2035');
insert into rainy_user(user_id,user_name,id) values('R8410101845','黄凤','2036');
insert into rainy_user(user_id,user_name,id) values('R8112023320','赵莲花','2037');
insert into rainy_user(user_id,user_name,id) values('R7706110320','易月辉','2038');
insert into rainy_user(user_id,user_name,id) values('R8311084409','尤灿红','2039');
insert into rainy_user(user_id,user_name,id) values('R8610040369','刘莉','2040');
insert into rainy_user(user_id,user_name,id) values('R8210272014','黎冯','2041');
insert into rainy_user(user_id,user_name,id) values('R8508185871','贺丽军','2042');
insert into rainy_user(user_id,user_name,id) values('R7801090421','罗伍零','2043');
insert into rainy_user(user_id,user_name,id) values('R8207010519','李文','2044');
insert into rainy_user(user_id,user_name,id) values('R8612313792','　周峰','2045');
insert into rainy_user(user_id,user_name,id) values('R8010130010','易平','2046');
insert into rainy_user(user_id,user_name,id) values('R8510087654','刘宏波','2047');
insert into rainy_user(user_id,user_name,id) values('R7702036768','陶小平','2048');
insert into rainy_user(user_id,user_name,id) values('R8101231440','余细燕','2049');
insert into rainy_user(user_id,user_name,id) values('R8706070030','李鑫','2050');
insert into rainy_user(user_id,user_name,id) values('R8608160612','马丕江','2051');
insert into rainy_user(user_id,user_name,id) values('R8207144811','卜鹏程','2052');
insert into rainy_user(user_id,user_name,id) values('R8712104351','罗蒙','2053');
insert into rainy_user(user_id,user_name,id) values('R7902258511','马勇','2054');
insert into rainy_user(user_id,user_name,id) values('R7612300035','余庆','2055');
insert into rainy_user(user_id,user_name,id) values('R9010098033','彭彪','2056');
insert into rainy_user(user_id,user_name,id) values('R791105072X','龚霞林','2057');
insert into rainy_user(user_id,user_name,id) values('R9111153612','刘毓','2058');
insert into rainy_user(user_id,user_name,id) values('R3750916041','陈文敏','2059');
insert into rainy_user(user_id,user_name,id) values('R7812247625','申燕','2060');
insert into rainy_user(user_id,user_name,id) values('R8206107825','张岚','2061');
insert into rainy_user(user_id,user_name,id) values('R8701170012','陈思','2062');
insert into rainy_user(user_id,user_name,id) values('R8709150042','胡倩倩','2063');
insert into rainy_user(user_id,user_name,id) values('R1790715201','杨先海','2064');
insert into rainy_user(user_id,user_name,id) values('R7808147621','周松妹','2065');
insert into rainy_user(user_id,user_name,id) values('R8412020623','潘芳芳','2066');
insert into rainy_user(user_id,user_name,id) values('R8703013411','段章顺','2067');
insert into rainy_user(user_id,user_name,id) values('R8710110038','滕树景','2068');
insert into rainy_user(user_id,user_name,id) values('R8811072849','杨超','2069');
insert into rainy_user(user_id,user_name,id) values('R7306176339','谢建平','2070');
--insert into rainy_user(user_id,user_name,id) values('R7609268516','王德军','2071');
--insert into rainy_user(user_id,user_name,id) values('R8201170555','谭立焕','2072');
--insert into rainy_user(user_id,user_name,id) values('R7307190015','费仲林','2073');
--insert into rainy_user(user_id,user_name,id) values('R7712053531','艾立强','2074');
--insert into rainy_user(user_id,user_name,id) values('R8012193316','王威','2075');
--insert into rainy_user(user_id,user_name,id) values('R7609015214','戚毅','2076');
--insert into rainy_user(user_id,user_name,id) values('R7502104015','谭永江','2077');
--insert into rainy_user(user_id,user_name,id) values('R7804298473','张建军','2078');
--insert into rainy_user(user_id,user_name,id) values('R7702180034','艾林','2079');
insert into rainy_user(user_id,user_name,id) values('R7606186033','杨俊','2080');
insert into rainy_user(user_id,user_name,id) values('R8904183053','彭涛','2081');

SELECT * FROM RAINY_USER WHERE USER_ID LIKE '%R9111153612%' for update
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
  WHERE RU.ID BETWEEN 2025 AND 2081 ;

--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID in ( 'R8812051740','R8309061528','R8306223527','R7111011012','R7609268516','R8201170555','R7307190015','R7712053531',
'R8012193316','R7609015214','R7502104015','R7804298473','R7702180034') FOR UPDATE;
--insert into rainy_user(user_id,user_name,id) values('R8812051740','喻丽娟','2025');
--insert into rainy_user(user_id,user_name,id) values('R8309061528','高翠兰','2026');
--insert into rainy_user(user_id,user_name,id) values('R8306223527','康松英','2027');
--insert into rainy_user(user_id,user_name,id) values('R7111011012','胡新平','2033');
--insert into rainy_user(user_id,user_name,id) values('R7609268516','王德军','2071');
--insert into rainy_user(user_id,user_name,id) values('R8201170555','谭立焕','2072');
--insert into rainy_user(user_id,user_name,id) values('R7307190015','费仲林','2073');
--insert into rainy_user(user_id,user_name,id) values('R7712053531','艾立强','2074');
--insert into rainy_user(user_id,user_name,id) values('R8012193316','王威','2075');
--insert into rainy_user(user_id,user_name,id) values('R7609015214','戚毅','2076');
--insert into rainy_user(user_id,user_name,id) values('R7502104015','谭永江','2077');
--insert into rainy_user(user_id,user_name,id) values('R7804298473','张建军','2078');
--insert into rainy_user(user_id,user_name,id) values('R7702180034','艾林','2079');
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
   AND RU.ID BETWEEN 2025 AND 2081;

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
AND RU.ID BETWEEN 2025 AND 2081 ;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2025 AND 2081 ;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2025 AND 2081 ;   
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2025 AND 2081);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2025 AND 2081);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2025 AND 2081);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2025 AND 2081);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2025 AND 2081);

insert into rainy_user_position(user_id,position_id) values('R8812051740',72);
insert into rainy_user_position(user_id,position_id) values('R8812051740',119);
insert into rainy_user_position(user_id,position_id) values('R8309061528',72);
insert into rainy_user_position(user_id,position_id) values('R8309061528',119);
insert into rainy_user_position(user_id,position_id) values('R8306223527',86);
insert into rainy_user_position(user_id,position_id) values('R8608232570',85);
insert into rainy_user_position(user_id,position_id) values('R7403224534',88);
insert into rainy_user_position(user_id,position_id) values('R7709098335',93);
insert into rainy_user_position(user_id,position_id) values('R7512261544',90);
insert into rainy_user_position(user_id,position_id) values('R8509179020',88);
insert into rainy_user_position(user_id,position_id) values('R7111011012',84);
insert into rainy_user_position(user_id,position_id) values('R8202172013',85);
insert into rainy_user_position(user_id,position_id) values('R7302022328',86);
insert into rainy_user_position(user_id,position_id) values('R8410101845',86);
insert into rainy_user_position(user_id,position_id) values('R8112023320',86);
insert into rainy_user_position(user_id,position_id) values('R7706110320',86);
insert into rainy_user_position(user_id,position_id) values('R8311084409',86);
insert into rainy_user_position(user_id,position_id) values('R8610040369',95);
insert into rainy_user_position(user_id,position_id) values('R8210272014',86);
insert into rainy_user_position(user_id,position_id) values('R8508185871',85);
insert into rainy_user_position(user_id,position_id) values('R7801090421',86);
insert into rainy_user_position(user_id,position_id) values('R8207010519',93);
insert into rainy_user_position(user_id,position_id) values('R8612313792',86);
insert into rainy_user_position(user_id,position_id) values('R8010130010',86);
insert into rainy_user_position(user_id,position_id) values('R8510087654',86);
insert into rainy_user_position(user_id,position_id) values('R7702036768',86);
insert into rainy_user_position(user_id,position_id) values('R8101231440',86);
insert into rainy_user_position(user_id,position_id) values('R8706070030',86);
insert into rainy_user_position(user_id,position_id) values('R8608160612',86);
insert into rainy_user_position(user_id,position_id) values('R8207144811',86);
insert into rainy_user_position(user_id,position_id) values('R8712104351',86);
insert into rainy_user_position(user_id,position_id) values('R7902258511',85);
insert into rainy_user_position(user_id,position_id) values('R7612300035',86);
insert into rainy_user_position(user_id,position_id) values('R9010098033',93);
insert into rainy_user_position(user_id,position_id) values('R791105072X',84);
insert into rainy_user_position(user_id,position_id) values('R7812247625',84);
insert into rainy_user_position(user_id,position_id) values('R8206107825',86);
insert into rainy_user_position(user_id,position_id) values('R8701170012',85);
insert into rainy_user_position(user_id,position_id) values('R8709150042',86);
insert into rainy_user_position(user_id,position_id) values('R1790715201',86);
insert into rainy_user_position(user_id,position_id) values('R7808147621',86);
insert into rainy_user_position(user_id,position_id) values('R8412020623',86);
insert into rainy_user_position(user_id,position_id) values('R8703013411',86);
insert into rainy_user_position(user_id,position_id) values('R8710110038',86);
insert into rainy_user_position(user_id,position_id) values('R8811072849',91);
insert into rainy_user_position(user_id,position_id) values('R7306176339',86);
insert into rainy_user_position(user_id,position_id) values('R7609268516',83);
insert into rainy_user_position(user_id,position_id) values('R8201170555',83);
insert into rainy_user_position(user_id,position_id) values('R7307190015',83);
insert into rainy_user_position(user_id,position_id) values('R7712053531',83);
insert into rainy_user_position(user_id,position_id) values('R8012193316',83);
insert into rainy_user_position(user_id,position_id) values('R7609015214',83);
insert into rainy_user_position(user_id,position_id) values('R7502104015',83);
insert into rainy_user_position(user_id,position_id) values('R7804298473',83);
insert into rainy_user_position(user_id,position_id) values('R7702180034',83);
insert into rainy_user_position(user_id,position_id) values('R7606186033',83);
insert into rainy_user_position(user_id,position_id) values('R8904183053',75);
----------------------------------------------------------------------------------
SELECT * FROM RAINY_USER_MERCH WHERE USER_ID='R8812051740';

insert into rainy_user_merch(user_id,merch) values('R8812051740','21');
insert into rainy_user_merch(user_id,merch) values('R8812051740','22');
insert into rainy_user_merch(user_id,merch) values('R8309061528','29');
insert into rainy_user_merch(user_id,merch) values('R8306223527','27');
insert into rainy_user_merch(user_id,merch) values('R8306223527','31');
insert into rainy_user_merch(user_id,merch) values('R8306223527','34');
insert into rainy_user_merch(user_id,merch) values('R8306223527','39');
insert into rainy_user_merch(user_id,merch) values('R8306223527','40');
insert into rainy_user_merch(user_id,merch) values('R8608232570','12');
insert into rainy_user_merch(user_id,merch) values('R8608232570','13');
insert into rainy_user_merch(user_id,merch) values('R8608232570','14');
insert into rainy_user_merch(user_id,merch) values('R8608232570','15');
insert into rainy_user_merch(user_id,merch) values('R8608232570','16');
insert into rainy_user_merch(user_id,merch) values('R8608232570','17');
insert into rainy_user_merch(user_id,merch) values('R8608232570','18');
insert into rainy_user_merch(user_id,merch) values('R8608232570','19');
insert into rainy_user_merch(user_id,merch) values('R8608232570','21');
insert into rainy_user_merch(user_id,merch) values('R8608232570','22');
insert into rainy_user_merch(user_id,merch) values('R8608232570','23');
insert into rainy_user_merch(user_id,merch) values('R8608232570','24');
insert into rainy_user_merch(user_id,merch) values('R8608232570','25');
insert into rainy_user_merch(user_id,merch) values('R8608232570','26');
insert into rainy_user_merch(user_id,merch) values('R7403224534','ALL');
insert into rainy_user_merch(user_id,merch) values('R7709098335','ALL');
insert into rainy_user_merch(user_id,merch) values('R7512261544','ALL');
insert into rainy_user_merch(user_id,merch) values('R8509179020','ALL');
insert into rainy_user_merch(user_id,merch) values('R7111011012','ALL');
insert into rainy_user_merch(user_id,merch) values('R8202172013','27');
insert into rainy_user_merch(user_id,merch) values('R8202172013','31');
insert into rainy_user_merch(user_id,merch) values('R8202172013','32');
insert into rainy_user_merch(user_id,merch) values('R8202172013','33');
insert into rainy_user_merch(user_id,merch) values('R8202172013','34');
insert into rainy_user_merch(user_id,merch) values('R8202172013','35');
insert into rainy_user_merch(user_id,merch) values('R8202172013','36');
insert into rainy_user_merch(user_id,merch) values('R8202172013','37');
insert into rainy_user_merch(user_id,merch) values('R8202172013','38');
insert into rainy_user_merch(user_id,merch) values('R8202172013','39');
insert into rainy_user_merch(user_id,merch) values('R8202172013','40');
insert into rainy_user_merch(user_id,merch) values('R8202172013','41');
insert into rainy_user_merch(user_id,merch) values('R7302022328','21');
insert into rainy_user_merch(user_id,merch) values('R7302022328','22');
insert into rainy_user_merch(user_id,merch) values('R7302022328','23');
insert into rainy_user_merch(user_id,merch) values('R7302022328','24');
insert into rainy_user_merch(user_id,merch) values('R7302022328','25');
insert into rainy_user_merch(user_id,merch) values('R7302022328','26');
insert into rainy_user_merch(user_id,merch) values('R8410101845','27');
insert into rainy_user_merch(user_id,merch) values('R8410101845','36');
insert into rainy_user_merch(user_id,merch) values('R8410101845','37');
insert into rainy_user_merch(user_id,merch) values('R8410101845','41');
insert into rainy_user_merch(user_id,merch) values('R8112023320','34');
insert into rainy_user_merch(user_id,merch) values('R8112023320','39');
insert into rainy_user_merch(user_id,merch) values('R8112023320','40');
insert into rainy_user_merch(user_id,merch) values('R7706110320','32');
insert into rainy_user_merch(user_id,merch) values('R7706110320','33');
insert into rainy_user_merch(user_id,merch) values('R7706110320','35');
insert into rainy_user_merch(user_id,merch) values('R7706110320','38');
insert into rainy_user_merch(user_id,merch) values('R7706110320','42');
insert into rainy_user_merch(user_id,merch) values('R8311084409','12');
insert into rainy_user_merch(user_id,merch) values('R8311084409','13');
insert into rainy_user_merch(user_id,merch) values('R8311084409','14');
insert into rainy_user_merch(user_id,merch) values('R8311084409','15');
insert into rainy_user_merch(user_id,merch) values('R8311084409','16');
insert into rainy_user_merch(user_id,merch) values('R8311084409','17');
insert into rainy_user_merch(user_id,merch) values('R8311084409','18');
insert into rainy_user_merch(user_id,merch) values('R8311084409','19');
insert into rainy_user_merch(user_id,merch) values('R8311084409','76');
insert into rainy_user_merch(user_id,merch) values('R8610040369','ALL');
insert into rainy_user_merch(user_id,merch) values('R8210272014','27');
insert into rainy_user_merch(user_id,merch) values('R8210272014','30');
insert into rainy_user_merch(user_id,merch) values('R8210272014','33');
insert into rainy_user_merch(user_id,merch) values('R8210272014','38');
insert into rainy_user_merch(user_id,merch) values('R8508185871','71');
insert into rainy_user_merch(user_id,merch) values('R8508185871','72');
insert into rainy_user_merch(user_id,merch) values('R8508185871','73');
insert into rainy_user_merch(user_id,merch) values('R8508185871','74');
insert into rainy_user_merch(user_id,merch) values('R8508185871','75');
insert into rainy_user_merch(user_id,merch) values('R8508185871','76');
insert into rainy_user_merch(user_id,merch) values('R8508185871','77');
insert into rainy_user_merch(user_id,merch) values('R7801090421','76');
insert into rainy_user_merch(user_id,merch) values('R8207010519','ALL');
insert into rainy_user_merch(user_id,merch) values('R8612313792','27');
insert into rainy_user_merch(user_id,merch) values('R8612313792','33');
insert into rainy_user_merch(user_id,merch) values('R8612313792','38');
insert into rainy_user_merch(user_id,merch) values('R8010130010','21');
insert into rainy_user_merch(user_id,merch) values('R8010130010','22');
insert into rainy_user_merch(user_id,merch) values('R8010130010','23');
insert into rainy_user_merch(user_id,merch) values('R8010130010','24');
insert into rainy_user_merch(user_id,merch) values('R8510087654','25');
insert into rainy_user_merch(user_id,merch) values('R8510087654','26');
insert into rainy_user_merch(user_id,merch) values('R7702036768','16');
insert into rainy_user_merch(user_id,merch) values('R7702036768','17');
insert into rainy_user_merch(user_id,merch) values('R7702036768','18');
insert into rainy_user_merch(user_id,merch) values('R7702036768','19');
insert into rainy_user_merch(user_id,merch) values('R8101231440','12');
insert into rainy_user_merch(user_id,merch) values('R8101231440','13');
insert into rainy_user_merch(user_id,merch) values('R8101231440','14');
insert into rainy_user_merch(user_id,merch) values('R8101231440','15');
insert into rainy_user_merch(user_id,merch) values('R8101231440','29');
insert into rainy_user_merch(user_id,merch) values('R8706070030','32');
insert into rainy_user_merch(user_id,merch) values('R8706070030','35');
insert into rainy_user_merch(user_id,merch) values('R8706070030','42');
insert into rainy_user_merch(user_id,merch) values('R8608160612','36');
insert into rainy_user_merch(user_id,merch) values('R8608160612','37');
insert into rainy_user_merch(user_id,merch) values('R8608160612','41');
insert into rainy_user_merch(user_id,merch) values('R8207144811','31');
insert into rainy_user_merch(user_id,merch) values('R8207144811','34');
insert into rainy_user_merch(user_id,merch) values('R8207144811','39');
insert into rainy_user_merch(user_id,merch) values('R8207144811','40');
insert into rainy_user_merch(user_id,merch) values('R8712104351','76');
insert into rainy_user_merch(user_id,merch) values('R7902258511','31');
insert into rainy_user_merch(user_id,merch) values('R7902258511','32');
insert into rainy_user_merch(user_id,merch) values('R7902258511','33');
insert into rainy_user_merch(user_id,merch) values('R7902258511','34');
insert into rainy_user_merch(user_id,merch) values('R7902258511','35');
insert into rainy_user_merch(user_id,merch) values('R7902258511','36');
insert into rainy_user_merch(user_id,merch) values('R7902258511','37');
insert into rainy_user_merch(user_id,merch) values('R7902258511','38');
insert into rainy_user_merch(user_id,merch) values('R7902258511','39');
insert into rainy_user_merch(user_id,merch) values('R7902258511','40');
insert into rainy_user_merch(user_id,merch) values('R7902258511','41');
insert into rainy_user_merch(user_id,merch) values('R7902258511','42');
insert into rainy_user_merch(user_id,merch) values('R7612300035','27');
insert into rainy_user_merch(user_id,merch) values('R7612300035','33');
insert into rainy_user_merch(user_id,merch) values('R7612300035','38');
insert into rainy_user_merch(user_id,merch) values('R9010098033','ALL');
insert into rainy_user_merch(user_id,merch) values('R791105072X','ALL');
insert into rainy_user_merch(user_id,merch) values('R9111153612','21');
insert into rainy_user_merch(user_id,merch) values('R9111153612','22');
insert into rainy_user_merch(user_id,merch) values('R9111153612','23');
insert into rainy_user_merch(user_id,merch) values('R9111153612','24');
insert into rainy_user_merch(user_id,merch) values('R9111153612','25');
insert into rainy_user_merch(user_id,merch) values('R9111153612','26');
insert into rainy_user_merch(user_id,merch) values('R3750916041','32');
insert into rainy_user_merch(user_id,merch) values('R3750916041','35');
insert into rainy_user_merch(user_id,merch) values('R3750916041','42');
insert into rainy_user_merch(user_id,merch) values('R7812247625','ALL');
insert into rainy_user_merch(user_id,merch) values('R8701170012','71');
insert into rainy_user_merch(user_id,merch) values('R8701170012','72');
insert into rainy_user_merch(user_id,merch) values('R8701170012','73');
insert into rainy_user_merch(user_id,merch) values('R8701170012','74');
insert into rainy_user_merch(user_id,merch) values('R8701170012','75');
insert into rainy_user_merch(user_id,merch) values('R8701170012','76');
insert into rainy_user_merch(user_id,merch) values('R8701170012','77');
insert into rainy_user_merch(user_id,merch) values('R8701170012','78');
insert into rainy_user_merch(user_id,merch) values('R8709150042','ALL');
insert into rainy_user_merch(user_id,merch) values('R1790715201','76');
insert into rainy_user_merch(user_id,merch) values('R7808147621','71');
insert into rainy_user_merch(user_id,merch) values('R8412020623','71');
insert into rainy_user_merch(user_id,merch) values('R8412020623','75');
insert into rainy_user_merch(user_id,merch) values('R8703013411','71');
insert into rainy_user_merch(user_id,merch) values('R8703013411','72');
insert into rainy_user_merch(user_id,merch) values('R8710110038','72');
insert into rainy_user_merch(user_id,merch) values('R8710110038','73');
insert into rainy_user_merch(user_id,merch) values('R8710110038','74');
insert into rainy_user_merch(user_id,merch) values('R8710110038','77');
insert into rainy_user_merch(user_id,merch) values('R8811072849','ALL');
insert into rainy_user_merch(user_id,merch) values('R7306176339','78');
insert into rainy_user_merch(user_id,merch) values('R7609268516','ALL');
insert into rainy_user_merch(user_id,merch) values('R8201170555','ALL');
insert into rainy_user_merch(user_id,merch) values('R7307190015','ALL');
insert into rainy_user_merch(user_id,merch) values('R7712053531','ALL');
insert into rainy_user_merch(user_id,merch) values('R8012193316','ALL');
insert into rainy_user_merch(user_id,merch) values('R7609015214','ALL');
insert into rainy_user_merch(user_id,merch) values('R7502104015','ALL');
insert into rainy_user_merch(user_id,merch) values('R7804298473','ALL');
insert into rainy_user_merch(user_id,merch) values('R7702180034','ALL');
insert into rainy_user_merch(user_id,merch) values('R7606186033','ALL');
-----------------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R8812051740','ALL');
insert into rainy_user_loc (user_id,loc)values('R8309061528','ALL');
insert into rainy_user_loc (user_id,loc)values('R8306223527','120103');
insert into rainy_user_loc (user_id,loc)values('R8608232570','120097');
insert into rainy_user_loc (user_id,loc)values('R7403224534','120087');
insert into rainy_user_loc (user_id,loc)values('R7709098335','120125');
insert into rainy_user_loc (user_id,loc)values('R7512261544','120125');
insert into rainy_user_loc (user_id,loc)values('R8509179020','120125');
insert into rainy_user_loc (user_id,loc)values('R7111011012','120156');
insert into rainy_user_loc (user_id,loc)values('R8202172013','120156');
insert into rainy_user_loc (user_id,loc)values('R7302022328','120156');
insert into rainy_user_loc (user_id,loc)values('R8410101845','120156');
insert into rainy_user_loc (user_id,loc)values('R8112023320','120156');
insert into rainy_user_loc (user_id,loc)values('R7706110320','120156');
insert into rainy_user_loc (user_id,loc)values('R8311084409','120156');
insert into rainy_user_loc (user_id,loc)values('R8610040369','120156');
insert into rainy_user_loc (user_id,loc)values('R8210272014','120056');
insert into rainy_user_loc (user_id,loc)values('R8508185871','120056');
insert into rainy_user_loc (user_id,loc)values('R7801090421','120056');
insert into rainy_user_loc (user_id,loc)values('R8207010519','120056');
insert into rainy_user_loc (user_id,loc)values('R8612313792','120157');
insert into rainy_user_loc (user_id,loc)values('R8010130010','120157');
insert into rainy_user_loc (user_id,loc)values('R8510087654','120157');
insert into rainy_user_loc (user_id,loc)values('R7702036768','120157');
insert into rainy_user_loc (user_id,loc)values('R8101231440','120157');
insert into rainy_user_loc (user_id,loc)values('R8706070030','120157');
insert into rainy_user_loc (user_id,loc)values('R8608160612','120157');
insert into rainy_user_loc (user_id,loc)values('R8207144811','120157');
insert into rainy_user_loc (user_id,loc)values('R8712104351','120157');
insert into rainy_user_loc (user_id,loc)values('R7902258511','120157');
insert into rainy_user_loc (user_id,loc)values('R7612300035','120064');
insert into rainy_user_loc (user_id,loc)values('R9010098033','120064');
insert into rainy_user_loc (user_id,loc)values('R791105072X','120077');
insert into rainy_user_loc (user_id,loc)values('R9111153612','120137');
insert into rainy_user_loc (user_id,loc)values('R3750916041','120137');
insert into rainy_user_loc (user_id,loc)values('R7812247625','130005');
insert into rainy_user_loc (user_id,loc)values('R8206107825','130005');
insert into rainy_user_loc (user_id,loc)values('R8701170012','130005');
insert into rainy_user_loc (user_id,loc)values('R8709150042','130005');
insert into rainy_user_loc (user_id,loc)values('R1790715201','130005');
insert into rainy_user_loc (user_id,loc)values('R7808147621','130005');
insert into rainy_user_loc (user_id,loc)values('R8412020623','130005');
insert into rainy_user_loc (user_id,loc)values('R8703013411','130005');
insert into rainy_user_loc (user_id,loc)values('R8710110038','130005');
insert into rainy_user_loc (user_id,loc)values('R8811072849','130005');
insert into rainy_user_loc (user_id,loc)values('R7306176339','130005');
insert into rainy_user_loc (user_id,loc)values('R7609268516','ALL');
insert into rainy_user_loc (user_id,loc)values('R8201170555','ALL');
insert into rainy_user_loc (user_id,loc)values('R7307190015','ALL');
insert into rainy_user_loc (user_id,loc)values('R7712053531','ALL');
insert into rainy_user_loc (user_id,loc)values('R8012193316','ALL');
insert into rainy_user_loc (user_id,loc)values('R7609015214','ALL');
insert into rainy_user_loc (user_id,loc)values('R7502104015','ALL');
insert into rainy_user_loc (user_id,loc)values('R7804298473','ALL');
insert into rainy_user_loc (user_id,loc)values('R7702180034','ALL');
insert into rainy_user_loc (user_id,loc)values('R7606186033','ALL');
insert into rainy_user_loc (user_id,loc)values('R8904183053','ALL');


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
   AND RU.ID BETWEEN 2025 AND 2081;

--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2025 AND 2081
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 2025 AND 2081 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2025 AND 2081
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
         AND RU.ID BETWEEN 2025 AND 2081
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
   AND RU.ID BETWEEN 2025 AND 2081;

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
and rul.loc = 'ALL'
AND RU.ID BETWEEN 2025 AND 2081
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
AND RU.ID BETWEEN 2025 AND 2081 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2025 AND 2081 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2025 AND 2081 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2025 AND 2081 
ORDER BY RU.ID;


