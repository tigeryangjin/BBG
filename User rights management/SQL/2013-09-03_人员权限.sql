
insert into rainy_user(user_id,user_name,id) values('R8108140011','袁科峰','2900');
insert into rainy_user(user_id,user_name,id) values('R737116184X','管小妹','2901');
insert into rainy_user(user_id,user_name,id) values('R9208100011','苏虎','2902');
insert into rainy_user(user_id,user_name,id) values('R8607250519','夏杰','2903');

insert into rainy_user(user_id,user_name,id) values('R900516221X','伍豫章','2905');
insert into rainy_user(user_id,user_name,id) values('R7204040066','彭亚辉','2906');
insert into rainy_user(user_id,user_name,id) values('R8806166541','彭海艳','2907');
insert into rainy_user(user_id,user_name,id) values('R7906293025','郭旭艳','2908');

insert into rainy_user(user_id,user_name,id) values('R7602246122','黄春艳','2916');


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
  WHERE RU.ID BETWEEN 2895 AND 2940 ;

--权限变更的用户修改ID列，从BBG_Security_Application_User_List表中获取
SELECT * FROM RAINY_USER
WHERE USER_ID IN( 'R7208170024','R8801246141','R9012278421','R7810144742','R7510180020','R8107190012',
'R7205222536','R7108070038','R8812280036','R8111295732','R790917003X','R7308210342','R7510010274','R8410060958','R8307083018','R7909131055',
'R8102190635','R8706172065') FOR UPDATE;

insert into rainy_user(user_id,user_name,id) values('R7208170024','谷祝湘','2923');
insert into rainy_user(user_id,user_name,id) values('R8801246141','易巧梅','2924');
insert into rainy_user(user_id,user_name,id) values('R9012278421','曾晶','2925');
insert into rainy_user(user_id,user_name,id) values('R7810144742','汤志华','2926');
insert into rainy_user(user_id,user_name,id) values('R7510180020','文晖煌','2927');
insert into rainy_user(user_id,user_name,id) values('R8107190012','邓小聪','2928');
insert into rainy_user(user_id,user_name,id) values('R7205222536','钟少青','2929');
insert into rainy_user(user_id,user_name,id) values('R7108070038','孙书桥','2930');
insert into rainy_user(user_id,user_name,id) values('R8812280036','姚亮','2931');
insert into rainy_user(user_id,user_name,id) values('R8111295732','卿海建','2932');
insert into rainy_user(user_id,user_name,id) values('R790917003X','韦林','2933');
insert into rainy_user(user_id,user_name,id) values('R7308210342','黄晓红','2934');
insert into rainy_user(user_id,user_name,id) values('R7510010274','王志方','2935');
insert into rainy_user(user_id,user_name,id) values('R8410060958','孙在杰','2936');
insert into rainy_user(user_id,user_name,id) values('R8307083018','唐若捷','2937');
insert into rainy_user(user_id,user_name,id) values('R7909131055','朱博','2938');
--insert into rainy_user(user_id,user_name,id) values('R8102190635','韦深尤','2939');
insert into rainy_user(user_id,user_name,id) values('R8706172065','李虹','2940');*/

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
   AND RU.ID BETWEEN 2895 AND 2940;

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
AND RU.ID BETWEEN 2895 AND 2940 ;

--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2895 AND 2940 ;



--用户地点权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2895 AND 2940 ;   
--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2895 AND 2940);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2895 AND 2940);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2895 AND 2940);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2895 AND 2940);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2895 AND 2940);




