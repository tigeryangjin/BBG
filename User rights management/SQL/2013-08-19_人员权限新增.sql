--insert into rainy_user(user_id,user_name,id) values('R8709171511','������','2091');
--insert into rainy_user(user_id,user_name,id) values('R8912181423','��Ӣ','2092');
--insert into rainy_user(user_id,user_name,id) values('R7611111049','�ξ�','2093');
--insert into rainy_user(user_id,user_name,id) values('R8407032818','����','2094');
--insert into rainy_user(user_id,user_name,id) values('R8303200037','�����','2095');
--insert into rainy_user(user_id,user_name,id) values('R6706073028','Ҷ����','2096');
--insert into rainy_user(user_id,user_name,id) values('R7009304512','̷־��','2097');
--insert into rainy_user(user_id,user_name,id) values('R7212170665','������','2098');
--insert into rainy_user(user_id,user_name,id) values('R7801101012','����','2099');
--insert into rainy_user(user_id,user_name,id) values('R750610042X','����֥','2100');
--insert into rainy_user(user_id,user_name,id) values('R6911130825','��С��','2101');
--insert into rainy_user(user_id,user_name,id) values('R9103230526','½��','2102');
--insert into rainy_user(user_id,user_name,id) values('R7010081017','�߾�','2103');
--insert into rainy_user(user_id,user_name,id) values('R7705034728','������','2104');
insert into rainy_user(user_id,user_name,id) values('R7711282517','���ؾ�','2105');
insert into rainy_user(user_id,user_name,id) values('R8507282514','����ƽ','2106');
insert into rainy_user(user_id,user_name,id) values('R8312294065','���ػ�','2107');
--insert into rainy_user(user_id,user_name,id) values('R7701011029','л��','2108');
insert into rainy_user(user_id,user_name,id) values('R8008213910','�Ž���','2109');
insert into rainy_user(user_id,user_name,id) values('R8005215015','�� ��','2110');
insert into rainy_user(user_id,user_name,id) values('R8802158746','���ֻ�','2111');
insert into rainy_user(user_id,user_name,id) values('R8604246422','������','2112');
insert into rainy_user(user_id,user_name,id) values('R9006188848','����','2113');
insert into rainy_user(user_id,user_name,id) values('R8910036235','����','2114');
insert into rainy_user(user_id,user_name,id) values('R751010011X','��ǿ','2115');
insert into rainy_user(user_id,user_name,id) values('R8808175413','��־��','2116');
insert into rainy_user(user_id,user_name,id) values('R7810237025','�ΰ���','2117');
------------------------------------------------------------------------------------------
--insert into rainy_user(user_id,user_name,id) values('R7902140058','Ф��','2118');
--insert into rainy_user(user_id,user_name,id) values('R8201158327','������','2119');
--insert into rainy_user(user_id,user_name,id) values('R8609271845','�곩','2120');
--insert into rainy_user(user_id,user_name,id) values('R7605200127','�����','2121');
--insert into rainy_user(user_id,user_name,id) values('R7608084579','������','2122');
--insert into rainy_user(user_id,user_name,id) values('R8503216617','����','2123');
--insert into rainy_user(user_id,user_name,id) values('R8006303244','Ф��','2124');
--insert into rainy_user(user_id,user_name,id) values('R840707078X','����','2125');
--insert into rainy_user(user_id,user_name,id) values('R7806193017','����','2126');
--insert into rainy_user(user_id,user_name,id) values('R870422031X','�ܺ���','2127');
--insert into rainy_user(user_id,user_name,id) values('R8907071528','��Զ��','2128');
--insert into rainy_user(user_id,user_name,id) values('R7409163928','�ܴ��','2129');
--insert into rainy_user(user_id,user_name,id) values('R8706264306','����Ƽ','2130');
--insert into rainy_user(user_id,user_name,id) values('R750514046X','лСƽ','2131');
--insert into rainy_user(user_id,user_name,id) values('R8212034035','�ܽ�','2132');
--insert into rainy_user(user_id,user_name,id) values('R8310212429','����ƽ','2133');
--insert into rainy_user(user_id,user_name,id) values('R8509060322','�ž�','2134');
--insert into rainy_user(user_id,user_name,id) values('R890121164X','���','2135');
--insert into rainy_user(user_id,user_name,id) values('R7607110341','�ܴ��','2136');
--insert into rainy_user(user_id,user_name,id) values('R8303101072','���','2137');
insert into rainy_user(user_id,user_name,id) values('R4122274219','��׿��','2138');
insert into rainy_user(user_id,user_name,id) values('R8902034014','������','2139');


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
  WHERE RU.ID BETWEEN 2138 AND 2139 ;

