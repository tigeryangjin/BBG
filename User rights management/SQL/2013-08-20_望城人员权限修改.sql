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
   AND RU.ID BETWEEN 2118 AND 2139;

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
AND RU.ID BETWEEN 2118 AND 2139 ;

--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2118 AND 2139 ;



--�û��ص�Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id =ru.user_id
where  RU.ID BETWEEN 2118 AND 2139 ;  

--ɾ�������û����ݣ�Ȩ���������Ҫɾ���ı�
DELETE FROM RSM_USER_ROLE T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2118 AND 2139);
DELETE FROM SEC_USER_GROUP T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2118 AND 2139);
DELETE FROM RAINY_USER_LOC T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2118 AND 2139);
DELETE FROM RAINY_USER_MERCH T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2118 AND 2139);
DELETE FROM RAINY_USER_POSITION T WHERE EXISTS(SELECT 1 FROM RAINY_USER RU WHERE T.USER_ID=RU.USER_ID AND RU.ID BETWEEN 2118 AND 2139);

insert into rainy_user_position(user_id,position_id) values('R7902140058',84);
insert into rainy_user_position(user_id,position_id) values('R8201158327',86);
insert into rainy_user_position(user_id,position_id) values('R8609271845',86);
insert into rainy_user_position(user_id,position_id) values('R7605200127',86);
insert into rainy_user_position(user_id,position_id) values('R7608084579',85);
insert into rainy_user_position(user_id,position_id) values('R8503216617',86);
insert into rainy_user_position(user_id,position_id) values('R8006303244',86);
insert into rainy_user_position(user_id,position_id) values('R840707078X',86);
insert into rainy_user_position(user_id,position_id) values('R7806193017',85);
insert into rainy_user_position(user_id,position_id) values('R870422031X',86);
insert into rainy_user_position(user_id,position_id) values('R8907071528',86);
insert into rainy_user_position(user_id,position_id) values('R7409163928',88);
insert into rainy_user_position(user_id,position_id) values('R8706264306',86);
insert into rainy_user_position(user_id,position_id) values('R750514046X',86);
insert into rainy_user_position(user_id,position_id) values('R8212034035',85);
insert into rainy_user_position(user_id,position_id) values('R8310212429',90);
insert into rainy_user_position(user_id,position_id) values('R8509060322',90);
insert into rainy_user_position(user_id,position_id) values('R890121164X',90);
insert into rainy_user_position(user_id,position_id) values('R7607110341',89);
insert into rainy_user_position(user_id,position_id) values('R8303101072',93);
insert into rainy_user_position(user_id,position_id) values('R8412274219',86);
insert into rainy_user_position(user_id,position_id) values('R8902034014',95);
---------------------------------------------------------------------------------
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
insert into rainy_user_merch(user_id,merch) values('R7605200127','15');
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
insert into rainy_user_merch(user_id,merch) values('R8412274219','27');
insert into rainy_user_merch(user_id,merch) values('R8412274219','33');
insert into rainy_user_merch(user_id,merch) values('R8412274219','38');
insert into rainy_user_merch(user_id,merch) values('R8902034014','ALL');