insert into rainy_user_position(user_id,position_id) values('R6907230063',86);
insert into rainy_user_position(user_id,position_id) values('R770524154X',86);
insert into rainy_user_position(user_id,position_id) values('R8601045514',86);
insert into rainy_user_position(user_id,position_id) values('R7411140842',86);
insert into rainy_user_position(user_id,position_id) values('R8705149117',84);
insert into rainy_user_position(user_id,position_id) values('R8108140011',95);
insert into rainy_user_position(user_id,position_id) values('R737116184X',86);
insert into rainy_user_position(user_id,position_id) values('R9208100011',96);
insert into rainy_user_position(user_id,position_id) values('R8607250519',95);
insert into rainy_user_position(user_id,position_id) values('R8107252512',85);
insert into rainy_user_position(user_id,position_id) values('R900516221X',93);
insert into rainy_user_position(user_id,position_id) values('R7204040066',86);
insert into rainy_user_position(user_id,position_id) values('R8806166541',86);
insert into rainy_user_position(user_id,position_id) values('R7906293025',86);
insert into rainy_user_position(user_id,position_id) values('R8910172663',86);
insert into rainy_user_position(user_id,position_id) values('R7301100033',86);
insert into rainy_user_position(user_id,position_id) values('R7801040479',86);
insert into rainy_user_position(user_id,position_id) values('R7112266229',86);
insert into rainy_user_position(user_id,position_id) values('R8908093018',86);
insert into rainy_user_position(user_id,position_id) values('R740713254X',86);
insert into rainy_user_position(user_id,position_id) values('R6809010088',85);
insert into rainy_user_position(user_id,position_id) values('R7602246122',86);
insert into rainy_user_position(user_id,position_id) values('R7512013013',85);
insert into rainy_user_position(user_id,position_id) values('R7507141526',84);
insert into rainy_user_position(user_id,position_id) values('R9206289524',85);
insert into rainy_user_position(user_id,position_id) values('R7909129024',86);
insert into rainy_user_position(user_id,position_id) values('R8003184726',86);
insert into rainy_user_position(user_id,position_id) values('R6609207946',86);
insert into rainy_user_position(user_id,position_id) values('R7208170024',86);
insert into rainy_user_position(user_id,position_id) values('R8801246141',86);
insert into rainy_user_position(user_id,position_id) values('R9012278421',86);
insert into rainy_user_position(user_id,position_id) values('R7810144742',86);
insert into rainy_user_position(user_id,position_id) values('R7510180020',88);
insert into rainy_user_position(user_id,position_id) values('R8107190012',95);
insert into rainy_user_position(user_id,position_id) values('R7205222536',88);
insert into rainy_user_position(user_id,position_id) values('R7108070038',85);
insert into rainy_user_position(user_id,position_id) values('R8812280036',86);
insert into rainy_user_position(user_id,position_id) values('R8111295732',86);
insert into rainy_user_position(user_id,position_id) values('R790917003X',86);
insert into rainy_user_position(user_id,position_id) values('R7308210342',86);
insert into rainy_user_position(user_id,position_id) values('R7510010274',86);
insert into rainy_user_position(user_id,position_id) values('R8410060958',86);
insert into rainy_user_position(user_id,position_id) values('R8307083018',86);
insert into rainy_user_position(user_id,position_id) values('R7909131055',85);
insert into rainy_user_position(user_id,position_id) values('R8102190635',86);
insert into rainy_user_position(user_id,position_id) values('R8706172065',86);
--------------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R6907230063','12');
insert into rainy_user_merch(user_id,merch) values('R6907230063','13');
insert into rainy_user_merch(user_id,merch) values('R6907230063','14');
insert into rainy_user_merch(user_id,merch) values('R6907230063','15');
insert into rainy_user_merch(user_id,merch) values('R6907230063','16');
insert into rainy_user_merch(user_id,merch) values('R6907230063','17');
insert into rainy_user_merch(user_id,merch) values('R6907230063','18');
insert into rainy_user_merch(user_id,merch) values('R6907230063','19');
insert into rainy_user_merch(user_id,merch) values('R6907230063','21');
insert into rainy_user_merch(user_id,merch) values('R6907230063','22');
insert into rainy_user_merch(user_id,merch) values('R6907230063','23');
insert into rainy_user_merch(user_id,merch) values('R6907230063','24');
insert into rainy_user_merch(user_id,merch) values('R6907230063','25');
insert into rainy_user_merch(user_id,merch) values('R6907230063','26');
insert into rainy_user_merch(user_id,merch) values('R6907230063','29');
insert into rainy_user_merch(user_id,merch) values('R6907230063','76');
insert into rainy_user_merch(user_id,merch) values('R770524154X','31');
insert into rainy_user_merch(user_id,merch) values('R770524154X','34');
insert into rainy_user_merch(user_id,merch) values('R770524154X','39');
insert into rainy_user_merch(user_id,merch) values('R770524154X','40');
insert into rainy_user_merch(user_id,merch) values('R8601045514','36');
insert into rainy_user_merch(user_id,merch) values('R8601045514','37');
insert into rainy_user_merch(user_id,merch) values('R7411140842','34');
insert into rainy_user_merch(user_id,merch) values('R7411140842','39');
insert into rainy_user_merch(user_id,merch) values('R8705149117','ALL');
insert into rainy_user_merch(user_id,merch) values('R8108140011','ALL');
insert into rainy_user_merch(user_id,merch) values('R737116184X','34');
insert into rainy_user_merch(user_id,merch) values('R737116184X','36');
insert into rainy_user_merch(user_id,merch) values('R737116184X','37');
insert into rainy_user_merch(user_id,merch) values('R737116184X','38');
insert into rainy_user_merch(user_id,merch) values('R737116184X','39');
insert into rainy_user_merch(user_id,merch) values('R9208100011','ALL');
insert into rainy_user_merch(user_id,merch) values('R8607250519','71');
insert into rainy_user_merch(user_id,merch) values('R8607250519','72');
insert into rainy_user_merch(user_id,merch) values('R8607250519','73');
insert into rainy_user_merch(user_id,merch) values('R8607250519','74');
insert into rainy_user_merch(user_id,merch) values('R8607250519','75');
insert into rainy_user_merch(user_id,merch) values('R8607250519','76');
insert into rainy_user_merch(user_id,merch) values('R8607250519','77');
insert into rainy_user_merch(user_id,merch) values('R8607250519','78');
insert into rainy_user_merch(user_id,merch) values('R8107252512','31');
insert into rainy_user_merch(user_id,merch) values('R8107252512','32');
insert into rainy_user_merch(user_id,merch) values('R8107252512','33');
insert into rainy_user_merch(user_id,merch) values('R8107252512','34');
insert into rainy_user_merch(user_id,merch) values('R8107252512','35');
insert into rainy_user_merch(user_id,merch) values('R8107252512','36');
insert into rainy_user_merch(user_id,merch) values('R8107252512','37');
insert into rainy_user_merch(user_id,merch) values('R8107252512','38');
insert into rainy_user_merch(user_id,merch) values('R8107252512','39');
insert into rainy_user_merch(user_id,merch) values('R8107252512','40');
insert into rainy_user_merch(user_id,merch) values('R8107252512','41');
insert into rainy_user_merch(user_id,merch) values('R8107252512','42');
insert into rainy_user_merch(user_id,merch) values('R7204040066','27');
insert into rainy_user_merch(user_id,merch) values('R7204040066','33');
insert into rainy_user_merch(user_id,merch) values('R7204040066','38');
insert into rainy_user_merch(user_id,merch) values('R8806166541','12');
insert into rainy_user_merch(user_id,merch) values('R8806166541','13');
insert into rainy_user_merch(user_id,merch) values('R8806166541','14');
insert into rainy_user_merch(user_id,merch) values('R8806166541','15');
insert into rainy_user_merch(user_id,merch) values('R8806166541','16');
insert into rainy_user_merch(user_id,merch) values('R8806166541','17');
insert into rainy_user_merch(user_id,merch) values('R8806166541','18');
insert into rainy_user_merch(user_id,merch) values('R8806166541','19');
insert into rainy_user_merch(user_id,merch) values('R7906293025','12');
insert into rainy_user_merch(user_id,merch) values('R7906293025','13');
insert into rainy_user_merch(user_id,merch) values('R7906293025','14');
insert into rainy_user_merch(user_id,merch) values('R7906293025','15');
insert into rainy_user_merch(user_id,merch) values('R7906293025','16');
insert into rainy_user_merch(user_id,merch) values('R7906293025','17');
insert into rainy_user_merch(user_id,merch) values('R7906293025','18');
insert into rainy_user_merch(user_id,merch) values('R7906293025','19');
insert into rainy_user_merch(user_id,merch) values('R8910172663','25');
insert into rainy_user_merch(user_id,merch) values('R8910172663','26');
insert into rainy_user_merch(user_id,merch) values('R8910172663','29');
insert into rainy_user_merch(user_id,merch) values('R7301100033','32');
insert into rainy_user_merch(user_id,merch) values('R7301100033','35');
insert into rainy_user_merch(user_id,merch) values('R7301100033','42');
insert into rainy_user_merch(user_id,merch) values('R7801040479','22');
insert into rainy_user_merch(user_id,merch) values('R7801040479','29');
insert into rainy_user_merch(user_id,merch) values('R7112266229','12');
insert into rainy_user_merch(user_id,merch) values('R7112266229','13');
insert into rainy_user_merch(user_id,merch) values('R7112266229','14');
insert into rainy_user_merch(user_id,merch) values('R7112266229','15');
insert into rainy_user_merch(user_id,merch) values('R7112266229','76');
insert into rainy_user_merch(user_id,merch) values('R8908093018','21');
insert into rainy_user_merch(user_id,merch) values('R8908093018','26');
insert into rainy_user_merch(user_id,merch) values('R740713254X','16');
insert into rainy_user_merch(user_id,merch) values('R740713254X','17');
insert into rainy_user_merch(user_id,merch) values('R740713254X','18');
insert into rainy_user_merch(user_id,merch) values('R740713254X','19');
insert into rainy_user_merch(user_id,merch) values('R6809010088','21');
insert into rainy_user_merch(user_id,merch) values('R6809010088','22');
insert into rainy_user_merch(user_id,merch) values('R6809010088','23');
insert into rainy_user_merch(user_id,merch) values('R6809010088','24');
insert into rainy_user_merch(user_id,merch) values('R6809010088','25');
insert into rainy_user_merch(user_id,merch) values('R6809010088','26');
insert into rainy_user_merch(user_id,merch) values('R6809010088','29');
insert into rainy_user_merch(user_id,merch) values('R7602246122','25');
insert into rainy_user_merch(user_id,merch) values('R7602246122','26');
insert into rainy_user_merch(user_id,merch) values('R7602246122','29');
insert into rainy_user_merch(user_id,merch) values('R7512013013','21');
insert into rainy_user_merch(user_id,merch) values('R7512013013','22');
insert into rainy_user_merch(user_id,merch) values('R7512013013','23');
insert into rainy_user_merch(user_id,merch) values('R7512013013','24');
insert into rainy_user_merch(user_id,merch) values('R7512013013','25');
insert into rainy_user_merch(user_id,merch) values('R7512013013','26');
insert into rainy_user_merch(user_id,merch) values('R7512013013','29');
insert into rainy_user_merch(user_id,merch) values('R7507141526','ALL');
insert into rainy_user_merch(user_id,merch) values('R9206289524','27');
insert into rainy_user_merch(user_id,merch) values('R9206289524','30');
insert into rainy_user_merch(user_id,merch) values('R9206289524','31');
insert into rainy_user_merch(user_id,merch) values('R9206289524','32');
insert into rainy_user_merch(user_id,merch) values('R9206289524','33');
insert into rainy_user_merch(user_id,merch) values('R9206289524','34');
insert into rainy_user_merch(user_id,merch) values('R9206289524','35');
insert into rainy_user_merch(user_id,merch) values('R9206289524','36');
insert into rainy_user_merch(user_id,merch) values('R9206289524','37');
insert into rainy_user_merch(user_id,merch) values('R9206289524','38');
insert into rainy_user_merch(user_id,merch) values('R9206289524','39');
insert into rainy_user_merch(user_id,merch) values('R9206289524','40');
insert into rainy_user_merch(user_id,merch) values('R9206289524','41');
insert into rainy_user_merch(user_id,merch) values('R9206289524','42');
insert into rainy_user_merch(user_id,merch) values('R7909129024','27');
insert into rainy_user_merch(user_id,merch) values('R7909129024','30');
insert into rainy_user_merch(user_id,merch) values('R7909129024','31');
insert into rainy_user_merch(user_id,merch) values('R7909129024','32');
insert into rainy_user_merch(user_id,merch) values('R7909129024','33');
insert into rainy_user_merch(user_id,merch) values('R7909129024','34');
insert into rainy_user_merch(user_id,merch) values('R7909129024','35');
insert into rainy_user_merch(user_id,merch) values('R7909129024','36');
insert into rainy_user_merch(user_id,merch) values('R7909129024','37');
insert into rainy_user_merch(user_id,merch) values('R7909129024','38');
insert into rainy_user_merch(user_id,merch) values('R7909129024','39');
insert into rainy_user_merch(user_id,merch) values('R7909129024','40');
insert into rainy_user_merch(user_id,merch) values('R7909129024','41');
insert into rainy_user_merch(user_id,merch) values('R7909129024','42');
insert into rainy_user_merch(user_id,merch) values('R8003184726','36');
insert into rainy_user_merch(user_id,merch) values('R8003184726','37');
insert into rainy_user_merch(user_id,merch) values('R8003184726','41');
insert into rainy_user_merch(user_id,merch) values('R6609207946','30');
insert into rainy_user_merch(user_id,merch) values('R6609207946','31');
insert into rainy_user_merch(user_id,merch) values('R6609207946','32');
insert into rainy_user_merch(user_id,merch) values('R6609207946','34');
insert into rainy_user_merch(user_id,merch) values('R6609207946','35');
insert into rainy_user_merch(user_id,merch) values('R6609207946','39');
insert into rainy_user_merch(user_id,merch) values('R6609207946','40');
insert into rainy_user_merch(user_id,merch) values('R6609207946','42');
insert into rainy_user_merch(user_id,merch) values('R7208170024','21');
insert into rainy_user_merch(user_id,merch) values('R7208170024','22');
insert into rainy_user_merch(user_id,merch) values('R7208170024','23');
insert into rainy_user_merch(user_id,merch) values('R7208170024','24');
insert into rainy_user_merch(user_id,merch) values('R7208170024','25');
insert into rainy_user_merch(user_id,merch) values('R7208170024','26');
insert into rainy_user_merch(user_id,merch) values('R8801246141','21');
insert into rainy_user_merch(user_id,merch) values('R8801246141','22');
insert into rainy_user_merch(user_id,merch) values('R8801246141','23');
insert into rainy_user_merch(user_id,merch) values('R8801246141','24');
insert into rainy_user_merch(user_id,merch) values('R8801246141','25');
insert into rainy_user_merch(user_id,merch) values('R8801246141','26');
insert into rainy_user_merch(user_id,merch) values('R9012278421','11');
insert into rainy_user_merch(user_id,merch) values('R9012278421','12');
insert into rainy_user_merch(user_id,merch) values('R9012278421','13');
insert into rainy_user_merch(user_id,merch) values('R9012278421','14');
insert into rainy_user_merch(user_id,merch) values('R9012278421','15');
insert into rainy_user_merch(user_id,merch) values('R9012278421','16');
insert into rainy_user_merch(user_id,merch) values('R9012278421','17');
insert into rainy_user_merch(user_id,merch) values('R9012278421','18');
insert into rainy_user_merch(user_id,merch) values('R9012278421','19');
insert into rainy_user_merch(user_id,merch) values('R9012278421','29');
insert into rainy_user_merch(user_id,merch) values('R9012278421','76');
insert into rainy_user_merch(user_id,merch) values('R7810144742','11');
insert into rainy_user_merch(user_id,merch) values('R7810144742','12');
insert into rainy_user_merch(user_id,merch) values('R7810144742','13');
insert into rainy_user_merch(user_id,merch) values('R7810144742','14');
insert into rainy_user_merch(user_id,merch) values('R7810144742','15');
insert into rainy_user_merch(user_id,merch) values('R7810144742','16');
insert into rainy_user_merch(user_id,merch) values('R7810144742','17');
insert into rainy_user_merch(user_id,merch) values('R7810144742','18');
insert into rainy_user_merch(user_id,merch) values('R7810144742','19');
insert into rainy_user_merch(user_id,merch) values('R7810144742','29');
insert into rainy_user_merch(user_id,merch) values('R7810144742','76');
insert into rainy_user_merch(user_id,merch) values('R7510180020','ALL');
insert into rainy_user_merch(user_id,merch) values('R8107190012','ALL');
insert into rainy_user_merch(user_id,merch) values('R7205222536','ALL');
insert into rainy_user_merch(user_id,merch) values('R7108070038','30');
insert into rainy_user_merch(user_id,merch) values('R7108070038','31');
insert into rainy_user_merch(user_id,merch) values('R7108070038','32');
insert into rainy_user_merch(user_id,merch) values('R7108070038','33');
insert into rainy_user_merch(user_id,merch) values('R7108070038','34');
insert into rainy_user_merch(user_id,merch) values('R7108070038','35');
insert into rainy_user_merch(user_id,merch) values('R7108070038','36');
insert into rainy_user_merch(user_id,merch) values('R7108070038','37');
insert into rainy_user_merch(user_id,merch) values('R7108070038','38');
insert into rainy_user_merch(user_id,merch) values('R7108070038','39');
insert into rainy_user_merch(user_id,merch) values('R7108070038','42');
insert into rainy_user_merch(user_id,merch) values('R8812280036','36');
insert into rainy_user_merch(user_id,merch) values('R8812280036','37');
insert into rainy_user_merch(user_id,merch) values('R8111295732','27');
insert into rainy_user_merch(user_id,merch) values('R790917003X','32');
insert into rainy_user_merch(user_id,merch) values('R790917003X','35');
insert into rainy_user_merch(user_id,merch) values('R7308210342','34');
insert into rainy_user_merch(user_id,merch) values('R7308210342','39');
insert into rainy_user_merch(user_id,merch) values('R7510010274','31');
insert into rainy_user_merch(user_id,merch) values('R8410060958','29');
insert into rainy_user_merch(user_id,merch) values('R8307083018','21');
insert into rainy_user_merch(user_id,merch) values('R8307083018','22');
insert into rainy_user_merch(user_id,merch) values('R8307083018','23');
insert into rainy_user_merch(user_id,merch) values('R8307083018','24');
insert into rainy_user_merch(user_id,merch) values('R8307083018','25');
insert into rainy_user_merch(user_id,merch) values('R8307083018','26');
insert into rainy_user_merch(user_id,merch) values('R8307083018','27');
insert into rainy_user_merch(user_id,merch) values('R7909131055','11');
insert into rainy_user_merch(user_id,merch) values('R7909131055','12');
insert into rainy_user_merch(user_id,merch) values('R7909131055','13');
insert into rainy_user_merch(user_id,merch) values('R7909131055','14');
insert into rainy_user_merch(user_id,merch) values('R7909131055','15');
insert into rainy_user_merch(user_id,merch) values('R7909131055','16');
insert into rainy_user_merch(user_id,merch) values('R7909131055','17');
insert into rainy_user_merch(user_id,merch) values('R7909131055','18');
insert into rainy_user_merch(user_id,merch) values('R7909131055','19');
insert into rainy_user_merch(user_id,merch) values('R8102190635','16');
insert into rainy_user_merch(user_id,merch) values('R8102190635','17');
insert into rainy_user_merch(user_id,merch) values('R8102190635','18');
insert into rainy_user_merch(user_id,merch) values('R8102190635','19');
insert into rainy_user_merch(user_id,merch) values('R8706172065','11');
insert into rainy_user_merch(user_id,merch) values('R8706172065','12');
insert into rainy_user_merch(user_id,merch) values('R8706172065','13');
insert into rainy_user_merch(user_id,merch) values('R8706172065','14');
insert into rainy_user_merch(user_id,merch) values('R8706172065','15');
------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R6907230063','120116');
insert into rainy_user_loc (user_id,loc)values('R770524154X','120171');
insert into rainy_user_loc (user_id,loc)values('R8601045514','120051');
insert into rainy_user_loc (user_id,loc)values('R7411140842','120051');
insert into rainy_user_loc (user_id,loc)values('R8705149117','120103');
insert into rainy_user_loc (user_id,loc)values('R8108140011','120171');
insert into rainy_user_loc (user_id,loc)values('R737116184X','120171');
insert into rainy_user_loc (user_id,loc)values('R9208100011','120171');
insert into rainy_user_loc (user_id,loc)values('R8607250519','130014');
insert into rainy_user_loc (user_id,loc)values('R8107252512','120149');
insert into rainy_user_loc (user_id,loc)values('R900516221X','120149');
insert into rainy_user_loc (user_id,loc)values('R7204040066','120020');
insert into rainy_user_loc (user_id,loc)values('R8806166541','120020');
insert into rainy_user_loc (user_id,loc)values('R7906293025','120189');
insert into rainy_user_loc (user_id,loc)values('R8910172663','120186');
insert into rainy_user_loc (user_id,loc)values('R7301100033','120043');
insert into rainy_user_loc (user_id,loc)values('R7801040479','120043');
insert into rainy_user_loc (user_id,loc)values('R7112266229','120043');
insert into rainy_user_loc (user_id,loc)values('R8908093018','120043');
insert into rainy_user_loc (user_id,loc)values('R740713254X','120043');
insert into rainy_user_loc (user_id,loc)values('R6809010088','120023');
insert into rainy_user_loc (user_id,loc)values('R7602246122','120023');
insert into rainy_user_loc (user_id,loc)values('R7512013013','120063');
insert into rainy_user_loc (user_id,loc)values('R7507141526','120177');
insert into rainy_user_loc (user_id,loc)values('R9206289524','120177');
insert into rainy_user_loc (user_id,loc)values('R7909129024','120177');
insert into rainy_user_loc (user_id,loc)values('R8003184726','120177');
insert into rainy_user_loc (user_id,loc)values('R6609207946','120177');
insert into rainy_user_loc (user_id,loc)values('R7208170024','120177');
insert into rainy_user_loc (user_id,loc)values('R8801246141','120177');
insert into rainy_user_loc (user_id,loc)values('R9012278421','120177');
insert into rainy_user_loc (user_id,loc)values('R7810144742','120177');
insert into rainy_user_loc (user_id,loc)values('R7510180020','120177');
insert into rainy_user_loc (user_id,loc)values('R8107190012','120177');
insert into rainy_user_loc (user_id,loc)values('R7205222536','120195');
insert into rainy_user_loc (user_id,loc)values('R7108070038','120195');
insert into rainy_user_loc (user_id,loc)values('R8812280036','120195');
insert into rainy_user_loc (user_id,loc)values('R8111295732','120195');
insert into rainy_user_loc (user_id,loc)values('R790917003X','120195');
insert into rainy_user_loc (user_id,loc)values('R7308210342','120195');
insert into rainy_user_loc (user_id,loc)values('R7510010274','120195');
insert into rainy_user_loc (user_id,loc)values('R8410060958','120195');
insert into rainy_user_loc (user_id,loc)values('R8307083018','120195');
insert into rainy_user_loc (user_id,loc)values('R7909131055','120195');
insert into rainy_user_loc (user_id,loc)values('R8102190635','120195');
insert into rainy_user_loc (user_id,loc)values('R8706172065','120195');



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
   AND RU.ID BETWEEN 2895 AND 2940;

--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2895 AND 2940
and user_id not in ( select user_id from user_attrib );

--插入sec_user_group表，分二种情况插入
--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2895 AND 2940 ;
--Department大类   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2895 AND 2940
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
         AND RU.ID BETWEEN 2895 AND 2940
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
   AND RU.ID BETWEEN 2895 AND 2940;

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
AND RU.ID BETWEEN 2895 AND 2940
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
AND RU.ID BETWEEN 2895 AND 2940 ;

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2895 AND 2940 ;



--用户地点权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2895 AND 2940 ;

--用户名和密码导出成EXCEL表格发邮件
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2895 AND 2940 
ORDER BY RU.ID;
