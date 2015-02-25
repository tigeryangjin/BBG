--insert into rainy_user(user_id,user_name,id) values('R8306223527','���ͷ�','2174');
insert into rainy_user(user_id,user_name,id) values('R7605010027','��С��','2175');
--insert into rainy_user(user_id,user_name,id) values('R7907286514','����','2176');
--insert into rainy_user(user_id,user_name,id) values('R6402241015','������','2177');
insert into rainy_user(user_id,user_name,id) values('R8307011321','ԬԵ','2178');
insert into rainy_user(user_id,user_name,id) values('R8004070349','����','2179');
--insert into rainy_user(user_id,user_name,id) values('R7606164625','����ΰ','2180');
--insert into rainy_user(user_id,user_name,id) values('R8910130916','�ż�','2181');
--insert into rainy_user(user_id,user_name,id) values('R8102236213','��н��','2182');
--insert into rainy_user(user_id,user_name,id) values('R7111077720','������','2183');
--insert into rainy_user(user_id,user_name,id) values('R8902064826','��ϼ','2184');
--insert into rainy_user(user_id,user_name,id) values('R7012162557','�ŭZ','2185');
--insert into rainy_user(user_id,user_name,id) values('R731223872X','����Ũ','2186');
--insert into rainy_user(user_id,user_name,id) values('R8204292031','��ŷ�','2187');
--insert into rainy_user(user_id,user_name,id) values('R890204463X','��־��','2188');
insert into rainy_user(user_id,user_name,id) values('R780214001X','��־��','2189');
insert into rainy_user(user_id,user_name,id) values('R8812173008','��־��','2190');


--�޸�����
update rainy_user t
set t.password =( select upper(dbms_random.string ( 'u' , 2 ))||dbms_random.string ('l' , 3 )|| trunc(dbms_random.value ( 0 ,10 ))||trunc ( dbms_random.value ( 0 ,10 ))|| trunc (dbms_random.value (0 , 10 ))
                   from rainy_user a
                  where t.user_id = a.user_id )
where t.password is null



--����DB�û�
--�����sys�û���ִ��
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
  WHERE RU.ID BETWEEN 2174 AND 2190 ;

--Ȩ�ޱ�����û��޸�ID�У���BBG_Security_Application_User_List���л�ȡ
SELECT * FROM RAINY_USER
WHERE USER_ID IN ( 'R8306223527','R7907286514','R6402241015','R7606164625','R8910130916','R8102236213','R7111077720','R8902064826',
'R7012162557','R731223872X','R8204292031','R890204463X') FOR UPDATE;
--insert into rainy_user(user_id,user_name,id) values('R8306223527','���ͷ�','2174');
--insert into rainy_user(user_id,user_name,id) values('R7907286514','����','2176');
--insert into rainy_user(user_id,user_name,id) values('R6402241015','������','2177');
--insert into rainy_user(user_id,user_name,id) values('R7606164625','����ΰ','2180');
--insert into rainy_user(user_id,user_name,id) values('R8910130916','�ż�','2181');
--insert into rainy_user(user_id,user_name,id) values('R8102236213','��н��','2182');
--insert into rainy_user(user_id,user_name,id) values('R7111077720','������','2183');
--insert into rainy_user(user_id,user_name,id) values('R8902064826','��ϼ','2184');
--insert into rainy_user(user_id,user_name,id) values('R7012162557','�ŭZ','2185');
--insert into rainy_user(user_id,user_name,id) values('R731223872X','����Ũ','2186');
--insert into rainy_user(user_id,user_name,id) values('R8204292031','��ŷ�','2187');
--insert into rainy_user(user_id,user_name,id) values('R890204463X','��־��','2188');
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
   AND RU.ID BETWEEN 2174 AND 2190;

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
AND RU.ID BETWEEN 2174 AND 2190 ;

--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2174 AND 2190 ;



