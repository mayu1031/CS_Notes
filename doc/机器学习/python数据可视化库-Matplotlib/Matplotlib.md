# Matplotlib
- [1Matplotlib工具](#1Matplotlib工具)
    - [1什么是matplotlib工具]
    - [2为什么要学习matplotli工具]
    - [3常见图形种类及意义]
    - [4实现一个简单的matplotlib画图]
    - [5matplotlib三层结构]
        - [1容器层]
        - [2辅助显示层]  
        - [3图像层]
        
- [2折线图plot与基础绘图功能]  
    - [2.1plot折线图绘制与保存图片]
        - [2.1.1matplotlib.pyplot模块]
        - [2.1.2折线图的绘制与显示]
        - [2.1.3设置画布的属性与保存图片]
    - [2.2完善原始折线图1辅助显示层]
        - [2.2.1准备数据并画出初始折线图]
        - [2.2.2添加xy刻度即范围] 
        - [2.2.3添加字符串]
        - [2.2.4如何解决中文显示问题]
        - [2.2.5添加网格]
        - [2.2.6添加x轴y轴描述信息标题]
    - [2.3完善原始折线图2图像层]
        - [2.3.1多次plot画两个城市]
        - [2.3.2颜色修改，线条修改]
        - [2.3.3显示图例]  
    - [2.4subplot多个坐标系显示] 
    - [2.5折线图的应用场景]
        - [2.5.1绘制数学函数图像]
- [3scatter散点图]
    - [3.1散点图应用场景]
- [4bar柱状图] 
    - [4.1柱状图应用场景]
- [5histogramhist直方图] 
    - [5.2直方图绘制]
    - [5.3直方图注意点]  
    - [5.4直方图的应用场景]
- [6pie饼图]
    - [6.1饼图api介绍]
    - [6.2饼图应用场景]

![思维导图](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/Matplotlib%E6%80%BB%E7%BB%93.png)

# 1Matplotlib工具

## 1什么是matplotlib工具

- 专门用于开发2D图表（包括3D图表，画二维图表的python库
    - mat matrix 矩阵
        - 二维数据 - 二维图表
    - plot 画图
    - lib library
- matplotlib可以绘制折线图，散点图，柱状图，直方图，饼图
- 使用起来很简单
- 以渐进，交互方式实现数据可视化


## 2为什么要学习matplotli工具
- 可视化是在整个数据挖掘的关键辅助工具，可以清晰的理解数据，从而调整分析方法
    - 能将数据进行可视化，更直观的呈现
    - 使数据更加客观，更具有说服力
    - 帮助理解数据，方便选择更合适的分析方法
- js库 -D3 echarts 可实现更酷炫的3D效果
- 奥卡姆剃刀原理 如无必要不要增加实体

## 3常见图形种类及意义
- 折线图 plot： 以折线的上升或者下降来表示统计数量的增减变化的统计图
    - 特点：能够显示数据的变化趋势，反映事物的变化情况
- 散点图 scatter： 用两组数据构成多个坐标点，考察坐标点的分布，判断两变量之间是否存在某种关联或总结坐标点的分布模式
    - 特点：判断变量之间是否存在数量关联趋势，展示离群点（分布规律）
- 柱状图 bar：排列在工作表的列或行中的数据可以绘制到柱状图中
    - 特点：绘制连离散的数据，能够一眼看出各个数据的大小，比较数据之间的差别（统计/对比）
- 直方图 histogram： 由一系列高度不等的纵向条纹或线段表示数据分布的情况。一般横轴表示数据范围，纵轴表示分布情况
    - 特点：绘制连续性的数据展示一组或多组数据的分布情况（统计）
- 饼图 pie：用来表示不同分类的占比情况，通过弧度大小来对比各种分类
    - 特点： 分类数据的占比情况（占比）

## 4实现一个简单的matplotlib画图


```python
#导包，把pyplot重新命名plt
import matplotlib.pyplot as plt 
%matplotlib inline
#%matplotlib具体作用是当你调用matplotlib.pyplot的绘图函数plot()进行绘图的时候，或者生成一个figure画布的时候，可以直接在你的python console里面生成图像
# figure 创建一个画布 准备添加数据
plt.figure()
# 两个参数 plot 传的第一个参数是横坐标x，第二个参数是纵坐标y
plt.plot([1,0,9],[4,5,6])
# 呈现结果
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_1_0.png)


## 5matplotlib三层结构
### 1容器层
容器层主要是Canvas，Figure，Axes组成。
画板层，画布层，绘图区(坐标系)
- Canvas是位于最底层的系统层，用户一般接触不到，在绘图的过程中充当画板的角色，即放置画布figure的工具。
- figure画布层，是Canvas上方的第一层，也是需要用户来操作的应用层的第一层，在绘图的过程中充当画布的角色。
- Axes是应用层的第二层，在绘图的过程中相当于画布上绘图区的角色。
    - figure：指整个图形，可以通过plt.figure()设置画布的大小和分辨率
    - axes(坐标系)： 数据的绘图区域
    - axis(坐标轴)：坐标系中的一条轴，包含大小限制，刻度和刻度标签
    - plt.subplots() 创建多个绘图区，每个绘图区都有坐标轴
- 特点：
    - 一个figure画布可以包含多个axes(坐标系/绘图区)，但是一个axes只能属于一个figure
    - 一个axes(坐标系/绘图区) 可以包含多个axis(坐标轴)，包含两个为2点坐标系，包含3个为3d坐标系
    
### 2辅助显示层  
- 辅助显示层为axes(绘图区)内的除了根据数据绘制出来的图像外的内容  
- 主要包括axes外观facecolor，边框线spines，坐标轴axis 
- 修改x，y轴刻度 plt.x/yticks(), 坐标轴刻度标签tick_label
- 添加描述信息 添加x轴，y轴描述信息 plt.x/ylabel(); 添加标题 plt.title()
- 添加网格 plt.grid()
- 显示图例 plt.legend()
- 这层的设置可使图像显示更加直观更加容易被用户理解，但又不会对图像产生实质的影响。
 
- 注意不同api的用法
    x_label = ["11点{}分".format(i) for i in x]    
    axes[0].set_xticks(x[::5])  
    axes[0].set_xticklabels(x_label)  
    axes[0].set_yticks(range(0,40,5))  
    axes[0].set_xlabel("时间")  
    axes[0].set_ylabel("温度")  
    axes[0].set_title("上海，中午11点到12点之间的温度变化图示：")

### 3图像层
- 图像是指axes内通过plot，scatter，bar，histogram，pei等函数根据数据描绘出的图像  
- 可以设置图像颜色，风格，标签

# 2折线图plot与基础绘图功能        
- 用figure实现创建绘画图的大小
- 应用plot实现折线图的绘制
- 应用savefig实现图形的本地保存
- 应用xticks，yticks实现axes的刻度设置和标注 添加字符串
- 知道如何解决中文显示问题
- 用grid实现网格
- x轴y轴的标题，以及整个图的标题 xlabel ylabel title
- 应用legend实现图形标注信息显示
- 应用plt.subplots实现多坐标系的创建
- 知道折线图的应用场景


## 2.1plot折线图绘制与保存图片
### 2.1.1matplotlib.pyplot模块

- mathplotlib.pyplot包含类一系列类似于matlab的画图函数
- 他的函数作用于当前图形figure的当前坐标系axes


```python
import matplotlib.pyplot as plt
```

### 2.1.2折线图的绘制与显示


```python
# 显示上海一周的天气，从星期一到星期日的天气温度如下
## 创建画布
plt.figure()
## 绘制图像 两个参数，前一个x，后一个是y
plt.plot([1,2,3,4,5,6,7],[17,17,18,15,11,11,13])
## 显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_7_0.png)


### 2.1.3设置画布的属性与保存图片
- figsize: 指定图的长度,画布大小
- dpi: 图像的清晰度 dot per inch
- plt.savefig(path): 保存图像
```
plt.figure(figsize=() ,dpi)
    figsize: 指定图的长度,画布大小
    dpi： 图像的清晰度 dot per inch
    返回fig对象
plt.savefig(path)
```


```python
### 折线图的绘制与显示
## 创建画布 dpi图像清晰度dot per inch
plt.figure(figsize=(20,8),dpi=80)
## 绘制图像 两个参数，前一个x，后一个是y
plt.plot([1,2,3,4,5,6,7],[17,17,18,15,11,11,13])
# 保存图像 保存在当前目录下 
plt.savefig("test.png")
## 显示图像
plt.show()
## 注意 plt.show()会释放figure资源，如果在显示图像之后保存图片将只能保存空白图片
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_9_0.png)


## 2.2完善原始折线图1辅助显示层
- 需求： 画出某城市11点到12点1小时内每分钟的温度变化折线图，温度范围在15-18之间 x轴60分钟
- 准备数据并画出初始折线图
- 准备数据
    - x = range(60)
- 绘制图像
- 显示图像
### 2.2.1准备数据并画出初始折线图


```python
import random
import matplotlib.pyplot as plt
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]

