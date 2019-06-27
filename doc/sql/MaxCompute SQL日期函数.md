
# MaxCompute SQL日期函数


## 参数
## DATEADD
## ADD_MONTHS
- 返回开始日期startdate增加nummonths个月后的日期。
## DATEDIFF
- 计算两个时间date1、date2在指定时间单位datepart的差值。
## DATEPART
- 提取日期date中指定的时间单位datepart的值。
## DATETRUNC
- 返回日期date被截取指定时间单位datepart后的日期值。
## GETDATE
- 获取当前系统时间。使用东八区时间作为MaxCompute标准时间。
## ISDATE
- 判断一个日期字符串能否根据对应的格式串转换为一个日期值，如果转换成功，返回TRUE，否则返回FALSE。
## LASTDAY
- 取date当月的最后一天，截取到天，时分秒部分为00:00:00。DATETIME类型。
## LAST_DAY
- 返回该日期所在月份的最后一天日期。STRING类型。
## NEXT_DAY
- 返回大于指定日期startdate并且与week相匹配的第一个日期，即下周几的具体日期。
## DATE_FORMAT
- 将字符串类型的日期从源格式转换至目标格式。
## TO_DATE
- 将一个format格式的字符串date转成日期值。
## TO_CHAR
- 将日期类型date按照format指定的格式转成字符串。
## UNIX_TIMESTAMP
- 将日期date转化为整型的unix格式的日期时间值。
## FROM_UNIXTIME
- 将数字型的unix时间日期值unixtime转为日期值。
## WEEKDAY
- 返回date日期当前周的第几天。
## YEARWEEK
## WEEKOFYEAR
- 返回日期date位于那一年的第几周。周一作为一周的第一天。
## YEAR
- 返回一个日期的年。
## QUARTER
- 返回一个日期的季度，范围是1~4。
## MONTH
- 返回一个日期的月份。
## 月
## DAY
- 返回一个日期的天。
## DAYOFMONTH
- 返回年/月/日中的具体日期。
## HOUR
- 返回一个日期的小时。
## MINUTE
- 返回一个日期的分钟。
## SECOND
- 返回一个日期的秒钟。
## CURRENT_TIMESTAMP
- 返回当前TIMESTAMP类型的时间戳，值不固定。
## MONTHS_BETWEEN
- 返回日期date1和date2之间的月数。



## 参数
如果 ${bdp.system.cyctime} 为 20190114010000

则$[yyyy-mm-dd]为2019-01-14  $[yyyymmdd] 为20190114

如果$2赋值为$[yyyy-mm-dd-2]  

则$2为2019-01-12 

如果$2赋值为$[yyyymmdd-2]  

$2为20190112


## DATEADD
```
datetime dateadd(datetime date, bigint delta, string datepart)
```
- 参数说明：
- date：DATETIME类型，日期值。若输入为STRING类型会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- delta：BIGINT类型，修改幅度。若输入为STRING类型或DOUBLE型会隐式转换到BIGINT类型后参与运算，其他类型会引发异常。若delta大于0，则增，否则减。
- datepart：STRING类型常量。此字段的取值遵循STRING与DATETIME类型转换的约定，即yyyy表示年，mm表示月。此外也支持扩展的日期格式：年-year，月-month或-mon，日-day，小时-hour。非常量、不支持的格式或其它类型会抛异常。
- 返回值：返回**DATETIME**类型。若任一输入参数为null，返回null。

- 按照指定的单位增减delta时，导致的对更高单位的进位或退位，年、月、时、分、秒分别按照10进制、12进制、24进制、60进制、60进制进行计算。
- 当delta的单位是月时，计算规则如下：
    - 若DATETIME的月部分在增加delta值之后不造成day溢出，则保持day值不变，否则把day值设置为结果月份的最后一天。
