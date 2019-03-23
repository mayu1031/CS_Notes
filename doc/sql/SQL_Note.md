<br>

<div align="center">
    <br>
    <a href="https://github.com/mayu1031/CS_Notes"> <img src="https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/others/icons/%E5%86%AC%E6%97%A5%E8%A3%85%E5%A4%87icon/%E8%80%B3%E7%BD%A9.png"></a>
  
</div> 

<br/>


数据库
 ========

<!-- GFM-TOC -->
## [1. 数据库概述](#一数据库概)
- [DB应用领域](#应用领域)
- [数据库定义](#数据库定义)
- [数据库分类](#数据库分类)
- [数据库产品](#数据库产品)
## [2. 数据库mysql](#二数据库mysql)
- [快捷键](#快捷键)
## [3. 数据库mysql基本使用](#三数据库mysql基本使用)
- [数据库指令](#数据库指令)
- [登录](#登录)
- [查看数据库](#查看数据库)
- [使用切换到指定的库](#使用切换到指定的库)
- [列出当前的库](#列出当前的库)
- [查看指定表的字段结构](#查看指定表的字段结构)
- [数据库命名规则](#数据库命名规则)
- [创建数据库](#创建数据库)
- [查看当前所在的库](#查看当前所在的库)
- [删除指定的库](#删除指定的库)
## [4. 数据类型](#四数据类型)
- [数值的说明](#数值的说明)
- [数值类型](#数值类型)
- [字符类型](#字符类型)
- [日期时间类型](#日期时间类型)
- [关于日期的说明](#关于日期的说明)
- [日期和时间函数](#日期和时间函数)
- [枚举类型](#枚举类型)
- [约束](#约束)
## [5. 表基本操作](#五表基本操作)
- [新建指定名称的表](#新建指定名称的表)
- [修改表的结构](#修改表的结构)
- [基本用法](#基本用法)
- [添加新字段](#添加新字段)
- [修改字段类型](#修改字段类型)
- [修改字段名](#修改字段名)
- [删除指定字段](#删除指定字段)
## [6. 索引](#六索引)
- [索引概括](#索引概括)
- [索引类型](#索引类型)
- [index普通索引](#普通索引)
    - [什么是index](#什么是普通索引)
    - [创建索引](#创建索引)
    - [删除索引](#删除索引)
    - [显示表里的索引](#显示表里的索引)
* [unique唯一索引](#唯一索引)
    - [什么是unique](#什么是唯一索引)
    - [创建索引](#创建索引)
    - [删除索引](#删除索引)
* [primary key主键](#主键)
    - [什么是primary key](#什么是主键)
    - [创建索引](#创建索引)
    - [删除primary key](#删除主键)
* [foreign key 外键](#外键)
    - [什么是foreign key](#什么是外键)
    - [创建外键](#创建外键)
    - [删除foreign key](#删除外键)
## [7. 查询](#七查询)
* [查询](#查询)
* [插入数据](#插入数据)
* [准备数据](#准备数据)
* [查询语法](#查询语法)
* [条件查询](#条件查询)
    - [基本语法](#基本语法)
    - [比较运算符](#比较运算符)
    - [逻辑运算符](#逻辑运算符)
    - [模糊查询](#模糊查询)
    - [范围查询](#范围查询)
* [排序](#排序)
* [聚合函数](#聚合函数)
    * [总数](#总数)
    * [最大值](#最大值)
    * [最小值](#最小值)
    * [平均值](#平均值)
    * [总和](#总和)
* [分组](#分组)
* [分页获取内容](#分页获取内容)
* [连接查询](#连接查询)
* [自关联](#自关联)
* [子查询](#子查询)
    - [标量子查询](#标量子查询)
    - [列级子查询](#列级子查询)
    - [行级子查询](#行级子查询)
    
## [8. 运维](#八运维)

## [9. 参考资料](#九参考资料)

<!-- GFM-TOC -->


----------


# 一、数据库概

## **应用领域**
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
- DB database 依照某种数据模型进行组织并存放到存储器的数据集合
- DBMS DB ManagementSystem: 用来操作和管理数据库的大型服务软件
- DBS: DB+DBMS 带有数据库并整合类数据管理软件的计算机系统
- Server/Client 服务器/客户端
- E-R数据模型 entity-relation model 实体关系模型
    - 方形：实体
    - 椭圆形： 属性
    - 菱形： 关系
- SQL Structured Query Language   
## **数据库分类**
- 关系型数据库
    - 基于关系数学
    - 最常见
    - MySQL  
- 非关系型数据 -NoSQL not only sql
    - 数据量大，数据不规整
    - MongoDB 比如网页 图片
    - Redis 内存
    - Neo4j 图像信息
        
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


# 二、数据库mysql

## **快捷键**
- ctrl+q           打开查询窗口
- ctrl+/           注释sql语句
- ctrl+shift +/    解除注释
- ctrl+r           运行查询窗口的sql语句
- ctrl+shift+r     只运行选中的sql语句
- F6               打开一个mysql命令行窗口
- ctrl+l           删除一行
- ctrl+n           打开一个新的查询窗口
- ctrl+w           关闭一个查询窗口

# 三、数据库mysql基本使用

## **数据库指令**
- 不区分大小写（密码，变量值除外）
- 每条sql指令以；结束或分隔
- 不支持tab自动补齐
- **\c可废弃当前边写错的操作指令**
   

 
## **登录**
- mysql command line
- mysql -u root -p （-h 服务器 -u 用户名 -p 密码）
- quit 或 exit 退出

## **查看数据库**
- 列出当前MySQL服务器上哪有库
- show databases；

## **使用切换到指定的库**
- use 数据库名；

## **列出当前的库里所有的表**
- （库里所有表的名字列出来）
- show tables；

## **查看指定表的字段结构**
- （某一表的结构，field（ID,NAME...）,type(类型)等等）
- describe 表名；
- des world；
- \G：表示以列形式查看
- des world\G；

## **数据库命名规则**
- 不能纯数字
- 区分大小写，具有唯一性
- 不可以使用关键字，特殊字符

## **创建数据库**
- **CREATE DATABASE 数据库名;**
```sql
CREATE DATABASE 数据库名；
create database abc;
show databases;
use ab;
select database();(在abc这个数据库下面)
显示结果：
database()
ab

drop database abc;
show databases; (确认被删)
```
## **查看当前所在的库**
- (看目前在哪个库里）
- **SELECT DATABASE();**

## **删除指定的库**
- **DROP DATABASE 数据库名**

## **删除指定名称的表**
- **DROP TABLE 表名**

# 四、数据类型

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
- INT: 4 byte -2^31-2^31-1, 0-2^64-1
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
    - 自动截断超过指定字符数的数据 最长是n位
    
- text/blob：大文本类型 （字符串太多太多太多了）
    - 字符数大于 65535存储时使用
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

now()
2019-03-21 23:28:26
```
```sql
select current_time();

current_time()
23:29:08
```
```sql
select now(), sleep(5), now(); #now一次性执行

2019-03-21 23:30:04	0	2019-03-21 23:30:04
```

```sql
select sysdate(), sleep(5), sysdate();

2019-03-21 23:30:37	0	2019-03-21 23:30:42
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
- null 允许为空，默认设置
- not null 不允许为空
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
# 五、表基本操作


## **修改表的结构**

- DDL
- Data Definition Language 数据定义语言，用来创建或者删除存储数据用的数据库以及数据库中表等对象，
    - create：创建数据库和表等对象
    - drop：删除数据库和表等对象
    - alter：修改数据库和表等对象的结构
    
- DML 
- Data Manipulation Language 数据操纵语言 用来查询或者变更表中的几率
    - select：查询表中的数据
    - insert：在表中插入新数据
    - update：更新表中的数据
    - delete：删除表中都数据

- DCL 
- Data Control Language 用来确认或者取消对数据库中的数据进行的变更
    - commit：确认对数据库中数据进行的变更
    - rollback：取消对数据库中数据进行的变更
    - grant：赋予用户操作权限
    - revoke：取消用户操作权限

## **新建指定名称的表**
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

## **基本用法**
- alter table 表名 执行动作；
```sql
alter table stu add score int(3) not null
```
## **添加新字段**
- add 字段名 类型（宽度）约束条件；
- 可加 after 字段名 
- 或者 first
```sql
alter table stu add phone varchar(15) not null after age;
alter table stu add qq varchar(10) not null after age
```
## **修改字段类型**
- modify 字段名 类型（宽度） 约束条件；
```sql
alter table stu modify qq int(15) not null;
```
## **修改字段名**
- change 源字段名 新字段名 类型（宽度）约束条件；
```sql
alter table stu change qq wechat varchar(20) not null;
```

## **查看表格内的字段结构**
- desc 表名;
```sql
desc stu;
```

## **删除指定字段**
- drop 字段名；
```sql
describe stu;
desc stu; (描述表具体什么样)
alter table stu drop wechat
```    

# 六、索引

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

## **普通索引**
### **什么是普通索引**
- 一个表中可以有多个index字段
- 对应的字段值可以重复 (比如名字重复一样)
- 把经常做查询条件的字段设置为index字段
- index字段的key标志是**MUL**
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
- create index xxx on 表名（字段名）
    - xxx是给索引起的名称
- 用**create** 记得区分开
```sql
create index hobby on stu（hobby); #给hobby创建了一条索引
create index index_hobby on stu（hobby); #可以给hobby再创建一条索引，index_hobby
show index from stu; #hobby就有两条索引，一条hobby，一条index_hobby
```
### **删除索引**
- drop index xxx on 表名
```sql
drop index course on stu; #把course的索引删除了
```
### **显示表里的索引**
- show index from 表名
```sql        
show index from stu; #hobby就有两条索引，一条hobby，一条index_hobby
```
## **唯一索引**
### **什么是唯一索引**
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

```sql
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
## **主键**
### **什么是主键**
- 一个表中只能有一个primary字段
- 对应字段值不允许有重复且不能为空
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
- **创建primary key 用alter add**
    - **注意，这里没有create key这种东西，我们用add**
    - 在已经有都表中设置primary key字段名
    - alter table 表名 add primary key（id）
    
### **删除主键**
- **删除primary key 用alter，drop**
    - alter table 表名 drop primary key；

## **外键**
### **什么是外键**
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

### **删除外键**
- alter table 表名 drop foreign key 约束名；


# 七、查询

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

## **查询语法**

```sql
select select_exper [,select_exper,...][
    from tb_name
    where 条件判断
    [group by ｛col_name| postion｝[ASC|DESC],..]
    [having where 条件判断]
    [order by ｛col_name| postion｝[ASC|DESC],..]
    [limit {}]
       
```
- **查询所有字段**
```sql
select * from 表名;   *通配符
```
- **查询指定字段**
```sql
select 列1，列2... from 表名;
```
- **用as别名给列表起名**
```sql
select id as 序列，name as 名字，gender as 性别... from 表名;
```
- **表字段名**
```sql
select students.id, student.name from students;
```
- **用as给表起别名**
```sql
select s.id, s.name, s.gender from studnets as s;
```
- **消除重复行**
```sql
select distinct name from students；
select distinct age from students；
```
## **条件查询**
### **基本语法**
```sql
select * from 表名
where 条件;
```
- where 后面多种运算符
### **比较运算符**
- 等于 =
- 大于 >
- 大于等于 >=
- 小于 <
- 小于等于 <=
- 不等于 !=/ <>


```sql
select * from students
where id <=4;

select * from students
where name != 'john';
```

### **逻辑运算符**
- and
- or
- not

```sql
select * from student
where id>3 and gender =1;
```
### **模糊查询**
- like
- %表示任意多个任意字符
- _表示任意一个字符

```sql
select * from students
where name like '黄%'

select * from students
where name like '黄_' #黄后面是一个字的学生

select * from students
where name like '黄__' #黄后面是两个字的学生

select * from students
where name like '黄%' or name like '梅%'
```

### **范围查询**
- in表示在一个非连续的范围内

```sql
select * from students
where id in (1,3,8);
```
- between

```sql
select * from students
where id between 3 and 8;
```
- 空判断
    - null与""是不同的，""表示空的字符串，而null表示什么都没有，连字符串都没有
    - 判断 is null
    
```sql
select * from students
where height is not null;
```

## **排序**
- 语法
- 默认 asc 从小到大，升序
```sql
select * from 表名
order by 列1 asc|desc, 列2 asc|desc;

select * from students
where is_delete = 0 
order by name;

select * from students
ordery by age desc, height desc;
```
## **聚合函数**
### **总数**
- count(*)
```sql
select count(*) from students;
```
### **最大值**
- max(列)
```sql
select max(id) from students;
```
### **最小值**
- min(列)
```sql
select min(id) from students
where is_delete=0;
```
### **平均值**
- avg(列)
```sql
select sum(age)/count(*) from students;
select avg(age) from students;
```
### **总和**
- sum(列)
```sql
select sum(age) from students
where gender = '男';
```
## **分组**
- group by
- **group by + group_concat 函数**
    - 分组之后，根据分组结果，使用group_concat()来放置某一组的某字段的值的集合**
```sql
select gender, group_concat(id) from students
group by gender;

select gender, group_concat(name) from students
group by gender;
```
- **group by +集合函数**
```sql
select gender, group_concat(age) from students
group by gender;

select gender, avg(age) from students
group by gender;
```
- **group + having**
    - 用来分组查询后指定一些条件来输出查询结果
    - having: 跟where一样，但只能和group by组合
```sql
select gender, group_concat(name) from students
group by gender
having count(*)>7; ##按性别分组，把组成员个数大于7的那一列名字列出来
```
- **group + with rollup**
    - 在最后新增一行，来记录当前列里所有记录的总和
    
```sql
select gender, count(*) from students
group by gender
with rollup;

-gender count(*)
-男      8
-女      5
-NULL    13

select gender, group_concat(age) from students
group by gender
with rollup;

```

- **Distinct和Group by去除重复字段记录**   
  一是完全重复的记录，也即所有字段均重复的记录  
  二是部分关键字段重复的记录，比如Name字段重复，而其他字段不一定重复或都重复可以忽略。
  
    - select count(distinct col) from A;
    - select count(1) from (select 1 from A group by col) as C;
```
其实上述两中方法分别是在运算和存储上的权衡。

distinct需要将col列中的全部内容都存储在一个内存中，可以理解为一个hash结构，key为col的值，最后计算hash结构中有多少个key即可得到结果。

很明显，需要将所有不同的值都存起来。内存消耗可能较大。

而group by的方式是先将col排序。而数据库中的group一般使用sort的方法，即数据库会先对col进行排序。而排序的基本理论是，时间复杂为nlogn，空间为1.，然后只要单纯的计数就可以了。优点是空间复杂度小，缺点是要进行一次排序，执行时间会较长。
```

## **分页获取内容**
- **数据量过大时，分批显示内容**
```sql
select *from 表名 
limit start,count;

select * from students limit 5,5
## id从6开始，显示5个
```
- **limit 和 offset的区别**
- limit x，y
    - 跳过x个数据，取y个数据
```sql
select *from 表名 
limit start,count;

select * from students limit 5,5
## id从6开始，显示5个
```

- limit x offset y
    - 取x个数据，跳过y个数据
```sql
select *from 表名 
limit count offset count;
```
    
## **连接查询**
- 内连接：查询的结果为两个表匹配到的数据
- 左连接：查询的结果为两个表匹配到的数据，左表特有的数据，对于右表中不存在的数据使用null填充
- 右连接：查询的结果为两个表匹配到的数据，右表特有的数据，对于左表中不存在的数据使用null填充

```sql
select * from 表1
inner join/ left join/ right join 表2 on 表1.列 = 表2.列
```

## **自关联**
- 地址表/商品类别表设计问题
- 解决办法：自关联表，加上父类别id

```sql
create table areas(
    aid int primary key, #area
    atitle varchar(20) #name
    pid int
)
```
- 查询一共多少省
- id  pid name
- 100 0   河北
- 101 199 石家庄
- 102 101 某某县

```sql
##一共多少个省
select count(*) from areas
where pid is 0; #顶级单位，上面没有了

##省为山西省的所有城市
select city.* from areas as city inner join areas as province
on city.pid = province.aid
where province.atitle = '山西省'；

##市的名称为广州市的所有区县
select dis.* from areas as dis inner join areas as city on dis.pid = city.aid
where city.atitle = '广州市'
```

## **子查询**
- 查询语句可以嵌套
- 主查询：第一条select语句
- 主查询和子查询的关系
    - 子查询嵌套在主查询中
    - 子查询辅助主查询，充当条件或者数据源
    - 子查询可以独立存在，是一条完整的select语句
    
- 子查询分类
    - 标量子查询：子查询返回的结果是一个数据
    - 列级子查询: 返回的结果是一列
    - 行级子查询：返回的结果是一行
     
### **标量子查询**
```sql
select * from students
where age > 
(select avg(age) from students);
```
### **列级子查询**
```sql
select name from classes
where id in (select cls_id from students);
#先查班级id，在查在这个id里面的学生
```
### **行级子查询**
```sql
select * from students 
where (height,age) = (select max(height),max(age) from students)
```

# 八、运维
- **用户权限管理**
    - 用户密码管理
    - 用户权限创建，撤销 grant revoke

- **备份**
    - 物理备份 明确创建一个文件
        - 冷备份 #系统关机
            - copy #linux
            - tar #linux
        - 热备份 #系统还是运行，边运行边备份
            - mysqlhotcopy 
    - 逻辑备份
        - mysqldump
        - mysql
    - 备份策略
        - 全量备份（全部都备份）
        - 增量备份（增加的给备份）
        - 差异备份（对比之后，把差异的备份了）
        
- **binlog日志**
    - 二进制日志
    - 记录所有数据的更改操作 
    - 必要时可以用于数据的恢复
    
- **xtrabackup：备份工具**
    - 备份时不锁数据库表
    - 适用于生产环境

- **主从同步**
    - 一般如果只是单向复制，从库设置成只读 （一个库读一个库写）
    - 结构划分 
        - 单向简单复制 
        - 链式
        - 双向
        - 放射式
        
- **读写分离**
    - 给客户提供统一的数据库接口
    - 使用mysql代理
    - 分别提供读写服务均衡流量
    
- **性能调优**
    - mysql执行过程
    - 解决系统瓶颈
        - 分表，加宽带
        - 替换硬件
        - 系统运行参数调整
        - 优化查询语句

# 九参考资料
- 北京图灵学院 
- [数据库大全-MySQL-MongoDB-Redis][1]


  [1]: https://study.163.com/course/courseMain.htm?courseId=1006361022
