insert into rainy_user(user_id,user_name,id) values('R8411102610','������','2149');
--insert into rainy_user(user_id,user_name,id) values('R7411170425','�ĺ���','2150');
--insert into rainy_user(user_id,user_name,id) values('R7801281559','Ƥ��','2151');
--insert into rainy_user(user_id,user_name,id) values('R7705200559','���','2152');
--insert into rainy_user(user_id,user_name,id) values('R7112073021','�˲Ӿ�','2153');
--insert into rainy_user(user_id,user_name,id) values('R7909221822','��С��','2154');
--insert into rainy_user(user_id,user_name,id) values('R7203227210','������','2155');
insert into rainy_user(user_id,user_name,id) values('R7004151022','��˳��','2156');
--insert into rainy_user(user_id,user_name,id) values('R7409254965','����','2157');
--insert into rainy_user(user_id,user_name,id) values('R7002270031','�����','2158');

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
  WHERE RU.ID BETWEEN 2149 AND 2158 ;


--Ȩ�ޱ�����û��޸�ID�У���BBG_Security_Application_User_List���л�ȡ
SELECT * FROM RAINY_USER
WHERE USER_ID IN ( 'R7411170425','R7801281559','R7705200559','R7112073021','R7909221822','R7203227210','R7409254965','R7002270031') FOR UPDATE;
--insert into rainy_user(user_id,user_name,id) values('R7411170425','�ĺ���','2150');
--insert into rainy_user(user_id,user_name,id) values('R7801281559','Ƥ��','2151');
--insert into rainy_user(user_id,user_name,id) values('R7705200559','���','2152');
--insert into rainy_user(user_id,user_name,id) values('R7112073021','�˲Ӿ�','2153');
--insert into rainy_user(user_id,user_name,id) values('R7909221822','��С��','2154');
--insert into rainy_user(user_id,user_name,id) values('R7203227210','������','2155');
--insert into rainy_user(user_id,user_name,id) values('R7409254965','����','2157');
--insert into rainy_user(user_id,user_name,id) values('R7002270031','�����','2158');
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
   AND RU.ID BETWEEN 2149 AND 2158;

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
AND RU.ID BETWEEN 2149 AND 2158 ;

--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2149 AND 2158 ;



--�û��ص�Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2149 AND 2158 ;   
--ɾ�������û����ݣ�Ȩ���������Ҫɾ���ı�
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2149 AND 2158);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2149 AND 2158);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2149 AND 2158);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2149 AND 2158);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2149 AND 2158);



