export ORACLE_HOME=$MW_HOME/Oracle_BI1
export ODBCINI=/u01/app/oracle/product/11.1.0/obiee_1/instances/instance1/bifoundation/OracleBIApplication/coreapplication/setup/odbc.ini
cd /u01/app/oracle/product/11.1.0/obiee_1/instances/instance1/bifoundation/OracleBIApplication/coreapplication/setup/
./bi-init.sh
cd /u01/app/oracle/product/11.1.0/obiee_1/Oracle_BI1/bifoundation/server/bin/
nqcmd -d AnalyticsWeb -u weblogic -p Oracle123 -s /u01/app/oracle/product/11.1.0/obiee_1/instances/instance1/SanFu/purgeAllCache >> /u01/app/oracle/product/11.1.0/obiee_1/instances/instance1/SanFu/NQCMD.log