plt.figure(figsize = (20,8), dpi = 80)
plt.plot(x, y_shanghai)
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_11_0.png)


### 2.2.2添加xy刻度即范围 
- plt.xticks(x,**kwargs)
    - x: 要显示的刻度值  **kwargs: 为需要的说明
- plt.yticks(y,**kwargs)
    - y: 要显示的刻度值


```python
import random
import matplotlib.pyplot as plt
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]

plt.figure(figsize = (20,8), dpi = 80)
# 绘制图像
plt.plot(x, y_shanghai)
# y刻度
plt.yticks(range(40)) # 0-39
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_13_0.png)


- 0到39每隔5步


```python
import random
import matplotlib.pyplot as plt
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]

plt.figure(figsize = (20,8), dpi = 80)
# 绘制图像
plt.plot(x, y_shanghai)
# y刻度
plt.yticks(range(0,40,5)) #0到39每隔5
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_15_0.png)


- x轴改成每隔5步


```python
import random
import matplotlib.pyplot as plt
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]

plt.figure(figsize = (20,8), dpi = 80)
# 绘制图像
plt.plot(x, y_shanghai)
# 修改x，y刻度
plt.xticks(range(0,60,5)) #改成每隔5步
plt.xticks(x[::5]) #改成每隔5步 第二种表达方式
plt.yticks(range(40)) # 0-39
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_17_0.png)


### 2.2.3添加字符串
- 构造x轴刻度标签 
- x_ticks_label  plt.xticks(x[::5],x_ticks_label[::5]) 和plt.xticks() 结合在一起
- 构造y轴刻度
- y_ticks_label


```python
import random
import matplotlib.pyplot as plt
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]

