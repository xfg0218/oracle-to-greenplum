#!bin/sh

# 特殊字符查看表
# https://blog.csdn.net/xfg0218/article/details/80901752

# 当前的日期
currentDate=`date +%Y%m%d`

# 需要替换文件的路径
replace_file_path=$1

# 向gp数据库插入脚本
thisshell='fileAsciiReplaceScriptAll.sh'

echo  "参数说明"
        echo -e "\t 把此脚本复制到带有特殊字符的文件夹下运行此脚本即可把全部文件进行替换,例如:sh" $thisshell
echo

echo -e "\t 转换开始...... \n" 

# 设置脚本开始时间
starttime=`date +'%Y-%m-%d %H:%M:%S'`

# 特殊字符的集合,28是特殊字符的10进制代码
soh=`echo 1 | awk '{printf("%c", $1)}'`
stx=`echo 2 | awk '{printf("%c", $1)}'`
etx=`echo 3 | awk '{printf("%c", $1)}'`
eot=`echo 4 | awk '{printf("%c", $1)}'`
enq=`echo 5 | awk '{printf("%c", $1)}'`
ack=`echo 6 | awk '{printf("%c", $1)}'`
bel=`echo 7 | awk '{printf("%c", $1)}'`
bs=`echo 8 | awk '{printf("%c", $1)}'`
ht=`echo 9 | awk '{printf("%c", $1)}'`
lf=`echo 10 | awk '{printf("%c", $1)}'`
vt=`echo 11 | awk '{printf("%c", $1)}'`
ff=`echo 12 | awk '{printf("%c", $1)}'`
cr=`echo 13 | awk '{printf("%c", $1)}'`
so=`echo 14 | awk '{printf("%c", $1)}'`
si=`echo 15 | awk '{printf("%c", $1)}'`
dle=`echo 16 | awk '{printf("%c", $1)}'`
dc1=`echo 17 | awk '{printf("%c", $1)}'`
dc2=`echo 18 | awk '{printf("%c", $1)}'`
dc3=`echo 19 | awk '{printf("%c", $1)}'`
dc4=`echo 20 | awk '{printf("%c", $1)}'`
nak=`echo 21 | awk '{printf("%c", $1)}'`
syn=`echo 22 | awk '{printf("%c", $1)}'`
etb=`echo 23 | awk '{printf("%c", $1)}'`
can=`echo 24 | awk '{printf("%c", $1)}'`
em=`echo 25 | awk '{printf("%c", $1)}'`
sub=`echo 26 | awk '{printf("%c", $1)}'`
esc=`echo 27 | awk '{printf("%c", $1)}'`
fs=`echo 28 | awk '{printf("%c", $1)}'`
gs=`echo 29 | awk '{printf("%c", $1)}'`
rs=`echo 30 | awk '{printf("%c", $1)}'`
us=`echo 31 | awk '{printf("%c", $1)}'`
del=`echo 127 | awk '{printf("%c", $1)}'`

# 循环把文件下的所有文件取出来
for replaceFile in  `ls $replace_file_path `
do

# 去除入库GP库与写入数据成功的脚本文件
if [ $replaceFile = $thisshell  ];then
continue;
fi

echo -e "\t 文件 $replaceFile 特殊符号替换开始...."

# 单个文件处理的开始时间
single_time=`date +'%Y-%m-%d %H:%M:%S'`

# 单个文件替换开始
sed -i  -e 's/\\//g' -e 's/\"//g'  -e 's/[\x0]//g' -e 's/'$stx'//g' -e 's/'$etx'//g' -e 's/'$eot'//g' -e 's/'$enq'//g' -e 's/'$ack'//g' -e 's/'$bel'//g' -e 's/'$bs'//g' -e 's/'$lf'//g' -e 's/'$vt'//g' -e 's/'$ff'//g' -e 's/'$cr'//g' -e 's/'$so'//g' -e 's/'$si'//g' -e 's/'$dle'//g' -e 's/'$dc1'//g' -e 's/'$dc2'//g' -e 's/'$dc3'//g' -e 's/'$dc4'//g' -e 's/'$nak'//g' -e 's/'$syn'//g' -e 's/'$etb'//g' -e 's/'$can'//g' -e 's/'$em'//g' -e 's/'$sub'//g' -e 's/'$esc'//g' -e 's/'$fs'//g' -e 's/'$gs'//g' -e 's/'$rs'//g' -e 's/'$us'//g' -e 's/'$del'//g' -e 's/'$'//g'  $replaceFile

# 替换单个文件特殊符号耗时
single_endtime=`date +'%Y-%m-%d %H:%M:%S'`
single_start_seconds=$(date --date="$single_time" +%s);
single_end_seconds=$(date --date="$single_endtime" +%s);
time_of_use=$((single_end_seconds-single_start_seconds))

echo -e "\t 文件" $replaceFile "特殊符号替换结束,耗时:"$((time_of_use/3600)) h $((time_of_use%3600/60)) m $((time_of_use%3600%60))"s\n"

# 定义分隔符
splitSign='@@@&&&'

splitSign_time=`date +'%Y-%m-%d %H:%M:%S'`

# 替换分隔符开始
echo -e "\t 文件 $replaceFile 替换分隔符开始...."

sed -i 's/'$splitSign'/'$soh'/g' $replaceFile

# 计算替换分隔符耗时
splitSign_endtime=`date +'%Y-%m-%d %H:%M:%S'`
splitSign_start_seconds=$(date --date="$splitSign_time" +%s);
splitSign_end_seconds=$(date --date="$splitSign_endtime" +%s);
sumSecond=$((splitSign_end_seconds-splitSign_start_seconds))

echo -e "\t 文件 $replaceFile 替换分隔符结束,耗时: $((sumSecond/3600)) h $((sumSecond%3600/60)) m $((sumSecond%3600%60)) s"
echo -e "\n"

done


# 全部文件替换的总耗时
endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
sumSecond=$((end_seconds-start_seconds))

echo -e "\t 全部文件转换结束,耗时: $((sumSecond/3600)) h $((sumSecond%3600/60)) m $((sumSecond%3600%60)) s \n"

echo -e "--------------------------------------------------------------------\n"

# 退出脚本
exit
