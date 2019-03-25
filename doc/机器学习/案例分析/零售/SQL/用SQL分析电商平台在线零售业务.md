# 用SQL分析电商平台在线零售业务
## 背景
一般来说，电子商务数据集是公司专有的，所以很难在公开的数据集中找到。在UCI机器学习库中，包含了这个从2010年到2011年实际交易的数据集。在UCI的官网中维护该数据集，我们可以通过搜寻'Online Retail'关键词来找到这个数据集。

这是一个跨国数据集，包含类2010年1月12号到2011年12月9号之间，在英国注册非实体店在线零售业务中发生的所有交易。这家公司主要销售特色礼物，很多的客户都是该公司的批发商。
## 数据来源
该数据来源 kaggle
https://www.kaggle.com/carrie1/ecommerce-data
## 数据信息
本段数据集为：541909 * 8 列

InvoiceNo：发票号，每笔交易产生一个6位编码，退货订单的编码以C开头的7位编码

StockCode：产品代码，每个产品都有自己的编码

Description：产品描述

Quantity：数量，每次交易产品的数量

InvoiceDate：发票日期，每笔交易产生的时间

UnitPrice：商品单价，单位英镑

CustomerID：消费者编码，每个客户都为5位编码

Country：国家名字，消费者所在国家/地区的名字

## 提出问题
- 一共有多少客户，客户分别来自哪些国家，哪个国家客户最多
- 一共有多少订单，订单分别来自哪些国家，哪个国家订单最多
- 哪个国家的销售最高
- 最畅销的商品是哪些，以及销售最高的是那个商品
- 国家畅销的产品
- 哪个月的销售额最高
- 退货率最高的商品
- 哪个国家的退货率最高

## 清洗数据
### 原始数据
![1](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/1.png)
### 删除缺失值
CustomerID 存在缺失数据，删除缺失数据 

删除空白CustomerID数据行之后，剩余406829行数据

使用的方方格子插件，批量删除，选中CustomerID列，删除空行/列

### 处理日期
日期数据处理，将原有的时间这列分成 日期和时间两列

利用数据-分列，把时间处理为月/日/年

![excel表格](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/excel%E8%A1%A8%E6%A0%BC.png)

## 分析数据

保存数据格式为cvs，把数据导入MySQL中

创建一个新的数据库 EcommerceData，导入向导

![2](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/2.png)

调整格式

![3](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/3.png)

导入之后的表格
![4](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/4.png)

```sql
SELECT COUNT(*)
FROM `data`
```
![5](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/5.png)

一共有406829条数据

### 一共有多少客户，客户分别来自哪些国家，哪个国家客户最多

```sql
SELECT COUNT(DISTINCT (Country)) as '国家个数'
FROM data
```
![6](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/6.png)

客户一共来自37个国家

```sql
SELECT COUNT(DISTINCT (CustomerID)) as '客户人数'
FROM data
```
![7](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/7.png)
客户人数一共有4372人

```sql
SELECT Country as '国家', COUNT(DISTINCT (CustomerID)) as '客户人数', CONCAT(ROUND(COUNT(DISTINCT (CustomerID))/(SELECT COUNT(DISTINCT CustomerID) FROM `data`),2)*100,'%') as '占总人数比列'
FROM
`data`
GROUP BY Country
ORDER BY COUNT(DISTINCT (CustomerID)) DESC
LIMIT 5
```
![8](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/8.png)

英国本土的顾客占比达到90%，剩下一部分客户在德国，法国等

本数据集中，一共有来自37个国家的4372位顾客，其中90%的来自United Kingdom

### 一共有多少订单，订单分别来自哪些国家，哪个国家订单最多

```sql
SELECT Country as '国家', COUNT(DISTINCT (InvoiceNo)) as '订单数目', CONCAT(ROUND(COUNT(DISTINCT (InvoiceNo))/(SELECT COUNT(DISTINCT (InvoiceNo)) FROM data)*100,2),'%') AS '占总订单的比例'
FROM
data
GROUP BY Country
ORDER BY COUNT(DISTINCT (InvoiceNo)) DESC
LIMIT 5
```
![10](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/10.png)

United Kingdom的订单是最多的，占到总订单的89%

```sql
SELECT COUNT(DISTINCT InvoiceNo) AS '总订单数' FROM data
```
![11](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/11.png)

在所有订单中，全世界有22190个订单，订单量最多的是United Kingdom，约占总订单量的89.49%。

### 哪个国家的销售最高
```sql
SELECT Country AS ‘国家’, COUNT(StockCode) AS '销售的产品次数', CONCAT(ROUND(COUNT(StockCode)/(SELECT COUNT(StockCode)FROM data )*100,2),'%') AS '占总消费次数的比例'
FROM data
GROUP BY Country
ORDER BY COUNT(StockCode) DESC
LIMIT 10
```
![12](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/12.png)