plt.figure(figsize = (20,8), dpi = 80)
# 绘制图像
plt.plot(x, y_shanghai)
# 修改x，y刻度
# 准备x的刻度说明 需要和x轴刻度一致 每5步跳一次 一一对应
x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
# 每隔5步一跳
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_19_0.png)


### 2.2.4如何解决中文显示问题
 - 加两行代码就能满足x_label里面有中文 
    - plt.rcParams['font.sans-serif'] = [u'SimHei']  
    - plt.rcParams['axes.unicode_minus'] = False 


```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
### 加两行代码就能满足x_label里面有中文

x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]

plt.figure(figsize = (20,8), dpi = 80)
# 绘制图像
plt.plot(x, y_shanghai)
# 修改x，y刻度
# 准备x的刻度说明
x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
# 每隔5步一跳
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_21_0.png)


### 2.2.5添加网格
- 默认True，意思是默认添加网格，linestyle网格风格，alpha透明度
- plt.grid(True, linestyle ='--', alpha=0.5)


```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)
plt.plot(x, y_shanghai)
x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])
#显示表格 linestyle网格风格，alpha透明度
plt.grid(True, linestyle='--',alpha=0.5)
plt.show()
```


![png](https://github.com/mayu1031/CS_Notes/blob/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_23_0.png)


### 2.2.6添加x轴y轴描述信息标题
- plt.xlabel("时间")
- plt.ylabel("温度")
- plt.title("中午11点到12点之间的温度变化图示：")


```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]
plt.figure(figsize = (20,8), dpi = 80)
plt.plot(x, y_shanghai)
x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.grid(True, linestyle='--',alpha=0.5)
# 添加描述信息
plt.xlabel("时间")
plt.ylabel("温度")
plt.title("中午11点到12点之间的温度变化图示：")
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_25_0.png)


## 2.3完善原始折线图2图像层
- 应用legend实现图形标注信息显示
    - 应用plt.subplots实现多坐标系的创建
    - 知道如何设置多个axes的标题，刻度
    - 知道折线图的应用场景
    
### 2.3.1多次plot画两个城市
- 再添加一个城市的温度变化
- 调用两个plot
- 收集到北京当天温度变化情况，温度在1度到3度


```python
# 收集到北京当天温度变化情况，温度在1度到3度
y_beijing = [random.uniform(1,3) for i in x]
y_beijing # 这样y北京就出来
```




    [2.1205726419989164,
     1.8934073838629872,
     2.5706503755881593,
     2.1709212308912242,
     1.0581781295877508,
     1.2568329383533408,
     2.9603423849249504,
     1.8338943906118657,
     1.8456159438547486,
     1.913006604932971,
     2.4098012354672607,
     2.241713199047719,
     2.6795081061261965,
     2.2970107007451936,
     2.2921797698878157,
     1.6554547972582576,
     2.684700410245715,
     1.3209288011154492,
     2.9745261995518977,
     1.946854132233927,
     1.9753100662397178,
     1.601755138204033,
     1.4847131276274261,
     2.070460933854136,
     2.909074882235907,
     2.0778150479290263,
     2.0915986847957164,
     1.1707520574924686,
     1.94069748947722,
     2.591593042117587,
     1.7229750912401456,
     2.4225277829576415,
     2.8322600862228224,
     1.4053104572041353,
     1.2492276755572724,
     1.4424893721532812,
     1.1525194654530007,
     2.237041969274136,
     1.0349827453260072,
     1.8046271920081562,
     2.504341410393897,
     1.660497027910922,
     2.962668864348123,
     2.8422176926235534,
     1.2369187414414762,
     1.4976485672693078,
     1.2155097364918186,
     2.166714932701452,
     1.7279223510852995,
     1.2714648167062705,
     2.1835781689061244,
     2.0139083288551665,
     2.5046646180567596,
     1.4547103509867954,
     1.787534776112113,
     2.3973205421635555,
     2.397418905307868,
     1.886696699972007,
     2.6052076236700703,
     2.9204541532112485]




