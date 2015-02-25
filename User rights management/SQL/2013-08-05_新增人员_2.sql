
--insert into rainy_user(user_id,user_name,id) values('R8605242781','����','1393');
--insert into rainy_user(user_id,user_name,id) values('R7101013526','��Զ��','1394');
--insert into rainy_user(user_id,user_name,id) values('R7908241554','����','1395');
--insert into rainy_user(user_id,user_name,id) values('R8211254293','����','1396');
--insert into rainy_user(user_id,user_name,id) values('R7806207120','л���','1397');
--insert into rainy_user(user_id,user_name,id) values('R8502100817','����','1398');
--insert into rainy_user(user_id,user_name,id) values('R9820120785','����','1399');
insert into rainy_user(user_id,user_name,id) values('R8205220775','����','1400');
--insert into rainy_user(user_id,user_name,id) values('R8510193534','��˼��','1401');
--insert into rainy_user(user_id,user_name,id) values('R7004082523','̷�Ļ�','1402');
--insert into rainy_user(user_id,user_name,id) values('R8212122305','����','1403');
insert into rainy_user(user_id,user_name,id) values('R6907019320','���','1404');
--insert into rainy_user(user_id,user_name,id) values('R8312012560','����','1405');
--insert into rainy_user(user_id,user_name,id) values('R9110250784','���','1406');
--insert into rainy_user(user_id,user_name,id) values('R7001080525','����÷','1407');
--insert into rainy_user(user_id,user_name,id) values('R840108831X','����ΰ','1408');
insert into rainy_user(user_id,user_name,id) values('R7510124520','��ԾȺ','1409');
insert into rainy_user(user_id,user_name,id) values('R8510061272','��ǿ','1410');
--insert into rainy_user(user_id,user_name,id) values('R721023302X','�Ż�','1411');
insert into rainy_user(user_id,user_name,id) values('R7411093027','�޸�ƽ','1412');
--insert into rainy_user(user_id,user_name,id) values('R770218102X','�ξ�','1413');
--insert into rainy_user(user_id,user_name,id) values('R7701011029','л��','1414');
--insert into rainy_user(user_id,user_name,id) values('R7404146429','��ΰ','1415');
--insert into rainy_user(user_id,user_name,id) values('R7907110000','�����','1416');
--insert into rainy_user(user_id,user_name,id) values('R7001280065','��ӵȺ','1417');
--insert into rainy_user(user_id,user_name,id) values('R7201230011','����','1418');
--insert into rainy_user(user_id,user_name,id) values('R8110268122','л����','1419');
--insert into rainy_user(user_id,user_name,id) values('R8401181278','����','1420');
--insert into rainy_user(user_id,user_name,id) values('R7511173747','��С��','1421');
--insert into rainy_user(user_id,user_name,id) values('R7301230529','�콨֥','1422');

SELECT * FROM RAINY_USER WHERE USER_ID= 'R7301230529' FOR UPDATE;

