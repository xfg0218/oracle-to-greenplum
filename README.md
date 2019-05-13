# oracle数据同步到Greenplum的shell脚本
  此脚本在运行时会先把oracle数据按照指定的分隔符下载到磁盘的目录下,再用替换脚本替换需要的分隔符和ascii字符,具体的替换方法请查看fileAsciiReplaceScriptAll.sh脚本
# oracle  字段映射 Greenplum  字段说明
	以下字段类型是作者在实际使用时遇到的常见字段类型

	oracle字段	Greenplum字段
	varchar2	varchar
	date	        date
	timestamp	timestamp
	clob	        text
	number		numeric

# sqluldr2linux64 工具下载
    
	sqluldr2linux64 下载地址:链接：https://pan.baidu.com/s/1pF_HMx5VUdwu16-cSn2ZBg 提取码：ddrn 
	oracle 客户端下载地址:链接：https://pan.baidu.com/s/1Llt1hRJ0BL-NQQT8V90T8Q 提取码：rwjb 
# ASCII特殊字符介绍
  ASCII特殊字符请查看:https://blog.csdn.net/xfg0218/article/details/80901752
  
# 测试数据介绍
  1、oracle表信息updateinfo_xiaoxu

       ANCHEID	VARCHAR2(100 BYTE)
       ALITEM	VARCHAR2(1000 BYTE)
       ALTBE	VARCHAR2(4000 BYTE)
       ALTAF	VARCHAR2(4000 BYTE)
       ALTDATE	DATE
       S_EXT_NODENUM	VARCHAR2(10 BYTE)
   2、oracle 表的个数

      select count(*) from updateinfo_xiaoxu;
       -- 6475930
# oracle-to-greenplum 目录介绍
        data-dir
        存放oracle数据落地的目录

        select-sql
        sql文件存放的路径,oracle的sql文件以及greenplum的sql文件

        util
        常用工具的存放路径

        export-oracle.sh
        从oracle落地到磁盘的sh脚本

        import-greenplum.sh
        把磁盘的文件导入到greenplum的脚本

        sqluldr2linux64.bin
        抽取oracle的工具
# oracle-to-greenplum 使用说明
     su - oracle
     time sh export-oracle.sh 
           0 rows exported at 2019-05-13 12:42:14, size 0 MB.
     1000000 rows exported at 2019-05-13 12:42:20, size 172 MB.
     2000000 rows exported at 2019-05-13 12:42:26, size 296 MB.
     3000000 rows exported at 2019-05-13 12:42:32, size 468 MB.
     4000000 rows exported at 2019-05-13 12:42:38, size 603 MB.
     5000000 rows exported at 2019-05-13 12:42:44, size 743 MB.
     6000000 rows exported at 2019-05-13 12:42:50, size 887 MB.
     6475930 rows exported at 2019-05-13 12:42:52, size 952 MB.
         output file /home/xiaoxu/oracle-to-greenplum/data-dir/updateinfo_xiaoxu.csv closed at 6475930 rows, size 952 MB.

	 替换特殊字符与分隔符......
	 
	 参数说明
	 把此脚本复制到带有特殊字符的文件夹下运行此脚本即可把全部文件进行替换,例如:sh fileAsciiReplaceScriptAll.sh

	 转换开始...... 

	 文件 /home/xiaoxu/oracle-to-greenplum/data-dir/updateinfo_xiaoxu.csv 特殊符号替换开始....
	 文件 /home/xiaoxu/oracle-to-greenplum/data-dir/updateinfo_xiaoxu.csv 特殊符号替换结束,耗时:0 h 1 m 5s

	 文件 /home/xiaoxu/oracle-to-greenplum/data-dir/updateinfo_xiaoxu.csv 替换分隔符开始....
	 文件 /home/xiaoxu/oracle-to-greenplum/data-dir/updateinfo_xiaoxu.csv 替换分隔符结束,耗时: 0 h 0 m 26 s


	 全部文件转换结束,耗时: 0 h 1 m 32 s
	 
	 创建 updateinfo_xiaoxu.csv 表结构开始...... 
         DROP TABLE
	 CREATE TABLE

	 real	0m0.200s
	 user	0m0.003s
	 sys	0m0.004s

 	 导入 updateinfo_xiaoxu.csv  数据开始......
	 COPY 6475930

	 real	0m19.699s
	 user	0m2.845s
	 sys	0m0.834s

	 real	2m32.290s
	 user	1m30.223s
	 sys	0m21.867s

# oracle-to-greenplum 总结说明
	1、在以上可以看出使用sqluldr2linux64导数据,大概6s就能抽取100W行数据，大概有172M
	2、替换分隔符与ASCII码耗时1m32s
	3、创建表结构与导入表数据耗时:19.699s
	4、总耗时2m32.29s
# Oracle  带有 RAW  类型的表结构
	1、在oracle中数据类型转换
	请修改util下的oracle-conversion.sh脚本，并在-- oracle   sql   conversion出添加以下转换即可 create table invevents_xiaoxu_a as select id,declaredate,eventcode,eventname,invname,tmstamp||'' as tmstamp,entrydate from invevents_xiaoxu;
	2、在任务中添加执行oracle-conversion.sh的脚本
	只要在export-oracle.sh脚本中打开oracle-conversion.sh 即可
# Oracle 带有CLOB类型的字段
	1、首先查询CLOB字段的长度
	2、使用截取字符串的形式截取CLOB字段

	实现步骤如下
	drop table markinf_xiaoxu;
	create table markinf_xiaoxu_temp as select * from markinf_xiaoxu;

	alter table newdaas.markinf_xiaoxu_temp rename column typedetaildes to typedetaildes_temp;
	alter table newdaas.markinf_xiaoxu_temp add typedetaildes1 varchar2(4000);
	alter table newdaas.markinf_xiaoxu_temp add typedetaildes2 varchar2(4000);
	********

	update newdaas.markinf_xiaoxu_temp set typedetaildes1=trim(DBMS_LOB.SUBSTR(typedetaildes_temp,1000,1) || DBMS_LOB.SUBSTR(typedetaildes_temp,1000,1001));
	update newdaas.markinf_xiaoxu_temp set typedetaildes2=trim(DBMS_LOB.SUBSTR(typedetaildes_temp,1000,2001) || DBMS_LOB.SUBSTR(typedetaildes_temp,1000,3001));
	********

	alter table newdaas.markinf_xiaoxu_temp drop column typedetaildes_temp;

	3、在任务中添加执行oracle-conversion.sh的脚本
	只要在export-oracle.sh脚本中打开oracle-conversion.sh 即可

	4、使用Greenplum拼接函数拼接字段
	在greenplum中使用COALESCE函数拼接字段，目的是方式出现空值，实例如下:

	alter table ods.markinf_xiaoxu_temp add  typedetaildes text;
	update ods.markinf_xiaoxu_temp set typedetaildes=COALESCE(typedetaildes1,'')||COALESCE(typedetaildes2,''); 等等

	alter table ods.markinf_xiaoxu_temp drop column typedetaildes1;
	alter table ods.markinf_xiaoxu_temp drop column typedetaildes2;
	*******



