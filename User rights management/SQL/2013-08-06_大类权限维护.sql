8301290805 Ȩ����Ͻ�����23����29
7705130782 Ȩ����Ͻ�����29����23



--�û�����Ȩ��ɾ��
--��ѯ�����Ľ�������txt�ı��ļ�������Ҫ�ѡ�����ȥ����Ȼ����LDAP���룬file-->import
--SIM,RA/BIPϵͳ���û��Ĵ�����Ȩ�޵��޸ģ�����ͨ��LDAP���롣
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH || ',cn=Groups,dc=bbg'|| CHR ( 10 )||
'changetype: modify' ||CHR ( 10 )||
'delete: uniquemember' ||CHR ( 10 )||
'uniquemember: cn='||a.USER_ID ||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id =ru.user_id
where  RU.USER_ID IN ('R8301290805','R7705130782') ;

SELECT * FROM RAINY_USER_MERCH WHERE USER_ID IN ('R8301290805','R7705130782') FOR UPDATE;
SELECT * FROM RAINY_USER  WHERE USER_ID IN ('R8301290805','R7705130782');

SELECT * FROM SEC_USER_GROUP WHERE USER_ID IN ('R8301290805','R7705130782') FOR UPDATE;
SELECT * FROM SEC_GROUP WHERE GROUP_ID IN (1111,1116)