SELECT * FROM RAINY_USER T WHERE T.ID BETWEEN 1393 AND 1422;
--�޸�����
update rainy_user t
set t.password =( select upper(dbms_random.string ( 'u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value ( 0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
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
quota unlimited on RETEK_INDEX' || ' ; '    || chr ( 13 ) ||
 'grant alter session,     analyze any, create any view,       create library,create procedure, create sequence,
       create session,  create synonym,    create table,       create trigger,     create view,      create job,delete any table,
   drop any procedure,   drop any view,  drop any table,execute any procedure,execute any type,insert any table,
  select any sequence,select any table,update any table,select any dictionary
to ' || rs.user_id || ' ;' || chr ( 13 ) ||
 
  'grant select on sys.dba_role_privs to ' || rs.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_jobs to '       || rs.user_id || ';' ||chr ( 13) ||
  'grant select on sys.dba_roles to '      || rs.user_id || ';' ||chr ( 13) ||
  'grant execute on dbms_rls to '          || rs.user_id || ';' ||chr ( 13) ||
  'grant execute on sys.dbms_crypto to '   || rs.user_id || ';' ||chr( 13) ||
  'grant select on sys.dba_sys_privs to '  || rs.user_id || ';' ||chr( 13) ||
  'grant execute on sys.dbms_alert to '    || rs.user_id || ';' ||chr ( 13) ||
  'grant execute on sys.dbms_lock to '     || rs.user_id || ';' ||chr ( 13) ||
  'grant execute on sys.dbms_system to '   || rs.user_id || ';' ||chr( 13) ||
  'grant AQ_ADMINISTRATOR_ROLE to '        || rs.user_id || ';' ||chr ( 13) ||
  'grant execute on DBMS_AQ to '           || rs.user_id || ';' ||chr ( 13) ||
  'grant execute on DBMS_AQADM to '        || rs.user_id || ';'
  FROM rainy_user rs
  WHERE RS.ID IN(1400,1404,1409,1410,1412)  ;

--�Ƴ�ԭְλȨ��
--��ѯ�����������sys�û���ִ��
SELECT 'revoke ' || rr.role_ext || ' from ' || ru.user_id || ';'
  FROM rainy_role          rr ,
       rainy_user          ru ,
       rainy_user_position rup ,
       rainy_position_role rpr
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.ID BETWEEN 1393 AND 1422;
--RA/BIPȨ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT 'dn: cn=' || ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
delete: uniquemember
uniquemember: cn='||ru.user_id ||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr ,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.ID BETWEEN 1393 AND 1422 ;

--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 1393 AND 1422 ;



--�û��ص�Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 1393 AND 1422 ;   
--ɾ�������û����ݣ�Ȩ���������Ҫɾ���ı�
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1393 AND 1422);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1393 AND 1422);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1393 AND 1422);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1393 AND 1422);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 1393 AND 1422);
--Ȩ�ޱ�����û��޸�ID�У���BBG_Security_Application_User_List���л�ȡ
SELECT * FROM RAINY_USER
WHERE USER_ID= 'R820211378X' FOR UPDATE;


insert into rainy_user_position(user_id,position_id) values('R8605242781',11);
insert into rainy_user_position(user_id,position_id) values('R7101013526',85);
insert into rainy_user_position(user_id,position_id) values('R7908241554',95);
insert into rainy_user_position(user_id,position_id) values('R8211254293',95);
insert into rainy_user_position(user_id,position_id) values('R7806207120',84);
insert into rainy_user_position(user_id,position_id) values('R8502100817',93);
insert into rainy_user_position(user_id,position_id) values('R9820120785',97);
insert into rainy_user_position(user_id,position_id) values('R8205220775',95);
insert into rainy_user_position(user_id,position_id) values('R8510193534',84);
insert into rainy_user_position(user_id,position_id) values('R7004082523',85);
insert into rainy_user_position(user_id,position_id) values('R8212122305',86);
insert into rainy_user_position(user_id,position_id) values('R6907019320',86);
insert into rainy_user_position(user_id,position_id) values('R8312012560',86);
insert into rainy_user_position(user_id,position_id) values('R9110250784',86);
insert into rainy_user_position(user_id,position_id) values('R7001080525',85);
insert into rainy_user_position(user_id,position_id) values('R840108831X',86);
insert into rainy_user_position(user_id,position_id) values('R7510124520',84);
insert into rainy_user_position(user_id,position_id) values('R8510061272',85);
insert into rainy_user_position(user_id,position_id) values('R721023302X',86);
insert into rainy_user_position(user_id,position_id) values('R7411093027',86);
insert into rainy_user_position(user_id,position_id) values('R770218102X',84);
insert into rainy_user_position(user_id,position_id) values('R7701011029',85);
insert into rainy_user_position(user_id,position_id) values('R7404146429',86);
insert into rainy_user_position(user_id,position_id) values('R7907110000',85);
insert into rainy_user_position(user_id,position_id) values('R7001280065',85);
insert into rainy_user_position(user_id,position_id) values('R7201230011',84);
insert into rainy_user_position(user_id,position_id) values('R8110268122',86);
insert into rainy_user_position(user_id,position_id) values('R8401181278',95);
insert into rainy_user_position(user_id,position_id) values('R7511173747',86);
insert into rainy_user_position(user_id,position_id) values('R7301230529',84);



