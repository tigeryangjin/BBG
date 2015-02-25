R8302282784无审批
R8611030563有审批
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID = 'R8302282784';
SELECT * FROM RAINY_USER_POSITION WHERE USER_ID = 'R8611030563';

SELECT * FROM RAINY_USER WHERE USER_ID = 'R8302282784';
SELECT * FROM RAINY_USER WHERE USER_ID = 'R8611030563';
--查看某一用户的权限明细
SELECT RR.*
FROM RAINY_USER_POSITION RUP,RAINY_POSITION_ROLE RPR,RAINY_ROLE RR
WHERE RUP.POSITION_ID=RPR.POSITION_ID AND RR.ROLE_ID=RPR.ROLE_ID
AND USER_ID = 'R8302282784' ;

SELECT RR.*
FROM RAINY_USER_POSITION RUP,RAINY_POSITION_ROLE RPR,RAINY_ROLE RR
WHERE RUP.POSITION_ID=RPR.POSITION_ID AND RR.ROLE_ID=RPR.ROLE_ID
AND USER_ID = 'R8611030563' ;

R8611030563
SELECT * FROM RAINY_ROLE RR WHERE RR.APPL='RPM';


--插入RSM_USER_ROLE表
--RPM系统权限写入
insert into RSM_USER_ROLE
select  rsm_user_role_seq.nextval, a.user_id, a.role_ext, SYSDATE - 720, null
from ( SELECT ru.user_id user_id ,ra.role_ext role_ext    
        FROM rainy_user ru , rainy_user_position rup , rainy_position_role rpr,RAINY_ROLE ra
       WHERE ru.user_id = rup.user_id
         AND rup.position_id = rpr.position_id
         and rpr.role_id =ra.role_id and ra.appl ='RPM'
         --注意以下条件
         AND RU.ID = 873
         group  by ru.user_id ,ra.role_ext ) a
where a.role_ext is not null ;

SELECT * FROM RSM_USER_ROLE  WHERE USER_ID='R8302282784';
SELECT * FROM RSM_USER_ROLE  WHERE USER_ID='R8611030563';