- datepart的取值遵循STRING与DATETIME类型转换的约定，即yyyy表示年，mm表示月，DATETIME相关的内建函数如无特殊说明均遵守此约定。如果没有特殊说明，所有DATETIME相关的内建函数的part部分也同样支持扩展的日期格式：年-year，月-month或-mon，日-day，小时-hour。
```
若trans_date = 2005-02-28 00:00:00
dateadd(trans_date, 1, 'dd') = 2005-03-01 00:00:00
-- 加一天，结果超出当年2月份的最后一天，实际值为下个月的第一天。
dateadd(trans_date, -1, 'dd') = 2005-02-27 00:00:00
-- 减一天
dateadd(trans_date, 20, 'mm') = 2006-10-28 00:00:00
-- 加20个月，月份溢出，年份加1。
若trans_date = 2005-02-28 00:00:00, dateadd(transdate, 1, 'mm') = 2005-03-28 00:00:00
若trans_date = 2005-01-29 00:00:00, dateadd(transdate, 1, 'mm') = 2005-02-28 00:00:00
-- 2005年2月没有29日，日期截取至当月最后一天。
若trans_date = 2005-03-30 00:00:00, dateadd(transdate, -1, 'mm') = 2005-02-28 00:00:00
```
- 在MaxCompute SQL中，DATETIME类型没有直接的常数表示方式，如下使用方式是错误的：
```
select dateadd(2005-03-30 00:00:00, -1, 'mm') from tbl1;
如果一定要描述DATETIME类型常量，请尝试如下方法：
select dateadd(cast("2005-03-30 00:00:00" as datetime), -1, 'mm') from tbl1;
-- 将STRING类型常量显式转换为DATETIME类型。
```

## ADD_MONTHS
```
string add_months(string startdate, int nummonths)
```
- 返回开始日期startdate增加nummonths个月后的日期。
- 参数说明：
- startdate：STRING类型，格式至少包含年-月-日的日期，否则返回null值。
- num_months：INT型数值。
- 返回值：返回**STRING**类型的日期，格式为yyyy-mm-dd。

```
add_months('2017-02-14',3) = '2017-05-14'
add_months('17-2-14',3) = '0017-05-14'
add_months('2017-02-14 21:30:00',3) = '2017-05-14'
add_months('20170214',3) = null
```

## DATEDIFF
```
bigint datediff(datetime date1, datetime date2, string datepart)
```
- 计算两个时间date1、date2在指定时间单位datepart的差值。
- 参数说明：
- datet1、date2：DATETIME类型，被减数和减数，若输入为STRING类型会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- datepart：STRING类型常量。支持扩展的日期格式。若datepart不符合指定格式或者其它类型则会发生异常。
- 返回值：返回**BIGINT**类型。任一输入参数是null，返回null。如果date1小于date2，返回值可以为负数。
- 说明 计算时会按照datepart切掉低单位部分，然后再计算结果。
```
若start = 2005-12-31 23:59:59，end = 2006-01-01 00:00:00:
    datediff(end, start, 'dd') = 1
    datediff(end, start, 'mm') = 1
    datediff(end, start, 'yyyy') = 1
    datediff(end, start, 'hh') = 1
    datediff(end, start, 'mi') = 1
    datediff(end, start, 'ss') = 1
    datediff('2013-05-31 13:00:00', '2013-05-31 12:30:00', 'ss') = 1800
    datediff('2013-05-31 13:00:00', '2013-05-31 12:30:00', 'mi') = 30
若start = 2018-06-04 19:33:23.234，end = 2018-06-04 19:33:23.250，含毫秒的日期不属于标准DATETIME式样，不能直接隐式转换，此处需进行显示转换：
 datediff(to_date('2018-06-04 19:33:23.250', 'yyyy-MM-dd hh:mi:ss.ff3'),to_date('2018-06-04 19:33:23.234', 'yyyy-MM-dd hh:mi:ss.ff3') , 'ff3') = 16
```
## DATEPART
```
bigint datepart(datetime date, string datepart)
```
- 提取日期date中指定的时间单位datepart的值。
- 参数说明：
- date：DATETIME类型，若输入为STRING类型会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- datepart：STRING类型常量，支持扩展的日期格式。若datepart不符合指定格式或者其它类型则会发生异常。
- 返回值：返回**BIGINT**类型。若任一输入参数为null，返回null。

```
datepart('2013-06-08 01:10:00', 'yyyy')  =  2013
datepart('2013-06-08 01:10:00', 'mm')  =  6
```

## DATETRUNC
```
datetime datetrunc (datetime date, string datepart)
```

- 返回日期date被截取指定时间单位datepart后的日期值。
- 参数说明：
- date：DATETIME类型，若输入为STRING类型会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- datepart：STRING类型常量，支持扩展的日期格式。若datepart不符合指定格式或者其它类型则会发生异常。
- 返回值：**DATETIME**类型。任意一个参数为null时，返回null。