```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)

##### 两个城市，一个北京一个上海
y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

plt.figure(figsize = (20,8), dpi = 80)

##### 多次用plot，画两个折线图
plt.plot(x, y_shanghai)
plt.plot(x, y_beijing)

#### 画刻度以及刻度标识 
x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.grid(True, linestyle='--',alpha=0.5)


plt.xlabel("时间")
plt.ylabel("温度")
plt.title("北京和上海，中午11点到12点之间的温度变化图示：")
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_28_0.png)


### 2.3.2颜色修改，线条修改
- plt.plot(x, y_shanghai, color="r", linestyle="--")
- plt.plot(x, y_beijing, color = 'b')

- 颜色字符
    - r 红色， g绿色， b蓝色， w白色， c青色，m洋红，y黄色， k黑色
- 风格字符
    - -实线， --虚线，-.点划线，：点虚线，''留空，空格


```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)

y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

plt.figure(figsize = (20,8), dpi = 80)

##### 修改折线的颜色和形式
plt.plot(x, y_shanghai, color="r", linestyle="--")
plt.plot(x, y_beijing, color = 'b', linestyle = "-.")

x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.grid(True, linestyle='--',alpha=0.5)
plt.xlabel("时间")
plt.ylabel("温度")
plt.title("北京和上海，中午11点到12点之间的温度变化图示：")
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_31_0.png)


## 2.3.3显示图例  
- 不仅要在图像层修改，也要在辅助显示层修改显示图例
- 图例的位置 Location String   Location Code
    - plt.legend(loc="best")
    - best        0
    - upper right 1
    - upper left  2
    - lower left  3
    - lower right 4
    - right       5
    - center left 6  
- plt.plot(x, y_shanghai, color="r", linestyle="--",label="上海")  ##只在图像层进行修改
- plt.plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")  
- plt.legend()  ##辅助显示层也要进行修改


```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)

y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

plt.figure(figsize = (20,8), dpi = 80)

plt.plot(x, y_shanghai, color="r", linestyle="--",label="上海")
plt.plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")

### 显示图例
plt.legend()

x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.grid(True, linestyle='--',alpha=0.5)
plt.xlabel("时间")
plt.ylabel("温度")
plt.title("北京和上海，中午11点到12点之间的温度变化图示：")
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_33_0.png)



```python
#### 图例的位置
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)

y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

plt.figure(figsize = (20,8), dpi = 80)

plt.plot(x, y_shanghai, color="r", linestyle="--",label="上海")
plt.plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")

### 显示图例,以及图例的位置
plt.legend(loc="center left")

x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.grid(True, linestyle='--',alpha=0.5)

plt.xlabel("时间")
plt.ylabel("温度")
plt.title("北京和上海，中午11点到12点之间的温度变化图示：")
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_34_0.png)



```python
#### 图例的位置,也可以用location code
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
x = range(60)

y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

plt.figure(figsize = (20,8), dpi = 80)

plt.plot(x, y_shanghai, color="r", linestyle="--",label="上海")
plt.plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")

### 显示图例,以及图例的位置
plt.legend(loc=5)

x_ticks_label = ["11点{}分".format(i) for i in x]  
y_ticks = range(40) 
plt.xticks(x[::5],x_ticks_label[::5])  
plt.yticks(y_ticks[::5])  
plt.grid(True, linestyle='--',alpha=0.5)

plt.xlabel("时间")
plt.ylabel("温度")
plt.title("北京和上海，中午11点到12点之间的温度变化图示：")
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_35_0.png)


## 2.4subplot多个坐标系显示 
- plt.subplots 面向对象的画图方法
- 将上海和北京的天气图显示在同一图的不同坐标系中
- matplotlib.pyplot.subplots(nrows=1,ncols=1,**fig_kw)
    - 创建一个带有多个axes(坐标系/绘图区)的图
    - 返回两个对象 return：fig 图对象 ax： set_xticks, set_yticks, set_xlabel, set_ylabel
    - **fig_kw 图像大小的设置
    
- 之前都是面向过程，所以用plt就可以了
- 现在是面向对象，所以就要用到创造好的实例对象里面的方法
- plt.函数名()相当于面对过程的画图方法，axes.set_方法名()相当于面向对象的画图方法  
  figure,axes = plt.subplots(nrows=1,ncols=2,**fig_kw) #一行两列   
  axes[0]  
  axws[1]


```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
#1. 准备数据 x，y
x = range(60)
##### 两个城市，一个北京一个上海
y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

#2.创建画布，这里需要修改，没有创建绘图区，之前默认只有一个绘图区
#plt.figure(figsize = (20,8), dpi = 80)
#返回两个对象，一个是figure，一个是绘图区  这里是一行两列 axes[0],axes[1]
figure,axes = plt.subplots(nrows=1,ncols=2,figsize=(20,8),dpi=80)

