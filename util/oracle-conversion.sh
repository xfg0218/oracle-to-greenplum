#!bin/bash

# 链接字符串信息
export NLS_LANG='SIMPLIFIED CHINESE_CHINA.ZHS16GBK'
export DB_ORCL='newdaas/Fcdt201901NewDaas@192.168.205.30/orcl'


#  c_gs_invite_baseinfo_xiaoxu 表的数据重命名

echo -e "\t \n c_gs_invite_baseinfo_xiaoxu ...... \n"

time sqlplus -s $DB_ORCL<<EOF

quit;

EOF