insert into rainy_user_merch(user_id,merch) values('R8605242781','27');
insert into rainy_user_merch(user_id,merch) values('R7101013526','12');
insert into rainy_user_merch(user_id,merch) values('R7101013526','13');
insert into rainy_user_merch(user_id,merch) values('R7101013526','14');
insert into rainy_user_merch(user_id,merch) values('R7101013526','15');
insert into rainy_user_merch(user_id,merch) values('R7101013526','16');
insert into rainy_user_merch(user_id,merch) values('R7101013526','17');
insert into rainy_user_merch(user_id,merch) values('R7101013526','18');
insert into rainy_user_merch(user_id,merch) values('R7101013526','19');
insert into rainy_user_merch(user_id,merch) values('R7101013526','21');
insert into rainy_user_merch(user_id,merch) values('R7101013526','22');
insert into rainy_user_merch(user_id,merch) values('R7101013526','23');
insert into rainy_user_merch(user_id,merch) values('R7101013526','24');
insert into rainy_user_merch(user_id,merch) values('R7101013526','25');
insert into rainy_user_merch(user_id,merch) values('R7101013526','26');
insert into rainy_user_merch(user_id,merch) values('R7101013526','29');
insert into rainy_user_merch(user_id,merch) values('R7101013526','76');
insert into rainy_user_merch(user_id,merch) values('R8211254293','ALL');
insert into rainy_user_merch(user_id,merch) values('R7806207120','ALL');
insert into rainy_user_merch(user_id,merch) values('R8502100817','ALL');
insert into rainy_user_merch(user_id,merch) values('R9820120785','ALL');
insert into rainy_user_merch(user_id,merch) values('R8510193534','ALL');
insert into rainy_user_merch(user_id,merch) values('R7004082523','27');
insert into rainy_user_merch(user_id,merch) values('R7004082523','30');
insert into rainy_user_merch(user_id,merch) values('R7004082523','31');
insert into rainy_user_merch(user_id,merch) values('R7004082523','32');
insert into rainy_user_merch(user_id,merch) values('R7004082523','33');
insert into rainy_user_merch(user_id,merch) values('R7004082523','34');
insert into rainy_user_merch(user_id,merch) values('R7004082523','35');
insert into rainy_user_merch(user_id,merch) values('R7004082523','36');
insert into rainy_user_merch(user_id,merch) values('R7004082523','37');
insert into rainy_user_merch(user_id,merch) values('R7004082523','38');
insert into rainy_user_merch(user_id,merch) values('R7004082523','39');
insert into rainy_user_merch(user_id,merch) values('R7004082523','40');
insert into rainy_user_merch(user_id,merch) values('R7004082523','41');
insert into rainy_user_merch(user_id,merch) values('R7004082523','42');
insert into rainy_user_merch(user_id,merch) values('R8212122305','31');
insert into rainy_user_merch(user_id,merch) values('R8212122305','40');
insert into rainy_user_merch(user_id,merch) values('R8312012560','22');
insert into rainy_user_merch(user_id,merch) values('R8312012560','23');
insert into rainy_user_merch(user_id,merch) values('R8312012560','24');
insert into rainy_user_merch(user_id,merch) values('R9110250784','16');
insert into rainy_user_merch(user_id,merch) values('R9110250784','17');
insert into rainy_user_merch(user_id,merch) values('R9110250784','18');
insert into rainy_user_merch(user_id,merch) values('R9110250784','19');
insert into rainy_user_merch(user_id,merch) values('R6907019320','21');
insert into rainy_user_merch(user_id,merch) values('R6907019320','29');
insert into rainy_user_merch(user_id,merch) values('R7001080525','12');
insert into rainy_user_merch(user_id,merch) values('R7001080525','13');
insert into rainy_user_merch(user_id,merch) values('R7001080525','14');
insert into rainy_user_merch(user_id,merch) values('R7001080525','15');
insert into rainy_user_merch(user_id,merch) values('R7001080525','16');
insert into rainy_user_merch(user_id,merch) values('R7001080525','17');
insert into rainy_user_merch(user_id,merch) values('R7001080525','18');
insert into rainy_user_merch(user_id,merch) values('R7001080525','19');
insert into rainy_user_merch(user_id,merch) values('R7001080525','76');
insert into rainy_user_merch(user_id,merch) values('R840108831X','ALL');
insert into rainy_user_merch(user_id,merch) values('R7510124520','ALL');
insert into rainy_user_merch(user_id,merch) values('R8510061272','27');
insert into rainy_user_merch(user_id,merch) values('R8510061272','31');
insert into rainy_user_merch(user_id,merch) values('R8510061272','32');
insert into rainy_user_merch(user_id,merch) values('R8510061272','33');
insert into rainy_user_merch(user_id,merch) values('R8510061272','34');
insert into rainy_user_merch(user_id,merch) values('R8510061272','35');
insert into rainy_user_merch(user_id,merch) values('R8510061272','36');
insert into rainy_user_merch(user_id,merch) values('R8510061272','37');
insert into rainy_user_merch(user_id,merch) values('R8510061272','38');
insert into rainy_user_merch(user_id,merch) values('R8510061272','39');
insert into rainy_user_merch(user_id,merch) values('R8510061272','40');
insert into rainy_user_merch(user_id,merch) values('R8510061272','41');
insert into rainy_user_merch(user_id,merch) values('R8510061272','42');
insert into rainy_user_merch(user_id,merch) values('R721023302X','36');
insert into rainy_user_merch(user_id,merch) values('R721023302X','37');
insert into rainy_user_merch(user_id,merch) values('R7411093027','21');
insert into rainy_user_merch(user_id,merch) values('R7411093027','22');
insert into rainy_user_merch(user_id,merch) values('R7411093027','23');
insert into rainy_user_merch(user_id,merch) values('R7411093027','24');
insert into rainy_user_merch(user_id,merch) values('R7411093027','25');
insert into rainy_user_merch(user_id,merch) values('R7411093027','26');
insert into rainy_user_merch(user_id,merch) values('R770218102X','ALL');
insert into rainy_user_merch(user_id,merch) values('R7701011029','12');
insert into rainy_user_merch(user_id,merch) values('R7701011029','13');
insert into rainy_user_merch(user_id,merch) values('R7701011029','14');
insert into rainy_user_merch(user_id,merch) values('R7701011029','15');
insert into rainy_user_merch(user_id,merch) values('R7701011029','16');
insert into rainy_user_merch(user_id,merch) values('R7701011029','17');
insert into rainy_user_merch(user_id,merch) values('R7701011029','18');
insert into rainy_user_merch(user_id,merch) values('R7701011029','19');
insert into rainy_user_merch(user_id,merch) values('R7701011029','21');
insert into rainy_user_merch(user_id,merch) values('R7701011029','22');
insert into rainy_user_merch(user_id,merch) values('R7701011029','23');
insert into rainy_user_merch(user_id,merch) values('R7701011029','24');
insert into rainy_user_merch(user_id,merch) values('R7701011029','25');
insert into rainy_user_merch(user_id,merch) values('R7701011029','26');
insert into rainy_user_merch(user_id,merch) values('R7701011029','29');
insert into rainy_user_merch(user_id,merch) values('R7404146429','21');
insert into rainy_user_merch(user_id,merch) values('R7404146429','29');
insert into rainy_user_merch(user_id,merch) values('R7907110000','27');
insert into rainy_user_merch(user_id,merch) values('R7907110000','31');
insert into rainy_user_merch(user_id,merch) values('R7907110000','32');
insert into rainy_user_merch(user_id,merch) values('R7907110000','33');
insert into rainy_user_merch(user_id,merch) values('R7907110000','34');
insert into rainy_user_merch(user_id,merch) values('R7907110000','35');
insert into rainy_user_merch(user_id,merch) values('R7907110000','36');
insert into rainy_user_merch(user_id,merch) values('R7907110000','37');
insert into rainy_user_merch(user_id,merch) values('R7907110000','38');
insert into rainy_user_merch(user_id,merch) values('R7907110000','39');
insert into rainy_user_merch(user_id,merch) values('R7907110000','40');
insert into rainy_user_merch(user_id,merch) values('R7907110000','41');
insert into rainy_user_merch(user_id,merch) values('R7907110000','42');
insert into rainy_user_merch(user_id,merch) values('R7001280065','71');
insert into rainy_user_merch(user_id,merch) values('R7001280065','72');
insert into rainy_user_merch(user_id,merch) values('R7001280065','73');
insert into rainy_user_merch(user_id,merch) values('R7001280065','74');
insert into rainy_user_merch(user_id,merch) values('R7001280065','75');
insert into rainy_user_merch(user_id,merch) values('R7001280065','76');
insert into rainy_user_merch(user_id,merch) values('R7001280065','77');
insert into rainy_user_merch(user_id,merch) values('R7001280065','78');
insert into rainy_user_merch(user_id,merch) values('R7201230011','ALL');
insert into rainy_user_merch(user_id,merch) values('R8110268122','31');
insert into rainy_user_merch(user_id,merch) values('R8110268122','32');
insert into rainy_user_merch(user_id,merch) values('R8110268122','34');
insert into rainy_user_merch(user_id,merch) values('R8110268122','35');
insert into rainy_user_merch(user_id,merch) values('R8110268122','39');
insert into rainy_user_merch(user_id,merch) values('R8110268122','40');
insert into rainy_user_merch(user_id,merch) values('R8110268122','42');
insert into rainy_user_merch(user_id,merch) values('R8401181278','ALL');
insert into rainy_user_merch(user_id,merch) values('R7301230529','ALL');


