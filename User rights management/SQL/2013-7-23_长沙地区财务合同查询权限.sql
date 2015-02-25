--insert into rainy_user(user_id,user_name,id) values('R6902180557','������','974');
insert into rainy_user(user_id,user_name,id) values('R8910199209','���޻�','975');
insert into rainy_user(user_id,user_name,id) values('R8612293646','������','976');

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
  WHERE RS.USER_ID IN ('R8910199209','R8612293646') ;


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
   AND RU.USER_ID IN ( 'R6902180557');
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
AND RU.USER_ID IN ( 'R6902180557' );

--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ( 'R6902180557' );



--�û��ص�Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'||CHR ( 10 )||
'changetype: modify' ||CHR (10 )||
'delete: uniquemember' ||CHR (10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ( 'R6902180557' ) ;    
--ɾ�������û����ݣ�Ȩ���������Ҫɾ���ı�
DELETE FROM RSM_USER_ROLE WHERE user_id IN ('R6902180557' );
DELETE FROM SEC_USER_GROUP WHERE USER_ID IN ('R6902180557' );
DELETE FROM RAINY_USER_LOC WHERE USER_ID IN ('R6902180557' );
DELETE FROM RAINY_USER_MERCH WHERE USER_ID IN ('R6902180557' );
DELETE FROM RAINY_USER_POSITION WHERE USER_ID IN ('R6902180557' );

--Ȩ�ޱ�����û��޸�ID�У���BBG_Security_Application_User_List���л�ȡ
SELECT * FROM RAINY_USER
WHERE USER_ID= 'R6902180557' FOR UPDATE

--
insert into rainy_user_position(user_id,position_id) values('R6902180557',64);		
insert into rainy_user_position(user_id,position_id) values('R8910199209',66);
insert into rainy_user_position(user_id,position_id) values('R8612293646',65);
--
insert into rainy_user_merch(user_id,merch) values('R6902180557','ALL');
insert into rainy_user_merch(user_id,merch) values('R8910199209','ALL');
insert into rainy_user_merch(user_id,merch) values('R8612293646','ALL');
--
insert into rainy_user_loc (user_id,loc)values('R6902180557','120036');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120056');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120066');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120068');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120077');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120078');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120090');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120096');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120122');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120125');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120135');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120136');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120156');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120157');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120159');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120161');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120163');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120164');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120166');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120167');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120189');
insert into rainy_user_loc (user_id,loc)values('R6902180557','120191');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120036');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120056');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120066');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120068');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120077');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120078');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120090');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120096');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120122');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120125');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120135');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120136');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120156');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120157');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120159');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120161');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120163');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120164');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120166');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120167');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120189');
insert into rainy_user_loc (user_id,loc)values('R8910199209','120191');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120036');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120056');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120066');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120068');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120077');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120078');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120090');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120096');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120122');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120125');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120135');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120136');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120156');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120157');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120159');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120161');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120163');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120164');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120166');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120167');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120189');
insert into rainy_user_loc (user_id,loc)values('R8612293646','120191');


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
   AND RU.USER_ID IN ('R6902180557','R8910199209','R8612293646' );
--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' ||';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang) 
select user_id,user_name, '8' 
from rainy_user 
where  to_number (id ) between 974 and 976
and user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.USER_ID IN ('R6902180557','R8910199209','R8612293646' );
--Department����    
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.USER_ID IN ('R6902180557','R8910199209','R8612293646' )
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
         AND RU.USER_ID IN ('R6902180557','R8910199209','R8612293646' )
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
--ע���������������û��ص�Ȩ��ΪALLʱ����=������ALL����<>
   AND EXISTS( SELECT 1 FROM RAINY_USER_LOC RULL WHERE RULL.USER_ID=RU.USER_ID AND RULL.LOC<> 'ALL')
   --AND ru.user_id NOT IN (SELECT rull.user_id FROM rainy_user_loc rull WHERE rull.loc <> 'ALL')
   --AND RU.ID in (901,902)
   AND RU.USER_ID IN ( 'R6902180557','R8910199209','R8612293646' );

--SIMϵͳ����
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import 
--ע�⣺userRoleStoresΪALLʱҪ�滻�������滻���С����� 
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
--ע���������������û��ص�Ȩ��ΪALLʱ����=������ALL����<>
and rul.loc <> 'ALL'
AND RU.USER_ID IN ( 'R6902180557','R8910199209','R8612293646' )
GROUP BY   rr.role_name, ru.user_id;

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
AND RU.USER_ID IN ( 'R6902180557','R8910199209','R8612293646' );

--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import 
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@'||MERCH|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.USER_ID IN ('R6902180557','R8910199209','R8612293646' );



--�û��ص�Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import 
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'||a.LOC|| ',cn=Groups,dc=bbg'||CHR (10 )||
'changetype: modify'||CHR (10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR (10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.USER_ID IN ('R6902180557','R8910199209','R8612293646') ;

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER
WHERE ID BETWEEN 974 AND 976;
	