#3.绘制图像
#需要修改，改成绘图区对象的方法
##### 多次用plot，画两个折线图，这里改成axes
#plt.plot(x, y_shanghai, color="r", linestyle="--",label="上海")
#plt.plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")

axes[0].plot(x, y_shanghai, color="r", linestyle="--",label="上海")
axes[1].plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")


#4.显示图例,以及图例的位置
#plt.legend(loc=5)
axes[0].legend()
axes[1].legend()

x_ticks_label = ["11点{}分".format(i) for i in x]  

#plt.xticks(x[::5],x_ticks_label[::5])  
#plt.yticks(range[0:40:5]) 

axes[0].set_xticks(x[::5],x_ticks_label[::5])  
axes[0].set_yticks(range(0,40,5))
axes[1].set_xticks(x[::5],x_ticks_label[::5])  
axes[1].set_yticks(range(0,40,5)) 

# 需要刻度说明的api axes[0].set_xticklabels(x_ticks_label[::5])

#plt.grid(True, linestyle='--',alpha=0.5)
axes[0].grid(True, linestyle='--',alpha=0.5)
axes[1].grid(True, linestyle='--',alpha=0.5)

# 添加描述信息
#plt.xlabel("时间")
#plt.ylabel("温度")
#plt.title("北京和上海，中午11点到12点之间的温度变化图示：")

axes[0].set_xlabel("时间")
axes[0].set_ylabel("温度")
axes[0].set_title("上海，中午11点到12点之间的温度变化图示：")

axes[1].set_xlabel("时间")
axes[1].set_ylabel("温度")
axes[1].set_title("北京，中午11点到12点之间的温度变化图示：")

plt.show()

```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_37_0.png)



```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
#1. 准备数据 x，y
x = range(60)
##### 两个城市，一个北京一个上海
y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

#2.创建画布，这里需要修改，没有创建绘图区，之前默认只有一个绘图区
#plt.figure(figsize = (20,8), dpi = 80)
#返回两个对象，一个是figure，一个是绘图区
figure,axes = plt.subplots(nrows=1,ncols=2,figsize=(20,8),dpi=80)

#3.绘制图像
#需要修改，改成绘图区对象的方法
##### 多次用plot，画两个折线图，这里改成axes
#plt.plot(x, y_shanghai, color="r", linestyle="--",label="上海")
#plt.plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")

axes[0].plot(x, y_shanghai, color="r", linestyle="--",label="上海")
axes[1].plot(x, y_beijing, color = 'b', linestyle = "-.",label="北京")


#4.显示图例,以及图例的位置
#plt.legend(loc=5)
axes[0].legend()
axes[1].legend()

x_ticks_label = ["11点{}分".format(i) for i in x]  

#plt.xticks(x[::5],x_ticks_label[::5])  
#plt.yticks(range[0:40:5]) 

###这个如果没有x_label[::5] 可以对比下 一个密集，一个不密集
axes[0].set_xticks(x[::5]) 
##刻度也需要调整 查找api
axes[0].set_xticklabels(x_ticks_label[::5])
axes[0].set_yticks(range(0,40,5))
axes[1].set_xticks(x[::5]) 
axes[1].set_xticklabels(x_ticks_label[::5])
axes[1].set_yticks(range(0,40,5)) 


#axes[0].set_xticks(x[::5],x_ticks_label[::5])  
#axes[0].set_yticks(range(0,40,5))
#axes[1].set_xticks(x[::5],x_ticks_label[::5])  
#axes[1].set_yticks(range(0,40,5))



#plt.grid(True, linestyle='--',alpha=0.5)
axes[0].grid(True, linestyle='--',alpha=0.5)
axes[1].grid(True, linestyle='--',alpha=0.5)

# 添加描述信息
#plt.xlabel("时间")
#plt.ylabel("温度")
#plt.title("北京和上海，中午11点到12点之间的温度变化图示：")

axes[0].set_xlabel("时间")
axes[0].set_ylabel("温度")
axes[0].set_title("上海，中午11点到12点之间的温度变化图示：")

axes[1].set_xlabel("时间")
axes[1].set_ylabel("温度")
axes[1].set_title("北京，中午11点到12点之间的温度变化图示：")

plt.show()

```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_38_0.png)


## 2.5折线图的应用场景
- 呈现公司产品（不同区域）每天活跃用户数
- 呈现app每天下载数量
- 呈现产品新功能上线后，用户点击次数随时间的变化
- 拓展，画各种数学函数图
- 某一个事物，指标随时间的变化状况
### 2.5.1绘制数学函数图像


```python
import numpy as np
# 1 准备x，y数据
x = np.linspace(-1,1,1000)
y = 2 * x * x
# 2 创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3 绘制图像
plt.plot(x,y)
#添加网格
plt.grid(linestyle='--',alpha=0.5)
# 4 显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_40_0.png)