insert into rainy_user_loc (user_id,loc)values('R8605242781','ALL');
insert into rainy_user_loc (user_id,loc)values('R7101013526','120001');
insert into rainy_user_loc (user_id,loc)values('R7908241554','120001');
insert into rainy_user_loc (user_id,loc)values('R8211254293','120002');
insert into rainy_user_loc (user_id,loc)values('R7806207120','120002');
insert into rainy_user_loc (user_id,loc)values('R8205220775','120072');
insert into rainy_user_loc (user_id,loc)values('R8205220775','130009');
insert into rainy_user_loc (user_id,loc)values('R8205220775','130014');
insert into rainy_user_loc (user_id,loc)values('R8510193534','120102');
insert into rainy_user_loc (user_id,loc)values('R7004082523','120110');
insert into rainy_user_loc (user_id,loc)values('R8212122305','120110');
insert into rainy_user_loc (user_id,loc)values('R6907019320','120110');
insert into rainy_user_loc (user_id,loc)values('R8312012560','120110');
insert into rainy_user_loc (user_id,loc)values('R9110250784','120110');
insert into rainy_user_loc (user_id,loc)values('R7001080525','120110');
insert into rainy_user_loc (user_id,loc)values('R840108831X','120115');
insert into rainy_user_loc (user_id,loc)values('R7510124520','118001');
insert into rainy_user_loc (user_id,loc)values('R7510124520','118005');
insert into rainy_user_loc (user_id,loc)values('R7510124520','118011');
insert into rainy_user_loc (user_id,loc)values('R7510124520','118012');
insert into rainy_user_loc (user_id,loc)values('R7510124520','120145');
insert into rainy_user_loc (user_id,loc)values('R8510061272','118001');
insert into rainy_user_loc (user_id,loc)values('R8510061272','120145');
insert into rainy_user_loc (user_id,loc)values('R721023302X','118005');
insert into rainy_user_loc (user_id,loc)values('R721023302X','118011');
insert into rainy_user_loc (user_id,loc)values('R721023302X','118012');
insert into rainy_user_loc (user_id,loc)values('R721023302X','120145');
insert into rainy_user_loc (user_id,loc)values('R7411093027','120145');
insert into rainy_user_loc (user_id,loc)values('R7701011029','118001');
insert into rainy_user_loc (user_id,loc)values('R7701011029','120153');
insert into rainy_user_loc (user_id,loc)values('R770218102X','118001');
insert into rainy_user_loc (user_id,loc)values('R770218102X','120153');
insert into rainy_user_loc (user_id,loc)values('R7404146429','118001');
insert into rainy_user_loc (user_id,loc)values('R7404146429','120153');
insert into rainy_user_loc (user_id,loc)values('R7907110000','118001');
insert into rainy_user_loc (user_id,loc)values('R7907110000','120153');
insert into rainy_user_loc (user_id,loc)values('R7001280065','118001');
insert into rainy_user_loc (user_id,loc)values('R7001280065','120153');
insert into rainy_user_loc (user_id,loc)values('R7201230011','120176');
insert into rainy_user_loc (user_id,loc)values('R8110268122','120176');
insert into rainy_user_loc (user_id,loc)values('R8401181278','120176');
insert into rainy_user_loc (user_id,loc)values('R7511173747','130014');
insert into rainy_user_loc (user_id,loc)values('R7301230529','120081');


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
   AND RU.ID BETWEEN 1393 AND 1422;
