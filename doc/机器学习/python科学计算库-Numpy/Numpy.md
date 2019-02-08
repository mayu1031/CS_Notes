# Numpy
- [1Numpy的优势](#1Numpy的优势)
    - [1Numpy介绍](#1Numpy介绍)
    - [2ndarray介绍](#2ndarray介绍)
    - [3ndarray与Python原生list运算效率对比](#3ndarray与Python原生list运算效率对比)
    - [4ndarray的优势](#4ndarray的优势)
- [2认识N维数组ndarray属性](#2认识N维数组ndarray属性)
    - [1ndarray的属性](#1ndarray的属性)
    - [2ndarray的形状](#2ndarray的形状)
    - [3ndarray的类型](#3ndarray的类型)
- [3基本操作](#3基本操作)
    - [1生成数组的方法]()
        - 3.1.1生成0和1的数组
        - 3.1.2从现有数组生成
        - 3.1.3生成固定范围的数组
        - 3.1.4生成随机数组
            - 3.1.4.1均匀分布
            - 3.1.4.2正态分布 
    - [2数组的索引切片](#2数组的索引切片)
    - [3形状的修改](#3形状的修改)
    - [4类型的修改](#4类型的修改)
    - [5数组的去重](#5数组的去重)
- [4ndarray运算](#4ndarray运算)
    - [1逻辑运算](#1逻辑运算)
        - 4.1.1布尔索引
    - [2通用判断函数](#2通用判断函数)
    - [3三元运算符](#3三元运算符)
        - 4.3.1复合逻辑
    - [4统计运算](#4统计运算)
        - 4.4.1统计指标
        - 4.4.2返回最大值最小值所在位置
- [5数组间运算](#5数组间运算)
    - [1数组与数的运算](#1数组与数的运算)
    - [2数组与数组的运算](#2数组与数组的运算)
    - [3广播机制](#3广播机制)
    - [4矩阵运算](#4矩阵运算)
        - 5.4.1什么是矩阵
        - 5.4.2矩阵的乘法预算
- [6合并分割](#6合并分割)
    - [1合并](#1合并)
    - [2分割](#2分割)
- [7IO操作与数据处理](#7IO操作与数据处理)
    - [1Numpy读取](#1Numpy读取)
    - [2如何处理缺失值](#2如何处理缺失值)
        - 7.2.1 什么是缺失值

# 1Numpy的优势
- 高效的运算工具
- numpy的基本操作
    - ndarray.方法()
    - numpy.函数名()
- ndarray运算
    - 逻辑运算
    - 统计运算
    - 数组间运算
- 合并 分割 IO操作 数据处理

## 1Numpy介绍
- 数值计算库
- Numpy(Numerical Python)是一个开源的Python科学计算库，用于快速处理任意维度的数组
    - Numerical 数值化的
- Numpy支持常见的数组和矩阵操作。对于同样的数值计算任务，使用numpy比直接用python要简洁的多
- Numpy使用ndarray对象来处理多维数组 ，该对象是一个快速而灵活的大数据容器。
- NumPy（Numerical Python的简称）是高性能科学计算和数据分析的基础包
    - ndarray，一个具有矢量算术运算和复杂广播能力的快速且节省空间的多维数组
    - 用于对整组数据进行快速运算的标准数学函数（无需编写循环）
    - 用于读写磁盘数据的工具以及用于操作内存映射文件的工具。
    - 线性代数、随机数生成以及傅里叶变换功能。
    - 用于集成由C、C++、Fortran等语言编写的代码的工具。

## 2ndarray介绍
- Numpy的核心数据结构ndarray
- n-任意一个
- d-dimension维度
- array-数组
- NumPy provides an N-dimensional array type, the ndarray, whicn describes a collection of "items" of the same type.
- Numpy提供了一个N维度数组类型ndarray，他描述了相同类型的items的集合
```python
import numpy as np
score = np.array([[80, 89, 86, 67, 79],
                  [78, 97, 89, 67, 81], 
                  [90, 94, 78, 67, 74],
                  [91, 91, 90, 67, 69],
                  [76, 87, 75, 67, 86],
                  [70, 79, 84, 67, 84],
                  [94, 92, 93, 67, 64],
                  [86, 85, 83, 67, 80]])

score
```
```
output:
    array([[80, 89, 86, 67, 79],
           [78, 97, 89, 67, 81],
           [90, 94, 78, 67, 74],
           [91, 91, 90, 67, 69],
           [76, 87, 75, 67, 86],
           [70, 79, 84, 67, 84],
           [94, 92, 93, 67, 64],
           [86, 85, 83, 67, 80]])
```

```python
type(score)
```
```
output:
    numpy.ndarray
```
## 3ndarrary与python原生list运算效率对比
- 从中我们看到ndarray的计算速度要快很多，节约了时间
- 机器学习最大的特点就是大量的数据运算，那么如果没有一个快速的解决方案，那可能现在python也在机器学习领域达不到好的效果
- Numpy专门对ndarray的操作和运算进行了设计，所以数组的存储效率和输入输出性能远优与Python的嵌套列表，数组越大，Numpy的优势就越明显


```python
import random
import time
import numpy as np
# 生成一个大数组
a = []
for i in range(1000000):
    a.append(random.random())
    
# 原生pyhtonlist求和    
t1 = time.time()
sum1 = sum(a)
t2= time.time()
# ndarray求和- 从中我们看到ndarray的计算速度要快很多，节约了时间
- 机器学习最大的特点就是大量的数据运算，那么如果没有一个快速的解决方案，那可能现在python也在机器学习领域达不到好的效果
- Numpy专门对ndarray的操作和运算进行了设计，所以数组的存储效率和输入输出性能远优与Python的嵌套列表，数组越大，Numpy的优势就越明显
b = np.array(a)
t3 = time.time()
sum2 = np.sum(b)
t4 = time.time()

print(t2-t1,t4-t3)
```
```
output:
    0.0060045719146728516 0.0010476112365722656
```    

## 4ndarray的优势
- 存储风格
    - ndarry 数据相同类型，通用性不强；ndarray在存储数据的时候，数据与数据的地址都是连接的，这样就使得批量操作数组元素时速度更快
    - list 数据可以不同类型 通用性强；python原生数组只能通过寻址的方式找到下一个元素，在科学计算中，Numpy的ndaary可以省去很多循环语句，代码使用方面比Python原生list要简单的多
- 并行化运算
    - ndarray支持并行化运算，向量化运算
- 底层语言
    - Numpy底层使用c语言编写，内部解除类GIL(全局解释器锁)，其对数组的操作速度不受Python解释器的限制，效率远高于纯Python代码

# 2认识N维数组ndarray属性

## 1ndarray的属性
- 数组属性反映了数组本身固有的信息
    - **ndarray.shape** 数组维度的元组
        - ndarray.ndim  数组维度
        - ndarray.size  数组中元素数量
    - **ndarray.dtype** 数组元素的类型 所占内存的大小
        - ndarray.itemsize 一个数组元素的长度(字节)


```python
import numpy as np
score = np.array([[80, 89, 86, 67, 79],
                  [78, 97, 89, 67, 81], 
                  [90, 94, 78, 67, 74],
                  [91, 91, 90, 67, 69],
                  [76, 87, 75, 67, 86],
                  [70, 79, 84, 67, 84],
                  [94, 92, 93, 67, 64],
                  [86, 85, 83, 67, 80]])
```

```python
score.shape # 元祖的形式，8行5列
```
```
output:
    (8, 5)
```

```python
score.ndim #二维
```
```
output:
    2
```

```python
score.size #40个元素
```
```
output:
    40
```

```python
score.dtype #在创建ndarray的时候，如果没有指定类型，整数默认的int32
```
```
output:
    dtype('int32')
```

```python
score.itemsize # 4个字节
```
```
output:
    4
```

## 2ndarrary的形状   
```python
# 首先创造一些数组
a = np.array([[1,2,3],[4,5,6]])
b = np.array([1,2,3,4])
c = np.array([[[1,2,3],[4,5,6]],[[1,2,3],[4,5,6]]])
```

```python
a # 元祖(2,3) 两行三列 二维 两个中括号
```
```
output:
    array([[1, 2, 3],
           [4, 5, 6]])
```

```python
b # 元祖(4，) 一行四列 一维 一个中括号
```
```
output:
    array([1, 2, 3, 4])
```

```python
c # 元祖(2,2,3) 三维
```
```
output:
    array([[[1, 2, 3],
            [4, 5, 6]],
    
           [[1, 2, 3],
            [4, 5, 6]]])
```
```python
a.shape
```
```
output:
    (2, 3)
```

```python
b.shape
```
```
output:
    (4,)
```

```python
c.shape
```
```
output:
    (2, 2, 3)
```

## 3ndarray的类型  
- type(score.dtype)      
- <type 'numpy.dtype'>  
- dtype是numpy.dtype类型，先看看对于数组来说都有哪些类型 
```
名称                                 描述                                  简写   
np.bool                 用一个字节存储的布尔模型 True/False                  'b'    
np.int8                    一个字节大小， -128至127                         'i'    
np.int16                      整数，-32768至32767                          'i2'  
np.int32                      整数，-2^31至2^32-1                          'i4'  
np.int64                      整数，-2^63至2^63-1                          'i8'  
np.uint8                      无符号整数，0至255                            'u'  
np.uint16                     无符号整数，0至65535                          'u2'  
np.uint32                     无符号整数，0至2^32-1                         'u4'  
np.uint64                     无符号整数，0至2^64-1                         'u8'  
np.float16         半精度浮点数：16位，正负号1位，指数5位，精度10位           'f2'  
np.float32         单精度浮点数：32位，正负号1位，指数8位，精度23位           'f4'  
np.float64         双精度浮点数：64位，正负号1位，指数11位，精度52位          'f8'  
np.complex64           复数，分别用两个32位浮点数表示实部和虚部               'c8'  
np.complex128          复数，分别用两个64位浮点数表示实部和虚部               'c16'  
np.object_                        python对象                               'O'  
np.string_                          字符串                                  'S'  
np.unicode_                       unicode类型                               'U'    
```

- 创建数组的时候指定类型
    - 如果在创建ndarray的时候，没有指定类型，默认整数int32 int64 浮点数默认 float64
    64
    - 常用类型 int32 int64 uint8 float32 float64
- 创建数组的时候指定类型
    - a = np.array([[1,2,3],[2,3,4]],dtype=np.float32)
    - arr = np.array(['acv','adf','qwe','ert'],dtype = np.string) string这种类型不常用


```python
data = np.array([1.1,2.4,6.5])
```

```python
data
```
```
output:
    array([ 1.1,  2.4,  6.5])
```

```python
data.dtype
```
```
output:
    dtype('float64')
```

```python
# 创建数组的时候指定类型
np.array([1.1,2.4,6.5],dtype="float32")
```
```
output:
    array([ 1.10000002,  2.4000001 ,  6.5       ], dtype=float32)
```

```python
np.array([1.1,2.4,6.5],dtype=np.float32)
```
```
output:
    array([ 1.10000002,  2.4000001 ,  6.5       ], dtype=float32)
```
# 3基本操作
- ndarray.方法()
- np.函数名()
    - np.array()
- 看属性的时候表示方法都是元祖，想指定形状的时候既可以是元祖也可以是列表

## 1生成数组的方法
### 3.1.1 生成0和1的数组
- ones(shape[,dtype,order])
    - ones_like(a[,dtype,order,subok])
- zeros(shape[,dtype,order])
    - zeros_like(a[,dtype,order,subok])
    - full(shape,full_value[,dtype,order])
- 生成一组0  
**np.zeros(shape，dtype=)**
- 生成一组1  
**np.ones(shape,dtype=)**

```python
#生成0和1的数组
np.zeros(shape=(3,4),dtype="float32")
```
```
output:
    array([[ 0.,  0.,  0.,  0.],
           [ 0.,  0.,  0.,  0.],
           [ 0.,  0.,  0.,  0.]], dtype=float32)
```
```python
np.ones(shape=[2,4],dtype='int32')
```
```
output:
    array([[1, 1, 1, 1],
           [1, 1, 1, 1]])
```

### 3.1.2 从现有数组中生成
- **array(object[,dtype,copy,order,subok,ndmin])**
- **asarray(a[,dtype,order])**
- **copy(a[,order])**
#### 三者区别
- np.array()和np.copy()是深copy
- np.asarray() 浅copy


```python
import numpy as np
score = np.array([[80, 89, 86, 67, 79],
                  [78, 97, 89, 67, 81], 
                  [90, 94, 78, 67, 74],
                  [91, 91, 90, 67, 69],
                  [76, 87, 75, 67, 86],
                  [70, 79, 84, 67, 84],
                  [94, 92, 93, 67, 64],
                  [86, 85, 83, 67, 80]])
```

```python
# np.array()
data1 = np.array(score)
```

```python
data1
```
```
output:
    array([[80, 89, 86, 67, 79],
           [78, 97, 89, 67, 81],
           [90, 94, 78, 67, 74],
           [91, 91, 90, 67, 69],
           [76, 87, 75, 67, 86],
           [70, 79, 84, 67, 84],
           [94, 92, 93, 67, 64],
           [86, 85, 83, 67, 80]])
```
```python
# np.asarray()
data2 = np.asarray(score)
```
```python
data2
```
```
output:
    array([[80, 89, 86, 67, 79],
           [78, 97, 89, 67, 81],
           [90, 94, 78, 67, 74],
           [91, 91, 90, 67, 69],
           [76, 87, 75, 67, 86],
           [70, 79, 84, 67, 84],
           [94, 92, 93, 67, 64],
           [86, 85, 83, 67, 80]])
```
```python
# np.copy()
data3=np.copy(score)
```

```python
data3
```
```
output:
    array([[80, 89, 86, 67, 79],
           [78, 97, 89, 67, 81],
           [90, 94, 78, 67, 74],
           [91, 91, 90, 67, 69],
           [76, 87, 75, 67, 86],
           [70, 79, 84, 67, 84],
           [94, 92, 93, 67, 64],
           [86, 85, 83, 67, 80]])
```
```python
score[3,1]=10000
```

```python
score
```
```
output:
    array([[   80,    89,    86,    67,    79],
           [   78,    97,    89,    67,    81],
           [   90,    94,    78,    67,    74],
           [   91, 10000,    90,    67,    69],
           [   76,    87,    75,    67,    86],
           [   70,    79,    84,    67,    84],
           [   94,    92,    93,    67,    64],
           [   86,    85,    83,    67,    80]])
```

```python
data1
```
```
output:
    array([[80, 89, 86, 67, 79],
           [78, 97, 89, 67, 81],
           [90, 94, 78, 67, 74],
           [91, 91, 90, 67, 69],
           [76, 87, 75, 67, 86],
           [70, 79, 84, 67, 84],
           [94, 92, 93, 67, 64],
           [86, 85, 83, 67, 80]])
```
```python
data2
```
```
output:
    array([[   80,    89,    86,    67,    79],
           [   78,    97,    89,    67,    81],
           [   90,    94,    78,    67,    74],
           [   91, 10000,    90,    67,    69],
           [   76,    87,    75,    67,    86],
           [   70,    79,    84,    67,    84],
           [   94,    92,    93,    67,    64],
           [   86,    85,    83,    67,    80]])
```
```python
data3
```
```
output:
    array([[80, 89, 86, 67, 79],
           [78, 97, 89, 67, 81],
           [90, 94, 78, 67, 74],
           [91, 91, 90, 67, 69],
           [76, 87, 75, 67, 86],
           [70, 79, 84, 67, 84],
           [94, 92, 93, 67, 64],
           [86, 85, 83, 67, 80]])
```
### 3.1.3 生成固定范围的数组
- **np.linspace(0,10,100)**
    - [0,10]左闭右也闭,等距离生成100个元素
- **np.arange(a,b,c)**
    - [a,b)左闭右开 c是步长


```python
np.linspace(0,10,5)
```
```
output:
    array([  0. ,   2.5,   5. ,   7.5,  10. ])
```

```python
np.arange(0,10,5)
```

```
output:
    array([0, 5])
```


### 3.1.4 生成随机数
#### 3.1.4.1均匀分布
- 均匀分布(Uniform Distribution)是概率统计中的重要分布之一。均匀，表示可能性相等的含义。均匀分布在自然情况下极为罕见，而人工栽培的有一定株行距的植物群落即是均匀分布
- np.random.rand(d0,d1,d2...dn)
    - 返回[0.0,1.0]内的一组均匀分布的数
- **np.random.uniform(low=0.0,high=1.0,size=None)**
    - 功能：从一个均匀分布][low,high]中随机取样，注意定义域是左闭右开，包含low，不包含high
    - 参数介绍
        - low： 采样下界，float类型，default值0
        - high： 采样上界，float类
        型，default值1
        - size： 输出样本数目，为int或元祖(tuple)类型，如size=(m,n,k),则输出mnk个样本，缺省时输出1个值
        - 返回值：ndarray类型，其形状和参数size中描述一致
    

```python
# 生成均匀分布的随机值
data = np.random.uniform(-1,1,10000)
```

```python
data
```

```
output:
    array([ 0.3845108 ,  0.47943764, -0.87134657, ...,  0.70930166,
            0.68327963,  0.17837419])
```

```python
import matplotlib.pyplot as plt
import numpy as np
# 1.收集数据
data = np.random.uniform(-1,1,10000000)
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)

# 3.绘制直方图 1000组数据 数据一共10000个
plt.hist(data,1000)
# 4.显示图像
plt.show()
##落到每个组的个数是一样的
```


![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%BA%93-Numpy/output_54_0.png)


#### 3.1.4.2 正态分布 
- 正态分布图  

![正态分布](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%BA%93-Numpy/%E6%AD%A3%E6%80%81%E5%88%86%E5%B8%83%E5%9B%BE.png) 、

- 正态分布特点  

![正态分布特点](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%BA%93-Numpy/%E6%AD%A3%E6%80%81%E5%88%86%E5%B8%83%E7%89%B9%E7%82%B9.png)

- 方差  
![方差](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%BA%93-Numpy/%E6%96%B9%E5%B7%AE.png)  


- 正态分布Normal distribution是一种概率分布，正态分布是具有两个参数μ和σ的连续型随机变量的分布，第一个参数μ是服从正态分布的随机变量的均值，第二个参数σ是此随机变量的方差，所以正态分布记作N(μ，σ)
- 数学期望μ，方差σ^2，标准差σ。其概率密度函数为正态分布的期望值μ决定了其位置，其标准差σ决定了分布的幅度。当μ = 0,σ = 1时的正态分布是标准正态分布
- μ决定了其位置，σ决定类分布幅度，波动程度， 集中程度，稳定性，离散程度
- 标准差与方差的意义: 可以理解为数据的一个离散程度的衡量
- 面积分布
    - 1、实际工作中，正态曲线下横轴上一定区间的面积反映该区间的例数占总例数的百分比，或变量值落在该区间的概率（概率分布）。不同 范围内正态曲线下的面积可用公式计算。
    - 2、正态曲线下，横轴区间（μ-σ,μ+σ）内的面积为68.268949%。
    - P{|X-μ|<σ}=2Φ（1）-1=0.6826
    - 横轴区间（μ-1.96σ,μ+1.96σ）内的面积为95.449974%。
    - P{|X-μ|<2σ}=2Φ（2）-1=0.9544
    - 横轴区间（μ-2.58σ,μ+2.58σ）内的面积为99.730020%。
    - P{|X-μ|<3σ}=2Φ（3）-1=0.9974
- 正态分布的应用
    - 生活，生产与科学实验中很多随机变量的概率分布可以近似的用正态分布来描述
- 正态分布
    - **np.random.normal(loc=0.0,scale=1.0,size=None)**
    - loc： float 此概率分布的均值（对应着整个分布的中心centre）
    - scale：float 此概率分布的标准差（对应于分布的宽度，scale越大越矮胖，scale越小，越瘦高）
    - size：int or tuple of ints 输出的shape，默认为None，只输出一个值   


```python
# 正态分布
data = np.random.normal(loc=1.75, scale=0.1,size=10000)
```

```python
data
```
```
output:
    array([ 1.73924452,  1.76359136,  1.8194269 , ...,  1.49469393,
            1.78814081,  1.67457965])
```

```python
import matplotlib.pyplot as plt
import numpy as np
# 1.收集数据
data = np.random.normal(loc=1.75, scale=0.1,size=1000000)
# 2.创建画布
plt.figure(figsize=(20,8),dpi=80)

# 3.绘制直方图 1000组数据 数据一共10000个
plt.hist(data,1000)
# 4.显示图像
plt.show()
##落到每个组的个数是一样的
```

![png](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/python%E7%A7%91%E5%AD%A6%E8%AE%A1%E7%AE%97%E5%BA%93-Numpy/output_58_0.png)


## 2数组的索引，切片
#### 案例：随机生成8只股票2周的交易日涨幅数据  
8只股票，两周（10天）的涨跌幅数据，如何获取？
- 两周的交易日数量为 2*5 =10
- 随机生成涨跌幅在某个正态分布内，比如均值0，方差1

##### 股票涨跌幅数据的创建


```python
# 创建符合正态分布的8只股票10天的涨跌幅数据，均值0，标准差σ为1
import numpy as np
stock_change = np.random.normal(loc=0,scale=1,size=(8,10))
```


```python
stock_change 
```
```
output:
    array([[-1.49470397,  0.49131448, -0.01765378,  0.45452142, -0.03897048,
             1.71215084,  1.23002293, -0.42454202,  1.13122617, -1.25827213],
           [-0.73078187,  1.32461256,  0.94498511,  0.48879489,  1.00177302,
             0.18638268, -1.6745243 , -1.25089099, -1.40680954, -0.95260986],
           [ 0.07776257, -0.06785564,  0.19586397,  1.35784963, -0.36883846,
            -0.89310789,  0.24165182, -0.72673975, -0.96448569, -0.60751773],
           [ 0.21022069,  0.94963914, -0.59352159, -0.77626264, -0.45615908,
             2.2003914 , -0.19529245,  0.13798572,  1.53711114, -1.04953609],
           [ 2.67633562, -0.91998229, -0.38635295, -0.89291025, -1.40971435,
            -0.74276204,  0.09596571, -1.0954643 ,  2.23854362, -3.04076067],
           [-1.40263586,  0.26141744,  0.78017096,  0.27131056, -0.6755476 ,
            -1.38407758,  0.13264233, -0.76628042,  0.28210614,  0.06949963],
           [-1.06141077,  0.1687235 ,  1.5048417 , -0.20189765,  1.85944784,
            -0.05954888, -1.22642201,  0.27496701,  0.70225073,  0.56043785],
           [ 1.20853856, -1.08613488,  0.91132549, -0.79233401, -0.75452822,
            -0.88686092, -0.38251026, -0.06599662,  0.56490123,  0.37603254]])

```
```python
# 获取第一支股票的前三个交易日的涨跌幅数据 二维数组
stock_change[0,:3]
```
```
output:
    array([-1.22063896,  2.10688652, -1.10723105])
```
```python
stock_change[0,0:3]
```
```
output:
    array([-1.22063896,  2.10688652, -1.10723105])
```
```python
# 三维数据如何获取
a1 = np.array([ [[1,2,3],[4,5,6]], [[12,3,34],[5,6,7]]])
```

```python
a1 #(2,2,3)
```
```
output:
    array([[[ 1,  2,  3],
            [ 4,  5,  6]],
    
           [[12,  3, 34],
            [ 5,  6,  7]]])
```

```python
a1.shape
```

```
output:
    (2, 2, 3)
```

```python
a1[0,0,:2]
```

```
output:
    array([1, 2])
```

```python
a1[0,0,:2] = 1000
```

```python
a1
```
```
output:
    array([[[1000, 1000,    3],
            [   4,    5,    6]],
    
           [[  12,    3,   34],
            [   5,    6,    7]]])
```
## 3形状修改
- 让刚刚的股票行，日期列反过来，变成日期行，股票列
- **ndarray.reshape(shape[,order])** #返回新的ndarry，只是形状变了，数据没有改变，
     - Returns an array containing the same data with a new shape
- **ndarray.resize(shape)** #没有返回值，对原始数据进行了修改
- **ndarray.T** 转置 行变成列，列变成行


```python
stock_change
```
```
output:
    array([[-1.49470397,  0.49131448, -0.01765378,  0.45452142, -0.03897048,
             1.71215084,  1.23002293, -0.42454202,  1.13122617, -1.25827213],
           [-0.73078187,  1.32461256,  0.94498511,  0.48879489,  1.00177302,
             0.18638268, -1.6745243 , -1.25089099, -1.40680954, -0.95260986],
           [ 0.07776257, -0.06785564,  0.19586397,  1.35784963, -0.36883846,
            -0.89310789,  0.24165182, -0.72673975, -0.96448569, -0.60751773],
           [ 0.21022069,  0.94963914, -0.59352159, -0.77626264, -0.45615908,
             2.2003914 , -0.19529245,  0.13798572,  1.53711114, -1.04953609],
           [ 2.67633562, -0.91998229, -0.38635295, -0.89291025, -1.40971435,
            -0.74276204,  0.09596571, -1.0954643 ,  2.23854362, -3.04076067],
           [-1.40263586,  0.26141744,  0.78017096,  0.27131056, -0.6755476 ,
            -1.38407758,  0.13264233, -0.76628042,  0.28210614,  0.06949963],
           [-1.06141077,  0.1687235 ,  1.5048417 , -0.20189765,  1.85944784,
            -0.05954888, -1.22642201,  0.27496701,  0.70225073,  0.56043785],
           [ 1.20853856, -1.08613488,  0.91132549, -0.79233401, -0.75452822,
            -0.88686092, -0.38251026, -0.06599662,  0.56490123,  0.37603254]])
```

```python
stock_change.shape
```
```
output: 
    (8, 10)
```
```python
stock_change.reshape((10,8)) ##只是将数据重新进行分割
```
```
output:
    array([[-1.49470397,  0.49131448, -0.01765378,  0.45452142, -0.03897048,
             1.71215084,  1.23002293, -0.42454202],
           [ 1.13122617, -1.25827213, -0.73078187,  1.32461256,  0.94498511,
             0.48879489,  1.00177302,  0.18638268],
           [-1.6745243 , -1.25089099, -1.40680954, -0.95260986,  0.07776257,
            -0.06785564,  0.19586397,  1.35784963],
           [-0.36883846, -0.89310789,  0.24165182, -0.72673975, -0.96448569,
            -0.60751773,  0.21022069,  0.94963914],
           [-0.59352159, -0.77626264, -0.45615908,  2.2003914 , -0.19529245,
             0.13798572,  1.53711114, -1.04953609],
           [ 2.67633562, -0.91998229, -0.38635295, -0.89291025, -1.40971435,
            -0.74276204,  0.09596571, -1.0954643 ],
           [ 2.23854362, -3.04076067, -1.40263586,  0.26141744,  0.78017096,
             0.27131056, -0.6755476 , -1.38407758],
           [ 0.13264233, -0.76628042,  0.28210614,  0.06949963, -1.06141077,
             0.1687235 ,  1.5048417 , -0.20189765],
           [ 1.85944784, -0.05954888, -1.22642201,  0.27496701,  0.70225073,
             0.56043785,  1.20853856, -1.08613488],
           [ 0.91132549, -0.79233401, -0.75452822, -0.88686092, -0.38251026,
            -0.06599662,  0.56490123,  0.37603254]])

```
```python
stock_change.shape
```
```
output:
    (8, 10)
```
```python
stock_change.resize((10,8))
```

```python
stock_change.shape
```
```
output:
    (10, 8)
```

```python
stock_change
```
```
output:
    array([[-1.22063896,  2.10688652, -1.10723105, -0.47167461,  1.94301083,
             0.66610931,  0.83099514, -0.08102053],
           [ 0.14871171,  1.63567475, -0.62992741,  1.746166  ,  1.01967608,
             0.08258876,  1.30407741, -0.40510161],
           [-0.92538225, -0.52872856, -0.08808039,  0.24734455, -1.60757201,
             1.23511857, -1.04468359,  0.10238274],
           [ 0.26341435, -0.19277449,  1.20621309,  0.42064235, -1.01526053,
            -0.63289634,  0.24677309,  0.46363607],
           [-0.84379068, -1.32865841,  0.46238094, -1.2343714 ,  1.98728501,
             1.40934018,  0.01360572, -0.75111747],
           [ 1.2358268 ,  1.80735981, -2.05987966,  1.3455604 , -0.22428711,
            -0.73947438, -0.60198434,  0.78965752],
           [ 0.70105989, -0.39709713, -0.47229277, -0.6793393 ,  1.06758332,
            -0.08035104,  1.52690698, -0.85231243],
           [-1.34698312, -0.12437267, -0.62056749, -0.1495915 , -1.07017979,
             0.07461446, -0.61179077,  0.07049211],
           [-1.45097551,  1.00261962, -0.11332372,  0.6691788 ,  0.50299339,
            -0.38189356, -0.76394189,  0.62679221],
           [ 0.26272542,  1.41893386, -1.4490209 ,  0.61199504,  0.1932734 ,
             0.42422995,  0.82107929,  1.01591412]])
```
```python
stock_change.resize((8,10))
```

```python
stock_change
```
```
output:
    array([[-1.22063896,  2.10688652, -1.10723105, -0.47167461,  1.94301083,
             0.66610931,  0.83099514, -0.08102053,  0.14871171,  1.63567475],
           [-0.62992741,  1.746166  ,  1.01967608,  0.08258876,  1.30407741,
            -0.40510161, -0.92538225, -0.52872856, -0.08808039,  0.24734455],
           [-1.60757201,  1.23511857, -1.04468359,  0.10238274,  0.26341435,
            -0.19277449,  1.20621309,  0.42064235, -1.01526053, -0.63289634],
           [ 0.24677309,  0.46363607, -0.84379068, -1.32865841,  0.46238094,
            -1.2343714 ,  1.98728501,  1.40934018,  0.01360572, -0.75111747],
           [ 1.2358268 ,  1.80735981, -2.05987966,  1.3455604 , -0.22428711,
            -0.73947438, -0.60198434,  0.78965752,  0.70105989, -0.39709713],
           [-0.47229277, -0.6793393 ,  1.06758332, -0.08035104,  1.52690698,
            -0.85231243, -1.34698312, -0.12437267, -0.62056749, -0.1495915 ],
           [-1.07017979,  0.07461446, -0.61179077,  0.07049211, -1.45097551,
             1.00261962, -0.11332372,  0.6691788 ,  0.50299339, -0.38189356],
           [-0.76394189,  0.62679221,  0.26272542,  1.41893386, -1.4490209 ,
             0.61199504,  0.1932734 ,  0.42422995,  0.82107929,  1.01591412]])

```
```python
stock_change.T
```
```
output:
    array([[-1.22063896, -0.62992741, -1.60757201,  0.24677309,  1.2358268 ,
            -0.47229277, -1.07017979, -0.76394189],
           [ 2.10688652,  1.746166  ,  1.23511857,  0.46363607,  1.80735981,
            -0.6793393 ,  0.07461446,  0.62679221],
           [-1.10723105,  1.01967608, -1.04468359, -0.84379068, -2.05987966,
             1.06758332, -0.61179077,  0.26272542],
           [-0.47167461,  0.08258876,  0.10238274, -1.32865841,  1.3455604 ,
            -0.08035104,  0.07049211,  1.41893386],
           [ 1.94301083,  1.30407741,  0.26341435,  0.46238094, -0.22428711,
             1.52690698, -1.45097551, -1.4490209 ],
           [ 0.66610931, -0.40510161, -0.19277449, -1.2343714 , -0.73947438,
            -0.85231243,  1.00261962,  0.61199504],
           [ 0.83099514, -0.92538225,  1.20621309,  1.98728501, -0.60198434,
            -1.34698312, -0.11332372,  0.1932734 ],
           [-0.08102053, -0.52872856,  0.42064235,  1.40934018,  0.78965752,
            -0.12437267,  0.6691788 ,  0.42422995],
           [ 0.14871171, -0.08808039, -1.01526053,  0.01360572,  0.70105989,
            -0.62056749,  0.50299339,  0.82107929],
           [ 1.63567475,  0.24734455, -0.63289634, -0.75111747, -0.39709713,
            -0.1495915 , -0.38189356,  1.01591412]])
```
```python
stock_change.T.shape
```
```
output:
    (10, 8)
```
## 4类型修改
- **ndarray.astype(type)**
    - stock_change.astype(np.int32)
- **ndarray.tostring([order])**或者**ndarray.tobyte([order])** ndarray序列化到本地
    - Construct Python bytes containing the raw data bytes in the array
    - arr = np.array([[1,2,3],[4,5,6]],[[12,3,34],[5,6,7]])
    - arr.tostring()


```python
type(stock_change)
```
```
output:
    numpy.ndarray
```

```python
stock_change.dtype
```
```
output:
    dtype('float64')
```
```python
stock_change.astype('int32') # astype(np.int32)   ## 此时并不改变数组自身属性，需要一个变量引导
```
```
output:
    array([[-1,  2, -1,  0,  1,  0,  0,  0,  0,  1],
           [ 0,  1,  1,  0,  1,  0,  0,  0,  0,  0],
           [-1,  1, -1,  0,  0,  0,  1,  0, -1,  0],
           [ 0,  0,  0, -1,  0, -1,  1,  1,  0,  0],
           [ 1,  1, -2,  1,  0,  0,  0,  0,  0,  0],
           [ 0,  0,  1,  0,  1,  0, -1,  0,  0,  0],
           [-1,  0,  0,  0, -1,  1,  0,  0,  0,  0],
           [ 0,  0,  0,  1, -1,  0,  0,  0,  0,  1]])
```
```python
stock_change.tostring()
```
```
output:
    b'no\xa6\xb6\xbc\x87\xf3\xbfp\x07\x8aQ\xe7\xda\x00@\xe7\xcb\x12\xe87\xb7\xf1\xbf\x08\xa3\xd0\xb4\xea/\xde\xbf+\xee%\x85\x92\x16\xff?\x9b\xf0\x8az\xc4P\xe5?\\\xf3\x14!\x83\x97\xea?\x97\xc7\xc3\xe1\xc2\xbd\xb4\xbf\xa0v)5\xfc\x08\xc3?Q\x95\x11H\xb9+\xfa?p(\xb3\x86](\xe4\xbfvoB\xc1K\xf0\xfb?\xb6g\x18\xde\x97P\xf0?\x8b\xf7\x82v\x89$\xb5?\x1fb\xe9F\x80\xdd\xf4?\xa7L1M/\xed\xd9\xbf\x12I\x1c>\xbb\x9c\xed\xbf\x10\xf4\xa5&X\xeb\xe0\xbf\x12\xf3\xe5\xaco\x8c\xb6\xbf>\x87\xa9y\xfc\xa8\xcf?\xee\xf9@n\x9d\xb8\xf9\xbfy\x03g\xb0\x0b\xc3\xf3?\xc1Q\xc4$\x06\xb7\xf0\xbf1I\xfdV\xc15\xba?\xe7\xdfP\xe0\xc7\xdb\xd0?V\xf6\x13\xa3\xd5\xac\xc8\xbf\x9c1\xb9\x19\xa6L\xf3?\xaa\x7f\xda\xe3\xcd\xeb\xda?S\x11\xc9\xd3\x81>\xf0\xbf\x87j\xca\xd4\xaf@\xe4\xbfFw\xa6\xaeB\x96\xcf?\xf5Wg\x9f6\xac\xdd?#\xcd\xd9MU\x00\xeb\xbf\xdfR\x83R/B\xf5\xbfKD\x836\xa6\x97\xdd?V\x1e\xcf:\xfc\xbf\xf3\xbf\xd5\x97\x9b^\xeb\xcb\xff?\x955\xfeH\xa8\x8c\xf6?EZpxP\xdd\x8b?\xb3\xd1\xac~\'\t\xe8\xbf\x8c\xf1\xfeQ\xf2\xc5\xf3?\xff\xd6\x9c\x1d\xf2\xea\xfc?\x9e\xd8@0\xa2z\x00\xc0\xa8\xd2\xb3Wj\x87\xf5?\xbb\xd5\x07\xadp\xb5\xcc\xbf\x1f<~+\xc6\xa9\xe7\xbf\xc5\x0e:\xabtC\xe3\xbf\x8d\xaf\xa3\xd6\xdfD\xe9?\x99m\x11$\x15o\xe6?\xbbA9\x14\nj\xd9\xbf<\'tv\x0b:\xde\xbf[N\xb4\xc3%\xbd\xe5\xbfjL\xe6>\xd2\x14\xf1?\xda1\x19\xc8\xe2\x91\xb4\xbf\xe7\xe6f\x046n\xf8?\xe8k\xa7\xb6$F\xeb\xbf*(\xe3*>\x8d\xf5\xbf;B?\'\xe3\xd6\xbf\xbf\xc1s\x00Y\xb0\xdb\xe3\xbf\xf0/\x9er\xd0%\xc3\xbfx\xe4#\xd8t\x1f\xf1\xbf#\xc3\xc4\xe0\xee\x19\xb3?\xd2\x18G:\xca\x93\xe3\xbf\xfa!nR\xc5\x0b\xb2?V\xf5S\x1927\xf7\xbfd\xe4!\xde\xba\n\xf0?\xe3#\x1a\x87\xc8\x02\xbd\xbf\xfd\xb8-\xa8\xe9i\xe5?\xc1:\xb2\x95\x85\x18\xe0?3\xe1\x9d\xb4\xf1p\xd8\xbf\xb4FrE6r\xe8\xbf\xe4\xb5\x99\x8a\xae\x0e\xe4?6\xb6NK~\xd0\xd0?\xd5\xb1\xc9\xfc\xf3\xb3\xf6?\n\x1c+\x890/\xf7\xbf\x85\xe3"\x9ev\x95\xe3?\x83\xc2\xe2\xce.\xbd\xc8?R@\xbdb\x95&\xdb?\xeb\xac\xd2\x13HF\xea?\x9e\xa87+/A\xf0?'
```
## 5数组的去重
- **ndarray.unique(data)**
- set只适用于一维数据，可以用flatten把数据拍扁之后，再用set
    - **set(data.flatten())**


```python
temp = np.array([[1, 2, 3, 4],[3, 4, 5, 6]])
```
```python
temp
```
```
output:
    array([[1, 2, 3, 4],
           [3, 4, 5, 6]])
```
```python
set(temp) #不可hash
```
```
output:
    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-121-204a5b33f72d> in <module>()
    ----> 1 set(temp)
    

    TypeError: unhashable type: 'numpy.ndarray'
```


```python
np.unique(temp)
```
```
output:
    array([1, 2, 3, 4, 5, 6])
```
```python
temp #把二维的数据拍扁，就可以用set
```
```
output:
    array([[1, 2, 3, 4],
           [3, 4, 5, 6]])
```

```python
temp.flatten()
```
```
output:
    array([1, 2, 3, 4, 3, 4, 5, 6])
```
```python
set(temp.flatten())
```
```
output:
    {1, 2, 3, 4, 5, 6}
```


# 4ndarray运算

## 1逻辑运算
- 布尔索引  
### 4.1.1布尔索引
- 想要操作符合某一条件的数据，可以选择布尔索引


```python
# 创建符合正态分布的8只股票10天的涨跌幅数据
import numpy as np
stock_change = np.random.normal(loc=0,scale=1,size=(8,10))
stock_change = stock_change[0:5,0:5]
stock_change
```
```
output:
    array([[-1.64923962, -1.35576898, -0.0200991 ,  0.25440645, -1.20218822],
           [ 1.25231424,  0.43659992, -0.80276234, -0.85928381,  1.15241732],
           [ 0.3062328 ,  1.5878486 , -0.06988383, -1.05485555,  0.19342865],
           [-1.5751586 , -1.30148225,  0.92125061, -0.7256191 , -1.19604008],
           [ 0.61605024, -0.29693507, -0.470531  , -0.73066117,  0.69818759]])
```

```python
# 逻辑判断，如果涨跌幅大于0.5则标记为True，否则则为False
stock_change>0.5
```
```
output:
    array([[False, False, False, False, False],
           [ True, False, False, False,  True],
           [False,  True, False, False, False],
           [False, False,  True, False, False],
           [ True, False, False, False,  True]], dtype=bool)
```
```python
# 返回的值都是大于0.5的
stock_change[stock_change>0.5]
```
```
output:
    array([ 1.25231424,  1.15241732,  1.5878486 ,  0.92125061,  0.61605024,
            0.69818759])
```

```python
# 返回的值都是大于0.5的, 赋值为1.1
stock_change[stock_change>0.5] =1.1
```

```python
# 所有满足条件的都变成1，1了
stock_change
```
```
output:
    array([[-1.64923962, -1.35576898, -0.0200991 ,  0.25440645, -1.20218822],
           [ 1.1       ,  0.43659992, -0.80276234, -0.85928381,  1.1       ],
           [ 0.3062328 ,  1.1       , -0.06988383, -1.05485555,  0.19342865],
           [-1.5751586 , -1.30148225,  1.1       , -0.7256191 , -1.19604008],
           [ 1.1       , -0.29693507, -0.470531  , -0.73066117,  1.1       ]])
```
## 2通用判断函数
- **np.all**(布尔值)
    - 只要有一个false，则返回false，只有全是true，才会返回true
- **np.any**(布尔值)
    - 只要有一个True，则返回True，只有全是false，才会返回false

```python
import numpy as np
stock_change = np.random.normal(loc=0,scale=1,size=(8,10))
stock_change = stock_change[0:5,0:5]
```

```python
# np.all()
# 判断stock_change[0:2,0:5]是否全是上涨的
np.all(stock_change[0:2,0:5]>0)
```
```
output:
    False
```

```python
# np.any()
# 判断前5只股票中这段期间是否有上涨
np.any(stock_change[0:5,:]>0)
```
```
output:
    True
```

## 3三元运算符
- 通过使用np.where能够进行更多复杂的运算
    - **np.where**(布尔值，True的位置的值，False的位置的值)
- 复合逻辑需要结合np.logical_and和np.logical_or使用


```python
# 判断前四个股票的四天的涨跌幅，大于0设置为1，否则为0 
# 不改变原数组
temp = stock_change[:4,:4]
np.where(temp>0,1,0)
```
```
output:
    array([[0, 1, 0, 0],
           [0, 0, 1, 1],
           [0, 1, 0, 0],
           [1, 0, 1, 0]])
```

```python
temp>0
```
```
output:
    array([[False,  True, False, False],
           [False, False,  True,  True],
           [False,  True, False, False],
           [ True, False,  True, False]], dtype=bool)
```
```python
np.where([[False,  True, False, False],
       [False, False,  True,  True],
       [False,  True, False, False],
       [ True, False,  True, False]],1,0)
```
```
output:
    array([[0, 1, 0, 0],
           [0, 0, 1, 1],
           [0, 1, 0, 0],
           [1, 0, 1, 0]])
```
```python
# 复合逻辑需要结合np.logical_andh和np.logical_or使用
temp = stock_change[:4,:4]
temp

```
```
output:
    array([[-1.03028942,  0.43488904, -1.71219847, -1.66985533],
           [-0.36762299, -1.08085229,  0.60529881,  0.65977775],
           [-0.36203793,  1.11984597, -0.78890783, -1.17333854],
           [ 1.42922861, -0.04194655,  0.41753452, -0.69631736]])
```

### 4.3.1 复合逻辑
- **np.logical_and**
- **np.logical_or**
- 判断前四个股票四天的涨跌幅，大于0.5并且小于1的，换为1，否则为0


```python
np.logical_and(temp>0.5,temp<1)
```
```
output:
    array([[False, False, False, False],
           [False, False,  True,  True],
           [False, False, False, False],
           [False, False, False, False]], dtype=bool)
```
```python
np.where(np.logical_and(temp>0.5,temp<1),1,0)
```
```
output:
    array([[0, 0, 0, 0],
           [0, 0, 1, 1],
           [0, 0, 0, 0],
           [0, 0, 0, 0]])
```
```python
np.where(np.logical_or(temp>0.5,temp<-0.5),1,0)
```
```
output:
    array([[1, 0, 1, 1],
           [0, 1, 1, 1],
           [0, 1, 1, 1],
           [1, 0, 0, 1]])
```
## 4统计运算
- 如果想要知道涨幅或者跌幅最大的数据，应该这么做
### 4.4.1 统计指标
- 在数据挖掘/机器学习领域，统计指标的值也是我们分析问题的一种方式
    - np.函数名
    - ndarray.方法名
- 统计指标函数：  
min, max, mean, median, var, std
- **np.min**(a[,axis,out,keepdims])
    - return the minimum fo an array or minimum along an axis
- **np.max**(a[,axis,out,keepdims])
    - return the maximum of an array or maximum along an axis
    - axis=0 列
    - axis=1 行  
- **np.median**(a[,axis,out,overwrite_imput,keepdims])
    - compute the median along the specified axis.
- **np.mean**(a[,axis,dtype,out,keepdims])
    - compute the arithmetic mean along the specified axis.
- **np.std**(a[,axis,dtype,out,ddof,keepdims])
    - compute the standard deviation along the specified axis.
- **np.var**(a[,axis,dtype,out,ddof,keepdims])
    - compute the variance along the specified axis.

#### 股票跌涨幅统计运算
- 进行统计的时候，axis轴的取值并不一定，Numpy中不同的API轴的值都不一样，在这里，axis 0代表列，axis 1代表去行统计


```python
# 前四个股票的四天的涨跌幅
temp = stock_change[:4,:4]
temp
```
```
output:
    array([[  1.10516303e+00,   1.52240789e+00,   7.66106468e-01,
              1.77288162e+00],
           [  7.84548835e-01,   1.82127803e-03,   6.07348285e-01,
             -2.47616029e-02],
           [  7.43009041e-02,   3.10159518e-02,   4.35135811e-03,
             -2.49224785e-01],
           [  2.08421712e+00,   6.58929242e-02,  -7.21426708e-02,
             -7.25494375e-01]])
```
```python
temp.max()
```
```
output:
    1.4292286138651558
```
```python
np.max(temp)
```
```
output:
    1.4292286138651558
```

```python
##每一列的最大值
print("前四天每天最大涨幅{}".format(np.max(temp,axis=0)))
```
```
output:
    前四天最大涨幅[ 1.42922861  1.11984597  0.60529881  0.65977775]
```    


```python
###每一行的最大值，按行 axis=1
print("前四只股票每只股票前四天最大涨幅{}".format(np.max(temp,axis=1)))
```
```
output:
    前四只股票前四天最大涨幅[ 0.43488904  0.65977775  1.11984597  1.42922861]
```    


```python
print("前四只股票前四天最大跌幅{}".format(np.min(temp,axis=1)))
```
```
output:
    前四只股票前四天最大跌幅[-1.71219847 -1.08085229 -1.17333854 -0.69631736]
```    


```python
print("前四只股票前四天波动程度{}".format(np.std(temp,axis=1)))
```
```
output:
    前四只股票前四天波动程度[ 0.86827843  0.72399463  0.86913138  0.77402427]
```    


```python
print("前四只股票前四天平均涨跌幅{}".format(np.mean(temp,axis=1)))
```
```
output:
    前四只股票前四天平均涨跌幅[-0.99436355 -0.04584968 -0.30110958  0.2771248 ]
```

```python
print("前四只股票前四天中间涨跌幅{}".format(np.median(temp,axis=1)))
```
```
output:
    前四只股票前四天中间涨跌幅[-1.35007238  0.11883791 -0.57547288  0.18779398]
```    

### 4.4.2 返回最大值最小值所在位置
如果需要统计出哪一只股票在某个交易日的涨幅最大或者最小  
- **np.argmax**(temp,axis=)
- **np.argmin**(temp,axis=)


```python
np.argmax(temp,axis=1)
```
```
output:
    array([1, 3, 1, 0], dtype=int64)
```
```python
#获取指定哪一天涨幅最大
print("前四只股票前四天涨幅最大{}".format(np.argmax(temp,axis=1)))
```
```
output:
    前四只股票前四天涨幅最大[1 3 1 0]
```    

```python
print("前四天一天内涨幅最大的股票{}".format(np.argmax(temp,axis=0)))
```
```
output:
    前四天一天内涨幅最大的股票[3 2 1 1]
```    

# 5数组间运算

## 1数组与数的运算


```python
arr = np.array([[1, 2, 3, 2, 1, 4], [5, 6, 1, 2, 3, 1]])
```


```python
arr+10
```
```
output:
    array([[11, 12, 13, 12, 11, 14],
           [15, 16, 11, 12, 13, 11]])
```
```python
arr/2
```
```
output:
    array([[ 0.5,  1. ,  1.5,  1. ,  0.5,  2. ],
           [ 2.5,  3. ,  0.5,  1. ,  1.5,  0.5]])
```

```python
##list做同样的事情就会报错
a = [1, 2, 3, 4, 5]
```
```python
a + 10
```
```
output:

    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-78-2c64baa9fdb5> in <module>()
    ----> 1 a + 10
    

    TypeError: can only concatenate list (not "int") to list
```

```python
a * 2  ##只是数组重复
```
```
output:
    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
```
## 2数组与数组的运算


```python
arr1 = np.array([[1, 2, 3, 2, 1, 4], [5, 6, 1, 2, 3, 1]])
arr2 = np.array([[1, 2, 3, 4], [3, 4, 5, 6]])
```


```python
arr1 ##(2,6)
```
```
output:
    array([[1, 2, 3, 2, 1, 4],
           [5, 6, 1, 2, 3, 1]])
```
```python
arr2 ##(2,4)
```
```
output:
    array([[1, 2, 3, 4],
           [3, 4, 5, 6]])
```
```python
arr1 + arr2
# operands could not be broadcast together with shapes (2,6) (2,4) 
# 不满足广播机制
```
```
output:

    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    <ipython-input-83-c32d35a25125> in <module>()
    ----> 1 arr1 + arr2
    

    ValueError: operands could not be broadcast together with shapes (2,6) (2,4) 
```

## 3广播机制
- 执行broadcast的前提在于，在两个ndarray执行的是element-wise的运算，broadcast机制的功能是为了方便不用形状的ndarray(numpy库的核心数据结构)进行数学运算
- 当操作两个数组时，numpy会逐个比较他们的shape(构成元祖的tuple)，只有在下述情况下，两个数组才能够进行数组与数组的运算
    - **维度相等**
    - **shape (其中相对应的一个地方为1)**  

```
(3d array) 256 * 256 * 3  
(1d array)             3
(3d array) 256 * 256 * 3
最后一个维度都是3 维度相等

(4d array)  9 * 1 * 7 * 1
(3d array)      8 * 1 * 5
(4d array)  9 * 8 * 7 * 5 
 
(2d array)  5 * 4
(1d array)      1
(2d array)  5 * 4

(3d array)  15 * 3 * 5
(3d array)  15 * 1 * 1
(3d array)  15 * 3 * 5
```


```python
arr1 = np.array([[1, 2, 3, 2, 1, 4], [5, 6, 1, 2, 3, 1]])
arr2 = np.array([[1], [3]])
```

```python
arr1
```
```
output:
    array([[1, 2, 3, 2, 1, 4],
           [5, 6, 1, 2, 3, 1]])
```

```python
arr1.shape
```
```
output:
    (2, 6)
```
```python
arr2
```
```
output:
    array([[1],
           [3]])
```
```python
arr2.shape
```
```
output:
    (2, 1)
```
```python
 arr1 + arr2
```
```
output:
    array([[2, 3, 4, 3, 2, 5],
           [8, 9, 4, 5, 6, 4]])
```
```python
arr1 * arr2
```
```
output:
    array([[ 1,  2,  3,  2,  1,  4],
           [15, 18,  3,  6,  9,  3]])
```
```python
arr1/arr2
```
```
output:
    array([[ 1.        ,  2.        ,  3.        ,  2.        ,  1.        ,
             4.        ],
           [ 1.66666667,  2.        ,  0.33333333,  0.66666667,  1.        ,
             0.33333333]])
```

## 4矩阵运算
### 5.4.1 什么是矩阵
- 矩阵，英文matrix, 和array的区别是必须是2维的，但是array可以是多维的
- 两种方法存储矩阵
    - **ndarray** 二维数组
    - **matrix** 数据结构
- **np.mat**()
    - 将数组转换成矩阵类型

```python
# ndarray存储矩阵
data = np.array([[80, 86],
[82, 80],
[85, 78],
[90, 90],
[86, 82], 
[82, 90],
[78, 80],
[92, 94]])
```

```python
data
```
```
output:
    array([[80, 86],
           [82, 80],
           [85, 78],
           [90, 90],
           [86, 82],
           [82, 90],
           [78, 80],
           [92, 94]])
```
```python
# matrix存储矩阵
data2 = np.mat([[80, 86],
       [82, 80],
       [85, 78],
       [90, 90],
       [86, 82],
       [82, 90],
       [78, 80],
       [92, 94]])
```

```python
data2
```
```
output:
    matrix([[80, 86],
            [82, 80],
            [85, 78],
            [90, 90],
            [86, 82],
            [82, 90],
            [78, 80],
            [92, 94]])
```
```python
type(data2)
```
```
output:
    numpy.matrixlib.defmatrix.matrix
```
### 5.4.2矩阵乘法运算
- 矩阵乘法的两个关键：
    - 形状改变
    - 运算规则
- 形状改变：  

- **(M行，N列) x (N行，L列) =(M行，L列)**
    - 必须符合上面的式子，否则运算出错
    - 设A为m*p的矩阵，B为p*n的矩阵，则称为m*n的矩阵c为矩阵A与B的乘机，记作C=AB
    - A(2,3) B(3,2) A*B=(2,2)
- 矩阵乘法api：
    - **np.matmul**
    - **np.dot**

```python
data = np.mat([[80, 86],
       [82, 80],
       [85, 78],
       [90, 90],
       [86, 82],
       [82, 90],
       [78, 80],
       [92, 94]])
data.shape
```
```
output:
    (8, 2)
```
```python
data2 = np.mat([[0.3],[0.7]])
data2.shape
```
```
output:
    (2, 1)
```
```python
data * data2
```
```
output:
    matrix([[ 84.2],
            [ 80.6],
            [ 80.1],
            [ 90. ],
            [ 83.2],
            [ 87.6],
            [ 79.4],
            [ 93.4]])
```
```python
np.matmul(data,data2)
```
```
output:
    matrix([[ 84.2],
            [ 80.6],
            [ 80.1],
            [ 90. ],
            [ 83.2],
            [ 87.6],
            [ 79.4],
            [ 93.4]])
```
```python
np.dot(data,data2)
```
```
output:
    matrix([[ 84.2],
            [ 80.6],
            [ 80.1],
            [ 90. ],
            [ 83.2],
            [ 87.6],
            [ 79.4],
            [ 93.4]])
```
```python
data @ data2
```
```
output:
    matrix([[ 84.2],
            [ 80.6],
            [ 80.1],
            [ 90. ],
            [ 83.2],
            [ 87.6],
            [ 79.4],
            [ 93.4]])

```

```python
A = np.array([[80, 86],
       [82, 80],
       [85, 78],
       [90, 90],
       [86, 82],
       [82, 90],
       [78, 80],
       [92, 94]])
```

```python
A.shape
```
```
output:
    (8, 2)
```

```python
type(A)
```
```
output:
    numpy.ndarray
```
```python
B = np.array([[0.3],[0.7]])
```

```python
B.shape
```
```
output:
    (2, 1)
```
```python
type(B)
```
```
output:
    numpy.ndarray
```
```python
A * B  # 矩阵可以相乘，但是ndarry不可以，不满足广播机制
```
```
output:

    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    <ipython-input-133-2aa8ba38e21e> in <module>()
    ----> 1 A * B
    

    ValueError: operands could not be broadcast together with shapes (8,2) (2,1) 
```

# 6合并分割
- 实现数据的切分和合并，将数据进行切分合并处理


## 1合并
- **numpy.hstack**(tup) Stack arrays in sequence horizontally (column wise) 水平
- **numpy.vstack**(tup) stack arrays in sequence vertically (row wise) 竖直
- **numpy.concatenate**((a1,a2...),axis=0)


```python
a = np.array([1,2,3])
```

```python
b = np.array([2,3,4])
```

```python
np.hstack((a,b))
```
```
output:
    array([1, 2, 3, 2, 3, 4])
```
```python
a = np.array([[1],[2],[3]])
```

```python
b = np.array([[2],[3],[4]])
```

```python
np.hstack((a,b))
```
```
output:
    array([[1, 2],
           [2, 3],
           [3, 4]])
```

```python
a = np.array([1,2,3])
b = np.array([2,3,4])
np.vstack((a,b))
```
```
output:
    array([[1, 2, 3],
           [2, 3, 4]])
```
```python
a = np.array([[1],[2],[3]])
b = np.array([[2],[3],[4]])
np.vstack((a,b))
```
```
output:
    array([[1],
           [2],
           [3],
           [2],
           [3],
           [4]])
```
```python
a = np.array([1,2,3])
b = np.array([2,3,4])
np.concatenate((a,b),axis=0) #列
```
```
output:
    array([1, 2, 3, 2, 3, 4])
```
```python
a = np.array([[1],[2],[3]])
b = np.array([[2],[3],[4]])
np.concatenate((a,b),axis=1) #行
```
```
output:
    array([[1, 2],
           [2, 3],
           [3, 4]])
```
```python
a = np.array([[1,2],[3,4]])
b = np.array([[5,6]])
```

```python
a
```
```
output:
    array([[1, 2],
           [3, 4]])
```

```python
b
```
```
output:
    array([[5, 6]])
```

```python
np.concatenate((a,b),axis=0) ### 竖直拼接
```
```
output:
    array([[1, 2],
           [3, 4],
           [5, 6]])
```

```python
np.concatenate((a,b.T),axis=1)  ### 水平拼接
```
```
output:
    array([[1, 2, 5],
           [3, 4, 6]])
```

## 2分割
- **numpy.split**(ary,indices_or_sections,axis=0) 
    - split an array into mutiple sub-arrays


```python
x = np.arange(9.0)
x
```
```
output:
    array([ 0.,  1.,  2.,  3.,  4.,  5.,  6.,  7.,  8.])
```
```python
np.split(x,3)
```
```
output:
    [array([ 0.,  1.,  2.]), array([ 3.,  4.,  5.]), array([ 6.,  7.,  8.])]
```
```python
x = np.arange(9.0)
x
```
```
output:
    array([ 0.,  1.,  2.,  3.,  4.,  5.,  6.,  7.,  8.])
```
```python
np.split(x,[3,4,5,6])
```
```
output:
    [array([ 0.,  1.,  2.]),
     array([ 3.]),
     array([ 4.]),
     array([ 5.]),
     array([ 6.,  7.,  8.])]
```


# 7IO操作与数据处理
- 大多数数据并不是我们自己构造的，而是存在文件中，需要我们用工具获取
- Numpy并不适合用来读取数据和处理数据，我们这里了解相关的API，以及Numpy不方便的地方

## 1Numpy读取
- **genfromtxt**(fname,[,dtype,comments...]) 
    - Load data from a text file, with missing values handled as specified.


```python
# 读取数据
test = np.genfromtxt("test.csv", delimiter = ",")
```

```python
test
```
```
output:
    array([[   nan,    nan,    nan,    nan],
           [   1. ,  123. ,    1.4,   23. ],
           [   2. ,  110. ,    nan,   18. ],
           [   3. ,    nan,    2.1,   19. ]])
```

## 2如何处理缺失值
### 7.2.1 什么是缺失值
- 什么时候numpy中会出现nan：当我们读取本地的文件为float的时候，如果有缺失（或者为None），就会出现nan
### 缺失值处理
- 直接删除含有缺失值的样本
- 替换/替换
    - 按列求平均，用平均值进行填补

```python
type(test[2,2]) #nan是浮点
```
```
output:
    numpy.float64
```
```python
def fill_nan_by_column_mean(t):
    for i in range(t.shape[1]):
        # 计算nan的个数
        nan_num = np.count_nonzero(t[:, i][t[:, i] != t[:, i]])
        if nan_num > 0:
            now_col = t[:, i]
            # 求和
            now_col_not_nan = now_col[np.isnan(now_col) == False].sum()
            # 和/个数
            now_col_mean = now_col_not_nan / (t.shape[0] - nan_num)
            # 赋值给now_col
            now_col[np.isnan(now_col)] = now_col_mean
            # 赋值给t，即更新t的当前列
            t[:, i] = now_col
    return t
```

```python
test
```
```
output:
    array([[   2.  ,  116.5 ,    1.75,   20.  ],
           [   1.  ,  123.  ,    1.4 ,   23.  ],
           [   2.  ,  110.  ,    1.75,   18.  ],
           [   3.  ,  116.5 ,    2.1 ,   19.  ]])
```
```python
fill_nan_by_column_mean(test) ##处理缺失值
```
```
output:
    array([[   2.  ,  116.5 ,    1.75,   20.  ],
           [   1.  ,  123.  ,    1.4 ,   23.  ],
           [   2.  ,  110.  ,    1.75,   18.  ],
           [   3.  ,  116.5 ,    2.1 ,   19.  ]])
```