# 3scatter散点图
- 散点图 scatter： 用两组数据构成多个坐标点，考察坐标点的分布，判断两变量之间是否存在某种关联或总结坐标点的分布模式
    - 特点：判断变量之间是否存在数量关联趋势，展示离群点（分布规律


```python
#探究房屋面积和房屋价格的关系
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
# 1.准备数据
x = [225.98, 247.07, 253.14, 457.85, 241.58, 301.01,  20.67, 288.64,
       163.56, 120.06, 207.83, 342.75, 147.9 ,  53.06, 224.72,  29.51,
        21.61, 483.21, 245.25, 399.25, 343.35]

y = [196.63, 203.88, 210.75, 372.74, 202.41, 247.61,  24.9 , 239.34,
       140.32, 104.15, 176.84, 288.23, 128.79,  49.64, 191.74,  33.1 ,
        30.74, 400.02, 205.35, 330.64, 283.45]

# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3.绘制图像
plt.scatter(x,y)
# 4.显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_42_0.png)


## 3.1散点图应用场景
- 探究不同变量之间的内在关系

# 4bar柱状图 
- 柱状图 bar：排列在工作表的列或行中的数据可以绘制到柱状图中
    - 特点：绘制连离散的数据，能够一眼看出各个数据的大小，比较数据之间的差别（统计/对比）
- bar
- matplotlib.pyplot.bar(x,y,width,align='center',**kwargs)  
- parameters:  
    - x: sequence of scalars.  
    - width: scalar or arrary-like,optional  
        - 柱状图的宽度  
    - aligh: {'center','edge'}, optional, default:'center'  
    - alignment of the bars to the x coordinate:  
    -'center': center the base on the x position.  
    - 'edge': Align the left edges of the bars with the x postion.  
    - 每个柱状图的位置对齐方式  

    - **kwargs:  
    - color: 选择柱状图的颜色  

- return:  
    - '.BarContainer'  
    - Container with all the bars and optionally errorbars.



```python
#对比每部电影的票房收入
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
# 1.准备数据
movie_names = ['雷神3：诸神黄昏','正义联盟','东方快车谋杀案','寻梦环游记','全球风暴', '降魔传','追捕','七十七天','密战','狂兽','其它']
tickets = [73853,57767,22354,15969,14839,8725,8716,8318,7916,6764,52222]
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3.绘制柱状图 
# 修改x的刻度
plt.bar(range(len(movie_names)),tickets)
# 4.显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_45_0.png)



```python
import random
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False

movie_names = ['雷神3：诸神黄昏','正义联盟','东方快车谋杀案','寻梦环游记','全球风暴', '降魔传','追捕','七十七天','密战','狂兽','其它']
tickets = [73853,57767,22354,15969,14839,8725,8716,8318,7916,6764,52222]

plt.figure(figsize=(20,8),dpi=80)

x_ticks = range(len(movie_names))
#图像层 在bar函数内修改颜色
plt.bar(x_ticks,tickets,color = ['b','r','g','y','c','m','y','k','c','g','b'] )
# 修改刻度线 
# 第一个参数是要显示的x刻度  第二个参数添加说明
plt.xticks(x_ticks, movie_names)
# 添加标题
plt.title("电影票房收入对比")
# 添加网格显示
plt.grid(linestyle = '--', alpha = 0.5)
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_46_0.png)



```python
# 对比相同天数的票房
# 为了公平起见，我们需要对比不同电影首日和首周的票房
# 1.准备数据
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
movie_name = ['雷神3：诸神黄昏','正义联盟','寻梦环游记']
first_day = [10587.6,10062.5,1275.7]
first_weekend=[36224.9,34479.6,11830]
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3.绘制柱状图
# 现在一个列表有两个柱状图
x_ticks = range(len(movie_name))
plt.bar(x_ticks, first_day)
plt.bar(x_ticks, first_weekend)

plt.xticks(x_ticks,movie_name)
# 4.显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_47_0.png)



