#!bin/bash
 
# 当前的日期
#current_date=$1

# 当前目录与父目录
current_path=$(cd `dirname $0`; pwd)
current_parent_path=$(dirname $(pwd))

# 创建表的SQL与数据的路径与表的名字
table_name=$1
create_table=$current_path"/select-sql/greenlum-sql/create-table.sql"
oracle_file_path=$current_path"/data-dir/"$table_name

# 数据库名字
gpdatabase='stagging'

# scheam 名字
scheamname='ods'

# gp服务器ip
gpip='192.168.209.11'

#gp port
gpport='5432'

# gp user
gpuser='gpadmin'

echo  -e "\n\r  创建 $table_name 表结构开始...... "
time psql -d $gpdatabase  -h $gpip -p $gpport -U $gpuser -f $create_table

echo -e "\n\r 导入 $table_name  数据开始......" 
time psql -d $gpdatabase  -h $gpip -p $gpport -U $gpuser -c "\COPY ods.${table_name%.*}  FROM '$oracle_file_path' WITH csv DELIMITER E'\001'  LOG ERRORS SEGMENT REJECT LIMIT 500 ROWS"

