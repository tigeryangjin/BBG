insert into rainy_user(user_id,user_name,id) values('R8308052287','邹晶','901');
insert into rainy_user(user_id,user_name,id) values('R7311100025','张燕','902');
--职位
insert into rainy_user_position(user_id,position_id) values('R8308052287',85);
insert into rainy_user_position(user_id,position_id) values('R7311100025',84);
--类别
  insert into rainy_user_merch(user_id,merch) values('R8308052287','11');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','12');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','13');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','14');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','15');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','16');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','17');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','18');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','19');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','21');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','22');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','23');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','24');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','25');  
  insert into rainy_user_merch(user_id,merch) values('R8308052287','26');		
  insert into rainy_user_merch(user_id,merch) values('R8308052287','29');																			
  insert into rainy_user_merch(user_id,merch) values('R8308052287','76');			
insert into rainy_user_merch(user_id,merch) values('R7311100025','ALL');																																							
--店别
insert into rainy_user_loc (user_id,loc)values('R8308052287','120115');
insert into rainy_user_loc (user_id,loc)values('R7311100025','120115');

--密码
update rainy_user t
set t.password =( select upper(dbms_random.string ('u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value (0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where t.password is null


--创建用户
SELECT
 'create user ' || rs.user_id || ' identified by ' || rs.password ||
  ' default tablespace RETEK_DATA
temporary tablespace TEMP
quota unlimited on RETEK_DATA
quota unlimited on RETEK_INDEX' || ' ; '   || chr( 13) ||
 'grant alter session ,       analyze any,      create any view,      create library,      create procedure,      create sequence,
      create session,      create synonym,      create table,      create trigger,      create view,      create job,      delete any table,
        drop any procedure,      drop any view,        drop any table,      execute any procedure,      execute any type,      insert any table,
      select any sequence,      select any table,      update any table,        select any dictionary
to ' || rs.user_id || ' ;' || chr (13 ) ||
 
  'grant select on sys.dba_role_privs to ' || rs.user_id || ' ;' ||chr( 13) ||
  'grant select on sys.dba_jobs to ' || rs.user_id || ' ;' ||chr( 13) ||
  'grant select on sys.dba_roles to ' || rs.user_id || '; ' ||chr( 13) ||
  'grant execute on dbms_rls to ' || rs.user_id || ';' ||chr (13 ) ||
  'grant execute on sys.dbms_crypto to ' || rs.user_id || '; ' ||chr( 13) ||
  'grant select on sys.dba_sys_privs to ' || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_alert to ' || rs.user_id || ' ;' ||chr( 13) ||
  'grant execute on sys.dbms_lock to ' || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_system to ' || rs.user_id || ';' ||chr( 13) ||
  'grant AQ_ADMINISTRATOR_ROLE to ' || rs.user_id || ';' ||chr( 13) ||
  'grant execute on DBMS_AQ to ' || rs.user_id || ';' ||chr (13 ) ||
  'grant execute on DBMS_AQADM to ' || rs.user_id || ';'
  FROM rainy_user rs 
  WHERE rs.user_id IN('R8308052287','R7311100025');
  
--添加新职位权限
--查询出来的数据用sys用户名执行
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr ,
       rainy_user          ru ,
       rainy_user_position rup ,
       rainy_position_role rpr 
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.USER_ID IN ('R8308052287','R7311100025');
   
--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru 
  WHERE RU.USER_ID IN ('R8308052287','R7311100025');

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where  to_number (id ) between 901 and 902
and user_id not in ( select user_id from user_attrib )

SELECT * FROM RAINY_USER WHERE USER_ID IN ('R8308052287','R7311100025');
SELECT * FROM user_attrib WHERE USER_ID IN ('R8308052287','R7311100025');

--插入sec_user_group表，分二种情况插入
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.USER_ID IN ('R8308052287','R7311100025');
    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.USER_ID IN ('R8308052287','R7311100025')
     group by sg.group_id,ru.user_id;
     
--插入RSM_USER_ROLE表
insert into RSM_USER_ROLE
select  rsm_user_role_seq.nextval, a.user_id, a.role_ext, SYSDATE - 720, null
from ( SELECT ru.user_id user_id ,ra.role_ext role_ext     
        FROM rainy_user ru , rainy_user_position rup , rainy_position_role rpr,RAINY_ROLE ra
       WHERE ru.user_id = rup.user_id
         AND rup.position_id = rpr.position_id
         and rpr.role_id =ra.role_id and ra.appl ='RPM'
         --注意以下条件
         AND RU.USER_ID IN ('R8308052287','R7311100025')
         group  by ru.user_id ,ra.role_ext ) a 
where a.role_ext is not null ;

--SIM系统导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import  
SELECT rr.role_name, ru.user_id, 'dn: roleName=' || rr.role_name || ',cn=' || ru.user_id ||
        ',cn=Users,dc=bbg
changetype: add
objectclass: simUserRole
roleName: ' || rr.role_name || chr (13 ) || 'userRole: roleName=' ||
        rr.role_name || ',cn=SIMRoles,cn=SIM,dc=bbg
userRoleStores: ' || wm_concat( 'storeId=' || rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg' ||chr (13 ))
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
and rul.loc= 'ALL'
AND RU.USER_ID IN ('R8308052287','R7311100025')
GROUP BY   rr.role_name, ru.user_id;

--RA/BIP权限导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn=' ||ru.user_id ||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup ,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.USER_ID IN ('R8308052287','R7311100025');

--用户大类权限导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@'|| MERCH|| ',cn=Groups,dc=bbg' ||CHR (10 )||
'changetype: modify' ||CHR (10 )||
'add: uniquemember' ||CHR (10 )||
'uniquemember: cn=' ||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id= ru.user_id
where   to_number( ru.id) between 901 and 902   ;

--用户地点权限导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import 
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'|| a.LOC|| ',cn=Groups,dc=bbg' ||CHR (10 )||
'changetype: modify' ||CHR (10 )||
'add: uniquemember' ||CHR (10 )||
'uniquemember: cn=' ||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id= ru.user_id
where   to_number( ru.id) between 901 and 902 ;

SELECT * FROM RAINY_USER WHERE to_number(id) between 901 and 902 ;











	
