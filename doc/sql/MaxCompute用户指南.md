# MaxCompute用户指南

# 基本概念
## MaxCompute术语表
- AccessKey，是访问阿里云API的密匙，用于标识用户，为访问MaxCompute或者其他云产品做签名验证； AK必须保密
- 安全 MaxCompute多租户数据安全体系，主要包括用户认证，项目空间的用户与授权管理，跨项目空间的资源分享以及项目空间的数据保护


## 项目空间
- 项目空间（project）是MaxCompute的基本组织单元，类似于传统数据库中的DataBase或Schema的概念，是进行多用户隔离和访问控制的主要边界
- 一个用户可以同时拥有多个项目空间的权限，通过安全授权，可以在一个项目空间中访问另一个项目空间中的对象，例如表（table），资源（resource），函数（function）和实例（instance）
- 进入一个名为my_project的项目空间，你可以操作该项目空间下的对象，例如表，资源，函数和实例等
- MaxCompute项目（project）即DataWorks的工作空间
```sql
use my_project
```
## 表
- 表是MaxCompute的数据存储单元，它在逻辑上也是由行和列组成的二维结构，每行代表一条记录，每列表示相同数据类型的一个字段，一条记录可以包含一个或多个列，各个列的名称和类型构成这张表的Schema
- MaxCompute中不同类型计算任务的操作对象（输入，输出）都是表，可以创建表，删除表以及向表中导入数据
- DataWorks的数据管理模块可以对MaxCompute表进行新建，收藏，修改数据生命周期管理，修改表结构和数据表/资源/函数权限管理审批等操作
- MaxCompute的表格有两种类型：内部表和外部表
    - 对于内部表，所有的数据都存储在MaxCompute中，表中的列可以是MaxCompute支持的任意一种数据类型
    - 对于外部表，MaxCompute并不真正的持有数据，表格的数据可以存放在OSS或OTS中。MaxCompute仅会记录表格中的Meta信息，可以通过MaxCompute的外部表格机制处理OSS货OTS上的非结构化数据，例如视频，音频，基因，气象，地理信息等

## 分区
- 分区表是指在创建表时指定分区空间，即指定表内的某几个字段作为分区列。分区表实际就是对应分布式文件系统上的独立的文件夹，该文件夹下是该分区所有数据文件
    - 分区可以理解为分类，通过分类把不同类型的数据放到不同的目录下；
    - 分类的标准就是分区字段，可以是一个，也可以是多个；
    - 分区表的意义在于优化查询，查询表是通过where字句查询指定所需查询的分区，避免全表扫描，提高处理效率，降低计算费用；
    - 可以指定多级分区，即将表的多个字段作为表的分区，分区之间如多级目录的关系

### 分区使用限制
- 分区有以下使用限制。
    - 单表分区层级最多6级。
    - 单表分区数最多允许60000个分区。
    - 一次查询最多查询分区数为10000个分区。
    - String分区类型的分区值不支持使用中文。

## 数据类型
## 生命周期
- MaxCompute表的生命周期（LIFECYCLE），指表（分区）数据从最后一次更新的时间算起，在经过指定的时间后没有变动，则此表（分区）将被MaxCompute自动回收，这个指定的时间就是生命周期
- 生命授权单位：days（天），只接受正整数
- 非分区表若指定生命周期，自最后一次数据被修改的时间（LastDataModifiedTime）开始计算，经过days天后数据仍未被改动，则此表被MaxCompute自动回收（类似drop table操作）
- 分区表若指定生命周期，则根据各个分区的LastDataModifiedTime判断该分区是否该被回收。不同于非分区表，分区表的最后一个分区被回收后，该表不会被删除
- 生命周期只能设定到表级别，不能再分区设置生命周期，创建表时即可指定生命周期
- 表若不指定生命周期，则表（分区）不会根据生命周期规则被MaxCompute自动回收

## 资源
- 资源Resource是MaxCompute的特有概念，如果想使用MaxCompute的自定义函数（UDF）或MapReduce功能需要依赖资源来完成

## 函数
- MaxCompute为您提供了SQL计算功能，您可以在MaxCompute SQL中使用系统的内建函数完成一定的计算和计数功能。但当内建函数无法满足要求时，您可以使用MaxCompute提供的Java编程接口开发自定义函数（User Defined Function，以下简称UDF）。
- 自定义函数（UDF）可以进一步分为标量值函数（UDF），自定义聚合函数（UDAF）和自定义表值函数（UDTF）三种类型。
- 您在开发完成UDF代码后，需要将代码编译成Jar包，并将此Jar包以Jar资源的形式上传到MaxCompute，最后在MaxCompute中注册此UDF

## 任务
- 任务（Task）是MaxCompute的基本计算单元，SQL及MapReduce功能都是通过任务完成的。
- 对于提交的大多数任务，特别是计算型任务，例如SQL DML语句、MapReduce，MaxCompute会对其进行解析，得出任务的执行计划。执行计划由具有依赖关系的多个执行阶段（Stage）构成

