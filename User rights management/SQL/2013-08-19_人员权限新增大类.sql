insert into rainy_user_merch(user_id,merch) values('R8307206613','12');
insert into rainy_user_merch(user_id,merch) values('R8307206613','76');

insert into rainy_user_merch(user_id,merch) values('R7608048546','12');
insert into rainy_user_merch(user_id,merch) values('R7608048546','76');

insert into rainy_user_merch(user_id,merch) values('R9007105011','16');


--Department����   
INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.USER_ID IN ('R8307206613','R7608048546','R9007105011')
    AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID)
     group by sg.group_id,ru.user_id;
     
--�û�����Ȩ�޵���
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.USER_ID IN ('R8307206613','R7608048546','R9007105011') ;



