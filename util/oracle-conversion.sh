#!bin/bash

# 链接字符串信息
export NLS_LANG='SIMPLIFIED CHINESE_CHINA.ZHS16GBK'
export DB_ORCL='username/password@ip/orcl'


#  c_gs_invite_baseinfo_xiaoxu 表的数据重命名

echo -e "\t \n updateinfo_xiaoxu 转换数据开始 ...... \n"

time sqlplus -s $DB_ORCL<<EOF


-- oracle   sql   conversion


quit;

EOF