## 任务实例 
# 常用命令
- add alias alter
- cost create
- delete/drop desc/describe download/get
- extended
- flag/flags functions
- get
- help history
- jar/mapreduce
- kill
- lifecycle list
- odpscmd
- partition
- q/quit
- resource
- set status show
- tunnel
- upload
- wait who

# 数据上传下载

# SQL
- SQL概述

MaxCompute SQL适用于海量数据（GB、TB、EB级别），离线批量计算的场合。MaxCompute作业提交后会有几十秒到数分钟不等的排队调度，所以适合处理跑批作业，一次作业批量处理海量数据，不适合直接对接需要每秒处理几千至数万笔事务的前台业务系统。

MaxCompute SQL采用的是类似于SQL的语法，可以看作是标准SQL的子集，但不能因此简单地把MaxCompute等价成一个数据库，它在很多方面并不具备数据库的特征，如事务、主键约束、索引等，更多差异请参见与其他SQL语法的差异。目前在MaxCompute中允许的最大SQL长度是3MB

- 关键字

MaxCompute将SQL语句的关键字作为保留字。在对表、列或是分区命名时如若使用关键字，需给关键字加` `符号进行转义，否则会报错。保留字不区分大小写。

- 类型转换

显式类型转换：是指用**cast**将一种数据类型的值转换为另一种类型的值的行为。

```
select cast(user_id as double) as new_id from user;
select cast('2015-10-01 00:00:00' as datetime) as new_date from user;
```

隐式类型转换：是指在运行时，由MaxCompute依据上下文使用环境及类型转换规则自动进行的类型转换。隐式转换作用域包括各种运算符、内建函数等作用域。

- 运算符

四种类型运算符：关系运算符、算术运算符、位运算符、逻辑运算符。

关系运算符：
```
运算符	        说明
A=B	            如果A或B为NULL，返回NULL；如果A等于B，返回TRUE，否则返回FALSE。
A<>B	        如果A或B为NULL，返回NULL；如果A不等于B，返回TRUE，否则返回FALSE。
A<B	            如果A或B为NULL，返回NULL；如果A小于B，返回TRUE，否则返回FALSE。
A<=B	        如果A或B为NULL，返回NULL；如果A小于等于B，返回TRUE，否则返回FALSE。
A>B	            如果A或B为NULL，返回NULL；如果A大于B，返回TRUE，否则返回FALSE。
A>=B	        如果A或B为NULL，返回NULL；如果A大于等于B，返回TRUE，否则返FALSE。
A IS NULL   	如果A为NULL，返回TRUE，否则返回FALSE。
A IS NOT NULL	如果A不为NULL，返回TRUE，否则返回FALSE。
A LIKE B     	如果A或B为NULL，返回NULL，A为字符串，B为要匹配的模式，如果匹配，返回TRUE，否则返回FALSE。（%）匹配任意多个字符，（_）匹配单个字符。要匹配（%）或（_）要用转义符表示（‘%’）或（‘_’）。
                ‘aaa’ like‘a__’= TRUE 
                ‘aaa’ like‘a%’ = TRUE
                ‘aaa’ like‘aab’= FALSE 
                ‘a%b’ like‘a\%b’= TRUE 
                ‘axb’ like ‘a\%b’= FALSE               
A RLIKE B   	A是字符串，B是字符串常量正则表达式。如果匹配成功，返回TRUE，否则返回FALSE。如果B为空串会报错退出。如果A或B为NULL，返回NULL。
A IN B	        B是一个集合，如果A为NULL，返回NULL，如A在B中则返回TRUE，否则返回FALSE若B仅有一个元素NULL，即A IN（NULL），则返回NULL。若B含有NULL元素，将NULL视为B集合中其他元素的类型。 B必须是常数并且至少有一项，所有类型要一致。
BETWEEN AND	    表达式为A [NOT] BETWEEN B AND C。如果A、B或C为空，则为空。如果A大于或等于B且小于或等于C，则为TRUE，否则为FALSE。
```
在进行部分关系运算之前，首先需要进行类型转换，否则可能会返回null。

```sql
select cast('2019-02-16 00:00:01' AS string) > '2019-02-16';
select cast('2019-02-16 00:00:02' AS datetime) > '2019-02-16 00:00:01';
```
'2019-02-16 00:00:01'是datetime类型，而'2019-02-16'是string类型，在进行比较关系前需要完成显示类型转换

double值存在一定的精度差，不建议直接使用等号对两个double
- 类型转换
## DDL语句
- 表操作
- 生命周期操作
- 分区和列操作
- 视图操作
## INSERT操作
## SELECT操作
## 内建函数
## UDF
## UDF示例程序
## 附录

# MapReduce
# 外部表
# Job运行信息查看
# 图模型
# 交互式分析（Lightning）
# PyODPS
# Spark






