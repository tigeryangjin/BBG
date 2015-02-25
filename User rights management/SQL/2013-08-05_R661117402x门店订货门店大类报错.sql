SELECT * FROM RAINY_USER T WHERE T.USER_ID='R661117402X' FOR UPDATE ;
SELECT * FROM RAINY_USER_LOC T WHERE T.USER_ID='R661117402X';
SELECT * FROM RAINY_USER_MERCH T WHERE T.USER_ID='R661117402X';
SELECT * FROM RAINY_USER_POSITION T WHERE T.USER_ID='R661117402X';

--删除表中用户数据，权限清除后需要删除的表
DELETE FROM RSM_USER_ROLE WHERE user_id IN ('R661117402X' );
DELETE FROM SEC_USER_GROUP WHERE USER_ID IN ('R661117402X' );
DELETE FROM RAINY_USER_LOC WHERE USER_ID IN ('R661117402X' );
DELETE FROM RAINY_USER_MERCH WHERE USER_ID IN ('R661117402X' );
DELETE FROM RAINY_USER_POSITION WHERE USER_ID IN ('R661117402X' );

----------------------------------------------------------

DROP USER  R661117402X;
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
  WHERE RS.USER_ID='R661117402X' ;






insert into rainy_user_loc (user_id,loc)values('R661117402X','118005');
insert into rainy_user_loc (user_id,loc)values('R661117402X','118011');
insert into rainy_user_loc (user_id,loc)values('R661117402X','118012');
insert into rainy_user_loc (user_id,loc)values('R661117402X','120017');

insert into rainy_user_merch(user_id,merch) values('R661117402X','27');
insert into rainy_user_merch(user_id,merch) values('R661117402X','30');
insert into rainy_user_merch(user_id,merch) values('R661117402X','31');
insert into rainy_user_merch(user_id,merch) values('R661117402X','32');
insert into rainy_user_merch(user_id,merch) values('R661117402X','33');
insert into rainy_user_merch(user_id,merch) values('R661117402X','34');
insert into rainy_user_merch(user_id,merch) values('R661117402X','35');
insert into rainy_user_merch(user_id,merch) values('R661117402X','36');
insert into rainy_user_merch(user_id,merch) values('R661117402X','37');
insert into rainy_user_merch(user_id,merch) values('R661117402X','38');
insert into rainy_user_merch(user_id,merch) values('R661117402X','39');
insert into rainy_user_merch(user_id,merch) values('R661117402X','40');
insert into rainy_user_merch(user_id,merch) values('R661117402X','41');
insert into rainy_user_merch(user_id,merch) values('R661117402X','42');

insert into rainy_user_position(user_id,position_id) values('R661117402X',85);



--新建用户插入用户属性表，lang字段8表示中文，1表示英文
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru 
  WHERE RU.ID=1228;
  
  SELECT * FROM user_attrib WHERE USER_ID LIKE '%R661117402%' FOR UPDATE;

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where  to_number (id ) =1228
and user_id not in ( select user_id from user_attrib );


--Location地点
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.USER_ID IN ('R661117402X' );
--Department大类    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.USER_ID IN ('R661117402X' )
     group by sg.group_id,ru.user_id;
     
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
   AND RU.USER_ID IN ('R661117402X' );