United Kingdom顾客的消费次数是最多的，占到总订单的88.95%，其次是德国，法国等

```sql
SELECT Country AS ‘国家’, ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额', CONCAT(ROUND(SUM(UnitPrice*Quantity)/(SELECT SUM(UnitPrice*Quantity)FROM data )*100,2),'%') AS '占总消费金额的比例'
FROM data
GROUP BY Country
ORDER BY SUM(UnitPrice*Quantity) DESC
LIMIT 10
```
![13](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/13.png)

United Kingdom顾客的消费次数是最多的，占到总订单的81.54%，其次是Netherlands，EIRE等

### 最畅销的商品是哪些，以及销售最高的是那个商品
```sql
SELECT StockCode AS '产品代码', Country AS '国家',Description AS '产品描述',SUM(Quantity) AS '销售总次数',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
GROUP BY StockCode
ORDER BY SUM(Quantity) DESC
LIMIT 10
```
![14](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/14.png)

图片中，显示的是所有产品中，销量最高的前十产品，其中最高的是84077

前十的产品描述分别为： 

WORLD WAR 2 GLIDERS ASSTD DESIGNS

SMALL POPCORN HOLDER

JUMBO BAG RED RETROSPOT

ASSORTED COLOUR BIRD ORNAMENT

WHITE HANGING HEART T-LIGHT HOLDER

PACK OF 72 RETROSPOT CAKE CASES

RABBIT NIGHT LIGHT

MINI PAINT SET VINTAGE 

PACK OF 12 LONDON TISSUES 

PACK OF 60 PINK PAISLEY CAKE CASES

```sql
SELECT StockCode AS '产品代码', Country AS '国家',Description AS '产品描述',SUM(Quantity) AS '销售总次数',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
GROUP BY StockCode
ORDER BY SUM(UnitPrice*Quantity) DESC
LIMIT 10
```
![15](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/15.png)

图片中，显示的是所有产品中，销售额最高的前十产品，其中最高的是22423

前十的产品描述：

REGENCY CAKESTAND 3 TIER

WHITE HANGING HEART T-LIGHT HOLDER

JUMBO BAG RED RETROSPOT

PARTY BUNTING

POSTAGE

ASSORTED COLOUR BIRD ORNAMENT

RABBIT NIGHT LIGHT

PICNIC BASKET WICKER SMALL

CHILLI LIGHTS

PAPER CHAIN KIT 50'S CHRISTMAS 

不管是从销量还是销售额的角度看，从描述中，热门产品大部分具有装饰，灯架，玩具特点

### 国家畅销的产品
```sql
SELECT StockCode AS '产品代码', Country AS '国家',Description AS '产品描述',SUM(Quantity) AS '销售量',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
GROUP BY Country,StockCode 
ORDER BY SUM(Quantity) DESC
```
![16](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/16.png)

```sql
SELECT StockCode AS '产品代码',Description AS '产品描述',SUM(Quantity) AS '销售量',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
WHERE Country = 'United Kingdom'
GROUP BY StockCode 
ORDER BY SUM(Quantity) DESC
limit 10
```
![17](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/17.png)

对比所有产品销售量之后，United Kingdom本地的销量一起绝尘，其中销售量最高的是84077

排名前10销售量的产品的单价都比较低

```sql
SELECT StockCode AS '产品代码',Description AS '产品描述',SUM(Quantity) AS '销售量',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
WHERE Country = 'United Kingdom'
GROUP BY StockCode 
ORDER BY SUM(UnitPrice*Quantity) DESC
limit 10
```
![18](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/18.png)

上图为United Kingdom销售金额前10的产品，销售额最高的产品是22423

排名前10销售额的产品的单价除了第一位之外都比较低

#### 我们取几个销售金额比较大的国家进行比较

- Germany
- 销售量
```sql
SELECT StockCode AS '产品代码',Description AS '产品描述',SUM(Quantity) AS '销售量', UnitPrice AS '单价',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
WHERE Country = 'Germany'
GROUP BY StockCode 
ORDER BY SUM(Quantity) DESC
limit 10
```
![19](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/19.png)

销售量10的产品，单价依次为2.95，0.75，18，0.85，0.55，1.25，1.95，1.65，1.45，0.04；大部分的价格较低

- 销售额
```sql
SELECT StockCode AS '产品代码',Description AS '产品描述',SUM(Quantity) AS '销售量', UnitPrice AS '单价',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
WHERE Country = 'Germany'
GROUP BY StockCode 
ORDER BY SUM(UnitPrice*Quantity) DESC
limit 10
```
![20](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/20.png)

销售额前10的产品，单价依次为18，12.75，2.95，2.95，1.95，1.65，8.5，1.65，1.65，2.55；除了第一个和第二个价格相对较高之外，剩下的价格都较低