--Ȩ�ޱ�����û��޸�ID�У���BBG_Security_Application_User_List���л�ȡ
SELECT * FROM RAINY_USER
WHERE USER_ID IN( 'R7902140058','R8201158327','R8609271845','R7605200127','R7608084579','R8503216617','R8006303244',
'R840707078X','R7806193017','R870422031X','R8907071528','R7409163928','R8706264306','R750514046X','R8212034035',
'R8310212429','R8509060322','R890121164X','R7607110341','R8303101072') FOR UPDATE;
--insert into rainy_user(user_id,user_name,id) values('R7902140058','Ф��','2118');
--insert into rainy_user(user_id,user_name,id) values('R8201158327','������','2119');
--insert into rainy_user(user_id,user_name,id) values('R8609271845','�곩','2120');
--insert into rainy_user(user_id,user_name,id) values('R7605200127','�����','2121');
--insert into rainy_user(user_id,user_name,id) values('R7608084579','������','2122');
--insert into rainy_user(user_id,user_name,id) values('R8503216617','����','2123');
--insert into rainy_user(user_id,user_name,id) values('R8006303244','Ф��','2124');
--insert into rainy_user(user_id,user_name,id) values('R840707078X','����','2125');
--insert into rainy_user(user_id,user_name,id) values('R7806193017','����','2126');
--insert into rainy_user(user_id,user_name,id) values('R870422031X','�ܺ���','2127');
--insert into rainy_user(user_id,user_name,id) values('R8907071528','��Զ��','2128');
--insert into rainy_user(user_id,user_name,id) values('R7409163928','�ܴ��','2129');
--insert into rainy_user(user_id,user_name,id) values('R8706264306','����Ƽ','2130');
--insert into rainy_user(user_id,user_name,id) values('R750514046X','лСƽ','2131');
--insert into rainy_user(user_id,user_name,id) values('R8212034035','�ܽ�','2132');
--insert into rainy_user(user_id,user_name,id) values('R8310212429','����ƽ','2133');
--insert into rainy_user(user_id,user_name,id) values('R8509060322','�ž�','2134');
--insert into rainy_user(user_id,user_name,id) values('R890121164X','���','2135');
--insert into rainy_user(user_id,user_name,id) values('R7607110341','�ܴ��','2136');
--insert into rainy_user(user_id,user_name,id) values('R8303101072','���','2137');

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
   AND RU.ID BETWEEN 2091 AND 2139;

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
AND RU.ID BETWEEN 2091 AND 2139 ;

--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2091 AND 2139 ;



--�û��ص�Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2091 AND 2139 ;   
--ɾ�������û����ݣ�Ȩ���������Ҫɾ���ı�
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2091 AND 2139);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2091 AND 2139);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2091 AND 2139);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2091 AND 2139);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2091 AND 2139);

