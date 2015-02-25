--
SELECT * FROM RAINY_USER WHERE USER_ID IN ('R7001140022','R7409071024');
--
insert into RAINY_POSITION_ROLE(role_id,position_id) values(182,101);

SELECT 'dn: cn=' ||ra.role_name ||',cn=Groups,dc=bbg
changetype: modify
add: uniquemember
uniquemember: cn='||ru.user_id||',cn=users,dc=bbg
'
FROM RAINY_USER ru, RAINY_USER_POSITION rup,RAINY_POSITION_ROLE rpr,rainy_role ra
WHERE ru.user_id= rup.user_id
and rpr.position_id= rup.position_id
and rpr.role_id= ra.role_id and ra.appl = 'RA/BIP'
AND RPR.ROLE_ID=182 AND RPR.POSITION_ID=101;
--AND RU.USER_ID IN ( 'R9012281325','R7402050629' ,'R8210267147' );