```python
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
movie_name = ['雷神3：诸神黄昏','正义联盟','寻梦环游记']
first_day = [10587.6,10062.5,1275.7]
first_weekend=[36224.9,34479.6,11830]
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3.绘制柱状图
# 现在一个列表有两个柱状图
x_ticks = range(len(movie_name))

# 添加宽度，以及列表生成式
# 图像层添加label 添加图例
plt.bar(x_ticks, first_day,width=0.2, label='首日票房')
plt.bar([i+0.2 for i in x_ticks], first_weekend,width=0.2,label='首周票房')

# 显示图例，要让label显示出来，要画出来
plt.legend()

# 修改刻度
plt.xticks([i+0.1 for i in x_ticks],movie_name)

plt.grid(linestyle='--',alpha=0.5)
plt.title("不同电影首日和首周的票房")
# 4.显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_48_0.png)


## 4.1柱状图应用场景
- 数量统计
- 用户数量对比分析

# 5histogramhist直方图 
- 直方图 histogram： 由一系列高度不等的纵向条纹或线段表示数据分布的情况。一般横轴表示数据范围，纵轴表示分布情况
    - 特点：绘制连续性的数据展示一组或多组数据的分布情况（统计）
- 直方图，形状类似柱状图却有着和柱状图完全不同的含义。直方图牵涉统计学的概念，首先要对数据进行分组，然后统计每个分组内数据元的数量。在坐标系中，横轴标出每个组的端点，纵轴表示频数，每个矩形的高代表相对应的频数，称这样的统计图为频数分布直方图
- 组数，在统计数据时，我们把数据按照不同的范围分成几个组，分成的组的个数称为组数
- 组距，每一组两个端点的差
- 根据组距，计算组数
    - 最高175.5 最矮150.5 组距 5
        组数：（175.5-150.5）/5 =5
## 5.1柱状图和直方图对比
- 柱状图是以矩形的长度表示每一组的频数或数量，其宽度(表示类别)则是固定的，利于较小的数据集分析
- 直方图描述的是一组数据的频次分布，是以矩形的长度表示每一组的频数或数量，宽度则表示各种的组距，因此其高度与宽度均有意义，利于展示大量数据集的统计结果  


- 直方图展示数据的分布，柱状图比较数据的大小
- 直方图x表示定量数据，柱状图x轴为分类数据
- 直方图柱子无间隔，柱状图柱子有间隔
- 直方图柱子宽度可不一，柱状图柱子宽度必须一致

## 5.2直方图绘制
- matplotlib.pyplot.hist(x,bins=None,density=None,**kwargs)

- Parameters:  
    - x:(n,) array or sequence of (n,) arrays
        - x就是这组数据
    - bins: integer or sequence or 'auto', optional
        - bins代表组数
    - density = None 是否显示频率

- 绘制
    - 设置组距
    - 设置组数（通常对于数据较少的情况，分为5-12组，数据较多的，更换图形显示方式）
        - 通常设置组数会有相应公式：组数 = 极差/组距 = (max-min)/组距


```python
#电影时长的分布情况
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
# 1.获取数据
# x = time
# bins 组数 = (max(time)-min(time))/剧组
time = [131,  98, 125, 131, 124, 139, 131, 117, 128, 108, 135, 138, 131, 102, 107, 114, 119, 128, 121, 142, 127, 130, 124, 101, 110, 116, 117, 110, 128, 128, 115,  99, 136, 126, 134,  95, 138, 117, 111,78, 132, 124, 113, 150, 110, 117,  86,  95, 144, 105, 126, 130,126, 130, 126, 116, 123, 106, 112, 138, 123,  86, 101,  99, 136,123, 117, 119, 105, 137, 123, 128, 125, 104, 109, 134, 125, 127,105, 120, 107, 129, 116, 108, 132, 103, 136, 118, 102, 120, 114,105, 115, 132, 145, 119, 121, 112, 139, 125, 138, 109, 132, 134,156, 106, 117, 127, 144, 139, 139, 119, 140,  83, 110, 102,123,107, 143, 115, 136, 118, 139, 123, 112, 118, 125, 109, 119, 133,112, 114, 122, 109, 106, 123, 116, 131, 127, 115, 118, 112, 135,115, 146, 137, 116, 103, 144,  83, 123, 111, 110, 111, 100, 154,136, 100, 118, 119, 133, 134, 106, 129, 126, 110, 111, 109, 141,120, 117, 106, 149, 122, 122, 110, 118, 127, 121, 114, 125, 126,114, 140, 103, 130, 141, 117, 106, 114, 121, 114, 133, 137,  92,121, 112, 146,  97, 137, 105,  98, 117, 112,  81,  97, 139, 113,134, 106, 144, 110, 137, 137, 111, 104, 117, 100, 111, 101, 110,105, 129, 137, 112, 120, 113, 133, 112,  83,  94, 146, 133, 101,131, 116, 111,  84, 137, 115, 122, 106, 144, 109, 123, 116, 111,111, 133, 150]
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3.绘制直方图
distance = 2
group_num = int((max(time) - min(time)) / distance)
plt.hist(time,bins = group_num)

# 显示刻度，修改x轴刻度
plt.xticks(range(min(time),max(time)+2,distance))


plt.grid(linestyle='--', alpha=0.5)

plt.title("电影时长的分布情况")
plt.xlabel("电影时长大小")
plt.ylabel("电影的数据量")
# 4.显示图像
plt.show()