------------------------------------------------------------------------------
insert into rainy_user_loc (user_id,loc)values('R7902140058','118001');
insert into rainy_user_loc (user_id,loc)values('R7902140058','118005');
insert into rainy_user_loc (user_id,loc)values('R7902140058','118004');
insert into rainy_user_loc (user_id,loc)values('R7902140058','118010');
insert into rainy_user_loc (user_id,loc)values('R7902140058','118011');
insert into rainy_user_loc (user_id,loc)values('R7902140058','118012');
insert into rainy_user_loc (user_id,loc)values('R7902140058','120163');
insert into rainy_user_loc (user_id,loc)values('R8201158327','118001');
insert into rainy_user_loc (user_id,loc)values('R8201158327','118005');
insert into rainy_user_loc (user_id,loc)values('R8201158327','118004');
insert into rainy_user_loc (user_id,loc)values('R8201158327','118010');
insert into rainy_user_loc (user_id,loc)values('R8201158327','118011');
insert into rainy_user_loc (user_id,loc)values('R8201158327','118012');
insert into rainy_user_loc (user_id,loc)values('R8201158327','120163');
insert into rainy_user_loc (user_id,loc)values('R8609271845','118001');
insert into rainy_user_loc (user_id,loc)values('R8609271845','118005');
insert into rainy_user_loc (user_id,loc)values('R8609271845','118004');
insert into rainy_user_loc (user_id,loc)values('R8609271845','118010');
insert into rainy_user_loc (user_id,loc)values('R8609271845','118011');
insert into rainy_user_loc (user_id,loc)values('R8609271845','118012');
insert into rainy_user_loc (user_id,loc)values('R8609271845','120163');
insert into rainy_user_loc (user_id,loc)values('R7605200127','118001');
insert into rainy_user_loc (user_id,loc)values('R7605200127','118005');
insert into rainy_user_loc (user_id,loc)values('R7605200127','118004');
insert into rainy_user_loc (user_id,loc)values('R7605200127','118010');
insert into rainy_user_loc (user_id,loc)values('R7605200127','118011');
insert into rainy_user_loc (user_id,loc)values('R7605200127','118012');
insert into rainy_user_loc (user_id,loc)values('R7605200127','120163');
insert into rainy_user_loc (user_id,loc)values('R7608084579','118001');
insert into rainy_user_loc (user_id,loc)values('R7608084579','118005');
insert into rainy_user_loc (user_id,loc)values('R7608084579','118004');
insert into rainy_user_loc (user_id,loc)values('R7608084579','118010');
insert into rainy_user_loc (user_id,loc)values('R7608084579','118011');
insert into rainy_user_loc (user_id,loc)values('R7608084579','118012');
insert into rainy_user_loc (user_id,loc)values('R7608084579','120163');
insert into rainy_user_loc (user_id,loc)values('R7608084579','130015');
insert into rainy_user_loc (user_id,loc)values('R8503216617','118001');
insert into rainy_user_loc (user_id,loc)values('R8503216617','118005');
insert into rainy_user_loc (user_id,loc)values('R8503216617','118004');
insert into rainy_user_loc (user_id,loc)values('R8503216617','118010');
insert into rainy_user_loc (user_id,loc)values('R8503216617','118011');
insert into rainy_user_loc (user_id,loc)values('R8503216617','118012');
insert into rainy_user_loc (user_id,loc)values('R8503216617','120163');
insert into rainy_user_loc (user_id,loc)values('R8006303244','118001');
insert into rainy_user_loc (user_id,loc)values('R8006303244','118005');
insert into rainy_user_loc (user_id,loc)values('R8006303244','118004');
insert into rainy_user_loc (user_id,loc)values('R8006303244','118010');
insert into rainy_user_loc (user_id,loc)values('R8006303244','118011');
insert into rainy_user_loc (user_id,loc)values('R8006303244','118012');
insert into rainy_user_loc (user_id,loc)values('R8006303244','120163');
insert into rainy_user_loc (user_id,loc)values('R840707078X','118001');
insert into rainy_user_loc (user_id,loc)values('R840707078X','118005');
insert into rainy_user_loc (user_id,loc)values('R840707078X','118004');
insert into rainy_user_loc (user_id,loc)values('R840707078X','118010');
insert into rainy_user_loc (user_id,loc)values('R840707078X','118011');
insert into rainy_user_loc (user_id,loc)values('R840707078X','118012');
insert into rainy_user_loc (user_id,loc)values('R840707078X','120163');
insert into rainy_user_loc (user_id,loc)values('R840707078X','130015');
insert into rainy_user_loc (user_id,loc)values('R7806193017','118001');
insert into rainy_user_loc (user_id,loc)values('R7806193017','118005');
insert into rainy_user_loc (user_id,loc)values('R7806193017','118004');
insert into rainy_user_loc (user_id,loc)values('R7806193017','118010');
insert into rainy_user_loc (user_id,loc)values('R7806193017','118011');
insert into rainy_user_loc (user_id,loc)values('R7806193017','118012');
insert into rainy_user_loc (user_id,loc)values('R7806193017','120163');
insert into rainy_user_loc (user_id,loc)values('R870422031X','118001');
insert into rainy_user_loc (user_id,loc)values('R870422031X','118005');
insert into rainy_user_loc (user_id,loc)values('R870422031X','118004');
insert into rainy_user_loc (user_id,loc)values('R870422031X','118010');
insert into rainy_user_loc (user_id,loc)values('R870422031X','118011');
insert into rainy_user_loc (user_id,loc)values('R870422031X','118012');
insert into rainy_user_loc (user_id,loc)values('R870422031X','120163');
insert into rainy_user_loc (user_id,loc)values('R8907071528','118001');
insert into rainy_user_loc (user_id,loc)values('R8907071528','118005');
insert into rainy_user_loc (user_id,loc)values('R8907071528','118004');
insert into rainy_user_loc (user_id,loc)values('R8907071528','118010');
insert into rainy_user_loc (user_id,loc)values('R8907071528','118011');
insert into rainy_user_loc (user_id,loc)values('R8907071528','118012');
insert into rainy_user_loc (user_id,loc)values('R8907071528','120163');
insert into rainy_user_loc (user_id,loc)values('R7409163928','118001');
insert into rainy_user_loc (user_id,loc)values('R7409163928','118005');
insert into rainy_user_loc (user_id,loc)values('R7409163928','118004');
insert into rainy_user_loc (user_id,loc)values('R7409163928','118010');
insert into rainy_user_loc (user_id,loc)values('R7409163928','118011');
insert into rainy_user_loc (user_id,loc)values('R7409163928','118012');
insert into rainy_user_loc (user_id,loc)values('R7409163928','120163');
insert into rainy_user_loc (user_id,loc)values('R8706264306','118001');
insert into rainy_user_loc (user_id,loc)values('R8706264306','118005');
insert into rainy_user_loc (user_id,loc)values('R8706264306','118004');
insert into rainy_user_loc (user_id,loc)values('R8706264306','118010');
insert into rainy_user_loc (user_id,loc)values('R8706264306','118011');
insert into rainy_user_loc (user_id,loc)values('R8706264306','118012');
insert into rainy_user_loc (user_id,loc)values('R8706264306','120163');
insert into rainy_user_loc (user_id,loc)values('R750514046X','118001');
insert into rainy_user_loc (user_id,loc)values('R750514046X','118005');
insert into rainy_user_loc (user_id,loc)values('R750514046X','118004');
insert into rainy_user_loc (user_id,loc)values('R750514046X','118010');
insert into rainy_user_loc (user_id,loc)values('R750514046X','118011');
insert into rainy_user_loc (user_id,loc)values('R750514046X','118012');
insert into rainy_user_loc (user_id,loc)values('R750514046X','120163');
insert into rainy_user_loc (user_id,loc)values('R8212034035','118001');
insert into rainy_user_loc (user_id,loc)values('R8212034035','118005');
insert into rainy_user_loc (user_id,loc)values('R8212034035','118004');
insert into rainy_user_loc (user_id,loc)values('R8212034035','118010');
insert into rainy_user_loc (user_id,loc)values('R8212034035','118011');
insert into rainy_user_loc (user_id,loc)values('R8212034035','118012');
insert into rainy_user_loc (user_id,loc)values('R8212034035','120163');
insert into rainy_user_loc (user_id,loc)values('R8310212429','118001');
insert into rainy_user_loc (user_id,loc)values('R8310212429','118005');
insert into rainy_user_loc (user_id,loc)values('R8310212429','118004');
insert into rainy_user_loc (user_id,loc)values('R8310212429','118010');
insert into rainy_user_loc (user_id,loc)values('R8310212429','118011');
insert into rainy_user_loc (user_id,loc)values('R8310212429','118012');
insert into rainy_user_loc (user_id,loc)values('R8310212429','120163');
insert into rainy_user_loc (user_id,loc)values('R8509060322','118001');
insert into rainy_user_loc (user_id,loc)values('R8509060322','118005');
insert into rainy_user_loc (user_id,loc)values('R8509060322','118004');
insert into rainy_user_loc (user_id,loc)values('R8509060322','118010');
insert into rainy_user_loc (user_id,loc)values('R8509060322','118011');
insert into rainy_user_loc (user_id,loc)values('R8509060322','118012');
insert into rainy_user_loc (user_id,loc)values('R8509060322','120163');
insert into rainy_user_loc (user_id,loc)values('R890121164X','118001');
insert into rainy_user_loc (user_id,loc)values('R890121164X','118005');
insert into rainy_user_loc (user_id,loc)values('R890121164X','118004');
insert into rainy_user_loc (user_id,loc)values('R890121164X','118010');
insert into rainy_user_loc (user_id,loc)values('R890121164X','118011');
insert into rainy_user_loc (user_id,loc)values('R890121164X','118012');
insert into rainy_user_loc (user_id,loc)values('R890121164X','120163');
insert into rainy_user_loc (user_id,loc)values('R7607110341','118001');
insert into rainy_user_loc (user_id,loc)values('R7607110341','118005');
insert into rainy_user_loc (user_id,loc)values('R7607110341','118004');
insert into rainy_user_loc (user_id,loc)values('R7607110341','118010');
insert into rainy_user_loc (user_id,loc)values('R7607110341','118011');
insert into rainy_user_loc (user_id,loc)values('R7607110341','118012');
insert into rainy_user_loc (user_id,loc)values('R7607110341','120163');
insert into rainy_user_loc (user_id,loc)values('R8303101072','118001');
insert into rainy_user_loc (user_id,loc)values('R8303101072','118005');
insert into rainy_user_loc (user_id,loc)values('R8303101072','118004');
insert into rainy_user_loc (user_id,loc)values('R8303101072','118010');
insert into rainy_user_loc (user_id,loc)values('R8303101072','118011');
insert into rainy_user_loc (user_id,loc)values('R8303101072','118012');
insert into rainy_user_loc (user_id,loc)values('R8303101072','120163');
insert into rainy_user_loc (user_id,loc)values('R8412274219','118001');
insert into rainy_user_loc (user_id,loc)values('R8412274219','118005');
insert into rainy_user_loc (user_id,loc)values('R8412274219','118004');
insert into rainy_user_loc (user_id,loc)values('R8412274219','118010');
insert into rainy_user_loc (user_id,loc)values('R8412274219','118011');
insert into rainy_user_loc (user_id,loc)values('R8412274219','118012');
insert into rainy_user_loc (user_id,loc)values('R8412274219','120163');
insert into rainy_user_loc (user_id,loc)values('R8902034014','118001');
insert into rainy_user_loc (user_id,loc)values('R8902034014','118005');
insert into rainy_user_loc (user_id,loc)values('R8902034014','118004');
insert into rainy_user_loc (user_id,loc)values('R8902034014','118010');
insert into rainy_user_loc (user_id,loc)values('R8902034014','118011');
insert into rainy_user_loc (user_id,loc)values('R8902034014','118012');
insert into rainy_user_loc (user_id,loc)values('R8902034014','120163');
insert into rainy_user_loc (user_id,loc)values('R8902034014','130015');


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
   AND RU.ID BETWEEN 2118 AND 2139;