insert into rainy_user_position(user_id,position_id) values('R8709171511',85);
insert into rainy_user_position(user_id,position_id) values('R8912181423',86);
insert into rainy_user_position(user_id,position_id) values('R7611111049',86);
insert into rainy_user_position(user_id,position_id) values('R8407032818',85);
insert into rainy_user_position(user_id,position_id) values('R8407032818',86);
insert into rainy_user_position(user_id,position_id) values('R8303200037',85);
insert into rainy_user_position(user_id,position_id) values('R6706073028',86);
insert into rainy_user_position(user_id,position_id) values('R7009304512',86);
insert into rainy_user_position(user_id,position_id) values('R7212170665',86);
insert into rainy_user_position(user_id,position_id) values('R7801101012',86);
insert into rainy_user_position(user_id,position_id) values('R750610042X',85);
insert into rainy_user_position(user_id,position_id) values('R6911130825',86);
insert into rainy_user_position(user_id,position_id) values('R9103230526',86);
insert into rainy_user_position(user_id,position_id) values('R7010081017',85);
insert into rainy_user_position(user_id,position_id) values('R7705034728',84);
insert into rainy_user_position(user_id,position_id) values('R7711282517',93);
insert into rainy_user_position(user_id,position_id) values('R8507282514',95);
insert into rainy_user_position(user_id,position_id) values('R8312294065',90);
insert into rainy_user_position(user_id,position_id) values('R7701011029',85);
insert into rainy_user_position(user_id,position_id) values('R8008213910',85);
insert into rainy_user_position(user_id,position_id) values('R8005215015',86);
insert into rainy_user_position(user_id,position_id) values('R8802158746',86);
insert into rainy_user_position(user_id,position_id) values('R8604246422',86);
insert into rainy_user_position(user_id,position_id) values('R9006188848',86);
insert into rainy_user_position(user_id,position_id) values('R8910036235',86);
insert into rainy_user_position(user_id,position_id) values('R751010011X',86);
insert into rainy_user_position(user_id,position_id) values('R8808175413',86);
insert into rainy_user_position(user_id,position_id) values('R7810237025',88);
insert into rainy_user_position(user_id,position_id) values('R7902140058',85);
insert into rainy_user_position(user_id,position_id) values('R8201158327',86);
insert into rainy_user_position(user_id,position_id) values('R8609271845',86);
insert into rainy_user_position(user_id,position_id) values('R7605200127',86);
insert into rainy_user_position(user_id,position_id) values('R7608084579',85);
insert into rainy_user_position(user_id,position_id) values('R8503216617',86);
insert into rainy_user_position(user_id,position_id) values('R8006303244',86);
insert into rainy_user_position(user_id,position_id) values('R840707078X',88);
insert into rainy_user_position(user_id,position_id) values('R7806193017',86);
insert into rainy_user_position(user_id,position_id) values('R870422031X',86);
insert into rainy_user_position(user_id,position_id) values('R8907071528',85);
insert into rainy_user_position(user_id,position_id) values('R7409163928',90);
insert into rainy_user_position(user_id,position_id) values('R8706264306',90);
insert into rainy_user_position(user_id,position_id) values('R750514046X',90);
insert into rainy_user_position(user_id,position_id) values('R8212034035',89);
insert into rainy_user_position(user_id,position_id) values('R8310212429',93);
insert into rainy_user_position(user_id,position_id) values('R8509060322',86);
insert into rainy_user_position(user_id,position_id) values('R890121164X',95);
------------------------------------------------------------------------------------
insert into rainy_user_merch(user_id,merch) values('R7010081017','71');
insert into rainy_user_merch(user_id,merch) values('R7010081017','72');
insert into rainy_user_merch(user_id,merch) values('R7010081017','73');
insert into rainy_user_merch(user_id,merch) values('R8709171511','21');
insert into rainy_user_merch(user_id,merch) values('R8709171511','22');
insert into rainy_user_merch(user_id,merch) values('R8709171511','23');
insert into rainy_user_merch(user_id,merch) values('R8709171511','24');
insert into rainy_user_merch(user_id,merch) values('R8709171511','25');
insert into rainy_user_merch(user_id,merch) values('R8709171511','26');
insert into rainy_user_merch(user_id,merch) values('R8709171511','29');
insert into rainy_user_merch(user_id,merch) values('R8912181423','29');
insert into rainy_user_merch(user_id,merch) values('R7611111049','23');
insert into rainy_user_merch(user_id,merch) values('R7611111049','24');
insert into rainy_user_merch(user_id,merch) values('R8407032818','21');
insert into rainy_user_merch(user_id,merch) values('R8407032818','22');
insert into rainy_user_merch(user_id,merch) values('R8407032818','25');
insert into rainy_user_merch(user_id,merch) values('R8407032818','26');
insert into rainy_user_merch(user_id,merch) values('R8303200037','27');
insert into rainy_user_merch(user_id,merch) values('R8303200037','32');
insert into rainy_user_merch(user_id,merch) values('R8303200037','33');
insert into rainy_user_merch(user_id,merch) values('R8303200037','34');
insert into rainy_user_merch(user_id,merch) values('R8303200037','35');
insert into rainy_user_merch(user_id,merch) values('R8303200037','36');
insert into rainy_user_merch(user_id,merch) values('R8303200037','37');
insert into rainy_user_merch(user_id,merch) values('R8303200037','38');
insert into rainy_user_merch(user_id,merch) values('R8303200037','39');
insert into rainy_user_merch(user_id,merch) values('R8303200037','40');
insert into rainy_user_merch(user_id,merch) values('R8303200037','41');
insert into rainy_user_merch(user_id,merch) values('R6706073028','32');
insert into rainy_user_merch(user_id,merch) values('R6706073028','35');
insert into rainy_user_merch(user_id,merch) values('R6706073028','42');
insert into rainy_user_merch(user_id,merch) values('R7009304512','31');
insert into rainy_user_merch(user_id,merch) values('R7009304512','34');
insert into rainy_user_merch(user_id,merch) values('R7009304512','39');
insert into rainy_user_merch(user_id,merch) values('R7009304512','40');
insert into rainy_user_merch(user_id,merch) values('R7009304512','41');
insert into rainy_user_merch(user_id,merch) values('R7212170665','27');
insert into rainy_user_merch(user_id,merch) values('R7212170665','33');
insert into rainy_user_merch(user_id,merch) values('R7212170665','37');
insert into rainy_user_merch(user_id,merch) values('R7212170665','38');
insert into rainy_user_merch(user_id,merch) values('R7801101012','34');
insert into rainy_user_merch(user_id,merch) values('R7801101012','36');
insert into rainy_user_merch(user_id,merch) values('R7801101012','37');
insert into rainy_user_merch(user_id,merch) values('R750610042X','12');
insert into rainy_user_merch(user_id,merch) values('R750610042X','13');
insert into rainy_user_merch(user_id,merch) values('R750610042X','14');
insert into rainy_user_merch(user_id,merch) values('R750610042X','15');
insert into rainy_user_merch(user_id,merch) values('R750610042X','16');
insert into rainy_user_merch(user_id,merch) values('R750610042X','17');
insert into rainy_user_merch(user_id,merch) values('R750610042X','18');
insert into rainy_user_merch(user_id,merch) values('R750610042X','19');
insert into rainy_user_merch(user_id,merch) values('R6911130825','12');
insert into rainy_user_merch(user_id,merch) values('R6911130825','13');
insert into rainy_user_merch(user_id,merch) values('R6911130825','14');
insert into rainy_user_merch(user_id,merch) values('R6911130825','15');
insert into rainy_user_merch(user_id,merch) values('R9103230526','16');
insert into rainy_user_merch(user_id,merch) values('R9103230526','17');
insert into rainy_user_merch(user_id,merch) values('R9103230526','18');
insert into rainy_user_merch(user_id,merch) values('R7705034728','ALL');
insert into rainy_user_merch(user_id,merch) values('R8507282514','ALL');
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
insert into rainy_user_merch(user_id,merch) values('R8008213910','27');
insert into rainy_user_merch(user_id,merch) values('R8008213910','30');
insert into rainy_user_merch(user_id,merch) values('R8008213910','31');
insert into rainy_user_merch(user_id,merch) values('R8008213910','32');
insert into rainy_user_merch(user_id,merch) values('R8008213910','33');
insert into rainy_user_merch(user_id,merch) values('R8008213910','34');
insert into rainy_user_merch(user_id,merch) values('R8008213910','35');
insert into rainy_user_merch(user_id,merch) values('R8008213910','36');
insert into rainy_user_merch(user_id,merch) values('R8008213910','37');
insert into rainy_user_merch(user_id,merch) values('R8008213910','38');
insert into rainy_user_merch(user_id,merch) values('R8008213910','39');
insert into rainy_user_merch(user_id,merch) values('R8008213910','40');
insert into rainy_user_merch(user_id,merch) values('R8008213910','41');
insert into rainy_user_merch(user_id,merch) values('R8008213910','42');
insert into rainy_user_merch(user_id,merch) values('R8005215015','21');
insert into rainy_user_merch(user_id,merch) values('R8005215015','22');
insert into rainy_user_merch(user_id,merch) values('R8005215015','23');
insert into rainy_user_merch(user_id,merch) values('R8005215015','24');
insert into rainy_user_merch(user_id,merch) values('R8005215015','25');
insert into rainy_user_merch(user_id,merch) values('R8005215015','26');
insert into rainy_user_merch(user_id,merch) values('R8005215015','29');
insert into rainy_user_merch(user_id,merch) values('R8802158746','21');
insert into rainy_user_merch(user_id,merch) values('R8802158746','22');
insert into rainy_user_merch(user_id,merch) values('R8802158746','23');
insert into rainy_user_merch(user_id,merch) values('R8802158746','24');
insert into rainy_user_merch(user_id,merch) values('R8802158746','25');
insert into rainy_user_merch(user_id,merch) values('R8802158746','26');
insert into rainy_user_merch(user_id,merch) values('R8802158746','29');
insert into rainy_user_merch(user_id,merch) values('R8604246422','12');
insert into rainy_user_merch(user_id,merch) values('R8604246422','13');
insert into rainy_user_merch(user_id,merch) values('R8604246422','14');
insert into rainy_user_merch(user_id,merch) values('R8604246422','15');
insert into rainy_user_merch(user_id,merch) values('R8604246422','16');
insert into rainy_user_merch(user_id,merch) values('R8604246422','17');
insert into rainy_user_merch(user_id,merch) values('R8604246422','18');
insert into rainy_user_merch(user_id,merch) values('R8604246422','19');
insert into rainy_user_merch(user_id,merch) values('R9006188848','16');
insert into rainy_user_merch(user_id,merch) values('R9006188848','17');
insert into rainy_user_merch(user_id,merch) values('R9006188848','18');
insert into rainy_user_merch(user_id,merch) values('R9006188848','19');
insert into rainy_user_merch(user_id,merch) values('R8910036235','36');
insert into rainy_user_merch(user_id,merch) values('R8910036235','37');
insert into rainy_user_merch(user_id,merch) values('R751010011X','31');
insert into rainy_user_merch(user_id,merch) values('R751010011X','32');
insert into rainy_user_merch(user_id,merch) values('R751010011X','35');
insert into rainy_user_merch(user_id,merch) values('R751010011X','39');
insert into rainy_user_merch(user_id,merch) values('R751010011X','42');
insert into rainy_user_merch(user_id,merch) values('R8808175413','27');
insert into rainy_user_merch(user_id,merch) values('R8808175413','33');
insert into rainy_user_merch(user_id,merch) values('R8808175413','38');
insert into rainy_user_merch(user_id,merch) values('R8610011275','ALL');
insert into rainy_user_merch(user_id,merch) values('R7902140058','ALL');
insert into rainy_user_merch(user_id,merch) values('R8201158327','16');
insert into rainy_user_merch(user_id,merch) values('R8201158327','17');
insert into rainy_user_merch(user_id,merch) values('R8201158327','18');
insert into rainy_user_merch(user_id,merch) values('R8201158327','19');
insert into rainy_user_merch(user_id,merch) values('R8609271845','29');
insert into rainy_user_merch(user_id,merch) values('R7605200127','11');
insert into rainy_user_merch(user_id,merch) values('R7605200127','12');
insert into rainy_user_merch(user_id,merch) values('R7605200127','13');
insert into rainy_user_merch(user_id,merch) values('R7605200127','14');
insert into rainy_user_merch(user_id,merch) values('R7608084579','71');
insert into rainy_user_merch(user_id,merch) values('R7608084579','72');
insert into rainy_user_merch(user_id,merch) values('R7608084579','73');
insert into rainy_user_merch(user_id,merch) values('R7608084579','75');
insert into rainy_user_merch(user_id,merch) values('R7608084579','76');
insert into rainy_user_merch(user_id,merch) values('R7608084579','77');
insert into rainy_user_merch(user_id,merch) values('R7608084579','78');
insert into rainy_user_merch(user_id,merch) values('R8503216617','71');
insert into rainy_user_merch(user_id,merch) values('R8503216617','72');
insert into rainy_user_merch(user_id,merch) values('R8503216617','73');
insert into rainy_user_merch(user_id,merch) values('R8503216617','77');
insert into rainy_user_merch(user_id,merch) values('R8503216617','78');
insert into rainy_user_merch(user_id,merch) values('R8006303244','71');
insert into rainy_user_merch(user_id,merch) values('R8006303244','72');
insert into rainy_user_merch(user_id,merch) values('R8006303244','73');
insert into rainy_user_merch(user_id,merch) values('R8006303244','77');
insert into rainy_user_merch(user_id,merch) values('R8006303244','78');
insert into rainy_user_merch(user_id,merch) values('R840707078X','75');
insert into rainy_user_merch(user_id,merch) values('R840707078X','76');
insert into rainy_user_merch(user_id,merch) values('R7806193017','11');
insert into rainy_user_merch(user_id,merch) values('R7806193017','12');
insert into rainy_user_merch(user_id,merch) values('R7806193017','13');
insert into rainy_user_merch(user_id,merch) values('R7806193017','14');
insert into rainy_user_merch(user_id,merch) values('R7806193017','15');
insert into rainy_user_merch(user_id,merch) values('R7806193017','16');
insert into rainy_user_merch(user_id,merch) values('R7806193017','17');
insert into rainy_user_merch(user_id,merch) values('R7806193017','18');
insert into rainy_user_merch(user_id,merch) values('R7806193017','19');
insert into rainy_user_merch(user_id,merch) values('R7806193017','21');
insert into rainy_user_merch(user_id,merch) values('R7806193017','22');
insert into rainy_user_merch(user_id,merch) values('R7806193017','23');
insert into rainy_user_merch(user_id,merch) values('R7806193017','24');
insert into rainy_user_merch(user_id,merch) values('R7806193017','25');
insert into rainy_user_merch(user_id,merch) values('R7806193017','26');
insert into rainy_user_merch(user_id,merch) values('R7806193017','29');
insert into rainy_user_merch(user_id,merch) values('R870422031X','24');
insert into rainy_user_merch(user_id,merch) values('R870422031X','25');
insert into rainy_user_merch(user_id,merch) values('R870422031X','26');
insert into rainy_user_merch(user_id,merch) values('R8907071528','21');
insert into rainy_user_merch(user_id,merch) values('R8907071528','22');
insert into rainy_user_merch(user_id,merch) values('R8907071528','23');
insert into rainy_user_merch(user_id,merch) values('R8907071528','24');
insert into rainy_user_merch(user_id,merch) values('R8907071528','25');
insert into rainy_user_merch(user_id,merch) values('R8907071528','26');
insert into rainy_user_merch(user_id,merch) values('R8706264306','36');
insert into rainy_user_merch(user_id,merch) values('R8706264306','37');
insert into rainy_user_merch(user_id,merch) values('R750514046X','32');
insert into rainy_user_merch(user_id,merch) values('R750514046X','35');
insert into rainy_user_merch(user_id,merch) values('R750514046X','42');
insert into rainy_user_merch(user_id,merch) values('R8212034035','27');
insert into rainy_user_merch(user_id,merch) values('R8212034035','31');
insert into rainy_user_merch(user_id,merch) values('R8212034035','32');
insert into rainy_user_merch(user_id,merch) values('R8212034035','33');
insert into rainy_user_merch(user_id,merch) values('R8212034035','34');
insert into rainy_user_merch(user_id,merch) values('R8212034035','35');
insert into rainy_user_merch(user_id,merch) values('R8212034035','36');
insert into rainy_user_merch(user_id,merch) values('R8212034035','37');
insert into rainy_user_merch(user_id,merch) values('R8212034035','38');
insert into rainy_user_merch(user_id,merch) values('R8212034035','39');
insert into rainy_user_merch(user_id,merch) values('R8212034035','40');
insert into rainy_user_merch(user_id,merch) values('R8212034035','41');
insert into rainy_user_merch(user_id,merch) values('R8212034035','42');
insert into rainy_user_merch(user_id,merch) values('R4122274219','27');
insert into rainy_user_merch(user_id,merch) values('R4122274219','33');
insert into rainy_user_merch(user_id,merch) values('R4122274219','38');
---------------------------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R7010081017','120122');
insert into rainy_user_loc (user_id,loc)values('R8709171511','120122');
insert into rainy_user_loc (user_id,loc)values('R8912181423','120122');
insert into rainy_user_loc (user_id,loc)values('R7611111049','120122');
insert into rainy_user_loc (user_id,loc)values('R8407032818','120122');
insert into rainy_user_loc (user_id,loc)values('R8303200037','120122');
insert into rainy_user_loc (user_id,loc)values('R6706073028','120122');
insert into rainy_user_loc (user_id,loc)values('R7009304512','120122');
insert into rainy_user_loc (user_id,loc)values('R7212170665','120122');
insert into rainy_user_loc (user_id,loc)values('R7801101012','120122');
insert into rainy_user_loc (user_id,loc)values('R750610042X','120122');
insert into rainy_user_loc (user_id,loc)values('R6911130825','120122');
insert into rainy_user_loc (user_id,loc)values('R9103230526','120122');
insert into rainy_user_loc (user_id,loc)values('R7705034728','120196');
insert into rainy_user_loc (user_id,loc)values('R7711282517','120196');
insert into rainy_user_loc (user_id,loc)values('R8507282514','120196');
insert into rainy_user_loc (user_id,loc)values('R8312294065','120196');
insert into rainy_user_loc (user_id,loc)values('R7701011029','120196');
insert into rainy_user_loc (user_id,loc)values('R8008213910','120196');
insert into rainy_user_loc (user_id,loc)values('R8005215015','120196');
insert into rainy_user_loc (user_id,loc)values('R8802158746','120196');
insert into rainy_user_loc (user_id,loc)values('R8604246422','120196');
insert into rainy_user_loc (user_id,loc)values('R9006188848','120196');
insert into rainy_user_loc (user_id,loc)values('R8910036235','120196');
insert into rainy_user_loc (user_id,loc)values('R751010011X','120196');
insert into rainy_user_loc (user_id,loc)values('R8808175413','120196');
insert into rainy_user_loc (user_id,loc)values('R7810237025','120196');
insert into rainy_user_loc (user_id,loc)values('R8610011275','120163');
insert into rainy_user_loc (user_id,loc)values('R7902140058','120163');
insert into rainy_user_loc (user_id,loc)values('R8201158327','120163');
insert into rainy_user_loc (user_id,loc)values('R8609271845','120163');
insert into rainy_user_loc (user_id,loc)values('R7605200127','120163');
insert into rainy_user_loc (user_id,loc)values('R7608084579','120163');
insert into rainy_user_loc (user_id,loc)values('R8503216617','120163');
insert into rainy_user_loc (user_id,loc)values('R8006303244','120163');
insert into rainy_user_loc (user_id,loc)values('R840707078X','120163');
insert into rainy_user_loc (user_id,loc)values('R7806193017','120163');
insert into rainy_user_loc (user_id,loc)values('R870422031X','120163');
insert into rainy_user_loc (user_id,loc)values('R8907071528','120163');
insert into rainy_user_loc (user_id,loc)values('R7409163928','120163');
insert into rainy_user_loc (user_id,loc)values('R8706264306','120163');
insert into rainy_user_loc (user_id,loc)values('R750514046X','120163');
insert into rainy_user_loc (user_id,loc)values('R8212034035','120163');
insert into rainy_user_loc (user_id,loc)values('R8310212429','120163');
insert into rainy_user_loc (user_id,loc)values('R8509060322','120163');
insert into rainy_user_loc (user_id,loc)values('R890121164X','120163');
insert into rainy_user_loc (user_id,loc)values('R7607110341','120163');
insert into rainy_user_loc (user_id,loc)values('R8303101072','120163');
insert into rainy_user_loc (user_id,loc)values('R4122274219','120163');



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
   AND RU.ID BETWEEN 2091 AND 2139;

--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2091 AND 2139
and user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
     AND RU.ID BETWEEN 2091 AND 2139 ;
--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2091 AND 2139
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
         AND RU.ID BETWEEN 2091 AND 2139
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
   AND RU.ID BETWEEN 2091 AND 2139;

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
AND RU.ID BETWEEN 2091 AND 2139
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
AND RU.ID BETWEEN 2091 AND 2139 ;

--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2091 AND 2139 ;



--�û��ص�Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2091 AND 2139 ;

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2091 AND 2139 
ORDER BY RU.ID;
