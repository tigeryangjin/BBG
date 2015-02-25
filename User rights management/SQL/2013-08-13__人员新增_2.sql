insert into rainy_user(user_id,user_name,id) values('R8409286518','余优根','2004');
insert into rainy_user(user_id,user_name,id) values('R8410103921','刘红玉','2005');
insert into rainy_user(user_id,user_name,id) values('R7903210216','杨武','2006');
insert into rainy_user(user_id,user_name,id) values('R8208293026','宋燕萍','2007');
insert into rainy_user(user_id,user_name,id) values('R7109190813','娄忠和','2008');
insert into rainy_user(user_id,user_name,id) values('R9109155634','冯强','2009');
insert into rainy_user(user_id,user_name,id) values('R8612242013','徐江滔','2010');
insert into rainy_user(user_id,user_name,id) values('R7102050056','贺永红','2011');
insert into rainy_user(user_id,user_name,id) values('R8908068383','谭婷','2012');
insert into rainy_user(user_id,user_name,id) values('R8306223527','康松英','2013');
insert into rainy_user(user_id,user_name,id) values('R7907285165','刘育英','2014');

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
  WHERE RU.ID BETWEEN 2004 AND 2014 ;


insert into rainy_user_position(user_id,position_id) values('R8409286518',84);
insert into rainy_user_position(user_id,position_id) values('R8410103921',86);
insert into rainy_user_position(user_id,position_id) values('R7903210216',88);
insert into rainy_user_position(user_id,position_id) values('R8208293026',90);
insert into rainy_user_position(user_id,position_id) values('R7109190813',93);
insert into rainy_user_position(user_id,position_id) values('R9109155634',95);
insert into rainy_user_position(user_id,position_id) values('R8612242013',86);
insert into rainy_user_position(user_id,position_id) values('R8908068383',6);
insert into rainy_user_position(user_id,position_id) values('R8306223527',87);
insert into rainy_user_position(user_id,position_id) values('R7907285165',68);
-------------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R8409286518','ALL');
insert into rainy_user_merch(user_id,merch) values('R8410103921','ALL');
insert into rainy_user_merch(user_id,merch) values('R7903210216','ALL');
insert into rainy_user_merch(user_id,merch) values('R8208293026','ALL');
insert into rainy_user_merch(user_id,merch) values('R7109190813','ALL');
insert into rainy_user_merch(user_id,merch) values('R9109155634','ALL');
insert into rainy_user_merch(user_id,merch) values('R8612242013','ALL');
insert into rainy_user_merch(user_id,merch) values('R7102050056','ALL');
insert into rainy_user_merch(user_id,merch) values('R8908068383','21');
insert into rainy_user_merch(user_id,merch) values('R8306223527','27');
insert into rainy_user_merch(user_id,merch) values('R8306223527','31');
insert into rainy_user_merch(user_id,merch) values('R8306223527','34');
insert into rainy_user_merch(user_id,merch) values('R8306223527','39');
insert into rainy_user_merch(user_id,merch) values('R8306223527','40');
insert into rainy_user_merch(user_id,merch) values('R7907285165','21');
insert into rainy_user_merch(user_id,merch) values('R7907285165','22');
insert into rainy_user_merch(user_id,merch) values('R7907285165','23');
insert into rainy_user_merch(user_id,merch) values('R7907285165','24');
insert into rainy_user_merch(user_id,merch) values('R7907285165','25');
insert into rainy_user_merch(user_id,merch) values('R7907285165','26');
insert into rainy_user_merch(user_id,merch) values('R7907285165','29');
-------------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R8409286518','120111');
insert into rainy_user_loc (user_id,loc)values('R8410103921','120111');
insert into rainy_user_loc (user_id,loc)values('R7903210216','120111');
insert into rainy_user_loc (user_id,loc)values('R8208293026','120111');
insert into rainy_user_loc (user_id,loc)values('R7109190813','120111');
insert into rainy_user_loc (user_id,loc)values('R9109155634','120111');
insert into rainy_user_loc (user_id,loc)values('R8612242013','120111');
insert into rainy_user_loc (user_id,loc)values('R7102050056','120111');
insert into rainy_user_loc (user_id,loc)values('R8908068383','118001');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120001');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120002');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120003');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120004');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120006');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120008');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120009');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120010');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120011');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120012');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120013');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120014');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120015');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120016');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120017');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120020');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120021');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120022');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120023');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120024');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120025');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120026');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120027');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120028');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120029');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120030');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120032');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120033');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120034');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120035');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120036');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120038');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120039');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120040');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120041');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120043');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120044');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120045');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120051');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120053');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120055');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120056');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120057');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120058');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120059');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120060');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120062');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120063');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120064');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120065');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120066');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120067');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120068');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120070');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120071');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120072');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120073');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120074');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120075');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120077');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120078');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120080');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120081');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120082');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120083');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120084');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120085');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120086');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120087');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120088');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120089');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120090');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120092');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120094');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120095');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120096');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120097');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120098');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120100');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120101');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120102');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120103');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120104');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120105');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120106');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120107');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120108');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120109');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120110');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120111');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120113');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120114');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120115');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120116');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120119');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120120');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120121');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120122');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120123');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120124');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120125');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120127');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120129');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120131');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120134');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120135');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120136');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120137');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120138');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120140');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120141');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120144');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120145');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120146');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120148');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120149');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120151');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120152');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120153');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120154');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120155');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120156');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120157');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120158');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120159');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120160');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120161');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120162');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120163');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120164');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120165');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120166');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120167');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120168');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120169');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120170');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120171');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120172');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120173');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120174');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120175');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120176');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120177');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120178');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120179');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120180');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120181');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120182');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120183');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120184');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120185');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120186');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120187');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120188');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120189');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120190');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120191');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120192');
insert into rainy_user_loc (user_id,loc)values('R8908068383','120194');
insert into rainy_user_loc (user_id,loc)values('R8306223527','120103');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120036');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120056');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120066');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120096');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120122');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120135');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120136');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120159');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120164');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120166');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120167');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120189');
insert into rainy_user_loc (user_id,loc)values('R7907285165','120191');

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
   AND RU.ID BETWEEN 2004 AND 2014;
--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2004 AND 2014
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 2004 AND 2014 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2004 AND 2014
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
         AND RU.ID BETWEEN 2004 AND 2014
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
        ( SELECT   wm_concat( 'userstores: storeId=' || rull.loc ||',cn=SIMStores,cn=SIM,dc=bbg' ||chr ( 13 ))
     
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
   AND RU.ID BETWEEN 2013 AND 2014;

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
AND RU.ID BETWEEN 2004 AND 2014
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
AND RU.ID BETWEEN 2004 AND 2014 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2004 AND 2014 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2004 AND 2014 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2004 AND 2014 ;