--�½��û������û����Ա�lang�ֶ�8��ʾ���ģ�1��ʾӢ��
SELECT 'insert into user_attrib(user_id,user_name,lang) values(' || chr( 39) ||
       ru.user_id || chr( 39 ) || ',' || chr (39 ) || ru.user_name || chr( 39) || ',' || 8 || ')' || ';'
  FROM rainy_user ru ;

insert into user_attrib( user_id, user_name, lang)
select user_id,user_name, '8'
from rainy_user ru
where  to_number (RU.id ) BETWEEN 2118 AND 2139
and user_id not in ( select user_id from user_attrib );

--����sec_user_group���ֶ����������
--Location�ص�
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_loc rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%'
  --AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     AND RU.ID BETWEEN 2118 AND 2139 ;
--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 2118 AND 2139
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
         AND RU.ID BETWEEN 2118 AND 2139
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
   AND RU.ID BETWEEN 2118 AND 2139;

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
AND RU.ID BETWEEN 2118 AND 2139
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
AND RU.ID BETWEEN 2118 AND 2139 ;

--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2118 AND 2139 ;



--�û��ص�Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@' ||a.LOC|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 2118 AND 2139 ;

--�û��������뵼����EXCEL����ʼ�
SELECT USER_ID, USER_NAME, PASSWORD
FROM RAINY_USER ru
WHERE RU.ID BETWEEN 2118 AND 2139 
ORDER BY RU.ID;



SELECT * FROM RAINY_USER WHERE USER_ID = 'R4122274219' for update;

SELECT * FROM RAINY_USER WHERE USER_ID = 'R8412274219' for update;

R8412274219




