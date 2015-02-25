R8209290418 增加27大类
R8212221036 增加42大类

SELECT * FROM RAINY_USER WHERE USER_ID IN ('R8209290418','R8212221036');
SELECT * FROM RAINY_USER_MERCH WHERE USER_ID IN ('R8209290418','R8212221036');

insert into rainy_user_merch(user_id,merch) values('R8209290418','27');
insert into rainy_user_merch(user_id,merch) values('R8212221036','42');

--用户大类权限导入
--查询出来的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_DOMAIN@' ||MERCH|| ',cn=Groups,dc=bbg'|| CHR (10 )||
'changetype: modify' ||CHR ( 10 )||
'add: uniquemember'||CHR (10 )||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg' ||CHR ( 10 )
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id
where  RU.ID BETWEEN 1285 AND 1286 ;


--Department大类   
INSERT INTO 

INSERT INTO sec_user_group
  SELECT sg.group_id , ru.user_id
    FROM rainy_user ru , rainy_user_merch rul , sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%'
     AND RU.ID BETWEEN 1285 AND 1286
     AND NOT EXISTS(SELECT 1 FROM sec_user_group SUG WHERE SUG.USER_ID=RU.USER_ID AND SUG.GROUP_ID=SG.GROUP_ID  )
     group by sg.group_id,ru.user_id;


SELECT * FROM SEC_USER_GROUP WHERE USER_ID ='R8209290418'
SELECT * FROM SEC_GROUP 
	1115	Security Department 27	
	1129	Security Department 42		
	
