# 用excel分析黑五销售数据
## 背景 
黑五类似于中国的双11，是美国厂家发起的年底之前的最大规模的促销打折活动。美国圣诞节大采购一般是从感恩节之后开始的。感恩节是每年11月的第四个星期四。因此它的第二天，也就是美国人大采购的第一天。在这一天，美国的商场都会推出大量的打折和优惠活动，以在年底进行最后一次大规模的促销。因为美国的商场一般以红笔记录赤字，以黑笔记录盈利，而感恩节后的这个星期五人们疯狂的抢购使得商场利润大增，因此被商家们称作黑色星期五。商家期望通过以这一天开始的圣诞大采购为这一年获得最多的盈利。

## 数据来源
- http://link.zhihu.com/?target=https%3A//www.kaggle.com/mehdidag/black-friday

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

### 数据重新命名

因为获取的消息名称为英文，为了方便的理解和描述数据，我们首先把数据信息改成中文

![1](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/1.jpg)

为了测试是否有空缺数据和重复数据，我们建立新的一列，由用户编码和产品编码组成

![2](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/2.jpg)

查找空缺数据

![3](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/3.png)

查找重复数据

![4](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/4.png)

很幸运，这组数据没有空缺数据也没有重复数据

### 数据格式处理
为了方便理解，我们将性别：F替换成女 M替换成男

![5](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/5.jpg)

婚姻状况: 0替换成未婚 1替换成已婚

![6](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/6.jpg)

## 分析数据

###人们的购物水平差异，哪一类产品更受人们喜欢，以及最受欢迎的商品是哪些

![7](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/7.jpg)

![8](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/8.jpg)

图表中为此次消费中，购买次数最多TOP10产品，其中最受欢迎的产品是P00265242

![9](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/9.jpg)

![10](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/10.jpg)

图表中为此次消费中，购买金额最多的TOP10产品，其中最受欢迎的是P00025442

我们可以发现，购买次数和购买金额最多的并不是同一件产品，从两张图表中，我们应该分析产品需求的价格和数量的关系；有些产品虽然购买的人多，但是单价不高，所以导致销售额不是最高，有些产品单价高，虽然销售额高，但是购买人数不是最多的。我们应该从中多挖掘各个产品的特点，为下一次销售制定更好的销售方针。

### 三个城市购物水平差异

![11](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/11.jpg)

此次消费中，三个城市中男性都是主力消费群体。

![12](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/12.jpg)

![13](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/13.jpg)

### 男性和女性购买力的差异

消费人数：

删除一人购买多个产品的重复数据，选定列表用户编码-数据-删除重复值

![14](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/14.png)

![15](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/15.png)

![16](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/16.jpg)

该次消费中，男性消费人数占总比72%

女性消费人数占总比28%，男性消费人数是女性消费人数2.6倍左右。

消费金额：

![17](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/17.jpg)

![18](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/18.jpg)

该次消费中，男性消费者的消费总金额和平均个人消费金额都是高于女性消费者的。商家应该深入女性消费者群体中，从消费者的收入和支出角度出发，调查女性消费者心理活动以及她们偏爱的产品，刺激女性消费。

![19](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/19.jpg)

![20](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/20.jpg)

最受男女消费者喜爱，购买数最多的商品都是P00265242。我们可以着手分析为什么产品P00265242皆是男女最喜爱的产品，分析产品特点，为以后的产品推广找到方向。

### 各个职业的购买力差异

![21](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/21.jpg)

女性0职业购买力最强

![22](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/22.jpg)

男性4职业购买力最强

![23](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/23.jpg)

![24](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/24.jpg)

整体职业4的购买力最强，职业8的购买力最柔

我们可以分析职业4的特点，为什么从事职业4的人购买力是最强的，是因为收入最高，还是因为职业偏好。

### 各个年龄段的购买力差异

![25](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/25.jpg)

![26](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/26.jpg)

此次消费中，26-35的年龄段购买力最强 占总的消费群体的40% 0-17的年龄段购买力最弱

26-53年龄段消费能力最强，我们要考虑是人们的收入和消费欲望。

### 在城市呆的年限是否影响人们的购买力

![27](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/27.jpg)

![28](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/28.jpg)

在一个城市住1年时间的购买力最强 少于一年的购买力最弱

### 婚姻状况是否对人们的购买力产生影响

![29](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E9%BB%91%E4%BA%94excel/29.jpg)

未婚的购物能力最强。我们要考虑是不是因为结婚之后，人们有了储蓄存钱的习惯，购买欲下降；在未婚的情况下，人们的购买欲是不是会更强一些。考虑开拓市场的时候，是不是可以加强家庭用品方面的宣传和产品投入，来刺激已婚人群的购买欲望。
