<br>

<div align="center">
    <br>
    <a href="https://github.com/mayu1031/CS_Notes"> <img src="https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/others/icons/%E5%86%AC%E6%97%A5%E8%A3%85%E5%A4%87icon/%E8%80%B3%E7%BD%A9.png"></a>
  
</div> 

<br/>


# MySQL命令

- [数据库](#数据库)
- [表格结构](#表格结构)
- [索引](#索引)
- [表格内部查询](#表格内部查询)
- [表格条件查询](#表格条件查询)




- DDL
- Data Definition Language 数据定义语言，用来创建或者删除存储数据用的数据库以及数据库中表等对象

create：创建数据库和表等对象

drop：删除数据库和表等对象

alter：修改数据库和表等对象的结构


- DML
- Data Manipulation Language 数据操纵语言 用来查询或者变更表中的几率
select：查询表中的数据

insert：在表中插入新数据

update：更新表中的数据

delete：删除表中都数据


- DCL
- Data Control Language 用来确认或者取消对数据库中的数据进行的变更
commit：确认对数据库中数据进行的变更

rollback：取消对数据库中数据进行的变更

grant：赋予用户操作权限

revoke：取消用户操作权限

 
# 数据库

- 数据库结构

## **显示所有的数据库**
```sql
show databases;
```
## **创建数据库**
- create database 表名;
```sql
create database database1;
```
## **切换到指定的库**
```sql
use 数据库名;
```
## **查看当前所在的库**
```sql
select database();
```
## **删除数据库**
- drop database 数据库名;
```sql
drop database database1;
```


# 表格结构

## **列出当前库中所有的表**
- show
```sql
show tables;
```
## **删除指定名称的表**
- drop
```
drop table 表名;
```

## **查看表格内的字段结构**
- desc
```sql
desc stu;
```
##  **创建指定名称的表**

create table 表名（

字段名1 字段类型（宽度） 约束条件，

字段名1 字段类型（宽度） 约束条件，

字段名1 字段类型（宽度） 约束条件， 

字段名1 字段类型（宽度） 约束条件，   

PRIMARY KEY(主键名)   );


```sql
create table student(
name char(5),
age int(2),
address char(20)
)
```

## **表格结构调整**
- alter
```sql
alter table 表名 执行动作；
```

### **表重命名**
- rename
```sql
alter table t1 rename t2;
```

### **添加新字段**
- add
    - add 字段名 类型（宽度）约束条件
- after
- first

```sql
alter table stu add score int(3) not null
alter table stu add phone varchar(15) not null after age;
```

### **修改字段类型**
- modify
    - modify 字段名 类型（宽度） 约束条件
```sql
alter table stu modify qq int(15);
```
### **修改字段名**
- change
    - change 源字段名 新字段名 类型（宽度）约束条件
```sql
alter table stu change qq wechat varchar(20) not null;
```
### **删除指定字段**
- drop
    - drop 字段名
```sql
alter table stu drop wechat
```

# 索引

## **创建索引index**
- 创建表格时自带index

```sql
create table stu（
name varchar（4） not null，
age int（3），
id char（6）not null，
course char(10) not null,
hobby char(10) not null,
index（id），index（name）
);
```
- create创建索引index
- create index xxx on 表名（字段名）xxx是给索引起的名称
```sql
create index hobby course on stu（hobby); #给hobby创建了一条索引
create index index_hobby course on stu（hobby); #可以给hobby再创建一条索引，index_hobby
```

### **显示表里的索引**
- show index from 表名
```sql
show index from stu; #hobby就有两条索引，一条hobby，一条index_hobby
```

### **删除索引**
- drop index xxx on 表名
```sql
drop index course on stu; #把course的索引删除了
```

## **创建索引unique**
- 创建表格时自带index
```sql
create table stu（
name varchar（4） not null，
age int（3），
id char（6）not null，
course char(10) not null,
hobby char(10) not null,
unique（id），unique（name）
);
```
- 创建一个unique index
```sql
create unique index myCourse on stu(course); #创建一个unique index
```
### **显示表里的索引**
- show unique index from 表名
```sql
show unique index from stu;
```

### **删除索引**
```sql
drop index index_hobby from stu; #删除index
drop index hobby from stu; #删除index
```
## **创建主键 primary key**
- 创建表格时自带主键
```sql
create table stu(
id char(6) auto increment,
...
primary key(id)
)   
```
- add添加主键
```sql
alter table 表名 add primary key（id）
```
### **删除主键**
```sql
alter table 表名 drop primary key；
```

## **创建外键 foreign key**

foreign key (表A的字段名)
references （表B的字段名）
on update cascade
on delete cascade
表A的字段名参照表B的字段名

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
- 注意外键名不一定就是创建时候的外建明
```sql
show create table student;
```
- 获得真实foreign key之后可以删除外键
```sql
alter table student drop FOREIGN key student_ibfk_1;
```

# 表格内部查询

## **准备数据**

- 创建数据库
```sql
create DATABASE database1 CHARSET = utf8;
```

- 使用数据库
```sql
use database1;
```

- 创建表格
```sql
create table students(
    stu_id int unsigned primary key auto_increment not null,
    name varchar(10) default "no name",
    age tinyint unsigned default 18,
    height decimal(5,2),
    gender enum("male","female","none") default "none",
    cls_id int unsigned default 0,
    is_delete bit default 0
);

desc student;

create table classes(
cs_id int unsigned auto_increment primary key not null,
name varchar(20) not null
);

desc classes;
```
## **插入数据**

- insert into 表名 （字段名1，字段名2，...）values (值1，值2，...)

- insert into 表名 values(值1，值2，...）


```sql
insert into students values (0, 'john',18, 180.00, 1, 1, 0)；

insert into students(stu_id, name, age, height, gender, cls_id, is_delete) values (0, 'john',18, 180.00, 1, 1, 0)；

insert into students values (0, 'john',18, 180.00, 1, 1, 0),(),(),(),()；
```

## **删除数据**
```
delete from students
where stu_id = 4;
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

### **查询所有字段**
```sql
select * from 表名;   *通配符
```
### **查询指定字段**
```sql
select 列1，列2... from 表名;
```
### **用as别名给列表起名**
```sql
select id as 序列，name as 名字，gender as 性别... from 表名;
```
### **表字段名**
```sql
select students.id, student.name from students;
```
### **用as给表起别名**
```sql
select s.id, s.name, s.gender from studnets as s;
```
### **消除重复行**
```sql
select distinct name from students；
select distinct age from students；
```
## **Distinct和Group by去除重复字段记录**   
  一是完全重复的记录，也即所有字段均重复的记录  
  二是部分关键字段重复的记录，比如Name字段重复，而其他字段不一定重复或都重复可以忽略。
  
    - select count(distinct col) from A;
    - select count(1) from (select 1 from A group by col) as C;

# 表格条件查询

### **基本语法**
```sql
select * from 表名
where 条件;
```

### **比较运算符**
```sql
等于 =
大于 >
大于等于 >=
小于 <
小于等于 <=
不等于 !=/ <>

select * from students
where id <=4;

select * from students
where name != 'john';
```

### **逻辑运算符**
```sql
and
or
not

select * from student
where id>3 and gender =1;

```

### **模糊查询**
- like
```sql
%表示任意多个任意字符
_表示任意一个字符

select * from students
where name like '黄%'
```
- '_'
```sql
select * from students
where name like '黄_' #黄后面是一个字的学生

select * from students
where name like '黄__' #黄后面是两个字的学生

select * from students
where name like '黄%' or name like '梅%'
```
### **范围查询**
- in
```sql
in表示在一个非连续的范围内
select * from students
where id in (1,3,8);
```
- between
```sql
select * from students
where id between 3 and 8;
```
- 空判断
```sql
select * from students
where height is not null;
```
### **排序**
```sql
order by，默认 asc 从小到大，升序

select * from 表名
order by 列1 asc|desc, 列2 asc|desc;

select * from students
where is_delete = 0 
order by name;
```
### **聚合函数**
- count(*)
```sql
select count(*) from students;
```
- max(列)
```sql
select max(id) from students;
```
- min(列)
```sql
select min(id) from students
where is_delete=0;
```
- avg(列)
```sql
select sum(age)/count(*) from students;
select avg(age) from students;
```
- sum(列)
```sql
select sum(age) from students
where gender = '男';
```
### **分组**
- group by
- group by + group_concat 函数
```sql
select gender, group_concat(name) from students
group by gender;
```
- group by +集合函数
```sql
select gender, group_concat(age) from students
group by gender;
```
- group + having
```sql
select gender, group_concat(name) from students
group by gender
having count(*)>7; ##按性别分组，把组成员个数大于7的那一列名字列出来
```
- group + with rollup
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

### Distinct和Group by去除重复字段记录
一是完全重复的记录，也即所有字段均重复的记录

二是部分关键字段重复的记录，比如Name字段重复，而其他字段不一定重复或都重复可以忽略。

select count(distinct col) from A;

select count(1) from (select 1 from A group by col) as C;

其实上述两中方法分别是在运算和存储上的权衡。

distinct需要将col列中的全部内容都存储在一个内存中，可以理解为一个hash结构，key为col的值，最后计算hash结构中有多少个key即可得到结果。

很明显，需要将所有不同的值都存起来。内存消耗可能较大。

而group by的方式是先将col排序。而数据库中的group一般使用sort的方法，即数据库会先对col进行排序。而排序的基本理论是，时间复杂为nlogn，空间为1.，然后只要单纯的计数就可以了。优点是空间复杂度小，缺点是要进行一次排序，执行时间会较长。


## **分页获取内容**  
- limit

```sql
select *from 表名 
limit start,count;

select * from students limit 5,5
## id从6开始，显示5个
```
- limit offset
```sql
limit 2 offset 3
##跳过3个值，显示2个
```
### **连接查询**
```sql
select * from 表1
inner join/ left join/ right join 表2 on 表1.列 = 表2.列
```
### **自关联**

```sql
create table areas(
    aid int primary key, #area
    atitle varchar(20) #name
    pid int
)
```
### **子查询**
- 标量子查询
```sql
select * from students
where age > 
(select avg(age) from students);
```
- 列级子查询
```sql
select name from classes
where id in (select cls_id from students);
#先查班级id，在查在这个id里面的学生
```
- 行级子查询
```sql
select * from students 
where (height,age) = (select max(height),max(age) from students)
```

### **union, union all**
- UNION 操作符用于合并两个或多个 SELECT 语句的结果集。
- 请注意，UNION 内部的 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。同时，每条 SELECT 语句中的列的顺序必须相同。

SQL UNION 语法

```sql
SELECT column_name(s) FROM table_name1
UNION
SELECT column_name(s) FROM table_name2
```

- 注释：默认地，UNION 操作符选取不同的值。如果允许重复的值，请使用 UNION ALL。
- UNION ALL 命令和 UNION 命令几乎是等效的，不过 UNION ALL 命令会列出所有的值。 

SQL UNION ALL 语法

```sql
SELECT column_name(s) FROM table_name1
UNION ALL
SELECT column_name(s) FROM table_name2
```
另外，UNION 结果集中的列名总是等于 UNION 中第一个 SELECT 语句中的列名。
