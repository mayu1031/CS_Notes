<!-- GFM-TOC -->
* [1. DB总概述](#DB总概述)
* [2. MySQL数据库](#MySQL数据库)
* [3. MySQL基本使用](#MySQL基本使用)
* [4. SQL数据类型](#SQL数据类型)
* [5. 表基本操作](#表基本操作)
* [6. 索引](#索引)
* [7.MySQL查询](#MySQL查询)
<!-- GFM-TOC -->

# 1. DB总概述

## **DB应用领域**
 - 后台程序员
    - 增删改查 CRUD
    - 数据库常见概念
 - DBA
    - 数据库设计者
    - ER 图
    - 关系数学
    - 范式
 - 运维
    - 数据库常见的瓶颈问题解决
    - 备份
    - 分表分库
    

## **数据库定义**
- DB database
- DBMS DB ManagementSystem: 用来操作和管理数据库的大型服务软件
- DBS: DB+DBMS
- Server/Client 服务器/客户端
- E-R数据模型 entity-relation model 实体关系模型
    - 方形：实体
    - 椭圆形： 属性
    - 菱形： 关系
    
## **数据库分类**

- 关系型数据库
- 基于关系数学
- 最常见
- 非关系型数据 -NoSQL not only sql
    - MongoDB 比如网页 图片
    - Redis
    - Neo4j
        
## **数据库产品**

- Oracle
    - MySQL 
    - Oracle DataBase
- Microsoft
    - SQL Server
    - Access
- IBM
    - DB2
- Sybase
    - Sybase


# 2. MySQL数据库

## **MySQL快捷键**
- 1.ctrl+q           打开查询窗口
- 2.ctrl+/           注释sql语句
- 3.ctrl+shift +/    解除注释
- 4.ctrl+r           运行查询窗口的sql语句
- 5.ctrl+shift+r     只运行选中的sql语句
- 6.F6               打开一个mysql命令行窗口
- 7.ctrl+l           删除一行
- 8.ctrl+n           打开一个新的查询窗口
- 9.ctrl+w           关闭一个查询窗口

# 3. MySQL基本使用

## **数据库指令**
- 不区分大小写（密码，变量值除外）
- 每条sql指令以；结束或分隔
- 不支持tab自动补齐
- **\c可废弃当前边写错的操作指令**
    
### **登录**
- mysql -u root -p （-h 服务器 -u 用户名 -p 密码）
### **查看数据库**
- 列出当前MySQL服务器上哪有库
- show databases；
### **使用/切换到指定的库**：
- use 数据库名；
### **列出当前的库**
- （库里所有表的名字列出来）
- show tables；
### **查看指定表的字段结构**
- （某一表的结构，field（ID,NAME...）,type(类型)等等）
- describe 表名；
- des world；
- \G：表示以列形式查看
- des world\G；
### **数据库命名规则**
- 不能纯数字
- 区分大小写，具有唯一性
- 不可以使用关键字，特殊字符
### **创建数据库**
- **CREATE DATABASE 表名；**
- create database abc;
- show databases;
- use ab;
- select database();(在abc这个数据库下面)
-显示结果：
>* database()
>* ab

- drop database abc;
- show databases; (确定被删)
 
### **查看当前所在的库**
- (看目前在哪个库里）
- **SELECT DATABASE();**

### **删除指定的库**
- **DROP DATABASE 数据库名**

- 新建指定名称的表
```sql
create table 表名（
字段名1 字段类型（宽度） 约束条件，
字段名1 字段类型（宽度） 约束条件，
字段名1 字段类型（宽度） 约束条件，     
字段名1 字段类型（宽度） 约束条件，     
PRIMARY KEY(主键名)   );
       
create table student(
name char(5),
age int(2),
address char(20)
)
      
- desc table student;
- show tables;
      
Empty set
```

# 4. SQL数据类型

## **数值的说明**
- 使用**unsigned**修饰时，对应字段只保存正数
- 数值不够指定宽段时，默认在左边填空格补位
- 宽度只是显示宽度，存数值大小由类型决定
- 使用关键字zerofill 用0补位
- 字段值与类型不匹配时，字段值作为0处理（都是数字，塞进去一个第五，默认用0处理）
- 数值超过范围时，仅保存最大/最小值
    
## **数值类型**
- TINYINT: 1 byte -128-127，0-255
- SAMLLINT: 2 byte -32768-32767， 0-65535
- MEDIUNINT: 3 byte
- INT: 4 byte -2^31-2^31-1, 0-2^32-1
- BIGINT: 8 byte
- FLOAT: FLOAT(M,D) FLOAT(5,2)
    - M: 总宽度
    - D：小数位数
- DOUBLE DOUBLE比FLOAT的精度更高
- DECIMAL：DECIMAL(M,D)
    - M:有效位数
    - D:小数位数
    - 占用M+2字节
```sql       
create table stu( 
age tinyint unsigned,
weight float(5,2) unsigned,
height float(5,2) unsigned,
);
(约束条件要放在后面)
```    

## **字符类型**
- char: 固定长度字符
    - char（n）
    - 最长255字符
    - 不够指定字符数时在右边用空格补齐
    - 自动截断超过指定字符数的数据
        
- varchar：可变字符串
    - varchar（n）
    - 按数据实际大小分配存储空间，你用多少，我给你多少
    - 自动截断超过指定字符数的数据
    
- text/blob：大文本类型 （字符串太多太多太多了）
    - 字符数大于
    - age int(2)
    - detail text(2000)
            
## **日期时间类型**
- 日期时间，DATETIME
    - 8个字节
    - 范围：1000-01-01 00：00：00.00000 - 9999-12-31 23:59:59.99999
- 日期时间，TIMESTAMP 时间戳
    - 4个字节
    - 范围：1970-01-01 00：00：00.00000 - 2038-01-19 03：14：07.0000
    - 使用时间戳，当前发生的事情，基本够用
- 日期，DATE
    - 4个字节
    - 范围：0001-01-01 - 9999-12-31
- 年份，YEAR
    - 1个字节
    - 范围：1901-2155
- 时间，TIME
    - 3个字节
    - 格式：HH:MM:SS
                
## **关于日期的说明**
- 关于日期时间字段
    - 当未给TIMESTAMP字段赋值时，自动以当前时间赋值，而DATETIME字段默认为0
- YEAR年份的处理
    - 默认用4位数字表示
    - 当只用两位数字赋值时
        - 0069 视为 20002069
        - 7099 视为 19701999
            
## **日期和时间函数**
- （加括号代表是函数）
- now（）：调取此函数时系统日期时间 
- sysdate（）：执行时动态获得得系统日期时间
- sleep（N）：休眠N秒
- curdate（）：获取当前系统日期
- curtime（）：获取当前系统时刻
- month（）：获取指定时间中月份
- date(): 获取指定时间中日期
- time（）：获取指定时间中时刻
```sql    
select now();
select current_time();
select now(), sleep(5), now(); #now一次性执行
select sysdate(), sleep(5), sysdate(); 
```
## **枚举类型**
- 给定值集合中选择单个值, ENUM
- enum（值1，值2，值3，值N）
- 给定值集合中选择一个或多个值，SET
- set (值1，值2，值3，值N)
```sql
create table stu(
name char(4),
age int(2) unsigned,
gender enum("boy","girl"),
hobbies set("a","b","c"),
weight float(5,2)
);
```
## **约束**
- null
- not null
- key 索引（是否为主键）
- default 设置默认值，缺省为null
```sql   
create table stu(
name varchar(4) not null,
age int(2) not null default 18,
gender enum("boy","girl") default "boy",
hobbies set("a","b","c"),
weight float(5,2)
);
```
# 5. 表基本操作

-基本操作
- DDL
    - create：创建数据库和表等对象
    - drop：删除数据库和表等对象
    - alter：修改数据库和表等对象的结构
    
- DML
    - select：查询表中的数据
    - insert：在表中插入新数据
    - update：更新表中的数据
    - delete：删除表中都数据
- DCL
    - commit：确认对数据库中数据进行的变更
    - rollback：取消对数据库中数据进行的变更
    - grant：赋予用户操作权限
    - revoke：取消用户操作权限
 
## **修改表的字段**
- **修改表的结构**
### **基本用法**
- alter table 表名 执行动作；
### **添加新字段**
- add 字段名 类型（宽度）约束条件；
- 可加 after 字段名 
- 或者 first
### **修改字段类型**
- modify 字段名 类型（宽度） 约束条件；
### **修改字段名**
- change 源字段名 新字段名 类型（宽度）约束条件；
### **删除指定字段**
- drop 字段名；
```sql
alter table stu add score int(3) not null
alter table stu add phone varchar(15) not null after age;
alter table stu add qq varchar(10) not null after age
describe stu;
desc stu; (描述表具体什么样)
alter table stu modify qq int(15);
alter table stu change qq wechat varchar(20) not null;
alter table stu drop wechat
```    

# 6. 索引

## **索引概括**
- 索引优点
    - 通过创建唯一性索引，可以确保数据库中每一行数据的唯一性
    - 可以加快数据的查找速度
- 索引缺点
    - 对表中数据修改，增加和删除，索引也要动态维护，降低了数据都维护速度
    - 索引需要占物理空间
    
## **索引类型**
- index：普通索引
- unique：唯一索引
- fulltext：全文索引
- primary key：主键
- foreign key：外键

## **index普通索引**
### **什么是index**
- 一个表中可以有多个index字段
- 对应的字段值可以重复 (比如名字重复一样)
- 把经常做查询条件的字段设置为index字段
- index字段的key标志是**mul**
```sql
create table stu（
name varchar（4） not null，
age int（3），
id char（6）not null，
course char(10) not null,
hobby char(10) not null,
index（id），index（name）
);
desc stu;
```

### **创建索引**
- 在表里添加索引
- create index xxx on               表名（字段名）xxx是给索引起的名称
- 用**create** 记得区分开
### **删除索引**
- drop index xxx on 表名
### **显示表里的索引**
- show index from 表名
```sql        
drop index course on stu; #把course的索引删除了
create index hobby course on stu（hobby); #给hobby创建了一条索引
create index index_hobby course on stu（hobby); #可以给hobby再创建一条索引，index_hobby
show index from stu; #hobby就有两条索引，一条hobby，一条index_hobby
```
## **unique唯一索引**
### **什么是unique**
- 一个表里面可以有好几个unique的索引
- 对应的字段不能有重复
- unique字段的key标志是**UNI**
- unique字段的值可以为null，当其修改为not null时，则此字段限制和主键相同，为PRI字样

### **创建索引**
- 在表里添加索引**
- 直接创建，unique（字段1），unique（字段2）
- 创建索引，在表里添加索引，某一个字段添加索引
    - create unique index xxx on 表名（字段名）
```sql
create table stu（
name varchar（4） not null，
age int（3），
id char（6）not null，
course char(10) not null,
hobby char(10) not null,
unique（id），unique（name）
);
desc stu;
```
### **删除索引**
```sql
drop index index_hobby from stu; #s删除index
drop index hobby from stu; #删除index
create unique index myCourse on stu(course); #创建一个unique index
desc stu;
```
- unique字段的值可以为null，当其修改为not null时，则此字段限制和主键相同，为PRI字样
```sql
create table teacher(
name char(3) not nulll
age int(2)
course varchar(20),
address varchar(20),
unique(name)
)
desc teacher;
- key 为PRI
```
## **primary key主键**
### **什么是primary key**
- 一个表中只能有一个primary字段
- 对应字段值不允许有重复
- **如果多个字段都作为primary key，称为复合键，必须在建表的时候一起建**
- 主键字段的key标志为**PRI**
- 通常和auto_increment连用 id不能重复，id自增长，只实用数字类型
### **创建索引**
- 在表里添加索引**
- 创建表的时候一起创建
    - primary key（字段名）
```sql       
create table stu(
id char(6) auto increment,
...
primary key(id)
)    
```
- **创建primary key 用alter，add**
    - **注意，这里没有create key这种东西，我们用add**
    - 在已经有都表中设置primary key字段名
    - alter table 表名 add primary key（id）
    
### **删除primary key**
- **删除primary key 用alter，drop**
    - alter table 表名 drop primary key；

## **foreign key**
### **什么是foreign key**
- 当A表的某个字段xx同时也是B表的主键，A表的数据应该参照B表进行联动
- 则A表中的字段xx可设为外键
- 使用外键的条件
    - A,B表都采用InnoDB存储引擎
    - 外键字段在A,B表的类型要一致 （相同类型，int，varchar）
    - B表中的参照字段要有明确的索引
    
### **创建外键**
- 外键基本用法
```sql
foreign key (表A的字段名)
references （表B的字段名）
on update cascade
on delete cascade
表A的字段名参照表B的字段名
```
- 创建AB表
```sql
create table mycourse(
course varchar(20),
course_id int(20),
primary key(course)
);

create table stu(
name char(4),
age int(2),
course varchar(2),
foreien key(course)
references mycourse(course)
on update cascade
on delete cascade
);
desc stu; (course key MUL 但是不能显示是外键)
```

### **删除foreign key**
- alter table 表名 drop foreign key 约束名；


# 7.MySQL查询

## **插入数据**
- 标准格式
    - insert into 表名 （字段名1，字段名2，...）values (值1，值2，...)
    - insert into 表名 values(值1，值2，...）
    - 如果没有为某个字段赋值，则使用默认值，NULL NONE
    - 如果添加非空约束NOT NULL，没有default约束，则会报错
## **准备数据**
- 创建数据库和表
    - 创建数据库
```sql
create database world CHARSET = UTF8;
```
  - 使用数据库

```sql
use world;
create table students(
    stu_id int unsigned primary key auto_increment not null,
    name varchar(10) default "name",
    age tinyint unsigned default 18,
    height decimal(5,2),
    gender enum("male","female","none") defualt "none",
    cls_id int unsigned default 0,
    is_delete bit default 0
);

desc student;

create table classes(
cs_id int unsigned auto_increment primary key not null,
name varchar(20) not null
);

insert into students values (0, 'john',18, 180.00, 1, 1, 0)；
##插进入一行数据

insert into students values (0, 'john',18, 180.00, 1, 1, 0),(),(),(),()；

insert into students(stu_id, name, age, height, gender, cls_id, is_delete) values (0, 'john',18, 180.00, 1, 1, 0)；

insert into classes vaules (0, 'math'),(0, 'english');
select * from classes;

```


