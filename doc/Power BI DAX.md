
# Power BI DAX


# 度量值
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
    
# 新建列
- 计算列类似于度量值，因为二者都基于DAX公式，但它们的区别在于使用方式。通常会在可视化效果的“值”区域中使用度量值，以基于其他字段计算结果。可以将计算列用作可视化效果的行、轴、图例和组区域中的新字段。
- 当前分析的数据不包含获取期望结果所需的特定字段。这就是计算列的有用之处。计算列使用数据分析表达式(DAX)公式来定义列值，包括从组合几个不同列中的文本值到通过其他值计算数值的任何操作。 例如，假设你的数据中含有“城市”和“州”两个字段，但你想要使用单一“位置”字段来同时含这两项内容，如“迈阿密，佛罗里达州”。 这正符合计算列的用途。
- 凭借计算列，你可以将新数据添加到模型中已存在的表。在Power BI Desktop中，使用“报表”视图中的“新建列”功能创建计算列。
- 与使用查询编辑器中的“添加自定义列”创建为查询的一部分的自定义列不同，在报表视图或数据视图中创建的计算列以你已加载到模型中的数据为基础。例如，可以选择连接两个不同但相关的表中的值、执行添加或提取子字符串。

# DAX
- DAX 是公式或表达式中可用于计算并返回一个或多个值的函数、运算符或常量的集合。简单来说，DAX 可帮助你通过模型中已有的数据来创建新信息。


# 语法
```
Total Sales = SUM(Sales[SalesAmount])
```
- 此度量值会将所包括的其他每个字段的销售额相加，进行计算并返回值。
- 这个度量值的功能与直接将 SalesAmount 字段添加到我的报表中一样,创建自己的度量值来对 SalesAmount 字段中的值求和有个好处：我们可以将它当作参数用于其他公式

# 函数
- 日期和时间函数
- 筛选器函数
- 信息函数
- 逻辑函数
- 数学和三角函数
- 统计函数
- 文本函数

DAX函数可以直接引用已经创建好的度量值，可以使DAX函数看起来更简洁、更具可读性

## Filter

```
FILTER(,)

第一个参数是要筛选的表
第二个参数是筛选条件
```
筛选函数

和calculate结合一起使用
```
CALCULATE(…,FILTER(ALL(…),…))
```
找出年销售额超过2000万的城市销售金额

```
销售总额 = sum('销售明细'[销售额])
大于2000万的城市销售金额 = CALCULATE([销售总额],FILTER(ALL('门店城市'),[销售总额]>20000000))
```

## SELECTEDVALUE

```
SELECTEDVALUE(<columnName>[, <alternateResult>]) 
```
过滤器当前选中的值，可以通过函数来获取：

参数注释：

columnName ：是已存的一个列名，不能是表达式，当columnName的上下文仅被过滤为一个不同的值时，该函数返回该值；

alternateResult：可选项，默认值是BLANK()；如果columnName的上下文被过滤到0个或多个唯一值时，返回alternateResult；

```
SELECTEDVALUE ( '用户'[用户指标] ) = "新增访客数", BLANK(),
SELECTEDVALUE ( '用户'[用户指标] ) = "新增交易用户数", [昨日_新增交易用户数],
```

## ALLSELECTED

```
ALLSELECTED([<tableName> | <columnName>])
```

从当前查询的列和行中删除上下文筛选器，同时保留所有其他上下文筛选器或显式筛选器。

ALLSELECTED 函数获取表示查询中所有行和列的上下文，同时保留显式筛选器以及行和列筛选器之外的上下文。 此函数可用于获取查询中的直观合计。

参数:
tableName 使用标准 DAX 语法的现有表的名称。 此参数不能是表达式。 此参数可选。

columnName 使用标准 DAX 语法的现有列的名称，通常是完全限定的名称。 它不能是表达式。 此参数可选。

返回值:
没有任何列和行筛选器的查询的上下文。

