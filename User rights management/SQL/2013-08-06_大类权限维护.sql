8301290805 权限所辖大类从23调到29
7705130782 权限所辖大类从29调到23



--用户大类权限删除
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
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