--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 1393 AND 1422
and user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 1393 AND 1422 ;
--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 1393 AND 1422
     group by sg.group_id,ru.user_id;

--����RSM_USER_ROLE��
--RPMϵͳȨ��д��
insert into RSM_USER_ROLE
select  rsm_user_role_seq.nextval, a.user_id, a.role_ext, SYSDATE - 720, null
from ( SELECT ru.user_id user_id ,ra.role_ext role_ext    
        FROM rainy_user ru , rainy_user_position rup , rainy_position_role rpr,RAINY_ROLE ra
       WHERE ru.user_id = rup.user_id
         AND rup.position_id = rpr.position_id
         and rpr.role_id =ra.role_id and ra.appl ='RPM'
         --ע����������
         AND RU.ID BETWEEN 1393 AND 1422
         group  by ru.user_id ,ra.role_ext ) a
where a.role_ext is not null ;
--LDAP���û�
--SIMϵͳ,RA/BIPϵͳ����һ���û�������һ����OK�ˡ�
--SIMϵͳ��LOCΪALL�ģ��ڽ��û���Ȩ�޵���ʱҪ�ֵ���������
--ע�⣺userstores: storeId=ALL ʱҪ�滻�������滻���С�����
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
--ע���������������û��ص�Ȩ��ΪALLʱ����=������ALL����<>
   AND EXISTS( SELECT 1 FROM RAINY_USER_LOC RULL WHERE RULL.USER_ID=RU.USER_ID AND RULL.LOC<> 'ALL')
   --AND ru.user_id NOT IN (SELECT rull.user_id FROM rainy_user_loc rull WHERE rull.loc <> 'ALL')
   AND RU.ID BETWEEN 1393 AND 1422;

--SIMϵͳ����
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--ע�⣺userRoleStoresΪALLʱҪ�滻�������滻���С�����
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
--ע���������������û��ص�Ȩ��ΪALLʱ����=������ALL����<>
and rul.loc = 'ALL'
AND RU.ID BETWEEN 1393 AND 1422
GROUP BY    rr.role_name, ru.user_id;

--RA/BIPȨ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RU.ID BETWEEN 1393 AND 1422 ;

--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1393 AND 1422 ;



--�û��ص�Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1393 AND 1422 ;

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 1393 AND 1422 ;