```
datetrunc('2011-12-07 16:28:46', 'yyyy') = 2011-01-01 00:00:00
datetrunc('2011-12-07 16:28:46', 'month') = 2011-12-01 00:00:00
datetrunc('2011-12-07 16:28:46', 'DD') = 2011-12-07 00:00:00
```
```
datetrunc(TO_DATE(${today}, 'yyyymmdd'), 'dd') AS day
```
## GETDATE
```
datetime getdate()
```
- 获取当前系统时间。使用东八区时间作为MaxCompute标准时间。
- 返回值：返回当前日期和时间，DATETIME类型。

## ISDATE
```
boolean isdate(string date, string format)
```
- 判断一个日期字符串能否根据对应的格式串转换为一个日期值，如果转换成功，返回TRUE，否则返回FALSE。
- 参数说明：
- date：STRING格式的日期值，若输入为BIGINT、DOUBLE、DECIMAL或DATETIME类型，会隐式转换为STRING类型后参与运算，其它类型报异常。
- format：STRING类型常量，不支持日期扩展格式。其它类型或不支持的格式会抛异常。如果format中出现多余的格式串，则只取第一个格式串对应的日期数值，其余的会被视为分隔符。如isdate("1234-yyyy", "yyyy-yyyy")，会返回TRUE。
- 返回值：返回**Boolean**类型，如任意参数为null，返回null。

## LASTDAY
```
datetime lastday(datetime date)
```
- 取date当月的最后一天，截取到天，时分秒部分为00:00:00。
- 参数说明：
- date：DATETIME类型，若输入为STRING类型，会隐式转换为DATETIME类型后参与运算，其它类型报异常。
- 返回值：返回**DATETIME**类型，如输入为null，返回null。

## LAST_DAY
```
string last_day(string date)
```
- 返回该日期所在月份的最后一天日期。
- 参数说明：
- date：STRING类型，格式为yyyy-MM-dd HH:mi:ss或yyyy-MM-dd。
- 返回值：返回**STRING**类型的日期，格式为yyyy-mm-dd。

```
last_day('2017-03-04') = '2017-03-31'
last_day('2017-07-04 11:40:00') = '2017-07-31'
last_day('20170304') = null
```
## NEXT_DAY
```
string next_day(string startdate, string week)
```
- 返回大于指定日期startdate并且与week相匹配的第一个日期，即下周几的具体日期。
- 参数说明：
- startdate：STRING类型，格式为yyyy-MM-dd HH:mi:ss或yyyy-MM-dd。
- week：STRING类型，一个星期前2个或3个字母，或者一个星期的全名，如MO、TUE、FRIDAY。
- 返回值：返回**STRING**类型的日期，格式为yyyy-mm-dd。

```
next_day('2017-08-01','TU') = '2017-08-08'
next_day('2017-08-01 23:34:00','TU') = '2017-08-08'
next_day('20170801','TU') = null
```


## DATE_FORMAT

```
VARCHAR DATE_FORMAT(TIMESTAMP time, VARCHAR to_format)
VARCHAR DATE_FORMAT(VARCHAR date, VARCHAR to_format)
VARCHAR DATE_FORMAT(VARCHAR date, VARCHAR from_format, VARCHAR to_format)

date 参数是合法的日期
to_format规定日期/时间的输出格式

```

将字符串类型的日期从源格式转换至目标格式。第一个参数（time 或 date）为源字符串。第二个参数from_format可选，为源字符串的格式，默认为yyyy-MM-dd hh:mm:ss。第三个参数为返回日期的的格式，返回值为转换格式后的字符串类型日期。若有参数为null或解析错误，返回null。

```
select  `day` from auto_analyze_rollup_update
2019-04-01 00:00:00
2019-04-01 00:00:00
2019-04-01 00:00:00

select DATE_FORMAT(`day`, '%Y%m%d') from auto_analyze_rollup_update
20190401
20190401
20190401
```

```
DELETE FROM `table` WHERE DATE_FORMAT(`day`, '%Y%m%d')='${bdp.system.bizdate}';

'%Y%m%d'为目标格式
'20190405'这种字符串类型日期
```

```
DELETE FROM `result_daily_big_merchant` WHERE DATE_FORMAT(`day`, '%Y%m%d')='${last30}';
```