-----------------------------------------------------------------------------
insert into rainy_user_position(user_id,position_id) values('R8411102610',95);
insert into rainy_user_position(user_id,position_id) values('R7411170425',85);
insert into rainy_user_position(user_id,position_id) values('R7801281559',86);
insert into rainy_user_position(user_id,position_id) values('R7705200559',86);
insert into rainy_user_position(user_id,position_id) values('R7112073021',85);
insert into rainy_user_position(user_id,position_id) values('R7909221822',86);
insert into rainy_user_position(user_id,position_id) values('R7203227210',86);
insert into rainy_user_position(user_id,position_id) values('R7004151022',86);
insert into rainy_user_position(user_id,position_id) values('R7409254965',86);
insert into rainy_user_position(user_id,position_id) values('R7002270031',86);
-----------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R7411170425','11');
insert into rainy_user_merch(user_id,merch) values('R7411170425','12');
insert into rainy_user_merch(user_id,merch) values('R7411170425','13');
insert into rainy_user_merch(user_id,merch) values('R7411170425','14');
insert into rainy_user_merch(user_id,merch) values('R7411170425','15');
insert into rainy_user_merch(user_id,merch) values('R7411170425','16');
insert into rainy_user_merch(user_id,merch) values('R7411170425','17');
insert into rainy_user_merch(user_id,merch) values('R7411170425','18');
insert into rainy_user_merch(user_id,merch) values('R7411170425','19');
insert into rainy_user_merch(user_id,merch) values('R7411170425','21');
insert into rainy_user_merch(user_id,merch) values('R7411170425','22');
insert into rainy_user_merch(user_id,merch) values('R7411170425','23');
insert into rainy_user_merch(user_id,merch) values('R7411170425','24');
insert into rainy_user_merch(user_id,merch) values('R7411170425','25');
insert into rainy_user_merch(user_id,merch) values('R7411170425','26');
insert into rainy_user_merch(user_id,merch) values('R7411170425','29');
insert into rainy_user_merch(user_id,merch) values('R7411170425','75');
insert into rainy_user_merch(user_id,merch) values('R7411170425','76');
insert into rainy_user_merch(user_id,merch) values('R7801281559','11');
insert into rainy_user_merch(user_id,merch) values('R7801281559','12');
insert into rainy_user_merch(user_id,merch) values('R7801281559','13');
insert into rainy_user_merch(user_id,merch) values('R7801281559','14');
insert into rainy_user_merch(user_id,merch) values('R7801281559','15');
insert into rainy_user_merch(user_id,merch) values('R7801281559','16');
insert into rainy_user_merch(user_id,merch) values('R7801281559','17');
insert into rainy_user_merch(user_id,merch) values('R7801281559','18');
insert into rainy_user_merch(user_id,merch) values('R7801281559','19');
insert into rainy_user_merch(user_id,merch) values('R7801281559','29');
insert into rainy_user_merch(user_id,merch) values('R7801281559','75');
insert into rainy_user_merch(user_id,merch) values('R7801281559','76');
insert into rainy_user_merch(user_id,merch) values('R7705200559','21');
insert into rainy_user_merch(user_id,merch) values('R7705200559','22');
insert into rainy_user_merch(user_id,merch) values('R7705200559','23');
insert into rainy_user_merch(user_id,merch) values('R7705200559','24');
insert into rainy_user_merch(user_id,merch) values('R7705200559','25');
insert into rainy_user_merch(user_id,merch) values('R7705200559','26');
insert into rainy_user_merch(user_id,merch) values('R7112073021','31');
insert into rainy_user_merch(user_id,merch) values('R7112073021','32');
insert into rainy_user_merch(user_id,merch) values('R7112073021','33');
insert into rainy_user_merch(user_id,merch) values('R7112073021','34');
insert into rainy_user_merch(user_id,merch) values('R7112073021','35');
insert into rainy_user_merch(user_id,merch) values('R7112073021','36');
insert into rainy_user_merch(user_id,merch) values('R7112073021','37');
insert into rainy_user_merch(user_id,merch) values('R7112073021','38');
insert into rainy_user_merch(user_id,merch) values('R7112073021','39');
insert into rainy_user_merch(user_id,merch) values('R7112073021','40');
insert into rainy_user_merch(user_id,merch) values('R7112073021','41');
insert into rainy_user_merch(user_id,merch) values('R7112073021','42');
insert into rainy_user_merch(user_id,merch) values('R7909221822','31');
insert into rainy_user_merch(user_id,merch) values('R7909221822','34');
insert into rainy_user_merch(user_id,merch) values('R7909221822','39');
insert into rainy_user_merch(user_id,merch) values('R7909221822','40');
insert into rainy_user_merch(user_id,merch) values('R7203227210','27');
insert into rainy_user_merch(user_id,merch) values('R7203227210','32');
insert into rainy_user_merch(user_id,merch) values('R7203227210','33');
insert into rainy_user_merch(user_id,merch) values('R7203227210','35');
insert into rainy_user_merch(user_id,merch) values('R7203227210','38');
insert into rainy_user_merch(user_id,merch) values('R7203227210','42');
insert into rainy_user_merch(user_id,merch) values('R7004151022','36');
insert into rainy_user_merch(user_id,merch) values('R7004151022','37');
insert into rainy_user_merch(user_id,merch) values('R7004151022','41');
insert into rainy_user_merch(user_id,merch) values('R7409254965','21');
insert into rainy_user_merch(user_id,merch) values('R7409254965','22');
insert into rainy_user_merch(user_id,merch) values('R7409254965','23');
insert into rainy_user_merch(user_id,merch) values('R7409254965','24');
insert into rainy_user_merch(user_id,merch) values('R7409254965','25');
insert into rainy_user_merch(user_id,merch) values('R7409254965','26');
insert into rainy_user_merch(user_id,merch) values('R7002270031','27');
insert into rainy_user_merch(user_id,merch) values('R7002270031','33');
insert into rainy_user_merch(user_id,merch) values('R7002270031','36');
insert into rainy_user_merch(user_id,merch) values('R7002270031','37');
insert into rainy_user_merch(user_id,merch) values('R7002270031','38');
insert into rainy_user_merch(user_id,merch) values('R7002270031','40');
insert into rainy_user_merch(user_id,merch) values('R7002270031','41');
----------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R7705200559','118001');
insert into rainy_user_loc (user_id,loc)values('R7705200559','120068');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118001');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118005');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118011');
insert into rainy_user_loc (user_id,loc)values('R7112073021','118012');
insert into rainy_user_loc (user_id,loc)values('R7112073021','120068');
insert into rainy_user_loc (user_id,loc)values('R7909221822','118001');
insert into rainy_user_loc (user_id,loc)values('R7909221822','120068');
insert into rainy_user_loc (user_id,loc)values('R7203227210','118001');
insert into rainy_user_loc (user_id,loc)values('R7203227210','120068');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118001');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118005');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118011');
insert into rainy_user_loc (user_id,loc)values('R7004151022','118012');
insert into rainy_user_loc (user_id,loc)values('R7004151022','120068');
insert into rainy_user_loc (user_id,loc)values('R7409254965','120021');
insert into rainy_user_loc (user_id,loc)values('R7002270031','120021');

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
   AND RU.ID BETWEEN 2149 AND 2158;

--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2149 AND 2158
and user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2149 AND 2158 ;
--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2149 AND 2158
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
         AND RU.ID BETWEEN 2149 AND 2158
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
   AND RU.ID BETWEEN 2149 AND 2158;

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
AND RU.ID BETWEEN 2149 AND 2158
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
AND RU.ID BETWEEN 2149 AND 2158 ;

--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2149 AND 2158 ;



--�û��ص�Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2149 AND 2158 ;

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2149 AND 2158 
ORDER BY RU.ID;
