SELECT * FROM RAINY_USER WHERE USER_ID IN ('9408242584',
'9408242605',
'9301062559',
'9209285677',
'9002273054',
'9203202752',
'9408092088')


insert into rainy_user(user_id,user_name,id) values('R9408242584','��ʫ��','1385');
insert into rainy_user(user_id,user_name,id) values('R9408242605','��ʫ��','1386');
insert into rainy_user(user_id,user_name,id) values('R9301062559','������','1387');
insert into rainy_user(user_id,user_name,id) values('R9209285677','Ҧ�۷�','1388');
insert into rainy_user(user_id,user_name,id) values('R9002273054','����','1389');
insert into rainy_user(user_id,user_name,id) values('R9203202752','��־��','1390');
insert into rainy_user(user_id,user_name,id) values('R9408092088','������','1391');



--�޸�����
update rainy_user t
set t.password =( select upper(dbms_random.string ('u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value (0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where t.password is null

--����DB�û�
--�����sys�û���ִ��
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
  WHERE RS.ID BETWEEN 1385 AND 1391 ;


--��λд��
SELECT * FROM RAINY_POSITION T FOR UPDATE;

--��λȨ��д��
25,28
insert into RAINY_POSITION_ROLE(role_id,position_id) values(25,127);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(28,127);
insert into RAINY_POSITION_ROLE(role_id,position_id) values(26,127);

SELECT * FROM RAINY_POSITION_ROLE WHERE POSITION_ID=127 AND role_id IN (25,28) FOR UPDATE 
--�����ְλȨ��
--RMSϵͳȨ��
--��ѯ������������sys�û���ִ��
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr  ,
       rainy_user          ru  ,
       rainy_user_position rup ,
       rainy_position_role rpr 
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.ID BETWEEN 1385 AND 1391;
   
   SELECT * FROM rainy_user T WHERE T.ID BETWEEN 1385 AND 1391;
   SELECT * FROM rainy_user_position T WHERE T.POSITION_ID=127;
   SELECT * FROM rainy_position_role T WHERE T.POSITION_ID=127;
   SELECT * FROM rainy_role T WHERE T.ROLE_ID IN (25,28);
   
   
   

   
--insert into RAINY_POSITION_ROLE(role_id,position_id) values(43,124);

SELECT * FROM rainy_user_loc T WHERE T.USER_ID IN (
'9408242584',
'9408242605',
'9301062559',
'9209285677',
'9002273054',
'9203202752',
'9408092088') FOR UPDATE;
--���й��ŵ�ְλȨ�޵�������excel[Position������]�и��Ƴ������������ִ��
insert into rainy_user_position( user_id, position_id) values('R9408242584' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9408242605' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9301062559' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9209285677' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9002273054' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9203202752' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9408092088' ,127 );
--���й��ŵĴ���Ȩ�޵�������excel[Merchandise������]�и��Ƴ������������ִ��
insert into rainy_user_merch( user_id, merch) values('R9408242584' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9408242605' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9301062559' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9209285677' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9002273054' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9203202752' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9408092088' ,'ALL' );
--���й��ŵĵص�Ȩ�޵�������excel[Organization������]�и��Ƴ������������ִ��
insert into rainy_user_loc (user_id ,loc )values ('R9408242584' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9408242605' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9301062559' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9209285677' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9002273054' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9203202752' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9408092088' ,'ALL' );

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE ru.ID BETWEEN 1385 AND 1391;


--**************************************************************************************************
--�ڶ�������5��
������	9301284526
����	99007137088
�ƽ�ǿ	9312150015
������	9305260514
������	970429205X

SELECT * FROM RAINY_USER

insert into rainy_user(user_id,user_name,id) values('R9301284526','������','1424');
insert into rainy_user(user_id,user_name,id) values('R9907137088','����','1425');
insert into rainy_user(user_id,user_name,id) values('R9312150015','�ƽ�ǿ','1426');
insert into rainy_user(user_id,user_name,id) values('R9305260514','������','1427');
insert into rainy_user(user_id,user_name,id) values('R970429205X','������','1428');


--�޸�����
update rainy_user t
set t.password =( select upper(dbms_random.string ('u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value (0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where t.password is null


--����DB�û�
--�����sys�û���ִ��
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
  WHERE RS.ID BETWEEN 1424 AND 1428 ;
  
--���й��ŵ�ְλȨ�޵�������excel[Position������]�и��Ƴ������������ִ��
insert into rainy_user_position( user_id, position_id) values('R9301284526' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9907137088' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9312150015' ,127 );
insert into rainy_user_position( user_id, position_id) values('R9305260514' ,127 );
insert into rainy_user_position( user_id, position_id) values('R970429205X' ,127 );
--���й��ŵĴ���Ȩ�޵�������excel[Merchandise������]�и��Ƴ������������ִ��
insert into rainy_user_merch( user_id, merch) values('R9301284526' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9907137088' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9312150015' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R9305260514' ,'ALL' );
insert into rainy_user_merch( user_id, merch) values('R970429205X' ,'ALL' );
--���й��ŵĵص�Ȩ�޵�������excel[Organization������]�и��Ƴ������������ִ��
insert into rainy_user_loc (user_id ,loc )values ('R9301284526' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9907137088' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9312150015' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R9305260514' ,'ALL' );
insert into rainy_user_loc (user_id ,loc )values ('R970429205X' ,'ALL' );

--�����ְλȨ��
--RMSϵͳȨ��
--��ѯ������������sys�û���ִ��
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr  ,
       rainy_user          ru  ,
       rainy_user_position rup ,
       rainy_position_role rpr 
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.ID BETWEEN 1424 AND 1428;
   
--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE ru.ID BETWEEN 1424 AND 1428;


--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  /*to_number (RU.id ) BETWEEN 9999 AND 10000
and*/ user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.USER_ID IN ('R9002273054',
'R9203202752',
'R9209285677',
'R9301062559',
'R9301284526',
'R9305260514',
'R9312150015',
'R9408092088',
'R9408242584',
'R9408242605',
'R970429205X',
'R9907137088'
) ;
--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.USER_ID IN ('R9002273054',
'R9203202752',
'R9209285677',
'R9301062559',
'R9301284526',
'R9305260514',
'R9312150015',
'R9408092088',
'R9408242584',
'R9408242605',
'R970429205X',
'R9907137088'
)
group by sg.group_id,ru.user_id;
     
SELECT * FROM SEC_USER_GROUP WHERE USER_ID IN ('R9002273054',
'R9203202752',
'R9209285677',
'R9301062559',
'R9301284526',
'R9305260514',
'R9312150015',
'R9408092088',
'R9408242584',
'R9408242605',
'R970429205X',
'R9907137088'
) ;

SELECT * FROM RAINY_USER_MERCH WHERE USER_ID IN ('R9002273054',
'R9203202752',
'R9209285677',
'R9301062559',
'R9301284526',
'R9305260514',
'R9312150015',
'R9408092088',
'R9408242584',
'R9408242605',
'R970429205X',
'R9907137088'
) ;

SELECT * FROM RAINY_USER_LOC WHERE USER_ID IN ('R9002273054',
'R9203202752',
'R9209285677',
'R9301062559',
'R9301284526',
'R9305260514',
'R9312150015',
'R9408092088',
'R9408242584',
'R9408242605',
'R970429205X',
'R9907137088'
) ;

SELECT * FROM SEC_USER_GROUP FOR UPDATE 
1500	R9002273054
1500	R9203202752
1500	R9209285677
1500	R9301062559
1500	R9301284526
1500	R9305260514
1500	R9312150015
1500	R9408092088
1500	R9408242584
1500	R9408242605
1500	R970429205X
1500	R9907137088


SELECT * FROM SEC_GROUP WHERE 

SELECT USER_ID 
FROM RAINY_USER_MERCH T
WHERE EXISTS(SELECT 1 FROM RAINY_USER_POSITION RUP WHERE T.USER_ID=RUP.USER_ID AND RUP.POSITION_ID=127 );

SELECT * FROM 

SELECT * FROM RAINY_USER WHERE USER_ID = 'R9002273054';
SELECT * FROM SEC_USER_GROUP WHERE USER_ID = 'R9002273054';