```
"last30=$[yyyymmdd-41]"
```


## TO_DATE
```
datetime to_date(string date, string format)
```
- 将一个format格式的字符串date转成日期值。
- 参数说明：
- date：STRING类型，要转换的字符串格式的日期值，若输入为BIGINT、DOUBLE、DECIMAL或者DATETIME类型，会隐式转换为STRING类型后参与运算，为其它类型则抛异常，为空串时抛异常。
- format：STRING类型常量，日期格式。非常量或其他类型会引发异常。format不支持日期扩展格式，其他字符作为无用字符在解析时忽略。
- format参数至少包含yyyy，否则引发异常，如果format中出现多余的格式串，则只取第一个格式串对应的日期数值，其余的会被视为分隔符。如to_date("1234-2234", "yyyy-yyyy") 会返回1234-01-01 00:00:00。
- format格式：yyyy为四位数的年，mm为2位数的月，dd为2位数的日，hh为24小时制的时，mi为2位数的分钟，ss为2位数秒，ff3为3位精度毫秒。
- 返回值：返回**DATETIME**类型，格式为‘yyyy-mm-dd hh:mi:ss’ 。若任意一个输入的参数为NULL，则返回NULL值。
```
to_date('阿里巴巴2010-12*03', '阿里巴巴yyyy-mm*dd') = 2010-12-03 00:00:00
to_date('20080718', 'yyyymmdd') = 2008-07-18 00:00:00
to_date('200807182030','yyyymmddhhmi') = 2008-07-18 20:30:00
to_date('2008718', 'yyyymmdd') = null
-- 格式不符合，引发异常。
to_date('阿里巴巴2010-12*3', '阿里巴巴yyyy-mm*dd') = null
-- 格式不符合，引发异常。
to_date('2010-24-01', 'yyyy') = null
-- 格式不符合，引发异常。
to_date('20181030 15-13-12.345','yyyymmdd hh-mi-ss.ff3')=2018-10-30 15:13:12
```

```
dateadd(TO_DATE('${bdp.system.bizdate}', 'yyyymmdd'), -1 * weekday(TO_DATE('${bdp.system.bizdate}', 'yyyymmdd')), 'dd') AS day
```

```
datetrunc(TO_DATE(${bdp.system.bizdate}, 'yyyymmdd'), 'dd') AS day
```

## TO_CHAR
```
string to_char(datetime date, string format)
```
- 将日期类型date按照format指定的格式转成字符串。
- 参数类型：
- date：DATETIME类型，要转换的日期值，若输入为STRING类型，会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- format：STRING类型常量。非常量或其他类型会引发异常。format中的日期格式部分会被替换成相应的数据，其它字符直接输出。
- 返回值：返回**STRING**类型。若任意一个输入的参数为NULL，则返回NULL值。
```
to_char('2010-12-03 00:00:00', '阿里金融yyyy-mm*dd') = '阿里金融2010-12*03'
to_char('2008-07-18 00:00:00', 'yyyymmdd') = '20080718' 
to_char('阿里巴巴2010-12*3', '阿里巴巴yyyy-mm*dd') -- 会引发异常。
to_char('2010-24-01', 'yyyy') -- 会引发异常。
to_char('2008718', 'yyyymmdd') -- 会引发异常。
关于其他类型向STRING类型转换的详情请参见字符串函数>TO_CHAR。
```

```
WHERE pt >= TO_CHAR(dateadd(TO_DATE('${bdp.system.bizdate}', 'yyyymmdd'), -1 * weekday(TO_DATE('${bdp.system.bizdate}', 'yyyymmdd')), 'dd'), 'yyyymmdd') --本周一
	AND pt < to_char(dateadd(TO_DATE('${bdp.system.bizdate}', 'yyyymmdd'), 7 - weekday(TO_DATE('${bdp.system.bizdate}', 'yyyymmdd')), 'dd'), 'yyyymmdd') --下周一
```
## UNIX_TIMESTAMP
```
bigint unix_timestamp(datetime date)
```
- 将日期date转化为整型的unix格式的日期时间值。
- 参数说明：
- date：DATETIME类型日期值，若输入为STRING类型，会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- 返回值：返回**BIGINT**类型，表示unix格式日期值，date为NULL时，返回NULL值。

