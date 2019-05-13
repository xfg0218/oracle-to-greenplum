 drop table if exists ods.updateinfo_xiaoxu;
create table ods.updateinfo_xiaoxu
(
ancheid	varchar(100),
alitem	varchar(1000),
altbe	varchar(4000),
altaf	varchar(4000),
altdate	date,
s_ext_nodenum	varchar(10)
) 
with (appendonly = true, compresstype = zlib, compresslevel = 5
,orientation=column, checksum = false,blocksize = 2097152)
Distributed by (ancheid)
