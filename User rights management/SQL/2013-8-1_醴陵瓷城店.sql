insert into rainy_user(user_id,user_name,id) values('R8606176648','丁姣','1354');
insert into rainy_user(user_id,user_name,id) values('R7408089127','吴明娥','1355');
insert into rainy_user(user_id,user_name,id) values('R7902047483','余群','1356');
insert into rainy_user(user_id,user_name,id) values('R791214771X','万建军','1357');
insert into rainy_user(user_id,user_name,id) values('R7408062364','蒙莉莎','1358');
insert into rainy_user(user_id,user_name,id) values('R6907022045','朱素平','1359');
insert into rainy_user(user_id,user_name,id) values('R7207152005','何利萍','1360');
insert into rainy_user(user_id,user_name,id) values('R8302221325','刘芳','1361');
insert into rainy_user(user_id,user_name,id) values('R8012294065','荣芳','1362');
insert into rainy_user(user_id,user_name,id) values('R7607162294','敬明刚','1363');
insert into rainy_user(user_id,user_name,id) values('R8206201308','肖欢','1364');
insert into rainy_user(user_id,user_name,id) values('R6910202305','陈民','1365');
insert into rainy_user(user_id,user_name,id) values('R8106111348','张宇','1366');
insert into rainy_user(user_id,user_name,id) values('R7604222310','刘彬','1367');
insert into rainy_user(user_id,user_name,id) values('R7612032306','朱敏','1368');
insert into rainy_user(user_id,user_name,id) values('R8705111313','胡细英','1369');
insert into rainy_user(user_id,user_name,id) values('R8010032004','杨幸','1370');
insert into rainy_user(user_id,user_name,id) values('R2760525152','王玉梅','1371');
insert into rainy_user(user_id,user_name,id) values('R7510307258','杨志强','1372');

SELECT * FROM RAINY_USER T WHERE T.USER_ID = 'R7502106229';

