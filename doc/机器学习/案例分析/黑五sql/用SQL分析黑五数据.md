# 用SQL分析黑五数据
 
- 之前我们用excel已经初步的处理完数据
- https://github.com/mayu1031/CS_Notes/blob/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/%E7%94%A8excel%E8%BF%9B%E4%B8%80%E6%AD%A5%E5%88%86%E6%9E%90%E9%BB%91%E4%BA%94%E9%94%80%E5%94%AE%E6%95%B0%E6%8D%AE.md

## 数据来源
零售商店提供的数据，反映的是零售商店中进行的交易的样本。零售商希望能更好的了解对于不同商品，消费者不同购买行为，从而通过借助已知的其他变量来预测消费者的购买量。

从另外一个角度，我们也可以预测消费者性别，年龄，甚至可以来预测商品的类别等。

## 提出问题
- 人们的购物水平差异，哪一类产品更受人们喜欢，以及最受欢迎的商品是哪些
- 三个城市购物水平差异
- 各个职业的购买力差异
- 男性和女性的购买力差异
- 各个年龄段的购买力差异
- 在城市呆的年限是否影响人们的购买力
- 婚姻状况是否对人们的购买力产生影响

## 数据清洗

### 数据信息

User_ID：用户编码

Product_ID：产品编码

Gender：性别 （M为男性，F为女性）

Age：年龄（0-17，18-25，26-35，36-45,46-50，51-55，55+ 7种）

Occupation：职业（用数字代表具体职业，一共有20种职业）

City_Category：城市分类（分为三类城市：ABC）

Stay_In_Current_City_Years：在目前城市的居住的年数 （0，1,2，3,4+5种）

Marital_Status：婚姻状况 （0代表未婚，1代表已婚）

Product_Category_1：产品分类为1，不可为空

Product_Category_2：产品分类为2

Product_Category_3：产品分类为3

Purchase：购买金额 （单位为美元）

### 导入SQL

创建新的数据库 blackfriday

导入EXCEL 文件

导入成功后可以查看数据

![1](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/1.png)

## 数据分析

###人们的购物水平差异，哪一类产品更受人们喜欢，以及最受欢迎的商品是哪些
```sql
SELECT
blackfriday.Product_ID AS `商品编码`,
Count(blackfriday.Product_ID) AS `商品销售数量`,
Sum(blackfriday.Purchase) AS `商品销售金额`
FROM
blackfriday
GROUP BY
blackfriday.Product_ID
ORDER BY
`商品销售数量` DESC
LIMIT 0, 10
```
![2](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/2.png)

我们得到销售数量TOP10的商品，其中数量最多的产品是P00265242，一共卖了1858件，销售金额是13983325

```sql
SELECT
blackfriday.Product_ID AS `商品编码`,
Count(blackfriday.Product_ID) AS `商品销售数量`,
Sum(blackfriday.Purchase) AS `商品销售金额`
FROM
blackfriday
GROUP BY
blackfriday.Product_ID
ORDER BY
`商品销售金额` DESC
LIMIT 0, 10
```

![3](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/3.png)
我们得到销售金额TOP10的商品，其中金额最多的产品是P0026442，一共卖了1586件，销售金额为27532426

### 三个城市购物水平差异
```sql
SELECT
blackfriday.City_Category AS `城市`,
Sum(blackfriday.Purchase) AS `商品销售金额`,
CONCAT(ROUND(SUM(blackfriday.Purchase)/(SELECT SUM(blackfriday.Purchase) from blackfriday)* 100,2),'%') AS 占销售额比例
FROM
blackfriday
GROUP BY
blackfriday.City_Category
ORDER BY
`商品销售金额` DESC

```
![4](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/4.png)

三个城市种，B市的购买能力是最强的，占总销售额的41.52%, C市其次，最低的是A市

### 各个职业的购买力差异
```
SELECT
blackfriday.Occupation AS `职业`,
Sum(blackfriday.Purchase) AS `消费金额`
FROM
blackfriday
GROUP BY
blackfriday.Occupation
ORDER BY
`消费金额` DESC
```

![5](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/5.png)

整体职业4的购买力最强，职业8的购买力最柔

#### 分别比较各个职业男女的消费水平
- 女性

```sql
SELECT
blackfriday.Occupation AS `职业`,
Sum(blackfriday.Purchase) AS `消费金额`
FROM
blackfriday
WHERE
blackfriday.Gender = 'M'
GROUP BY
blackfriday.Occupation
ORDER BY
`消费金额` DESC
```
![6](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/6.png)

女性消费者职业0的消费能力最强

- 男性
```sql
SELECT
blackfriday.Occupation AS `职业`,
Sum(blackfriday.Purchase) AS `消费金额`
FROM
blackfriday
WHERE
blackfriday.Gender = 'M'
GROUP BY
blackfriday.Occupation
ORDER BY
`消费金额` DESC
```
![7](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/7.png)

男性消费者职业4的消费能力最强

### 男性和女性的购买力差异
```sql
SELECT
blackfriday.Gender AS `性别`,
Count(DISTINCT(blackfriday.User_ID)) AS '数目',
SUM(blackfriday.Purchase) AS '消费金额',
AVG(blackfriday.Purchase) AS '平均消费金额'
FROM
blackfriday
GROUP BY
blackfriday.Gender
```
![8](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/8.png)

男性消费者平均消费金额高于女性，而消费人数和总消费金额则远超女性消费者
男性占比76.79% 远高于女性的23.32

### 各个年龄段的购买力差异
```sql
SELECT
blackfriday.Age AS `年龄`,
Sum(blackfriday.Purchase) AS `消费金额`
FROM
blackfriday
GROUP BY
blackfriday.Age
ORDER BY
`消费金额` DESC
```
![9](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/9.png)

年龄段在26-35岁段购买力最强，0-17岁段购买力最弱

### 在城市呆的年限是否影响人们的购买力
```sql
SELECT
blackfriday.City_Category AS `居住年限`,
Sum(blackfriday.Purchase) AS `购买金额`
FROM
blackfriday
GROUP BY
blackfriday.City_Category
ORDER BY
`购买金额` DESC
```
![10](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/10.png)

在一个城市住1年时间的购买力最强 少于一年的购买力最弱

### 婚姻状况是否对人们的购买力产生影响
```sql
SELECT
blackfriday.Marital_Status AS `婚姻状况`,
Sum(blackfriday.Purchase) AS `购买金额`
FROM
blackfriday
GROUP BY
blackfriday.Marital_Status
ORDER BY
`购买金额` DESC
```
![11](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/11.png)

未婚人群的购物能力强于已婚人群

## 可视化报告
![1](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%871.JPG)
![2](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%872.JPG)
![3](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%873.JPG)
![4](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%874.JPG)
![5](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%875.JPG)
![6](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%876.JPG)
![7](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%877.JPG)
![8](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%878.JPG)
![9](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%879.JPG)
![10](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8710.JPG)
![11](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8711.JPG)
![12](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8712.JPG)
![13](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8713.JPG)
![14](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8714.JPG)
![15](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8715.JPG)
![16](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94sql/%E5%B9%BB%E7%81%AF%E7%89%8716.JPG)
