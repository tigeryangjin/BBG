
/*
120056
120164
120022
120123
120082
120122
120027
120033
120028
120065
120170
120020
120015
120153
120045
120145
120030
120110
120036
120129
120095
120146
120035
120127
120011
120159
120051
120060
120135
120124
120195
120194
120116
120173
120185
*/

/*hyk_hyxx 会员信息
hyk_grxx 个人信息
hyk_jfzh 积分总和
hyk_mdjf 门店积分
mddy 门店定义
lm_md 门店路名
md_sq_lm 门店商圈路名
hyxfjl 消费记录
*/

SELECT * FROM mddy;
--截至9月30日会员来客数
SELECT * FROM RADM.hyk_hyxx;
SELECT DISTINCT STATUS FROM RADM.hyk_hyxx;
SELECT COUNT(*) FROM RADM.hyk_hyxx
WHERE JKRQ<DATE'2013-10-1' AND YXQ>SYSDATE;
6275933;
--9月会员来客数
select * 
from radm.hyxfjl t ,mddy md
where t.mdid=md.mdid and t.xfsj between date'2013-09-01' and date'2013-09-30'
and substr(md.mddm,4,2)||substr(md.mddm3,1)||sub in ();