## FROM_UNIXTIME
```
datetime from_unixtime(bigint unixtime)
```
- 将数字型的unix时间日期值unixtime转为日期值。
- 参数说明：
- unixtime：BIGINT类型，秒数，unix格式的日期时间值，若输入为STRING、DOUBLE、DECIMAL类型会隐式转换为BIGINT后参与运算。
- 返回值：返回**DATETIME**类型的日期值，unixtime为NULL时，返回NULL。
```
from_unixtime(123456789) = 1973-11-30 05:33:09
```

## WEEKDAY
```
bigint weekday (datetime date)
```
- 返回date日期当前周的第几天。
- 参数说明：
- date：DATETIME类型，若输入为STRING类型，会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- 返回值：返回**BIGINT**类型，若输入参数为NULL，返回NULL值。周一作为一周的第一天，返回值为0。其他日期依次递增，周日返回6。


## YEARWEEK

```
DELETE FROM `table` WHERE YEARWEEK(date_format(day,'%Y%m%d'),1) = YEARWEEK('${bdp.system.bizdate}',1);
```

```
DELETE FROM `table` WHERE YEARWEEK(date_format(day,'%Y%m%d'),1) = YEARWEEK('${lastday}',1);
```
```
lastday=$[yyyymmdd-183]
```



## WEEKOFYEAR
```
bigint weekofyear (datetime date)
```
- 返回日期date位于那一年的第几周。周一作为一周的第一天。
- 说明 关于这一周算上一年， 还是下一年，主要是看这一周大多数日期（4天以上）在哪一年多。算在前一年，就是前一年的最后一周，算在后一年就是后一年的第一周。
- 参数说明:
- date：DATETIME类型日期值，若输入为STRING类型，会隐式转换为DATETIME类型后参与运算，其它类型抛异常。
- 返回值：返回**BIGINT**类型。若输入为NULL，返回NULL值。

```
select weekofyear(to_date("20141229", "yyyymmdd")) from dual;  
返回结果：  
+------------+
| _c0        |
+------------+
| 1          |
+------------+
 -虽然20141229属于2014年，但是这一周的大多数日期是在2015年，因此返回结果为1，表示是2015年的第一周。    
 select weekofyear(to_date("20141231", "yyyymmdd")) from dual；--返回结果为1。  
 select weekofyear(to_date("20151229", "yyyymmdd")) from dual；--返回结果为53。
 
```

```
YEARWEEK(date[,mode])
```
例如 2010-3-14 ，礼拜天

SELECT YEARWEEK('2010-3-14') 返回 11

SELECT YEARWEEK('2010-3-14',1) 返回 10

```
Mode	First day of week	Range	Week 1 is the first week …
0	    Sunday	0-53	with a Sunday in this year
1	    Monday	0-53	with more than 3 days this year
2  	    Sunday	1-53	with a Sunday in this year
3	    Monday	1-53	with more than 3 days this year
4	    Sunday	0-53	with more than 3 days this year
5	    Monday	0-53	with a Monday in this year
6	    Sunday	1-53	with more than 3 days this year
7	    Monday	1-53	with a Monday in this year

```

weekofyear函数是计算出当前日期所在周数，和YEARWEEK('日期',1)的周数一致，但YEARWEEK('日期',1)在小于10的时候，不带0

select WEEKOFYEAR('2016-2-2'); =5

## YEAR
```
INT year(string date)
```
- 返回一个日期的年。
- 参数说明：
- date：STRING类型日期值，格式至少包含yyyy-mm-dd且不含多余的字符串，否则返回null值。
- 返回值：返回**INT**类型。

```
year('1970-01-01 12:30:00') = 1970
year('1970-01-01') = 1970
year('70-01-01') = 70
year('1970-01-01') = null
year('1970/03/09') = null
year(null) --返回异常。
```
## QUARTER
```
INT quarter (datetime/timestamp/string date)
```
- 返回一个日期的季度，范围是1~4。
- 参数说明：
- date：DATETIME/TIMESTAMP/STRING类型日期值，日期格式至少包含yyyy-mm-dd，其他会返回null值。
- 返回值：返回**INT**类型，输入null，则返回null值。
```
quarter('1970-11-12 10:00:00') = 4
quarter('1970-11-12') = 4
```
## MONTH
```
INT month(string date)
```
- 返回一个日期的月份。
- 参数说明：
- date：STRING类型日期值，其他类型将返回异常。
- 返回值：返回**INT**类型。
```
month('2014-09-01') = 9
month('20140901') = null
```