```
两 (2) 个先前的筛选器已应用于 Reseller Sales 数据；一个应用于 Sales Territory Group = Europe，另一个应用于 Promotion Type = Volume Discount。

define
measure 'Reseller Sales'[Reseller Sales Amount]=sum('Reseller Sales'[Sales Amount])
measure 'Reseller Sales'[Reseller Grand Total]=calculate(sum('Reseller Sales'[Sales Amount]), ALL('Reseller Sales'))
measure 'Reseller Sales'[Reseller Visual Total]=calculate(sum('Reseller Sales'[Sales Amount]), ALLSELECTED())
//CT filters
, 'Sales Territory'[Sales Territory Group]="Europe", 'Promotion'[Promotion Type]="Volume Discount"

```

## SUMX


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
SUMX的计算原理是逐行运算，如果数据量特别大，这种方式对内存的消耗比较严重，使用这种方式候需要慎重

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

## DAY

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

## MONTH 
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

## EOMONTH

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

## DATESINPERIOD 

```
DATESINPERIOD(<dates>,<start_date>,<number_of_intervals>,<interval>)
```

datesinperiod

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

## DATESBETWEEN

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

## WEEKDAY 

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

## DATESMTD 

```
DATESMTD(<dates>)
```
datesmtd

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

## SWITCH

```
SWITCH(<expression>, <value>, <result>[, <value>, <result>]…[, <else>])
```

参数:
expression 任何返回单个标量值的 DAX 表达式，其中，表达式将计算多次（针对每行/上下文）。

value 要与 expression 的结果匹配的常量值。

result 当 expression 的结果与对应的 value 匹配时，要进行计算的任何标量表达式。

else 当 expression 的结果与任何 value 参数不匹配时，要进行计算的任何标量表达式。

返回值:
来自其中一个 result 表达式的标量值（如果与 value 有匹配），或者来自 else 表达式（如果与任何 value 都不匹配）的标量值。

根据值列表计算表达式，并返回多个可能的结果表达式之一。

```

昨日数据_用户 = 
SWITCH (
    TRUE (),
    SELECTEDVALUE ( '用户'[用户指标] ) = "新增访客数", BLANK(),
    SELECTEDVALUE ( '用户'[用户指标] ) = "访客数", BLANK(),
    SELECTEDVALUE ( '用户'[用户指标] ) = "累计访客总数", BLANK(),
    SELECTEDVALUE ( '用户'[用户指标] ) = "新增交易用户数", [昨日_新增交易用户数],
    SELECTEDVALUE ( '用户'[用户指标] ) = "交易用户数", [昨日_交易用户数],
    SELECTEDVALUE ( '用户'[用户指标] ) = "累计交易用户数", [累计_交易用户数],
    0
)
```
```
=SWITCH([Month], 1, "January", 2, "February", 3, "March", 4, "April"
               , 5, "May", 6, "June", 7, "July", 8, "August"
               , 9, "September", 10, "October", 11, "November", 12, "December"
               , "Unknown month number" )
```

IF和SWITCH的对比，可以用SWITCH函数替换嵌套IF函数

IF(<logical_test>,<value_if_true>, value_if_false)

SWITCH(<logical_test>, TRUE(), <value_if_true>, value_if_false)。

```
IF FUNCTION = 
IF(EXPRESSION = 1,
    A,
    IF(EXPRESSION = 2,
        B,
        IF(EXPRESSION =3,
            C,
            IF(EXPRESSION = 4,
            D
            )
        )
    )
)
```

```
SWITCH FUNCTION= 
SWITCH (
    EXPRESSION,
    1,A,
    2,B,
    3,C,
    4,D
)
```

如果IF内的判断条件有大小

```
IF (EXPRESSION>1,
    A,
    IF(EXPRESSION>2,
    B,
    C
    )
)
```

```
SWITCH(
    TRUE(),
    EXPRESSION>1,A,
    EXPRESSION>2,B,
    C,
    
```

