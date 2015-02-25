--insert into rainy_user(user_id,user_name,id) values('R7206284544','朱琼芳','988');
insert into rainy_user(user_id,user_name,id) values('R7609050029','陈敏','989');
insert into rainy_user(user_id,user_name,id) values('R8409237920','周静','990');
insert into rainy_user(user_id,user_name,id) values('R8702062567','李英','991');
insert into rainy_user(user_id,user_name,id) values('R8012230020','王循','992');
insert into rainy_user(user_id,user_name,id) values('R7910012048','彭伟香','993');
--insert into rainy_user(user_id,user_name,id) values('R7704092066','胡静玲','994');
insert into rainy_user(user_id,user_name,id) values('R7807230046','李媛','995');

--新增 'R7609050029','R8409237920','R8702062567','R8012230020','R7910012048','R7807230046'
--已建 'R7206284544','R7704092066'

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
  WHERE RS.USER_ID IN ('R7609050029','R8409237920','R8702062567','R8012230020','R7910012048','R7807230046') ;
  
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
   AND RU.USER_ID IN ( 'R7206284544','R7704092066');
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
AND RU.USER_ID IN ( 'R7206284544','R7704092066' );

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ( 'R7206284544','R7704092066' );



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ( 'R7206284544','R7704092066' ) ;    
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE WHERE user_id IN ('R7206284544','R7704092066' );
DELETE FROM SEC_USER_GROUP WHERE USER_ID IN ('R7206284544','R7704092066' );
DELETE FROM RAINY_USER_LOC WHERE USER_ID IN ('R7206284544','R7704092066' );
DELETE FROM RAINY_USER_MERCH WHERE USER_ID IN ('R7206284544','R7704092066');
DELETE FROM RAINY_USER_POSITION WHERE USER_ID IN ('R7206284544','R7704092066' );

--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID IN ('R7206284544','R7704092066' ) FOR UPDATE


--
insert into rainy_user_position(user_id,position_id) values('R7206284544',64);
insert into rainy_user_position(user_id,position_id) values('R7609050029',64);
insert into rainy_user_position(user_id,position_id) values('R8409237920',64);
insert into rainy_user_position(user_id,position_id) values('R8702062567',65);
insert into rainy_user_position(user_id,position_id) values('R8012230020',66);
insert into rainy_user_position(user_id,position_id) values('R7910012048',68);
insert into rainy_user_position(user_id,position_id) values('R7704092066',64);
insert into rainy_user_position(user_id,position_id) values('R7807230046',65);

--
insert into rainy_user_merch(user_id,merch) values('R7910012048','21');
insert into rainy_user_merch(user_id,merch) values('R7910012048','22');
insert into rainy_user_merch(user_id,merch) values('R7910012048','23');
insert into rainy_user_merch(user_id,merch) values('R7910012048','24');
insert into rainy_user_merch(user_id,merch) values('R7910012048','25');
insert into rainy_user_merch(user_id,merch) values('R7910012048','26');
insert into rainy_user_merch(user_id,merch) values('R7910012048','29');
insert into rainy_user_merch(user_id,merch) values('R7206284544','ALL');
insert into rainy_user_merch(user_id,merch) values('R7609050029','ALL');
insert into rainy_user_merch(user_id,merch) values('R8409237920','ALL');
insert into rainy_user_merch(user_id,merch) values('R8702062567','ALL');
insert into rainy_user_merch(user_id,merch) values('R8012230020','ALL');
insert into rainy_user_merch(user_id,merch) values('R7704092066','ALL');
insert into rainy_user_merch(user_id,merch) values('R7807230046','ALL');

--
insert into rainy_user_loc (user_id,loc)values('R7206284544','118001');

insert into rainy_user_loc (user_id,loc)values('R7206284544','118005');
insert into rainy_user_loc (user_id,loc)values('R7206284544','118011');
insert into rainy_user_loc (user_id,loc)values('R7206284544','118012');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120021');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120063');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120080');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120097');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120103');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120144');
insert into rainy_user_loc (user_id,loc)values('R7206284544','120151');
insert into rainy_user_loc (user_id,loc)values('R7609050029','118001');
insert into rainy_user_loc (user_id,loc)values('R7609050029','118005');
insert into rainy_user_loc (user_id,loc)values('R7609050029','118011');
insert into rainy_user_loc (user_id,loc)values('R7609050029','118012');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120021');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120063');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120080');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120097');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120103');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120144');
insert into rainy_user_loc (user_id,loc)values('R7609050029','120151');
insert into rainy_user_loc (user_id,loc)values('R8409237920','118001');
insert into rainy_user_loc (user_id,loc)values('R8409237920','118005');
insert into rainy_user_loc (user_id,loc)values('R8409237920','118011');
insert into rainy_user_loc (user_id,loc)values('R8409237920','118012');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120021');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120063');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120080');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120097');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120103');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120144');
insert into rainy_user_loc (user_id,loc)values('R8409237920','120151');
insert into rainy_user_loc (user_id,loc)values('R8702062567','118001');
insert into rainy_user_loc (user_id,loc)values('R8702062567','118005');
insert into rainy_user_loc (user_id,loc)values('R8702062567','118011');
insert into rainy_user_loc (user_id,loc)values('R8702062567','118012');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120021');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120063');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120080');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120097');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120103');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120144');
insert into rainy_user_loc (user_id,loc)values('R8702062567','120151');
insert into rainy_user_loc (user_id,loc)values('R8012230020','118001');
insert into rainy_user_loc (user_id,loc)values('R8012230020','118005');
insert into rainy_user_loc (user_id,loc)values('R8012230020','118011');
insert into rainy_user_loc (user_id,loc)values('R8012230020','118012');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120021');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120063');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120080');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120097');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120103');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120144');
insert into rainy_user_loc (user_id,loc)values('R8012230020','120151');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120029');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120064');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120085');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120157');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120161');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120163');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120170');
insert into rainy_user_loc (user_id,loc)values('R7910012048','120188');
insert into rainy_user_loc (user_id,loc)values('R7704092066','120092');
insert into rainy_user_loc (user_id,loc)values('R7807230046','120092');


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
   AND RU.ID BETWEEN 988 AND 995;
--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where  to_number (id ) BETWEEN 988 AND 995
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 988 AND 995;
--Department大类    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 988 AND 995
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
         AND RU.ID BETWEEN 988 AND 995
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
   AND RU.ID BETWEEN 988 AND 995;

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
AND RU.ID BETWEEN 988 AND 995
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
AND RU.ID BETWEEN 988 AND 995;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@'||MERCH|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 988 AND 995;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'||a.LOC|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 988 AND 995 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER
WHERE ID BETWEEN 988 AND 995;




