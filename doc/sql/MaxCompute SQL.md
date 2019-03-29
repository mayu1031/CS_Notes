# SQL
# 1SQL概述

MaxCompute SQL适用于海量数据（GB、TB、EB级别），离线批量计算的场合。MaxCompute作业提交后会有几十秒到数分钟不等的排队调度，所以适合处理跑批作业，一次作业批量处理海量数据，不适合直接对接需要每秒处理几千至数万笔事务的前台业务系统。

MaxCompute SQL采用的是类似于SQL的语法，可以看作是标准SQL的子集，但不能因此简单地把MaxCompute等价成一个数据库，它在很多方面并不具备数据库的特征，如事务、主键约束、索引等，更多差异请参见与其他SQL语法的差异。目前在MaxCompute中允许的最大SQL长度是3MB

## 1.1关键字

MaxCompute将SQL语句的关键字作为保留字。在对表、列或是分区命名时如若使用关键字，需给关键字加` `符号进行转义，否则会报错。保留字不区分大小写。

## 1.2类型转换

显式类型转换：是指用**cast**将一种数据类型的值转换为另一种类型的值的行为。

```
select cast(user_id as double) as new_id from user;
select cast('2015-10-01 00:00:00' as datetime) as new_date from user;
```

隐式类型转换：是指在运行时，由MaxCompute依据上下文使用环境及类型转换规则自动进行的类型转换。隐式转换作用域包括各种运算符、内建函数等作用域。

## 1.3运算符

四种类型运算符：关系运算符、算术运算符、位运算符、逻辑运算符。

**关系运算符：**
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

double值存在一定的精度差，不建议直接使用等号对两个double类型的数据进行比较。可以使用两个double类型相减，然后取绝对值的方法进行判断，当绝对值足够小时，认为两个double数值相等
```sql
abs(0.9999999999 - 1.0000000000) < 0.000000001
 -- 0.9999999999和1.0000000000为10位精度，而0.000000001为9位精度。
 -- 此时可以认为0.9999999999和1.0000000000相等。
```
**算数运算符：**
```
运算符	说明
A + B	如果A或B为NULL，返回NULL；否则返回A + B的结果。
A – B	如果A或B为NULL，返回NULL；否则返回A – B的结果。
A * B	如果A或B为NULL，返回NULL；否则返回A * B的结果。
A / B	如果A或B为NULL，返回NULL；否则返回A / B的结果。 说明 如果A和B为BIGINT类型，返回结果为DOUBLE类型。
A % B	如果A或B为NULL，返回NULL；否则返回A模B的结果。
+A	仍然返回A。
-A	如果A为NULL，返回NULL，否则返回-A。
```

```sql
select age+10, age-10, age%10, -age, age*age, age/10 from user;
```

- 只有参数是STRING、BIGINT或DOUBLE类型才能参与算术运算，日期型和布尔型不允许参与运算。
- STRING类型在参与运算前会进行隐式类型转换，转换为DOUBLE类型。
- BIGINT和DOUBLE类型共同参与计算时，会将BIGINT隐式转换为DOUBLE再进行计算，返回结果为DOUBLE类型。
- A和B都是BIGINT类型，进行A/B运算，返回结果为DOUBLE类型。进行上述其他运算，仍然返回BIGINT类型。
**位运算符：**

```
运算符	说明
A & B	返回A与B进行按位与的结果。例如1&2返回0，1&3返回1，NULL与任何值按位与都为NULL。A和B必须为BIGINT类型。
A | B	返回A与B进行按位或的结果。例如1 |2返回3，1 |3返回3，NULL与任何值按位或都为NULL。A和B必须为BIGINT类型。
```
- 说明 位运算符不支持隐式转换，只允许BIGINT类型。

**逻辑运算符：**

```
运算符	说明
A and B	TRUE and TRUE=TRUE
        TRUE and FALSE=FALSE
        FALSE and TRUE=FALSE
        FALSE and NULL=FALSE
        NULL and FALSE=FALSE
        TRUE and NULL=NULL
        NULL and TRUE=NULL
        NULL and NULL=NULL
A or B	TRUE or TRUE=TRUE
        TRUE or FALSE=TRUE
        FALSE or TRUE=TRUE
        FALSE or NULL=NULL
        NULL or FALSE=NULL
        TRUE or NULL=TRUE
        NULL or TRUE=TRUE
        NULL or NULL=NULL
NOT A	如果A是NULL，返回NULL
        如果A是TRUE，返回FALSE
        如果A是FALSE，返回TRUE
```

# 2DDL语句
## 表操作
## 生命周期操作
## 分区和列操作
## 视图操作
# INSERT操作
# SELECT操作
# 内建函数
# UDF
# UDF示例程序
# 附录