```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_51_0.png)



```python
#电影时长的分布情况
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
# 1.获取数据
# x = time
# bins 组数 = (max(time)-min(time))/剧组
time = [131,  98, 125, 131, 124, 139, 131, 117, 128, 108, 135, 138, 131, 102, 107, 114, 119, 128, 121, 142, 127, 130, 124, 101, 110, 116, 117, 110, 128, 128, 115,  99, 136, 126, 134,  95, 138, 117, 111,78, 132, 124, 113, 150, 110, 117,  86,  95, 144, 105, 126, 130,126, 130, 126, 116, 123, 106, 112, 138, 123,  86, 101,  99, 136,123, 117, 119, 105, 137, 123, 128, 125, 104, 109, 134, 125, 127,105, 120, 107, 129, 116, 108, 132, 103, 136, 118, 102, 120, 114,105, 115, 132, 145, 119, 121, 112, 139, 125, 138, 109, 132, 134,156, 106, 117, 127, 144, 139, 139, 119, 140,  83, 110, 102,123,107, 143, 115, 136, 118, 139, 123, 112, 118, 125, 109, 119, 133,112, 114, 122, 109, 106, 123, 116, 131, 127, 115, 118, 112, 135,115, 146, 137, 116, 103, 144,  83, 123, 111, 110, 111, 100, 154,136, 100, 118, 119, 133, 134, 106, 129, 126, 110, 111, 109, 141,120, 117, 106, 149, 122, 122, 110, 118, 127, 121, 114, 125, 126,114, 140, 103, 130, 141, 117, 106, 114, 121, 114, 133, 137,  92,121, 112, 146,  97, 137, 105,  98, 117, 112,  81,  97, 139, 113,134, 106, 144, 110, 137, 137, 111, 104, 117, 100, 111, 101, 110,105, 129, 137, 112, 120, 113, 133, 112,  83,  94, 146, 133, 101,131, 116, 111,  84, 137, 115, 122, 106, 144, 109, 123, 116, 111,111, 133, 150]
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)
# 3.绘制直方图
distance = 2
group_num = int((max(time) - min(time)) / distance)
### 显示的是频率 density，不是频数
plt.hist(time,bins = group_num,density = True)

# 显示刻度，修改x轴刻度
plt.xticks(range(min(time),max(time)+2,distance))

plt.grid(linestyle='--', alpha=0.5)
plt.title("电影时长的分布情况")
plt.xlabel("电影时长大小")
plt.ylabel("电影的频率")
# 4.显示图像
plt.show()

```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_52_0.png)


## 5.3直方图注意点  
- 注意组距
    - 组距会影响直方图呈现出来的数据分布，因此在绘制直方图的时候需要多次尝试改变组距
- 注意y轴所代表的变量
    - y轴上的变量可以是频次（数据出现多少次），频率（频次/总次数），频率/组距，不同的变量会让直方图描述的数据分布意义不同
    
## 5.4直方图的应用场景
- 用于表示一组数据的分布情况
- 通过直方图还可以观察和估计哪些数据比较集中，异常或者孤立的数据分布在何处
    - 比如年龄分布，商品价格分布

# 6pie饼图
- 饼图 pie：用来表示不同分类的占比情况，通过弧度大小来对比各种分类
    - 特点： 分类数据的占比情况（占比）
- 饼图广泛的应用在各个领域，用于表示不同分类的占比情况，通过弧度大小来对比各种分类。饼图通过将一个圆饼按照分类的占比划分成多个区域，整个圆饼代表数据的总量，每个区块（圆弧）表示该分类占总体的比例大小，所有区块（圆弧）的加和等于100%
## 6.1饼图api介绍
- 注意显示的百分比的位数
- plt.pie(x,label=,autopct=,colors)
    - x：数量，自动算百分比
    - labels：每部分名称
    - autopct：占比显示指定 %1.2f%% print('%1.2f%%') 输出浮点数%f，%ff%%，后面两个%第一个代表百分号 第二个代表转义字符 .2保留两位 1占一个位置
    - colors：每部分颜色
- 为了让显示的饼图保持圆形，需要添加axis保证长宽一样
    - plt.axis('equal')
    


```python
#电影排片占比
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = [u'SimHei']
plt.rcParams['axes.unicode_minus'] = False
# 1.准备数据
movie_names = ['雷神3：诸神黄昏','正义联盟','东方快车谋杀案','寻梦环游记','全球风暴','降魔传','追捕','七十七天','密战','狂兽','其它']
#排片的数量
place_count = [60605,54546,45819,28243,13270,9945,7679,6799,6101,4621,20105]
# 2.创建画布
plt.figure(figsize=(20,8), dpi=80)
# 3.绘制饼图
plt.pie(place_count,labels=movie_names,autopct="%1.2f%%",colors = ['b','r','g','y','c','m','y','k','c','g','y'])
#为了让显示的饼图保持圆形
plt.axis('equal')
plt.legend()  ## plt里面已经有labels了
# 4.显示图像
plt.show()
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E6%95%B0%E6%8D%AE%E5%8F%AF%E8%A7%86%E5%8C%96%E5%BA%93-Matplotlib/output_55_0.png)


## 6.2饼图应用场景
- 分类的占比情况（不超过9个分类）
例如：班级男女分布占比，公司销售额占比