--修改密码
update rainy_user t
set t.password =( select upper(dbms_random.string ('u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value (0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where t.password is null

--创建DB用户
--语句在sys用户下执行
SELECT
 'create user ' || rs.user_id || ' identified by ' || rs.password ||
 ' default tablespace RETEK_DATA
temporary tablespace TEMP
quota unlimited on RETEK_DATA
quota unlimited on RETEK_INDEX' || ' ; '    || chr ( 13) ||
 'grant alter session,     analyze any, create any view,       create library,create procedure, create sequence,
       create session,  create synonym,    create table,       create trigger,     create view,      create job,delete any table,
   drop any procedure,   drop any view,  drop any table,execute any procedure,execute any type,insert any table,
  select any sequence,select any table,update any table,select any dictionary
to ' || rs.user_id || ' ;' || chr ( 13 ) ||
 
  'grant select on sys.dba_role_privs to ' || rs.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_jobs to '       || rs.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_roles to '      || rs.user_id || ';' ||chr( 13) ||
  'grant execute on dbms_rls to '          || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_crypto to '   || rs.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_sys_privs to '  || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_alert to '    || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_lock to '     || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_system to '   || rs.user_id || ';' ||chr( 13) ||
  'grant AQ_ADMINISTRATOR_ROLE to '        || rs.user_id || ';' ||chr( 13) ||
  'grant execute on DBMS_AQ to '           || rs.user_id || ';' ||chr( 13) ||
  'grant execute on DBMS_AQADM to '        || rs.user_id || ';'
  FROM rainy_user rs
  WHERE RS.ID BETWEEN 1354 AND 1372 ;


insert into rainy_user_position(user_id,position_id) values('R8606176648',88);
insert into rainy_user_position(user_id,position_id) values('R7408089127',86);
insert into rainy_user_position(user_id,position_id) values('R7902047483',86);
insert into rainy_user_position(user_id,position_id) values('R791214771X',86);
insert into rainy_user_position(user_id,position_id) values('R7408062364',93);
insert into rainy_user_position(user_id,position_id) values('R6907022045',86);
insert into rainy_user_position(user_id,position_id) values('R7207152005',86);
insert into rainy_user_position(user_id,position_id) values('R8302221325',88);
insert into rainy_user_position(user_id,position_id) values('R8012294065',86);
insert into rainy_user_position(user_id,position_id) values('R7607162294',86);
insert into rainy_user_position(user_id,position_id) values('R8206201308',86);
insert into rainy_user_position(user_id,position_id) values('R6910202305',90);
insert into rainy_user_position(user_id,position_id) values('R8106111348',86);
insert into rainy_user_position(user_id,position_id) values('R7604222310',88);
insert into rainy_user_position(user_id,position_id) values('R7612032306',86);
insert into rainy_user_position(user_id,position_id) values('R8705111313',86);
insert into rainy_user_position(user_id,position_id) values('R8010032004',95);
insert into rainy_user_position(user_id,position_id) values('R2760525152',86);
insert into rainy_user_position(user_id,position_id) values('R7510307258',84);


insert into rainy_user_merch(user_id,merch) values('R8606176648','ALL');
insert into rainy_user_merch(user_id,merch) values('R7408089127','27');
insert into rainy_user_merch(user_id,merch) values('R7408089127','30');
insert into rainy_user_merch(user_id,merch) values('R7408089127','31');
insert into rainy_user_merch(user_id,merch) values('R7408089127','32');
insert into rainy_user_merch(user_id,merch) values('R7408089127','33');
insert into rainy_user_merch(user_id,merch) values('R7408089127','34');
insert into rainy_user_merch(user_id,merch) values('R7408089127','35');
insert into rainy_user_merch(user_id,merch) values('R7408089127','36');
insert into rainy_user_merch(user_id,merch) values('R7408089127','37');
insert into rainy_user_merch(user_id,merch) values('R7408089127','38');
insert into rainy_user_merch(user_id,merch) values('R7408089127','39');
insert into rainy_user_merch(user_id,merch) values('R7408089127','40');
insert into rainy_user_merch(user_id,merch) values('R7408089127','41');
insert into rainy_user_merch(user_id,merch) values('R7408089127','42');
insert into rainy_user_merch(user_id,merch) values('R7902047483','32');
insert into rainy_user_merch(user_id,merch) values('R7902047483','35');
insert into rainy_user_merch(user_id,merch) values('R7902047483','38');
insert into rainy_user_merch(user_id,merch) values('R7902047483','42');
insert into rainy_user_merch(user_id,merch) values('R7408062364','ALL');
insert into rainy_user_merch(user_id,merch) values('R8302221325','ALL');
insert into rainy_user_merch(user_id,merch) values('R6910202305','ALL');
insert into rainy_user_merch(user_id,merch) values('R7604222310','ALL');
insert into rainy_user_merch(user_id,merch) values('R8010032004','ALL');
insert into rainy_user_merch(user_id,merch) values('R7510307258','ALL');



insert into rainy_user_loc (user_id,loc)values('R8606176648','118001');
insert into rainy_user_loc (user_id,loc)values('R8606176648','118005');
insert into rainy_user_loc (user_id,loc)values('R8606176648','118011');
insert into rainy_user_loc (user_id,loc)values('R8606176648','118012');
insert into rainy_user_loc (user_id,loc)values('R8606176648','120146');
insert into rainy_user_loc (user_id,loc)values('R7408089127','118001');
insert into rainy_user_loc (user_id,loc)values('R7408089127','118005');
insert into rainy_user_loc (user_id,loc)values('R7408089127','118011');
insert into rainy_user_loc (user_id,loc)values('R7408089127','118012');
insert into rainy_user_loc (user_id,loc)values('R7408089127','120146');
insert into rainy_user_loc (user_id,loc)values('R7902047483','118001');
insert into rainy_user_loc (user_id,loc)values('R7902047483','118005');
insert into rainy_user_loc (user_id,loc)values('R7902047483','118011');
insert into rainy_user_loc (user_id,loc)values('R7902047483','118012');
insert into rainy_user_loc (user_id,loc)values('R7902047483','120146');
insert into rainy_user_loc (user_id,loc)values('R791214771X','118001');
insert into rainy_user_loc (user_id,loc)values('R791214771X','118005');
insert into rainy_user_loc (user_id,loc)values('R791214771X','118011');
insert into rainy_user_loc (user_id,loc)values('R791214771X','118012');
insert into rainy_user_loc (user_id,loc)values('R791214771X','120146');
insert into rainy_user_loc (user_id,loc)values('R7408062364','118001');
insert into rainy_user_loc (user_id,loc)values('R7408062364','118005');
insert into rainy_user_loc (user_id,loc)values('R7408062364','118011');
insert into rainy_user_loc (user_id,loc)values('R7408062364','118012');
insert into rainy_user_loc (user_id,loc)values('R7408062364','120146');
insert into rainy_user_loc (user_id,loc)values('R6907022045','118001');
insert into rainy_user_loc (user_id,loc)values('R6907022045','118005');
insert into rainy_user_loc (user_id,loc)values('R6907022045','118011');
insert into rainy_user_loc (user_id,loc)values('R6907022045','118012');
insert into rainy_user_loc (user_id,loc)values('R6907022045','120146');
insert into rainy_user_loc (user_id,loc)values('R7207152005','118001');
insert into rainy_user_loc (user_id,loc)values('R7207152005','118005');
insert into rainy_user_loc (user_id,loc)values('R7207152005','118011');
insert into rainy_user_loc (user_id,loc)values('R7207152005','118012');
insert into rainy_user_loc (user_id,loc)values('R7207152005','120146');
insert into rainy_user_loc (user_id,loc)values('R8302221325','118001');
insert into rainy_user_loc (user_id,loc)values('R8302221325','118005');
insert into rainy_user_loc (user_id,loc)values('R8302221325','118011');
insert into rainy_user_loc (user_id,loc)values('R8302221325','118012');
insert into rainy_user_loc (user_id,loc)values('R8302221325','120146');
insert into rainy_user_loc (user_id,loc)values('R8012294065','118001');
insert into rainy_user_loc (user_id,loc)values('R8012294065','118005');
insert into rainy_user_loc (user_id,loc)values('R8012294065','118011');
insert into rainy_user_loc (user_id,loc)values('R8012294065','118012');
insert into rainy_user_loc (user_id,loc)values('R8012294065','120146');
insert into rainy_user_loc (user_id,loc)values('R7607162294','118001');
insert into rainy_user_loc (user_id,loc)values('R7607162294','118005');
insert into rainy_user_loc (user_id,loc)values('R7607162294','118011');
insert into rainy_user_loc (user_id,loc)values('R7607162294','118012');
insert into rainy_user_loc (user_id,loc)values('R7607162294','120146');
insert into rainy_user_loc (user_id,loc)values('R8206201308','118001');
insert into rainy_user_loc (user_id,loc)values('R8206201308','118005');
insert into rainy_user_loc (user_id,loc)values('R8206201308','118011');
insert into rainy_user_loc (user_id,loc)values('R8206201308','118012');
insert into rainy_user_loc (user_id,loc)values('R8206201308','120146');
insert into rainy_user_loc (user_id,loc)values('R6910202305','118001');
insert into rainy_user_loc (user_id,loc)values('R6910202305','118005');
insert into rainy_user_loc (user_id,loc)values('R6910202305','118011');
insert into rainy_user_loc (user_id,loc)values('R6910202305','118012');
insert into rainy_user_loc (user_id,loc)values('R6910202305','120146');
insert into rainy_user_loc (user_id,loc)values('R8106111348','118001');
insert into rainy_user_loc (user_id,loc)values('R8106111348','118005');
insert into rainy_user_loc (user_id,loc)values('R8106111348','118011');
insert into rainy_user_loc (user_id,loc)values('R8106111348','118012');
insert into rainy_user_loc (user_id,loc)values('R8106111348','120146');
insert into rainy_user_loc (user_id,loc)values('R7604222310','118001');
insert into rainy_user_loc (user_id,loc)values('R7604222310','118005');
insert into rainy_user_loc (user_id,loc)values('R7604222310','118011');
insert into rainy_user_loc (user_id,loc)values('R7604222310','118012');
insert into rainy_user_loc (user_id,loc)values('R7604222310','120146');
insert into rainy_user_loc (user_id,loc)values('R7612032306','118001');
insert into rainy_user_loc (user_id,loc)values('R7612032306','118005');
insert into rainy_user_loc (user_id,loc)values('R7612032306','118011');
insert into rainy_user_loc (user_id,loc)values('R7612032306','118012');
insert into rainy_user_loc (user_id,loc)values('R7612032306','120146');
insert into rainy_user_loc (user_id,loc)values('R8705111313','118001');
insert into rainy_user_loc (user_id,loc)values('R8705111313','118005');
insert into rainy_user_loc (user_id,loc)values('R8705111313','118011');
insert into rainy_user_loc (user_id,loc)values('R8705111313','118012');
insert into rainy_user_loc (user_id,loc)values('R8705111313','120146');
insert into rainy_user_loc (user_id,loc)values('R8010032004','120146');
insert into rainy_user_loc (user_id,loc)values('R2760525152','120146');
insert into rainy_user_loc (user_id,loc)values('R7510307258','120146');


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
   AND RU.ID BETWEEN 1354 AND 1372;
--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where  to_number (id ) BETWEEN 1354 AND 1372
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 1354 AND 1372;
--Department大类    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 1354 AND 1372
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
         AND RU.ID BETWEEN 1354 AND 1372
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
       to_char ( (SELECT   wm_concat( 'userstores: storeId=' || rull.loc ||',cn=SIMStores,cn=SIM,dc=bbg' ||chr (13 ))
      
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
   AND RU.ID BETWEEN 1354 AND 1372;

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
AND RU.ID BETWEEN 1354 AND 1372
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
AND RU.ID BETWEEN 1354 AND 1372;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@'||MERCH|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1354 AND 1372;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'||a.LOC|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1354 AND 1372 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER
WHERE ID BETWEEN 1354 AND 1372;




