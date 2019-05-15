
# Power BI DAX


## 度量值
- 度量值用于一些最常见的数据分析。例如，求和、平均值、最小值或最大值、计数，或自己使用 DAX 公式创建的更高级的计算。度量值的计算结果也始终随着你与的报表的交互而改变，以便进行快速和动态的临时数据浏览。
- 通常自动为用户创建度量值，系统会自动提供一种计算，显示在“字段”框中且带有一个 sigma 图标 ∑的任何字段为数值，并且其值可以聚合。当 Power BI Desktop 检测到数字类型数据列时，它不会直接显示包含 200 万行 SalesAmount 值的表，而是自动创建度量值来计算聚合数据。 求和是数字类型数据的默认聚合方式，但可以轻松应用不同类型的聚合方式，如**平均值或计数**。
- 要将图表聚合更改为平均值，在“可视化效果”窗格“值”区域中，单击SalesAmount旁边的向下箭头，并选择“平均值”。
- 创建度量值，使用到DAX
```
Projected Sales = SUM('Sales'[Last Years Sales])*1.06
```
- 在另一个度量值中使用度量值
    - 已经创建的度量值可以直接使用 不需要再使用聚合函数
```
Net Sales per Unit = [Net Sales] / SUM(Sales[SalesQuantity])
```
    
## 新建列
- 计算列类似于度量值，因为二者都基于DAX公式，但它们的区别在于使用方式。通常会在可视化效果的“值”区域中使用度量值，以基于其他字段计算结果。可以将计算列用作可视化效果的行、轴、图例和组区域中的新字段。
- 当前分析的数据不包含获取期望结果所需的特定字段。这就是计算列的有用之处。计算列使用数据分析表达式(DAX)公式来定义列值，包括从组合几个不同列中的文本值到通过其他值计算数值的任何操作。 例如，假设你的数据中含有“城市”和“州”两个字段，但你想要使用单一“位置”字段来同时含这两项内容，如“迈阿密，佛罗里达州”。 这正符合计算列的用途。
- 凭借计算列，你可以将新数据添加到模型中已存在的表。在Power BI Desktop中，使用“报表”视图中的“新建列”功能创建计算列。
- 与使用查询编辑器中的“添加自定义列”创建为查询的一部分的自定义列不同，在报表视图或数据视图中创建的计算列以你已加载到模型中的数据为基础。例如，可以选择连接两个不同但相关的表中的值、执行添加或提取子字符串。

# DAX
- DAX 是公式或表达式中可用于计算并返回一个或多个值的函数、运算符或常量的集合。简单来说，DAX 可帮助你通过模型中已有的数据来创建新信息。


## 语法
```
Total Sales = SUM(Sales[SalesAmount])
```
- 此度量值会将所包括的其他每个字段的销售额相加，进行计算并返回值。
- 这个度量值的功能与直接将 SalesAmount 字段添加到我的报表中一样,创建自己的度量值来对 SalesAmount 字段中的值求和有个好处：我们可以将它当作参数用于其他公式

## 函数
- 日期和时间函数
- 筛选器函数
- 信息函数
- 逻辑函数
- 数学和三角函数
- 统计函数
- 文本函数

DAX函数可以直接引用已经创建好的度量值，可以使DAX函数看起来更简洁、更具可读性

### Filter
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

### SUMX

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

### CALCULATE
```
CALCULATE(<expression>,<filter1>,<filter2>…)
```

expression 要进行计算的表达式。

filter1,filter2,… （可选）定义筛选器的布尔表达式或表表达式的逗号分隔的列表。

CALCULATE第一个参数为聚合运算表达式，第一个参数可以是一个度量值，因为度量值本身就是一个聚合函数运算

### count

The Count function counts the number of records that contain a number in a single-column table

### countRows

The CountRows function counts the number records in a table

### 知道某月日期计算这个月的天数
```
power_bi merchant_unionpay_monthly'[日期] 设定为每月的一号

4月1号到4月30号

度量值  = DateDiff(LASTDATE('power_bi merchant_unionpay_monthly'[日期]),EOMONTH(LASTDATE('power_bi merchant_unionpay_monthly'[日期]),0),DAY)
```
```
度量值  = DAY(EOMONTH((LASTDATE('power_bi merchant_unionpay_monthly'[日期])),0))
```

### DAY

```
DAY(<date>)
```

参数:

date datetime 格式的日期，或日期的文本表示形式。

返回值:

表示月中第几天的整数。

返回月中的第几天，即一个 1 到 31 之间的数字。


```
度量值  = DAY(EOMONTH((LASTDATE('power_bi merchant_unionpay_monthly'[日期])),0))
```

### MONTH 
```
MONTH(<datetime>)
```

参数:

date datetime 或文本格式的日期。

返回值:

从 1 到 12 的整数。

将月份返回为从 1（1 月）到 12（12 月）的数字。

```
=MONTH(Orders[TransactionDate])
```

### EOMONTH

```
EOMONTH(<start_date>, <months>)
```

参数:

start_date datetime 格式或一个可接受文本日期表示形式的开始日期。

months 表示 start_date 之前或之后的月份数的数字。

返回值:

一个日期 (datetime)。

返回指定月份数之前或之后的月份的最后一天的日期，该日期采用 datetime 格式。EOMONTH 可用于计算处于月份最后一天的到期日期。