```
IF的公式如下：

=IF('入职'[入职年限]<1," 1年以内",

IF('入职'[入职年限]<3," 1-3年",

IF('入职'[入职年限]<5," 3-5年",

IF('入职'[入职年限]<10," 5-10年",

"10年以上"))))

对于这种基于某个区间的判断，我们可以使用SWITCH加TRUE来实现：
SWITCH加TRUE(布尔表达式)

=SWITCH(
TRUE(),
'入职'[入职年限]<1," 1年以内",
'入职'[入职年限]<3," 1-3年",
'入职'[入职年限]<5," 3-5年",
'入职'[入职年限]<10," 5-10年",
"10年以上")

```

## ADDCOLUMNS
```
ADDCOLUMNS(<table>, <name>, <expression>[, <name>, <expression>]…)
```
将计算列添加到给定的表或表的表达式中。

参数

table 任何返回数据表的 DAX 表达式。

name 给予此列的名称，包含在双引号内。

expression 返回标量表达式且针对 table 的每行进行计算的任何 DAX 表达式。

返回值

具有所有原始列和添加列的表。

```
ADDCOLUMNS(ProductCategory, 
               , "Internet Sales", SUMX(RELATEDTABLE(InternetSales_USD),InternetSales_USD[SalesAmount_USD])
               , "Reseller Sales", SUMX(RELATEDTABLE(ResellerSales_USD),ResellerSales_USD[SalesAmount_USD]))
```
```
VAR SparklineTable = ADDCOLUMNS(
    SUMMARIZE('merchant','merchant_'[日期]),
        "X",INT(110 * DIVIDE()),
        "Y",INT(50 * DIVIDE()))
```

## SUMMARIZE

```
SUMMARIZE(<table>, <groupBy_columnName>[, <groupBy_columnName>]…[, <name>, <expression>]…)
```

参数

table 任何返回数据表的 DAX 表达式。

groupBy_columnName（可选）现有列的限定名称，将使用该列中找到的值创建摘要组。 此参数不能是表达式。

name 给予总计或汇总列的名称，包含在双引号内。

expression 任何返回单个标量值的 DAX 表达式，其中，表达式将计算多次（针对每行/上下文）。

返回值
其中包含 groupBy_columnName 参数的选定列和由名称参数设计的汇总列的表。

```
 SUMMARIZE('merchant','merchant'[日期])
```

```
返回围绕此日历年和产品类别名称分组的分销商销售额，通过此结果表可以按年度和产品类别分析分销商销售额。
SUMMARIZE(ResellerSales_USD
      , DateTime[CalendarYear]
      , ProductCategory[ProductCategoryName]
      , "Sales Amount (USD)", SUM(ResellerSales_USD[SalesAmount_USD])
      , "Discount Amount (USD)", SUM(ResellerSales_USD[DiscountAmount])
      )
```

https://docs.microsoft.com/zh-cn/previous-versions/sql/sql-server-2014/gg492171(v=sql.120)

## CONCATENATE

```
CONCATENATE(<text1>, <text2>)
```

参数

text1, text2 要联接为单个文本字符串的文本字符串。字符串可以包括文本或数字。还可以使用列引用。

返回值 串联的字符串。

# 上下文
- 上下文是需要了解的重要 DAX 概念之一。 DAX 中有两种上下文类型；行上下文和筛选上下文。 

- “行上下文”可被视为“当前行”。如果创建了计算列，则行上下文由每个单独行中的值以及与当前行相关的列中的值组成。 还有一些函数（EARLIER和EARLIEST）可从当前行获取值，然后在对整个表执行操作时使用该值。

- “筛选上下文”是根据筛选约束（已应用于行或由公式中的筛选表达式定义）而允许在每列中存在的值集。可以将筛选器上下文视为：决定结果或值的计算中**所应用的一个或多个筛选器。**
- 筛选器:FILTER,ALL,ALLEXCEPT等
