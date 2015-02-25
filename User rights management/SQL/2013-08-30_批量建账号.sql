insert into rainy_user(user_id,user_name,id) values('R7003083473','吁光辉','2431');
insert into rainy_user(user_id,user_name,id) values('R8912020355','赵明','2444');
insert into rainy_user(user_id,user_name,id) values('R880422461X','王德利','2445');


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
  WHERE RU.ID BETWEEN 2431 AND 2446 ;

--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID IN( 'R8109227809','R7709098335','R7512261544','R7309178329','R8706255851','R6607121847','R7211091557',
'R6612017649','R7708194429','R8509179020','R7010081017','R8005104934','R8502050046') FOR UPDATE;
/*insert into rainy_user(user_id,user_name,id) values('R8109227809','文莉','2432');
insert into rainy_user(user_id,user_name,id) values('R7709098335','文乐弦','2433');
insert into rainy_user(user_id,user_name,id) values('R7512261544','胡小莉','2434');
insert into rainy_user(user_id,user_name,id) values('R7309178329','郭平','2435');
insert into rainy_user(user_id,user_name,id) values('R8706255851','汪瑶','2436');
insert into rainy_user(user_id,user_name,id) values('R6607121847','彭春兰','2437');
insert into rainy_user(user_id,user_name,id) values('R7211091557','崔坚石','2438');
insert into rainy_user(user_id,user_name,id) values('R6612017649','吉锦卫','2439');
insert into rainy_user(user_id,user_name,id) values('R7708194429','彭慧敏','2440');
insert into rainy_user(user_id,user_name,id) values('R8509179020','刘晓庆','2441');
insert into rainy_user(user_id,user_name,id) values('R7010081017','高军','2442');
insert into rainy_user(user_id,user_name,id) values('R8005104934','聂浪','2443');*/
--insert into rainy_user(user_id,user_name,id) values('R8502050046','桂玮琳','2446');

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
   AND RU.ID BETWEEN 2431 AND 2446;

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
AND RU.ID BETWEEN 2431 AND 2446 ;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2431 AND 2446 ;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2431 AND 2446 ;   
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2431 AND 2446);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2431 AND 2446);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2431 AND 2446);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2431 AND 2446);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2431 AND 2446);