```
度量值  = DAY(EOMONTH((LASTDATE('power_bi merchant_unionpay_monthly'[日期])),0))
```

### DATESINPERIOD 
datesinperiod

```
DATESINPERIOD(<dates>,<start_date>,<number_of_intervals>,<interval>)
```

参数

dates 包含日期的列。

start_date 日期表达式。

number_of_intervals 一个整数，指定要从日期中加上或减去的间隔数。

interval 日期按其轮换的间隔。间隔值可以是以下值之一：year、quarter、month、day

返回值 包含由日期值构成的单列的表。

返回一个表，该表包含由日期构成的一列，这些日期从 start_date 开始，并且继续到指定的 number_of_intervals。

```
DATESINPERIOD(<dates>,<start_date>,<number_of_intervals>,<interval>)

下面的公式为 2007 年 8 月 24 日之前的 21 天返回 Internet 销售额。
= CALCULATE(SUM(InternetSales_USD[SalesAmount_USD]),DATESINPERIOD(DateTime[DateKey],DATE(2007,08,24),-21,day))

```


```
实际应用中的一个案例 计算截止到统计这天，这周的某一数据的平均情况
KA_本周日均_新增登记 = 
VAR lastday =
    LASTDATE ( KA_daily[day] )
RETURN
    DIVIDE (
        CALCULATE (
            SUM ( KA_daily[new_register_store_number]),
            DATESINPERIOD (
                KA_daily[day],
                lastday,
                - WEEKDAY ( lastday, 2 ),
                DAY
            )
        ),
        WEEKDAY ( lastday, 2 )
    )
```

### DATESBETWEEN

```
DATESBETWEEN(<dates>,<start_date>,<end_date>)
```

参数:

dates 对日期/时间列的引用。

start_date 日期表达式。

end_date 日期表达式。

返回值:

包含由日期值构成的单列的表。

注释:

如果 start_date 是空白日期值，则 start_date 将是 dates 列中的最早的值。

如果 end_date 是空白日期值，则 end_date 将是 dates 列中的最晚的值。

包括用作 start_date 和 end_date 的日期：也就是说，如果销售在 9 月 1 日发生并且您使用 9 月 1 日作为开始日期，将对 9 月 1 日的销售计数。

```
=CALCULATE(SUM(InternetSales_USD[SalesAmount_USD]), DATESBETWEEN(DateTime[DateKey],
    DATE(2003,6,1),
    DATE(2003,8,31)
  ))
```

```
实际应用中的一个案例 计算截止到统计这天，这周的某一数据的平均情况和上周同一天计算平均情况的对比
KA_周同比_笔数(万) = 
VAR lastweekday =
    DATEADD ( LASTDATE ( KA_daily[day] ), -7, DAY )
VAR lastweekdata =
    DIVIDE (
        CALCULATE (
            SUM (KA_daily[cnt] ) / 10000,
            DATESBETWEEN (
                KA_daily[day],
                DATEADD ( lastweekday, - WEEKDAY ( lastweekday, 3 ), DAY ),
                lastweekday
            )
        ),
        WEEKDAY ( lastweekday, 2 )
    )
RETURN
    DIVIDE ( [KA_本周日均_笔数(万)], lastweekdata ) - 1
```

### WEEKDAY 

```
WEEKDAY(<date>, <return_type>)
```

返回用来标识某一日期是星期几的 1 到 7 之间的数字。默认情况下，这个星期几的范围是从 1（星期日）到 7（星期六）。

参数:

date 采用 datetime 格式的日期。应通过使用 DATE 函数、使用导致日期的表达式或作为其他公式的结果，输入日期。

return_type 用于确定返回值的数字：

返回类型周开始于

1周从星期日 (1) 开始，到星期六 (7) 结束。

2周从星期一 (1) 开始，到星期日 (7) 结束。

3周从星期一 (0) 开始，到星期日 (6) 结束。

返回值:

从 1 到 7 的整数。

### DATESMTD 
datesmtd

```
DATESMTD(<dates>)
```

参数:

dates 包含日期的列。

属性值/返回值:

包含由日期值构成的单列的表。返回一个表，该表包含当前上下文中本月截止到现在的日期列。

```
该度量值为 Internet 销售计算“本月截止到现在的总计”
=CALCULATE(SUM(InternetSales_USD[SalesAmount_USD]), DATESMTD(DateTime[DateKey]))
```

```
本月日均_活跃门店 = CALCULATE(SUM('power_bi result_bd_daily'[活跃门店数])/10000,DATESMTD('power_bi result_bd_daily'[统计日期]))
/DAY(LASTDATE('power_bi result_bd_daily'[统计日期]))
```

## 上下文
- 上下文是需要了解的重要 DAX 概念之一。 DAX 中有两种上下文类型；行上下文和筛选上下文。 

- “行上下文”可被视为“当前行”。如果创建了计算列，则行上下文由每个单独行中的值以及与当前行相关的列中的值组成。 还有一些函数（EARLIER和EARLIEST）可从当前行获取值，然后在对整个表执行操作时使用该值。

- “筛选上下文”是根据筛选约束（已应用于行或由公式中的筛选表达式定义）而允许在每列中存在的值集。可以将筛选器上下文视为：决定结果或值的计算中**所应用的一个或多个筛选器。**
- 筛选器:FILTER,ALL,ALLEXCEPT等
