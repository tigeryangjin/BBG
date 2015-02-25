SELECT * FROM RAINY_USER 
WHERE USER_ID IN ('R9012281325','R7402050629','R8210267147') for update;

1 R7402050629	李文玲	KDghz705	855
2	R8210267147	郭永红	JYgtl008	742
3	R9012281325	李帜	BLvgt878	875

--移除原职位权限
--查询出来的数据用sys用户名执行
SELECT 'revoke ' || rr.role_ext || ' from ' || ru.user_id || ';'
  FROM rainy_role          rr,
       rainy_user          ru,
       rainy_user_position rup,
       rainy_position_role rpr  
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id 
   AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147');
   
--删除表中用户数据
DELETE FROM RSM_USER_ROLE WHERE user_id IN ('R9012281325','R7402050629','R8210267147');
DELETE FROM SEC_USER_GROUP WHERE USER_ID IN ('R9012281325','R7402050629','R8210267147');
DELETE FROM RAINY_USER_LOC WHERE USER_ID IN ('R9012281325','R7402050629','R8210267147');
DELETE FROM RAINY_USER_MERCH WHERE USER_ID IN ('R9012281325','R7402050629','R8210267147');
DELETE FROM RAINY_USER_POSITION WHERE USER_ID IN ('R9012281325','R7402050629','R8210267147');


   
   
--从EXCEL表中取得语句插入用户职位表
insert into rainy_user_position(user_id,position_id) values('R9012281325',29);

--从EXCEL表中取得语句插入用户大类表
insert into rainy_user_merch(user_id,merch) values('R9012281325','ALL');
insert into rainy_user_merch(user_id,merch) values('R7402050629','ALL');
insert into rainy_user_merch(user_id,merch) values('R8210267147','ALL');

--从EXCEL表中取得语句插入用户地点表
insert into rainy_user_loc (user_id,loc)values('R9012281325','118004');

--插入RSM_USER_ROLE表
insert into RSM_USER_ROLE
select  rsm_user_role_seq.nextval, a.user_id,a.role_ext,SYSDATE - 720,null 
from (SELECT ru.user_id user_id,ra.role_ext role_ext      
        FROM rainy_user ru, rainy_user_position rup, rainy_position_role rpr,RAINY_ROLE ra
       WHERE ru.user_id = rup.user_id
         AND rup.position_id = rpr.position_id
         and rpr.role_id=ra.role_id and ra.appl='RPM'
         --注意以下条件 
         AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147')
         group  by ru.user_id,ra.role_ext ) a  
where a.role_ext is not null;

--插入sec_user_group表，分二种情况插入
INSERT INTO sec_user_group
  SELECT sg.group_id, ru.user_id
    FROM rainy_user ru, rainy_user_loc rul, sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Location%' || rul.loc || '%' 
     AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147');
     
INSERT INTO sec_user_group
  SELECT sg.group_id, ru.user_id
    FROM rainy_user ru, rainy_user_merch rul, sec_group sg
   WHERE ru.user_id = rul.user_id
     AND sg.group_name LIKE '%Department%' || rul.merch || '%' 
     AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147') 
     group by sg.group_id,ru.user_id; 
     
--添加新职位权限
--查询出来的数据用sys用户名执行
SELECT 'grant ' || rr.role_ext || ' to ' || ru.user_id || ';'
  FROM rainy_role          rr,
       rainy_user          ru,
       rainy_user_position rup,
       rainy_position_role rpr  
 WHERE rr.appl = 'RMS'
   AND rup.user_id = ru.user_id
   AND rup.position_id = rpr.position_id
   AND rpr.role_id = rr.role_id
   AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147');
 
--SIM系统导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import   
SELECT rr.role_name,ru.user_id, 'dn: roleName=' || rr.role_name || ',cn=' || ru.user_id ||
        ',cn=Users,dc=bbg
changetype: add
objectclass: simUserRole
roleName: ' || rr.role_name || chr(13) || 'userRole: roleName=' ||
        rr.role_name || ',cn=SIMRoles,cn=SIM,dc=bbg
userRoleStores: ' || wm_concat( 'storeId='|| rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13))
        /*(SELECT wm_concat(decode(rul.loc,
                                 'ALL',
                                 'storeId='||rl.loc_id || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13),
                                 'storeId='|| rul.loc || ',cn=SIMStores,cn=SIM,dc=bbg'||chr(13))) 
           FROM rainy_loc rl)*/ text
  FROM rainy_role          rr,
       rainy_user          ru,
       rainy_user_position rup,
       rainy_position_role rpr,
       rainy_user_loc      rul
--  rainy_loc           rl
 WHERE rr.appl = 'SIM'
   AND ru.user_id = rup.user_id
   AND rr.role_id = rpr.role_id
   AND rup.position_id = rpr.position_id
   AND ru.user_id = rul.user_id
and rul.loc='ALL'
AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147')
GROUP BY  rr.role_name,ru.user_id;

--RA/BIP权限导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import  
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT 'dn: cn='||ra.role_name||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
' 
FROM RAINY_USER ru,RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id=rup.user_id
and rpr.position_id=rup.position_id
and rpr.role_id=ra.role_id and ra.appl ='RA/BIP'
AND RU.USER_ID IN ('R9012281325','R7402050629','R8210267147');

--用户大类权限导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import  
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT 
'dn: cn=RA_DATA_SECURITY_DOMAIN@'||MERCH||',cn=Groups,dc=bbg'||CHR(10)||
'changetype: modify'||CHR(10)||
'add: uniquemember'||CHR(10)||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg'||CHR(10) 
FROM RAINY_USER_MERCH a left join rainy_user ru on a.user_id=ru.user_id 
where  to_number(ru.id) between 898 and 900  ;



--用户地点权限导入
--查询处理的结果保存成txt文本文件，并且要把【”】去掉，然后用LDAP导入，file-->import  
--SIM,RA/BIP系统的用户的创建、权限的修改，都是通过LDAP导入。
SELECT DISTINCT
'dn: cn=RA_DATA_SECURITY_LOC@'||a.LOC||',cn=Groups,dc=bbg'||CHR(10)||
'changetype: modify'||CHR(10)||
'add: uniquemember'||CHR(10)||
'uniquemember: cn='||a.USER_ID||',cn=users,dc=bbg'||CHR(10) 
FROM RAINY_USER_LOC a left join rainy_user ru on a.user_id=ru.user_id 
where  to_number(ru.id) between 898 and 900;

dn: cn=RA_DATA_SECURITY_DOMAIN@ALL,cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn=R7402050629,cn=users,dc=bbg

dn: cn=RA_DATA_SECURITY_LOC@120180,cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn=R7402050629,cn=users,dc=bbg