--�û��ص�Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2174 AND 2190 ;   
--ɾ�������û����ݣ�Ȩ���������Ҫɾ���ı�
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2174 AND 2190);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2174 AND 2190);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2174 AND 2190);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2174 AND 2190);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2174 AND 2190);

insert into rainy_user_position(user_id,position_id) values('R8306223527',86);
insert into rainy_user_position(user_id,position_id) values('R7605010027',86);
insert into rainy_user_position(user_id,position_id) values('R7907286514',86);
insert into rainy_user_position(user_id,position_id) values('R6402241015',85);
insert into rainy_user_position(user_id,position_id) values('R8307011321',86);
insert into rainy_user_position(user_id,position_id) values('R8004070349',86);
insert into rainy_user_position(user_id,position_id) values('R7606164625',85);
insert into rainy_user_position(user_id,position_id) values('R8910130916',85);
insert into rainy_user_position(user_id,position_id) values('R8102236213',86);
insert into rainy_user_position(user_id,position_id) values('R7111077720',86);
insert into rainy_user_position(user_id,position_id) values('R8902064826',86);
insert into rainy_user_position(user_id,position_id) values('R7012162557',86);
insert into rainy_user_position(user_id,position_id) values('R731223872X',86);
insert into rainy_user_position(user_id,position_id) values('R8204292031',85);
insert into rainy_user_position(user_id,position_id) values('R890204463X',86);
insert into rainy_user_position(user_id,position_id) values('R780214001X',118);
insert into rainy_user_position(user_id,position_id) values('R8812173008',75);
------------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R8306223527','31');
insert into rainy_user_merch(user_id,merch) values('R8306223527','34');
insert into rainy_user_merch(user_id,merch) values('R8306223527','39');
insert into rainy_user_merch(user_id,merch) values('R8306223527','40');
insert into rainy_user_merch(user_id,merch) values('R7605010027','32');
insert into rainy_user_merch(user_id,merch) values('R7605010027','35');
insert into rainy_user_merch(user_id,merch) values('R7605010027','42');
insert into rainy_user_merch(user_id,merch) values('R7907286514','31');
insert into rainy_user_merch(user_id,merch) values('R7907286514','40');
insert into rainy_user_merch(user_id,merch) values('R7907286514','42');
insert into rainy_user_merch(user_id,merch) values('R6402241015','27');
insert into rainy_user_merch(user_id,merch) values('R6402241015','31');
insert into rainy_user_merch(user_id,merch) values('R6402241015','32');
insert into rainy_user_merch(user_id,merch) values('R6402241015','33');
insert into rainy_user_merch(user_id,merch) values('R6402241015','34');
insert into rainy_user_merch(user_id,merch) values('R6402241015','35');
insert into rainy_user_merch(user_id,merch) values('R6402241015','36');
insert into rainy_user_merch(user_id,merch) values('R6402241015','37');
insert into rainy_user_merch(user_id,merch) values('R6402241015','38');
insert into rainy_user_merch(user_id,merch) values('R6402241015','39');
insert into rainy_user_merch(user_id,merch) values('R6402241015','40');
insert into rainy_user_merch(user_id,merch) values('R6402241015','41');
insert into rainy_user_merch(user_id,merch) values('R6402241015','42');
insert into rainy_user_merch(user_id,merch) values('R8307011321','27');
insert into rainy_user_merch(user_id,merch) values('R8307011321','32');
insert into rainy_user_merch(user_id,merch) values('R8307011321','33');
insert into rainy_user_merch(user_id,merch) values('R8307011321','35');
insert into rainy_user_merch(user_id,merch) values('R8307011321','38');
insert into rainy_user_merch(user_id,merch) values('R8307011321','42');
insert into rainy_user_merch(user_id,merch) values('R8004070349','12');
insert into rainy_user_merch(user_id,merch) values('R8004070349','13');
insert into rainy_user_merch(user_id,merch) values('R8004070349','14');
insert into rainy_user_merch(user_id,merch) values('R8004070349','15');
insert into rainy_user_merch(user_id,merch) values('R8004070349','16');
insert into rainy_user_merch(user_id,merch) values('R8004070349','17');
insert into rainy_user_merch(user_id,merch) values('R8004070349','18');
insert into rainy_user_merch(user_id,merch) values('R8004070349','19');
insert into rainy_user_merch(user_id,merch) values('R8004070349','29');
insert into rainy_user_merch(user_id,merch) values('R8004070349','76');
insert into rainy_user_merch(user_id,merch) values('R7606164625','12');
insert into rainy_user_merch(user_id,merch) values('R7606164625','13');
insert into rainy_user_merch(user_id,merch) values('R7606164625','14');
insert into rainy_user_merch(user_id,merch) values('R7606164625','15');
insert into rainy_user_merch(user_id,merch) values('R7606164625','16');
insert into rainy_user_merch(user_id,merch) values('R7606164625','17');
insert into rainy_user_merch(user_id,merch) values('R7606164625','18');
insert into rainy_user_merch(user_id,merch) values('R7606164625','19');
insert into rainy_user_merch(user_id,merch) values('R8910130916','31');
insert into rainy_user_merch(user_id,merch) values('R8910130916','32');
insert into rainy_user_merch(user_id,merch) values('R8910130916','33');
insert into rainy_user_merch(user_id,merch) values('R8910130916','34');
insert into rainy_user_merch(user_id,merch) values('R8910130916','35');
insert into rainy_user_merch(user_id,merch) values('R8910130916','36');
insert into rainy_user_merch(user_id,merch) values('R8910130916','37');
insert into rainy_user_merch(user_id,merch) values('R8910130916','38');
insert into rainy_user_merch(user_id,merch) values('R8910130916','39');
insert into rainy_user_merch(user_id,merch) values('R8910130916','40');
insert into rainy_user_merch(user_id,merch) values('R8910130916','41');
insert into rainy_user_merch(user_id,merch) values('R8910130916','42');
insert into rainy_user_merch(user_id,merch) values('R8102236213','34');
insert into rainy_user_merch(user_id,merch) values('R8102236213','39');
insert into rainy_user_merch(user_id,merch) values('R7111077720','32');
insert into rainy_user_merch(user_id,merch) values('R7111077720','35');
insert into rainy_user_merch(user_id,merch) values('R7111077720','42');
insert into rainy_user_merch(user_id,merch) values('R8902064826','36');
insert into rainy_user_merch(user_id,merch) values('R8902064826','37');
insert into rainy_user_merch(user_id,merch) values('R8902064826','41');
insert into rainy_user_merch(user_id,merch) values('R7012162557','27');
insert into rainy_user_merch(user_id,merch) values('R7012162557','33');
insert into rainy_user_merch(user_id,merch) values('R7012162557','38');
insert into rainy_user_merch(user_id,merch) values('R731223872X','31');
insert into rainy_user_merch(user_id,merch) values('R731223872X','40');
insert into rainy_user_merch(user_id,merch) values('R8204292031','21');
insert into rainy_user_merch(user_id,merch) values('R8204292031','22');
insert into rainy_user_merch(user_id,merch) values('R8204292031','23');
insert into rainy_user_merch(user_id,merch) values('R8204292031','24');
insert into rainy_user_merch(user_id,merch) values('R8204292031','25');
insert into rainy_user_merch(user_id,merch) values('R8204292031','26');
insert into rainy_user_merch(user_id,merch) values('R8204292031','29');
insert into rainy_user_merch(user_id,merch) values('R890204463X','21');
insert into rainy_user_merch(user_id,merch) values('R890204463X','22');
insert into rainy_user_merch(user_id,merch) values('R890204463X','23');
insert into rainy_user_merch(user_id,merch) values('R890204463X','24');
insert into rainy_user_merch(user_id,merch) values('R780214001X','12');
insert into rainy_user_merch(user_id,merch) values('R780214001X','13');
insert into rainy_user_merch(user_id,merch) values('R780214001X','14');
insert into rainy_user_merch(user_id,merch) values('R780214001X','15');
insert into rainy_user_merch(user_id,merch) values('R780214001X','16');
insert into rainy_user_merch(user_id,merch) values('R780214001X','17');
insert into rainy_user_merch(user_id,merch) values('R780214001X','18');
insert into rainy_user_merch(user_id,merch) values('R780214001X','19');
insert into rainy_user_merch(user_id,merch) values('R780214001X','21');
insert into rainy_user_merch(user_id,merch) values('R780214001X','22');
insert into rainy_user_merch(user_id,merch) values('R780214001X','23');
insert into rainy_user_merch(user_id,merch) values('R780214001X','24');
insert into rainy_user_merch(user_id,merch) values('R780214001X','25');
insert into rainy_user_merch(user_id,merch) values('R780214001X','26');
insert into rainy_user_merch(user_id,merch) values('R780214001X','29');
insert into rainy_user_merch(user_id,merch) values('R8812173008','76');
-----------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R8306223527','120158');
insert into rainy_user_loc (user_id,loc)values('R7605010027','120144');
insert into rainy_user_loc (user_id,loc)values('R7907286514','120144');
insert into rainy_user_loc (user_id,loc)values('R6402241015','118001');
insert into rainy_user_loc (user_id,loc)values('R6402241015','118005');
insert into rainy_user_loc (user_id,loc)values('R6402241015','118011');
insert into rainy_user_loc (user_id,loc)values('R6402241015','118012');
insert into rainy_user_loc (user_id,loc)values('R6402241015','120156');
insert into rainy_user_loc (user_id,loc)values('R8307011321','120156');
insert into rainy_user_loc (user_id,loc)values('R8004070349','118001');
insert into rainy_user_loc (user_id,loc)values('R8004070349','120156');
insert into rainy_user_loc (user_id,loc)values('R7606164625','118001');
insert into rainy_user_loc (user_id,loc)values('R7606164625','118005');
insert into rainy_user_loc (user_id,loc)values('R7606164625','118011');
insert into rainy_user_loc (user_id,loc)values('R7606164625','118012');
insert into rainy_user_loc (user_id,loc)values('R7606164625','120056');
insert into rainy_user_loc (user_id,loc)values('R8910130916','120173');
insert into rainy_user_loc (user_id,loc)values('R8102236213','120173');
insert into rainy_user_loc (user_id,loc)values('R7111077720','120173');
insert into rainy_user_loc (user_id,loc)values('R8902064826','120173');
insert into rainy_user_loc (user_id,loc)values('R7012162557','120173');
insert into rainy_user_loc (user_id,loc)values('R731223872X','120173');
insert into rainy_user_loc (user_id,loc)values('R8204292031','120173');
insert into rainy_user_loc (user_id,loc)values('R890204463X','120173');
insert into rainy_user_loc (user_id,loc)values('R780214001X','120194');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120001');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120020');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120023');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120028');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120039');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120045');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120065');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120094');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120123');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120124');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120134');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120149');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120160');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120168');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120171');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120179');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120181');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120185');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120186');
insert into rainy_user_loc (user_id,loc)values('R8812173008','120190');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130003');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130004');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130005');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130007');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130010');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130011');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130012');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130017');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130018');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130019');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130021');
insert into rainy_user_loc (user_id,loc)values('R8812173008','130022');


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
   AND RU.ID BETWEEN 2174 AND 2190;

--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2174 AND 2190
and user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2174 AND 2190 ;
--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2174 AND 2190
    --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
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
         AND RU.ID BETWEEN 2174 AND 2190
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
   AND RU.ID BETWEEN 2174 AND 2190;

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
and rul.loc <> 'ALL'
AND RU.ID BETWEEN 2174 AND 2190
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
AND RU.ID BETWEEN 2174 AND 2190 ;

--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2174 AND 2190 ;



--�û��ص�Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2174 AND 2190 ;

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2174 AND 2190 
ORDER BY RU.ID;