- France
- 销售量
```sql
SELECT StockCode AS '产品代码',Description AS '产品描述',SUM(Quantity) AS '销售量', UnitPrice AS '单价',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
WHERE Country = 'France'
GROUP BY StockCode 
ORDER BY SUM(Quantity) DESC
limit 10
```
![21](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/21.png)

销售量前10的产品几乎价格都比较低

- 销售额
```sql
SELECT StockCode AS '产品代码',Description AS '产品描述',SUM(Quantity) AS '销售量', UnitPrice AS '单价',ROUND(SUM(UnitPrice*Quantity),2) AS '销售的金额'
FROM data
WHERE Country = 'France'
GROUP BY StockCode 
ORDER BY SUM(UnitPrice*Quantity) DESC
limit 10
```
![22](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/22.png)

销售额前10的产品，除了第一个和第三个价格相对较高之外，剩下的价格都较低

- 销售量靠前的产品一般具有单价较低的特点，同样从销售额角度看，大部分也是价格较低的商品排在前列

### 哪个月的销售额最高
销售额

```sql
SELECT DATE_FORMAT(invoicedate,'%Y-%m') AS '日期',ROUND(SUM(quantity*unitprice),2) AS'销售额', count(DISTINCT InvoiceNo) AS '订单数'
FROM data
GROUP BY DATE_FORMAT(invoicedate,'%Y-%m')
ORDER BY SUM(quantity*unitprice) DESC
```

![23](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/23.png)


订单量

```sql
SELECT DATE_FORMAT(invoicedate,'%Y-%m') AS '日期',ROUND(SUM(quantity*unitprice),2) AS'销售额', count(DISTINCT InvoiceNo) AS '订单数'
FROM data
GROUP BY DATE_FORMAT(invoicedate,'%Y-%m')
ORDER BY SUM(InvoiceNo) DESC
```
![24](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/24.png)

不管从销售量还是销售额的角度看，都是11年11月的数据最高，其次是11年10月，此时靠近黑五和感恩节，我们可以假定销售量和销售额是受到节日的影响

### 退货率

退货率

可侧面表达单店服务\商品质量\商品价格的指标等

#### 国家退货率
这里退货率，我们用的退货总量/出货总量

出货总量不需要考虑退货的数量，只需要计算quantity大于0的所有总和

实际卖出的货品量=出货总量-退货总量

```sql
SELECT C1.country as '国家', CONCAT(ROUND(C1.c1/C2.c2*(100),2),'%') as '退货率'
	FROM (
		SELECT country,SUM(ABS(quantity)) AS c1
			FROM data
			WHERE InvoiceNo like 'C%'
			GROUP BY country
				) AS C1,
			 (
    SELECT country,SUM(quantity) AS c2
			FROM data
			WHERE Quantity > 0
			GROUP BY country
				) AS C2
WHERE C1.country = C2.country AND C1.c1!= 0
ORDER BY ROUND(C1.c1/C2.c2*(100),2) DESC
LIMIT 10
```
![25](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/25.png)

图上显示的退货率最高的10个国家，厂家应该考虑不同国家对产品要求和需求的不同

#### 客户个人退货率
```sql
SELECT C1.CustomerID as '客户', CONCAT(ROUND(C1.c1/C2.c2*(100),2),'%') as '退货率'
FROM
(
		SELECT CustomerID,SUM(ABS(quantity)) AS c1
			FROM data
			WHERE InvoiceNo like 'C%'
			GROUP BY CustomerID
				) AS C1 ,
(
    SELECT CustomerID,SUM(quantity) AS c2
			FROM data
			WHERE Quantity > 0
			GROUP BY CustomerID
				) AS C2 
WHERE C1.CustomerID = C2.CustomerID AND C1.c1!= 0
ORDER BY ROUND(C1.c1/C2.c2*(100),2) DESC
LIMIT 10
```
![26](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/26.png)

图上显示的退货率最高的10个客户，其中ID为17900的客户，退货率达到了98.63%

#### 商品自身退货率

```sql
SELECT C1.StockCode as '商品', C1.Description AS '产品描述',CONCAT(ROUND(C1.c1/C2.c2*(100),2),'%') as '退货率'
FROM
(
		SELECT StockCode,Description,SUM(ABS(quantity)) AS c1
			FROM data
			WHERE InvoiceNo like 'C%'
			GROUP BY StockCode
				) AS C1 ,
(
    SELECT StockCode,Description,SUM(quantity) AS c2
			FROM data
			WHERE Quantity > 0
			GROUP BY StockCode
				) AS C2 
WHERE C1.StockCode = C2.StockCode AND C1.c1!= 0
ORDER BY ROUND(C1.c1/C2.c2*(100),2) DESC
LIMIT 10
```
![27](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%9B%B6%E5%94%AE/SQL/27.png)

产品 23166 和 产品 85232B 的退货率达到了 95.61% 和 95.15%， 厂家应该反思这两个产品退货率这么高的原因，以及相对应的策略
