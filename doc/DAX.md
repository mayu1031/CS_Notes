# DAX

DAX函数可以直接引用已经创建好的度量值，可以使DAX函数看起来更简洁、更具可读性

## Filter
- 筛选函数
```
FILTER(,)

第一个参数是要筛选的表
第二个参数是筛选条件
```

和calculate结合一起使用
```
CALCULATE(…,FILTER(ALL(…),…))
```
找出年销售额超过2000万的城市销售金额

```
销售总额 = sum('销售明细'[销售额])
大于2000万的城市销售金额 = CALCULATE([销售总额],FILTER(ALL('门店城市'),[销售总额]>20000000))
```

## SUMX

SUMX的计算原理是逐行运算，如果数据量特别大，这种方式对内存的消耗比较严重，使用这种方式候需要慎重

```
SUMX(<table>, <expression> )

第一个参数为被运算的表table

第二个参数是对表中的每一行计算的表达式 (表的具体某一列or度量值)

这是一个迭代函数，可以对表进行逐行运算
```

```
= SUMX('产品明细',[大于2000万的城市销售金额])
```

```
= SUMX('产品明细',SUMX(FILTER('门店城市',[销售总额]>20000000),[销售总额]))
```

## CALCULATE
```
CALCULATE(<expression>,<filter1>,<filter2>…)
```

expression 要进行计算的表达式。

filter1,filter2,… （可选）定义筛选器的布尔表达式或表表达式的逗号分隔的列表。

CALCULATE第一个参数为聚合运算表达式，第一个参数可以是一个度量值，因为度量值本身就是一个聚合函数运算

## count

The Count function counts the number of records that contain a number in a single-column table

## countRows

The CountRows function counts the number records in a table

## 知道某月日期计算这个月的天数
```
power_bi merchant_unionpay_monthly'[日期] 设定为每月的一号

4月1号到4月30号

度量值  = DateDiff(LASTDATE('power_bi merchant_unionpay_monthly'[日期]),EOMONTH(LASTDATE('power_bi merchant_unionpay_monthly'[日期]),0),DAY)
```

```
度量值  = DAY(EOMONTH((LASTDATE('power_bi merchant_unionpay_monthly'[日期])),0))
```

