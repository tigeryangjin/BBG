SELECT * FROM RAINY_USER WHERE USER_ID = 'R7212132528';
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID ='R7212132528';
insert into rainy_user_position(user_id,position_id) values('R7212132528',84);


DROP USER R7212132528;

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
  WHERE RU.ID =1133 ;
  
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
   AND RU.ID =1133;