insert into rainy_user_position(user_id,position_id) values('R7003083473',86);
insert into rainy_user_position(user_id,position_id) values('R8109227809',84);
insert into rainy_user_position(user_id,position_id) values('R7709098335',93);
insert into rainy_user_position(user_id,position_id) values('R7512261544',90);
insert into rainy_user_position(user_id,position_id) values('R7309178329',86);
insert into rainy_user_position(user_id,position_id) values('R8706255851',85);
insert into rainy_user_position(user_id,position_id) values('R6607121847',86);
insert into rainy_user_position(user_id,position_id) values('R7211091557',85);
insert into rainy_user_position(user_id,position_id) values('R6612017649',86);
insert into rainy_user_position(user_id,position_id) values('R7708194429',86);
insert into rainy_user_position(user_id,position_id) values('R8509179020',88);
insert into rainy_user_position(user_id,position_id) values('R7010081017',85);
insert into rainy_user_position(user_id,position_id) values('R8005104934',85);
insert into rainy_user_position(user_id,position_id) values('R8912020355',86);
insert into rainy_user_position(user_id,position_id) values('R880422461X',86);
insert into rainy_user_position(user_id,position_id) values('R8502050046',85);
--------------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R7003083473','32');
insert into rainy_user_merch(user_id,merch) values('R7003083473','35');
insert into rainy_user_merch(user_id,merch) values('R7003083473','42');
insert into rainy_user_merch(user_id,merch) values('R7309178329','21');
insert into rainy_user_merch(user_id,merch) values('R7309178329','22');
insert into rainy_user_merch(user_id,merch) values('R7309178329','23');
insert into rainy_user_merch(user_id,merch) values('R7309178329','24');
insert into rainy_user_merch(user_id,merch) values('R7309178329','25');
insert into rainy_user_merch(user_id,merch) values('R7309178329','26');
insert into rainy_user_merch(user_id,merch) values('R8706255851','12');
insert into rainy_user_merch(user_id,merch) values('R8706255851','13');
insert into rainy_user_merch(user_id,merch) values('R8706255851','14');
insert into rainy_user_merch(user_id,merch) values('R8706255851','15');
insert into rainy_user_merch(user_id,merch) values('R8706255851','16');
insert into rainy_user_merch(user_id,merch) values('R8706255851','17');
insert into rainy_user_merch(user_id,merch) values('R8706255851','18');
insert into rainy_user_merch(user_id,merch) values('R8706255851','19');
insert into rainy_user_merch(user_id,merch) values('R8706255851','21');
insert into rainy_user_merch(user_id,merch) values('R8706255851','22');
insert into rainy_user_merch(user_id,merch) values('R8706255851','23');
insert into rainy_user_merch(user_id,merch) values('R8706255851','24');
insert into rainy_user_merch(user_id,merch) values('R8706255851','25');
insert into rainy_user_merch(user_id,merch) values('R8706255851','26');
insert into rainy_user_merch(user_id,merch) values('R8706255851','29');
insert into rainy_user_merch(user_id,merch) values('R8706255851','76');
insert into rainy_user_merch(user_id,merch) values('R6607121847','27');
insert into rainy_user_merch(user_id,merch) values('R6607121847','32');
insert into rainy_user_merch(user_id,merch) values('R6607121847','35');
insert into rainy_user_merch(user_id,merch) values('R6607121847','42');
insert into rainy_user_merch(user_id,merch) values('R7211091557','27');
insert into rainy_user_merch(user_id,merch) values('R7211091557','31');
insert into rainy_user_merch(user_id,merch) values('R7211091557','32');
insert into rainy_user_merch(user_id,merch) values('R7211091557','33');
insert into rainy_user_merch(user_id,merch) values('R7211091557','34');
insert into rainy_user_merch(user_id,merch) values('R7211091557','35');
insert into rainy_user_merch(user_id,merch) values('R7211091557','36');
insert into rainy_user_merch(user_id,merch) values('R7211091557','37');
insert into rainy_user_merch(user_id,merch) values('R7211091557','38');
insert into rainy_user_merch(user_id,merch) values('R7211091557','39');
insert into rainy_user_merch(user_id,merch) values('R7211091557','40');
insert into rainy_user_merch(user_id,merch) values('R7211091557','41');
insert into rainy_user_merch(user_id,merch) values('R7211091557','42');
insert into rainy_user_merch(user_id,merch) values('R6612017649','12');
insert into rainy_user_merch(user_id,merch) values('R6612017649','13');
insert into rainy_user_merch(user_id,merch) values('R6612017649','14');
insert into rainy_user_merch(user_id,merch) values('R6612017649','15');
insert into rainy_user_merch(user_id,merch) values('R6612017649','16');
insert into rainy_user_merch(user_id,merch) values('R6612017649','17');
insert into rainy_user_merch(user_id,merch) values('R6612017649','18');
insert into rainy_user_merch(user_id,merch) values('R6612017649','19');
insert into rainy_user_merch(user_id,merch) values('R6612017649','29');
insert into rainy_user_merch(user_id,merch) values('R6612017649','76');
insert into rainy_user_merch(user_id,merch) values('R7708194429','31');
insert into rainy_user_merch(user_id,merch) values('R7708194429','33');
insert into rainy_user_merch(user_id,merch) values('R7708194429','34');
insert into rainy_user_merch(user_id,merch) values('R7708194429','39');
insert into rainy_user_merch(user_id,merch) values('R7708194429','40');
insert into rainy_user_merch(user_id,merch) values('R7010081017','76');
insert into rainy_user_merch(user_id,merch) values('R8005104934','27');
insert into rainy_user_merch(user_id,merch) values('R8005104934','31');
insert into rainy_user_merch(user_id,merch) values('R8005104934','32');
insert into rainy_user_merch(user_id,merch) values('R8005104934','33');
insert into rainy_user_merch(user_id,merch) values('R8005104934','34');
insert into rainy_user_merch(user_id,merch) values('R8005104934','35');
insert into rainy_user_merch(user_id,merch) values('R8005104934','36');
insert into rainy_user_merch(user_id,merch) values('R8005104934','37');
insert into rainy_user_merch(user_id,merch) values('R8005104934','38');
insert into rainy_user_merch(user_id,merch) values('R8005104934','39');
insert into rainy_user_merch(user_id,merch) values('R8005104934','40');
insert into rainy_user_merch(user_id,merch) values('R8005104934','41');
insert into rainy_user_merch(user_id,merch) values('R8005104934','42');
insert into rainy_user_merch(user_id,merch) values('R8912020355','27');
insert into rainy_user_merch(user_id,merch) values('R8912020355','33');
insert into rainy_user_merch(user_id,merch) values('R8912020355','38');
insert into rainy_user_merch(user_id,merch) values('R880422461X','21');
insert into rainy_user_merch(user_id,merch) values('R880422461X','22');
insert into rainy_user_merch(user_id,merch) values('R880422461X','23');
insert into rainy_user_merch(user_id,merch) values('R880422461X','24');
insert into rainy_user_merch(user_id,merch) values('R8502050046','12');
insert into rainy_user_merch(user_id,merch) values('R8502050046','13');
insert into rainy_user_merch(user_id,merch) values('R8502050046','14');
insert into rainy_user_merch(user_id,merch) values('R8502050046','15');
insert into rainy_user_merch(user_id,merch) values('R8502050046','16');
insert into rainy_user_merch(user_id,merch) values('R8502050046','17');
insert into rainy_user_merch(user_id,merch) values('R8502050046','18');
insert into rainy_user_merch(user_id,merch) values('R8502050046','19');
insert into rainy_user_merch(user_id,merch) values('R8109227809','ALL');
-----------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R7003083473','118001');
insert into rainy_user_loc (user_id,loc)values('R7003083473','118005');
insert into rainy_user_loc (user_id,loc)values('R7003083473','118011');
insert into rainy_user_loc (user_id,loc)values('R7003083473','118012');
insert into rainy_user_loc (user_id,loc)values('R7003083473','120056');
insert into rainy_user_loc (user_id,loc)values('R8109227809','120125');
insert into rainy_user_loc (user_id,loc)values('R7709098335','120125');
insert into rainy_user_loc (user_id,loc)values('R7512261544','120125');
insert into rainy_user_loc (user_id,loc)values('R7309178329','120125');
insert into rainy_user_loc (user_id,loc)values('R8706255851','120125');
insert into rainy_user_loc (user_id,loc)values('R6607121847','120125');
insert into rainy_user_loc (user_id,loc)values('R7211091557','120125');
insert into rainy_user_loc (user_id,loc)values('R6612017649','120125');
insert into rainy_user_loc (user_id,loc)values('R7708194429','120125');
insert into rainy_user_loc (user_id,loc)values('R8509179020','120125');
insert into rainy_user_loc (user_id,loc)values('R7010081017','120122');
insert into rainy_user_loc (user_id,loc)values('R8005104934','118001');
insert into rainy_user_loc (user_id,loc)values('R8005104934','118005');
insert into rainy_user_loc (user_id,loc)values('R8005104934','118010');
insert into rainy_user_loc (user_id,loc)values('R8005104934','118011');
insert into rainy_user_loc (user_id,loc)values('R8005104934','118012');
insert into rainy_user_loc (user_id,loc)values('R8005104934','120189');
insert into rainy_user_loc (user_id,loc)values('R8912020355','118001');
insert into rainy_user_loc (user_id,loc)values('R8912020355','118005');
insert into rainy_user_loc (user_id,loc)values('R8912020355','118010');
insert into rainy_user_loc (user_id,loc)values('R8912020355','118011');
insert into rainy_user_loc (user_id,loc)values('R8912020355','118012');
insert into rainy_user_loc (user_id,loc)values('R8912020355','120189');
insert into rainy_user_loc (user_id,loc)values('R880422461X','118001');
insert into rainy_user_loc (user_id,loc)values('R880422461X','118005');
insert into rainy_user_loc (user_id,loc)values('R880422461X','118010');
insert into rainy_user_loc (user_id,loc)values('R880422461X','118011');
insert into rainy_user_loc (user_id,loc)values('R880422461X','118012');
insert into rainy_user_loc (user_id,loc)values('R880422461X','120189');
insert into rainy_user_loc (user_id,loc)values('R8502050046','120159');




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
   AND RU.ID BETWEEN 2431 AND 2446;

--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2431 AND 2446
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2431 AND 2446 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2431 AND 2446
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
         AND RU.ID BETWEEN 2431 AND 2446
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
   AND RU.ID BETWEEN 2431 AND 2446;

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
AND RU.ID BETWEEN 2431 AND 2446
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
AND RU.ID BETWEEN 2431 AND 2446 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2431 AND 2446 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2431 AND 2446 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2431 AND 2446 
ORDER BY RU.ID;