## 月

```
DELETE FROM `result_monthly_big_merchant_mod` WHERE DATE_FORMAT(`day`, '%Y%m%d')='${monthOfYesterday}01';
```
```
"monthOfYesterday=$[yyyymm-1]"
```

## DAY
```
INT day(string date)
```
- 返回一个日期的天。
- 参数说明：
- date：STRING类型日期值（格式为yyyy-mm-dd、yyyy-mm-dd hh:mi:ss）其他类型将返回异常。
- 返回值：返回**INT**类型。
```
day('2014-09-01') = 1
day('20140901') = null
```
## DAYOFMONTH
```
INT dayofmonth(date)
```
- 返回年/月/日中的具体日期。
- 例如2017年10月13日，执行命令int dayofmonth(2017-10-13)返回结果为13。
- 参数说明：
- date：STRING类型日期值，其他类型将返回异常。
- 返回值：返回**INT**类型。

```
dayofmonth('2014-09-01') = 1
dayofmonth('20140901') = null
```
## HOUR
```
INT hour(string date)
```
- 返回一个日期的小时。
- 参数说明：
- date：STRING类型日期值，其他类型将返回异常。
- 返回值：返回**INT**类型。

```
hour('2014-09-01 12:00:00') = 12
hour('12:00:00') = 12
hour('20140901120000') = null
```
## MINUTE
```
INT minute(string date)
```
- 返回一个日期的分钟。
- 参数说明：
- date：STRING类型日期值，其他类型将返回异常。
- 返回值：返回**INT**类型。

```
minute('2014-09-01 12:30:00') = 30
minute('12:30:00') = 30
minute('20140901120000') = null
```
## SECOND
```
INT second(string date)
```
- 返回一个日期的秒钟。
- 参数说明：
- date：STRING类型日期值，其他类型将返回异常。
- 返回值：返回**INT**类型。

```
second('2014-09-01 12:30:45') = 45
second('12:30:45') = 45
second('20140901123045') = null
```
## CURRENT_TIMESTAMP
```
timestamp current_timestamp()
```
- 返回当前TIMESTAMP类型的时间戳，值不固定。
-返回值：返回TIMESTAMP类型。

```
select current_timestamp() from dual; --返回'2017-08-03 11:50:30.661'。

## FROM_UTC_TIMESTAMP

timestamp from_utc_timestamp({any primitive type}*, string timezone)
```
- 将一个UTC时区的时间戳转换成一个指定时区的时间戳。
- 参数说明：
- {any primitive type}*：时间戳，类型包含TIMESTAMP/DATETIME/TINYINT/SMALLINT/INT/BIGINT。
- timezone：指定需要转换的目标时区，如PST。
- 本函数只支持Asia/Shanghai这种格式，不支持GMT+9这种格式。
- 返回值：返回**TIMESTAMP**类型。

```
SELECT from_utc_timestamp(1501557840,'PST') ;--返回：1970-01-18 09:05:57.84。
SELECT from_utc_timestamp('1970-01-30 16:00:00','PST') ;--返回：1970-01-30 08:00:00.0。
SELECT from_utc_timestamp('1970-01-30','PST') ;--返回：1970-01-29 16:00:00.0。
```

## MONTHS_BETWEEN
```
double months_between(datetime/timestamp/string date1, datetime/timestamp/string date2)
```
- 返回日期date1和date2之间的月数。

- 参数说明：
- date1：DATETIME/TIMESTAMP/STRING类型，格式为yyyy-MM-dd HH:mi:ss或yyyy-MM-dd。
- date2：DATETIME/TIMESTAMP/STRING类型，格式为yyyy-MM-dd HH:mi:ss或yyyy-MM-dd。
- 返回值：返回**Double**类型。
- 当date1晚于date2，返回值为正。当date2晚于date1，返回值为负。
- 当date1和date2分别对应两个月的最后一天，返回整数月，否则计算方式为date1-date2的天数除以31天。
```
months_between('1997-02-28 10:30:00', '1996-10-30') = 3.9495967741935485
months_between('1996-10-30','1997-02-28 10:30:00' ) = -3.9495967741935485
months_between('1996-09-30','1996-12-31') = -3.0
```
