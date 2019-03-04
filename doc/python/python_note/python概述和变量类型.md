
# 1Python概述
- 计算机语言概述
    - 语言：交流的工具，沟通的媒介
    - 计算机语言：人和计算机交流的工具
    - Python是计算机语言中的一种
    - Python编程语言
        - 代码：人类语言，通过代码命令，跟机器交流
        - Python解释器：就是那个担任翻译工作
        - 流程：
            - 写代码
            - 执行：Python解释器把Code翻译给机器，同时再把机器结果翻译给我们
- Python简史
    - 1989年 Guido van Rossum
    - 2008： Python3.0
- Python特点
- Python应用领域
    - 各个领域
    - 平衡发展，简洁明了

# 2注释
- 机器不去执行注释内容
- 注释一般用自然语言去书写
- 注释的写法：
    - 行注释：以#开头，可以单独行，可以在某代码后边
    - 快注释：好几行代码或者内容
        - ''' 两行三引号
# 3变量  
- 程序 = 数据结构 + 算法
- 用变量来表示数据
- 变量就是可以重复使用的一个量
- 变量命名的规则
    - 变量命名可以包含数字，大小写字母，下划线或者更多，但是我们不推荐除了前三种内容之外的符号
    - 数字不可以打头
        - 4uio 不可以
        - uio4 可以
    - 一般在Python中，以**下划线**开头的内容具有特殊含义，不建议使用
        - 比如_age,_name,理论可以，但是强烈不推荐，包括但是不限于一个下划线开头或者两个连续下划线开头
    - 大小写不一样
        - 大小写敏感
    - 推荐：
        - 使用具有固定含义的英文单词或者缩写： srv=server，skt=socket，一般以posix命名规则为主
        - 驼峰命名法
            - 单词以单词自动连接，且每个单词首字母大写
                - 大驼峰，每个单词第一个字母大写
                    - 在Python中给**类**命名使用此法
                    - IntOne
                - 小驼峰，类似大驼峰，但是第一个字母小写
                    - 在Python中一般给普通变量或者函数命名
                    - intOne
                - posix写法
                    - 多个单词用下划线连接
                    - 单词全部小写
                    - int_one
    - 保留字和关键字
        - 变量命名必须避开，不能和关键字和保留字一样
        - class，def，break，for
     


```python
# 查看关键字的方法
import keyword  # 引入关键字模块
print(keyword.kwlist)
```

    ['False', 'None', 'True', 'and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']
    

# 4变量声明
- 一个等号是赋值的意思
- var_name = var_value
- var1=var2=var3=var_value
- var1,var2,var3=v1,v2,v3


```python
# 定义变量age，把18放入变量age中
age = 18
print(age)

# 给age1，age2，age3放入同样一个内容或值
age1=age2=age3=18
print(age1)
print(age2)
print(age3)

# 一行内给多个变量赋值
age4, age5, age6 = 12, 32, 45
print(age4)
print(age5)
print(age6)

```

    18
    18
    18
    18
    12
    32
    45
    

# 5变量类型
- 严格意义上，Python只有一种类型
- 标准数据一共六种
    - 数字类型Number
    - 字符串 str
    - 列表 list
    - 元祖 tuple
    - 字典 dictionary
    - 集合 set
- 数字类型没有大小限制 bignumber 只要内存装都下


## 5.1 数字类型 Number
### 5.1.1整数
- 整数 没有小数部分  
- 自然数 负自然数 0
- 整数分进制
    - 二进制
        - 机器常用
        - 是计算机唯一能理解的数字
        - 已0b为开头都0，1代码 0b00101
    - 八进制
        - 以0o开头包含0-7的数字
    - 十进制
        - 18，19，178
    - 十六进制
        - 逢16进1
        - 其实是每四位二进制表示一位十六进制数
        - 0-9 a-f
        - 数字上以0x开头表示
       


```python
#进制之间可以互相转换
age = 18
print (age)

# 二进制表示
age = 0b10010

# 八进制表示
print (age)
age = 0o102
print(age)
#ff表示1111 1111
age = 0xff14 
print(age)
```

    18
    18
    66
    65300
    

### 5.1.2浮点数float
- 小数
- 计算机表示浮点数可以有条件省略
- 3.1415
- 3.
- 0.5
- .5
- 科学计数法
    - 定义科学
    - 用e/E后面跟着整数表示10的指数
    - 176.23 == 1.7623e2 == 1.7623 * 10^2
    - 0.876 == 8.76e-1


```python
height = 156.34
print(height)
shili = 0.2
print(shili)
shili = .6
print(shili)
```

    156.34
    0.2
    0.6
    

### 5.1.3复数 complex
- 一共由实数和虚部构成的数字
- 虚部用j/J表示
- 5+3j
- 3j

### 5.1.4布尔值
- 表示真假的值
- True/False
- 可以直接跟数字操作


```python
age = 18 + True
print(age)
```

    19
    

## 5.2字符串
- 用來表示一串文字信息
- 如何表示
    -单引号
    -双引号
    -三引号（三个单引号或者三个双引号）
        - 能够扩起多行信息
- 单双引号可以交错使用
- 转义字符
- 格式化
- 内建函数


```python
variable = "abc"
print(variable)
variable = 'aaaa'
print(variable)

# 单双引号交错使用的例子
html = '<a style = "color :red">hahha</a>'
# 三引号
htmls =''' 
ABC
def
GHI
'''
print(html)
print(htmls)
```

    abc
    aaaa
    <a style = "color :red">hahha</a>
     
    ABC
    def
    GHI
    
    

### 5.2.1转义字符
- 用一个特殊的方法表示出一系列不方便写出来的内容，比如回车键，换行键，退格键
- 借助反斜杠字符，一旦字符串中出现反斜杠，则反斜杠后面一个或几个字符表示已经不是原来的含义，进行了转义
- 不同的系统对换行操作有不同的表示
    - windows：\n
    - Linux: \r\n


```python
## 用嵌套引号，外层用双引号
s = "let's go"
print (s)
##用转义字符 \
ss= 'let\'s go'
print (ss)
# \\ = \
# SyntaxError: (unicode error) 'unicodeescape' codec can't decode bytes in position 2-3: truncated \uXXXX escape
# SSS ="c:\user"
SSS ="c:\\user"
print(SSS)
#回车换行
#windows:\n
#linux: \r\n   \t制表符
s1 = "123 \r\nxxx"
s2 = "123  \nxxx"
print (s1) 
print (s2)
```

    let's go
    let's go
    c:\user
    123 
    xxx
    123  
    xxx
    

### 5.2.2字符串的格式化
- 字符串按照一定格式打印或者填充
- 格式化一般两种方法
    - 利用百分号% 
    - 利用format函数

#### 5.2.2.1利用百分号格式化
- 在字符串中，利用%表示一个特殊的含义，表示对字符串进行格式化
- %d 放入一个整数
- %s 放入一个字符串


```python
aa = "I love %s"
print(aa)
```

    I love %s
    


```python
print("I love %s" %"xxx")
```

    I love xxx
    


```python
print (aa%"xxx")
```

    I love xxx
    


```python
s = "I am %d years old "
#区别
print(s)
print(s%18)
```

    I am %d years old 
    I am 18 years old 
    


```python
s = "I am %s, I am %d years old"
print(s)
#注意以下报错的原因
# 如果字符串中的有占位符，则有几个占位符必须用几个实际内容代替，或者一个也不要
# print(s%"abc") #typeerror 类型相关 not enough arguments for format string
print(s%("xxx",18)) #用括号括起来
```

    I am %s, I am %d years old
    I am xxx, I am 18 years old
    

#### 5.2.2.2format函数格式化字符串
- 直接用format
- 推荐用这个办法， 以｛｝和： 代替%号，后面用format带参数完成


```python
s = "I am {}".format("xxx")
print(s)
ss = "I am {1} years old, I am {0} and I am {1} years old".format("xxx",18)
print (ss)
```

    I am xxx
    I am 18 years old, I am xxx and I am 18 years old
    

# 内置数据结构（变量类型）
- list
- set
- dict
- tuple

## 5.3List 列表

### 5.3.1list 定义
- 一组有顺序都数据的组合
- 创建列表
    - 空列表        


```python
# 空列表
L1 = []
# type是内置函数，负责打印出变量的类型
print(type(L1))
print(L1)
```

    <class 'list'>
    []
    


```python
#创建带值的列表
L2 = [100]
print(type(L2))
print(L2)
```

    <class 'list'>
    [100]
    


```python
#创建列表，带多个值
L3 = [2,3,4,5,6,7,8]
print(type(L3))
print(L3)
```

    <class 'list'>
    [2, 3, 4, 5, 6, 7, 8]
    


```python
#使用list()
L4 = list()
print(type(L4))
print(L4)
```

    <class 'list'>
    []
    

### 5.3.2 访问
- 使用下标操作（索引）从0开始


```python
#下标访问列表
L = [3,5,6,7,8,9,10]
print(L[1])
print(L[4])
```

    5
    8
    

### 5.3.3 分片操作
- 对列表进行任何一段的截取
- L[:]
- 分片操作是生成了一个新的list
- 分片可以控制增长幅度，默认增长幅度为1 
- 下标可以超过范围，超过后不在考虑多余下标内容
- 下标值，可以为负数，从右往左，数组最后一个数字为-1
    - 左边的值一定要小于右边的值
- 如果分片一定要左边比右边大，则步长参数用负数
    - 但是顺序颠倒了


```python
L = [3,5,6,7,8,9,10]
print(L)
```

    [3, 5, 6, 7, 8, 9, 10]
    


```python
#分片操作
#包含左，不包含右下标值，左闭右开
#如果不写，左边为0，右边为下标最大+1，截取到最后一个数据
print(L[1:4]) 
```

    [5, 6, 7]
    


```python
print(L[:])
```

    [3, 5, 6, 7, 8, 9, 10]
    


```python
print(L[:4])
```

    [3, 5, 6, 7]
    


```python
print(L[2:])
```

    [6, 7, 8, 9, 10]
    


```python
# 分片可以控制增长幅度，默认增长幅度为1
print(L[1:6:1])
```

    [5, 6, 7, 8, 9]
    


```python
#增长为两个
print(L[1:6:2])
```

    [5, 7, 9]
    


```python
#下标可以超过范围，超过后不在考虑多余下标内容
print(L[2:10])
```

    [6, 7, 8, 9, 10]
    


```python
#下标值，可以为负数，从右往左，数组最后一个数字为-1
print(L[-4:-1]) #还是包括左，不包括右 左边的值一定要小于右边的值
```

    [7, 8, 9]
    


```python
#如果分片一定要左边比右边大，则步长参数用负数
print(L[-1:-4:-1])  #但是顺序颠倒了
```

    [10, 9, 8]
    

### 5.3.4切片操作是生成了一个新的list
- 内置函数id，负责显示一个变量或者数据唯一确定的编号
- LLL = L #赋值是相同的list 地址相同


```python
# id函数举例
a = 100
b = 200
print(id(a))
print(id(b))
```

    1777888512
    1777891712
    


```python
#c和a的地址相同 指向同样的地址
c = a 
print(id(c))
```

    1777888512
    


```python
# a改变 c没有改变
a = 101
print(a)
print(c)
```

    101
    100
    


```python
# 通过id
L = [3,4,56,76,23,45,7]
# 分片操作是生成了一个新的list
L1 =L [:]
# 赋值是相同的list 地址相同
L2 = L 
print(id(L))
print(id(L1))
print(id(L2))
```

    2394719655752
    2394719655496
    2394719655752
    


```python
#L和L3指向都是同一段代码
L[1] = 100 
print(L)
print(L1)
print(L2)
```

    [3, 100, 56, 76, 23, 45, 7]
    [3, 4, 56, 76, 23, 45, 7]
    [3, 100, 56, 76, 23, 45, 7]
    

### 5.3.5删除命令
- 删除之后，原地删除，列表自身不变


```python
a = [1,2,3,4,5]
print(id(a))
del a[2]
print(a)
#删除之后，原地删除，列表自身不变
print(id(a)) 
```

    1815498314184
    [1, 2, 4, 5]
    1815498314184
    


```python
# del完之后不能再用了，删掉就没了，会报一个NameError的错
del a
print (a)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    <ipython-input-32-dd215dcb053e> in <module>()
          1 # del完之后不能再用了
          2 del a
    ----> 3 print (a)
    

    NameError: name 'a' is not defined


### 5.3.6列表相加
- 使用加号链接两个列表


```python
#使用加号，
a = [1,2,3,4,5]
b = [5,6,7,8,9]
c = ['a','b']
print (a)
print (b)
print (c)
```

    [1, 2, 3, 4, 5]
    [5, 6, 7, 8, 9]
    ['a', 'b']
    


```python
# abc分别是d中的元素
d = [a,b,c]
print(d)
```

    [[1, 2, 3, 4, 5], [5, 6, 7, 8, 9], ['a', 'b']]
    


```python
# 注意连接和上一个的区别,三个列表直接接在一起
e = a + b + c
print(e)
```

    [1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 'a', 'b']
    

### 5.3.7列表相乘
- 相当于把n个数列接在一起


```python
# 使用乘号操作列表
# 列表直接跟一个整数相乘
#相当于把n个数列接在一起
a = [1,2,3,4,5]
b = a*3
c = a + a + a
print(b) 
print(c)
```

    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    

### 5.3.8成员资格运算
- 判断一个元素是否在list里边
- 返回的是一个布尔值
- in
- not in


```python
#判断一个元素是否在list里边
a = [1,2,3,4]
b = 8
c = b in a #逻辑运算
print(c)
d = 4
print(d in a)
```

    False
    True
    


```python
#not in
a = [1,2,3,5]
b = 9
print(b not in a)
```

    True
    

### 5.3.9链表的遍历
- 挨个访问里面的元素
- for
- while

#### 5.3.9.1for


```python
# b中只有一个元素
b = ["abcd"]
for i in b:
    print(i)
```

    abcd
    


```python
# for in list
a = [1,2,3,4,5]

for i in a:
    print (i)
```

    1
    2
    3
    4
    5
    


```python
#java, c++ 程序员写python代码
for i in range(0,len(a)):
    print (a[i])
```

    1
    2
    3
    4
    5
    


```python
# range
# in 后面的变量要求是可以迭代的
for i in range(1,10):
    print(i)
#range(1，10)不是list也不是set    
print(type(range(1,10))) 
print(type(range))
```

    1
    2
    3
    4
    5
    6
    7
    8
    9
    <class 'range'>
    <class 'type'>
    

#### 5.3.9.2while


```python
# 用while循环访问list
# 一般不用while遍历list

a = [1,2,4,5,6,7]
length = len(a)
# index代表的是a的下标
indx = 0
while indx < length:
    print (a[indx])
    indx += 1
```

    1
    2
    4
    5
    6
    7
    

#### 5.3.9.3嵌套列表


```python
# 字典里面使用的比较多
# 双层列表循环 
# 嵌套列表，或者叫双层列表
a = [["one",1],["two",2],["three",3]]
for k, v in a:
    print(k, "...", v)
```

    one ... 1
    two ... 2
    three ... 3
    


```python
a = [["one",1,"abc"],["two",2,4,5,6],["three",3]]
for i in a:
    print(i)
```

    ['one', 1, 'abc']
    ['two', 2, 4, 5, 6]
    ['three', 3]
    


```python
# 双层类别循环变异
# too many values to unpack
a = [["one",1,"abc"],["two",2,4,5,6],["three",3]]
for k, v in a:
    print(k, "...", v)
```


    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    <ipython-input-84-3e822b0cc064> in <module>()
          1 # 双层类别循环变异
          2 a = [["one",1,"abc"],["two",2,4,5,6],["three",3]]
    ----> 3 for k, v in a:
          4     print(k, "...", v)
    

    ValueError: too many values to unpack (expected 2)



```python
# k,v,w的个数应该跟解包出来的变量个数一致
a = [["one",1,"abc"],["two",2,4],["three",3,"www"]]
for k, v,w in a:
    print(k, "...", v,"...",w)
```

    one ... 1 ... abc
    two ... 2 ... 4
    three ... 3 ... www
    

### 5.3.10列表内涵: list content
- 通过简单方法创作列表


```python
# for创建
a = [1,2,3]
# 用list a 创建一个 list b
# 下面代码含义是，对于所有a中的元素，逐个放入新列表b中
b = [i for i in a]
print(b)
```

    [1, 2, 3]
    


```python
# 对a中所有元素*10
a = ["a","b","c"]
# 用list a 创建一个 list b
# 下面代码含义是，对于所有a中的元素，逐个放入新列表b中
b = [i*10 for i in a]
# 注意和c的区别，c是10个a相连接
c = a * 10
print(b)
print(c)
```

    ['aaaaaaaaaa', 'bbbbbbbbbb', 'cccccccccc']
    ['a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c']
    


```python
# 对a中所有元素都为数字*10
a = [1,2,3]
# 用list a 创建一个 list b
# 下面代码含义是，对于所有a中的元素，逐个放入新列表b中
b = [i*10 for i in a]
# 注意和c的区别，c是10个a相连接
c = a * 10
print(b)
print(c)
```

    [10, 20, 30]
    [1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3]
    


```python
#还可以过滤原来list中的内容放入新列表
# 比如原来列表a， 需要把所有a中的偶数生成新列表b
#生成一个1到35的列表
a =[x for x in range(1,36)] 
b1 = [m for m in a]
# a中所有的偶数生成一个新的列表b
b2 =[m for m in a if m%2 ==0] 
print(b1)
print (b2)
```

    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]
    [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34]
    


```python
#列表生产式也可以嵌套
# 两个列表a，b
a = [i for i in range(1,4)]
print(a)

b = [i for i in range(100,400) if i%100 ==0]
print(b)

# 列表的生成可以嵌套，此时等于两个for循环嵌套
c=[m+n for m in a for n in b]
print ('c:',c)

# 一共有a*b个元素
print('c中一共有元素的个数：',len(c))

# ab表相连
d = a+b
print ('d:',d)

# 满足ab相加小于250，嵌套的列表生成的结果也可以用条件表达式
e = [m+n for m in a for n in b if m+n<250]
print ('e:',e)

# c和以下的表达式结果相等，但是最终结果不是list
print('i+j:')
for i in a:
    for j in b:
        print(i+j, end =" ")
```

    [1, 2, 3]
    [100, 200, 300]
    c: [101, 201, 301, 102, 202, 302, 103, 203, 303]
    c中一共有元素的个数： 9
    d: [1, 2, 3, 100, 200, 300]
    e: [101, 201, 102, 202, 103, 203]
    i+j:
    101 201 301 102 202 302 103 203 303 

###  5.3.11关于列表的常用函数
- len
- max
- min
- 把数据转出成list的要求，数据是要iterable 要求是可迭代的
- 传值和传址的区别
- append
    - 插入一个内容,在末尾追加
- insert
    - 在指定位置插入
- del
    - **删除指定位置**的数值
    - pop把**最后一个元素**取出来
    - remove在列表中**删除指定值**的元素，如果删除的值不存在，则会报错
- clear
    - 清空了列表，但是列表的地址没有变
- reverse
    - 原地反转，地址不变
- extend
    - 扩展列表，两个列表，把一个直接接在后一个,id不变
- count
    - 查找列表中指定值或元素的个数
- copy
    - 浅copy
- deep copy
    - 列表里面又包含一个列表，浅copy只能copy一层，浅copy在处理后面的[5,6,7] copy的只是地址
- AttributeError 实例object，实例调用，调用函数，或者使用某一属性，但是没有，就会报错


```python
# len：求列表都长度
a = [x for x in range(1,100)]
print(len(a))

# max: 求max
print(max(a))
# min: 求min
print(min(a))

b = ["man","fime","python"]
print(max(b))
```

    99
    99
    1
    python
    


```python
# list:将其他格式的数据转换成list
a = [1,2,3]
print(list(a))
```

    [1, 2, 3]
    


```python
#s是一个string
s = "ab cd"
print(list(s))
# 想把一个string以单个的形式表达出来，可以先把string转化成list
a = list(s)
for i in a:
     print(i)
```

    ['a', 'b', ' ', 'c', 'd']
    a
    b
     
    c
    d
    


```python
# 把range产生的内容转换成list
print(list(range(12,19)))
```

    [12, 13, 14, 15, 16, 17, 18]
    


```python
#传址和传值的区别
#对于简单的数值，采用传值的操作，在函数内的操作不影响外面的值
#对于复杂的变量，采用传址，函数内部的参数和外部变量是同一内容，任何地方对此内容的更改都影响另外的变量或参数的使用

def a(n):
    n[2] = 300
    print(n)
    return None

def b(n):
    n+=100
    print(n)
    return None

an = [1,2,3,4,5,6]
bn = 9

#一个内部改变了an，导致外部参数an也改变了
# 传址
print(an)
a(an) 
print(an)
 
print('')

#一个内部不能改变bn，外部参数bn没有改变
# 传值
print(bn)
b(bn)
print(bn)
```

    [1, 2, 3, 4, 5, 6]
    [1, 2, 300, 4, 5, 6]
    [1, 2, 300, 4, 5, 6]
    
    9
    109
    9
    


```python
# append 插入一个内容,在末尾追加
a = [i for i in range(1,5)]
print(a)
a.append(100)
print(a)
```

    [1, 2, 3, 4]
    [1, 2, 3, 4, 100]
    


```python
# insert 在指定位置插入,两个参数，index索引和具体数字，插入的位置是index前面
print(a)
a.insert(3,666)
print(a)
```

    [1, 2, 55, 4, [5, 6, 66]]
    [1, 2, 55, 666, 4, [5, 6, 66]]
    


```python
#删除 del
#删除指定位置的数
a = [1,2,3,4,5]
print(id(a))
del a[2]
print(a)
#删除之后，原地删除，列表自身不变
print(id(a)) 
```

    1815499224008
    [1, 2, 4, 5]
    1815499224008
    


```python
#pop，把最后一个元素取出来
print(a)
last_ele=a.pop()
print(last_ele)
print(a)
```

    [1, 2, 3, 666, 4, 100]
    100
    [1, 2, 3, 666, 4]
    


```python
# remove:在列表中删除指定值的元素
# 如果删除的值不存在，则会报错，所以在使用remove之前，需要做一个判断函数
# if x in list:
#     list.remove(x)
print(a)
print(id(a))

a.remove(666)

print(a)
print(id(a))
#id不变，remove操作是在原list直接操作，一直是同一个list
```

    [1, 2, 3, 666, 4]
    1815498885768
    [1, 2, 3, 4]
    1815498885768
    


```python
#clear：清空
print(a)
print(id(a))
a.clear()
print(a)
print(id(a)) #清空了列表，但是列表的地址没有变
#如果不需要列表地址保持不变，则清空列表可以使用以下办法
# a = list()
# a = []
```

    [1, 2, 4, 5]
    1815499224008
    []
    1815499224008
    


```python
# reverse() 反转, 原地反转，地址不变
a = [1,2,3,4,5,6]
print(a)
print(id(a))
a.reverse()
print(a)
print(id(a))
```

    [1, 2, 3, 4, 5, 6]
    1815499224008
    [6, 5, 4, 3, 2, 1]
    1815499224008
    


```python
# extend：扩展列表，两个列表，把一个直接接在后一个,id不变
a =[1,2,3,4,5]
b =[6,7,8,9,10]
print(id(a))

a.extend(b)
print(a)
print(id(a))
```

    1815499244040
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    1815499244040
    


```python
# count:查找列表中指定值或元素的个数
print(a)
a_len = len(a)
print(a_len)

# 不是查找长度，是查找某个值或者元素的个数
a1_len = a.count()
print(a1_len) 
```

    [6, 5, 4, 3, 2, 1]
    6
    


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-142-6ba98b2484af> in <module>()
          5 
          6 # 不是查找长度，是查找某个值或者元素的个数
    ----> 7 a1_len = a.count()
          8 print(a1_len)
    

    TypeError: count() takes exactly one argument (0 given)



```python
print(a)
a.append(8)
a.insert(3,8)
a1_len = a.count(8) #8的个数
print(a)
print(a1_len)
```

    [6, 5, 4, 3, 2, 1]
    [6, 5, 4, 8, 3, 2, 1, 8]
    2
    


```python
# copy: 浅copy
# 列表类型变量赋值示例，用等号进行，是传址操作
# b和a指向同一个地址，在b改变的同时，a也改变了

a = [1,2,3,4,5,6,666]
print(a)
print(id(a))

# list变量，用'='，简单的赋值操作，是传址操作 
#a和b其实是指向的同一个地址
# ab的地址相同
b = a 
print(b)
print(id(b))

b[3] = 777
print(b)
print(a) 
#a也变了
#怎么才能解决这个问题，用copy

```

    [1, 2, 3, 4, 5, 6, 666]
    1815499225992
    [1, 2, 3, 4, 5, 6, 666]
    1815499225992
    [1, 2, 3, 777, 5, 6, 666]
    [1, 2, 3, 777, 5, 6, 666]
    


```python
a = [1,2,3,4,5,6,666]
print(a)
print(id(a))
# list变量，简单的赋值操作，是传地址 

b = a.copy() #用copy来传
#b的地址和a的地址不同了，a和b除了值一样，其他没有关系
print(b)
print(id(b)) 

b[3] = 777
print(a) 
print(b)

```

    [1, 2, 3, 4, 5, 6, 666]
    1815499225992
    [1, 2, 3, 4, 5, 6, 666]
    1815480312520
    [1, 2, 3, 4, 5, 6, 666]
    [1, 2, 3, 777, 5, 6, 666]
    


```python
#deep cope 深copy
#深copy需要使用特定工具
#列表里面又嵌套一个列表，浅copy只能copy一层，浅copy在处理后面的[5,6,7] copy的只是地址
a = [1,2,3,4,[5,6,7]] 
b = a.copy()

print (a)
print (b)

print(id(a))
print(id(b))

#两个id一致
print(id(a[3])) 
print(id(b[3]))

# 第一层没有同时改变，但是在第二层是同时改变了
a[2] = 55
a[4][2]=66

print(a)
print(b)
    
```

    [1, 2, 3, 4, [5, 6, 7]]
    [1, 2, 3, 4, [5, 6, 7]]
    1815499223816
    1815499225992
    1777885440
    1777885440
    [1, 2, 55, 4, [5, 6, 66]]
    [1, 2, 3, 4, [5, 6, 66]]
    

## 5.4元祖 -tuple 
- 元祖可以看出一个**不可更改**的list

### 5.4.1元祖创建
- 创建空元祖
- 创建只有一个值的元祖
- 创建多个值的元祖
- 使用其他结构创建
    - tuple(L)


```python
# 创建空元祖
t = ()
print (type(t)) #是tuple类型
```

    <class 'tuple'>
    


```python
#创建只有一个值的元祖
t =(1,)
print(type(t))
#是int类型
t =(1)
print(type(t)) 
t =1,
print(type(t))
```

    <class 'tuple'>
    <class 'int'>
    <class 'tuple'>
    


```python
#创建多个值的元祖
t = (1,2,3,4,5)
print(type(t))
print (t)

t = 1,2,3,4,5
print(type(t))
print (t)
```

    <class 'tuple'>
    (1, 2, 3, 4, 5)
    <class 'tuple'>
    (1, 2, 3, 4, 5)
    


```python
#使用其他结构创建
# L是list
L = [1,2,3,4,5]
t = tuple(L)
print(type(t))
print (t)
```

    <class 'tuple'>
    (1, 2, 3, 4, 5)
    


```python
t = [1,2,3,4,6,7]
t2 =[i for i in t]
print (t2)
```

    [1, 2, 3, 4, 6, 7]
    


```python
f =(1,2,4)
t2 = (i for i in f)
# 元祖不能用和list一样的方法创建
print (t2) 

print (id(f))
print (id(t2))
```

    <generator object <genexpr> at 0x000001A6B2DE9678>
    1815476596312
    1815477130872
    


```python
t =(1,2,4)
for i in t:
    print(i, end=" ")
# 得出的不是元祖
```

    1 2 4 

### 5.4.2元祖的特性
- 是序列组，有序
- 元祖数据值可以访问，**不能修改，不能修改，不能修改**
- 元祖数据可以是任意类型
- 总之，list所有特性，除了**可修改**外，元祖都具有
- 意味着，list具有一些操作，比如索引，分片，序列相加，相乘，成员资格操作等一样

### 5.4.3索引操作
- 索引
- 超标错误
- 切片
    - 切片可以超标


```python
# 索引操作
t = (1,2,3,4,6,7)
print(t[4])
```

    6
    


```python
#超标错误
print(t[7])
```


    ---------------------------------------------------------------------------

    IndexError                                Traceback (most recent call last)

    <ipython-input-159-ab367618f010> in <module>()
          1 #超标错误
    ----> 2 print(t[7])
    

    IndexError: tuple index out of range



```python
#切片
#还是包含左，不包含右
t = (1,2,3,4,6,7)
t1 = t[1:4:1] 
t2 = t[1::2] # 步长为2
print(t)
print(id(t))
print(t1)
print(id(t1))
print(t2)
print(id(t2))
```

    (1, 2, 3, 4, 6, 7)
    1815497899464
    (2, 3, 4)
    1815498984544
    (2, 4, 7)
    1815480514960
    


```python
#切片可以超标
t3 = t[2:100]
print(t3)
```

    (3, 4, 6, 7)
    

### 5.4.4序列相加
- 原值重新赋值，地址改变
- tuple的不可修改，是指内容的不可修改


```python
#序列相加
t1 = (1,2,3)
t2 = (5,6,7)
#传址操作
print(t1)
print(id(t1))

t1 += t2
print(t1)
#修改id是新的
print(id(t1)) 
```

    (1, 2, 3)
    1815498982888
    (1, 2, 3, 5, 6, 7)
    1815497899368
    


```python
print(t1[1])
```

    2
    


```python
# 指内容的不可修改
t1[1] = 100
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-171-ae3fb9a47235> in <module>()
    ----> 1 t1[1] = 100
    

    TypeError: 'tuple' object does not support item assignment


### 5.4.5元祖相乘
- 元祖相连


```python
# 元祖相乘
# 三个t相连
t = [1,2,3,4,6,7]
t1 = t *3  
print (t1)

t =(1,2,4)
t1 = t *3
print (t1)
```

    [1, 2, 3, 4, 6, 7, 1, 2, 3, 4, 6, 7, 1, 2, 3, 4, 6, 7]
    (1, 2, 4, 1, 2, 4, 1, 2, 4)
    

### 5.4.6成员检测


```python
# 成员检测
t =(1,2,4)
if 2 in t:
    print("yes")
else:
    print("No")
```

    yes
    

### 5.4.7元祖的遍历
- 一般用for

#### 5.4.7.1 单层元祖遍历


```python
t =(1,2,4)
for i in t:
    print(i)
```

    1
    2
    4
    


```python
t =(1,2,4)
for i in t:
    print(i, end=" ")
# 得出的不是元祖
```

    1 2 4 


```python
f =(1,2,4)
t2 = (i for i in f)
# 元祖不能用和list一样的方法创建
print (t2) 
```

    <generator object <genexpr> at 0x000001A6B4319048>
    

#### 5.4.7.2 双层元祖遍历
- 元祖套元祖


```python
# 双层元祖的遍历
t = ((1,2,3),(4,5,6),(7,8,9))
for i in t:
    print(i)

for k,m,n in t:
    print(k,"..",m,"..",n)
```

    (1, 2, 3)
    (4, 5, 6)
    (7, 8, 9)
    1 .. 2 .. 3
    4 .. 5 .. 6
    7 .. 8 .. 9
    


```python
#如果元祖里元素类型既有数字，又有字符串（需要自己写for循环来一个一个处理）
tu = (111,'alex',(11,['aa','xhg',(78,43)],'aaa'),789,)
s = ''
for item in tu:
    s = s + ' '+ str(item)
    print(s)
```

     111
     111 alex
     111 alex (11, ['aa', 'xhg', (78, 43)], 'aaa')
     111 alex (11, ['aa', 'xhg', (78, 43)], 'aaa') 789
    


```python
#如果元祖里元素类型只有字符串，使用join即可
tu = ('adf','qwe','xhg')
s = ''.join(tu)
print(s)
```

    adfqwexhg
    


```python
#元祖一级元素不可以删除、修改、增加
#所以，这里的修改针对的是元祖二级以上的元素
tu = (111,'alex',(11,['aa','xhg',(78,43)],'aaa'),789,)
tu[2][1][0] = 666
print(tu)
```

    (111, 'alex', (11, [666, 'xhg', (78, 43)], 'aaa'), 789)
    

### 5.4.8关于元祖的函数
- 以下函数， 对list基本适用
- 基本和list通用，除了append等（改变了元祖）
- max, min
- tuple 转化成或创建元祖
- count()
- index
    - 如果有重复值，返回第一个


```python
#len: 获取元祖的长度
t = (1,2,3,4,5)
len(t)
```




    5




```python
# max, min:
print(max(t))
print(min(t))
```

    5
    1
    


```python
# tuple 转化成或创建元祖
l = [1,2,3,4,5]
t = tuple(l)
print(t)

#空元祖
t = tuple()
print (t)
```

    (1, 2, 3, 4, 5)
    ()
    


```python
# count()： 计算指定数据出现的次数
t = (1,2,3,4,2,5,6,2,3,4,5)
print(t.count(2))

# index: 求指定元素在元祖中的索引的位置, 返回第一个
print(t.index(2))
```

    3
    1
    

### 5.4.9元祖变量交换法
- 两个变量交换值
- a, b = b, a


```python
a = 1
b = 3

# java的写法
c = a
a = b
b = c
print (a)
print (b)

print ('***')

# python
a, b = b, a
print (a)
print (b)

```

    3
    1
    ***
    1
    3
    

## 5.5集合 set
- 一堆**确定的无序的唯一的**数据，集合中每一个数据成为一个元素

### 5.5.1集合的定义


```python
# 如果只用大括号定义，则定义的是一个dict类型
d = {}
print (type(d))
print (d)
```

    <class 'dict'>
    {}
    


```python
## 大括号里面一定要有值，否则定义的是一个dict
s = {1,23,4,5,6}
print (type(s))
print (s)
```

    <class 'set'>
    {1, 4, 5, 6, 23}
    


```python
s = set()
print (type(s))
print (s)
```

    <class 'set'>
    set()
    

### 5.5.2集合的特征
- 集合内数据**无序**，即**无法使用索引和分片**
- 集合内数据元素具有**唯一性**，可以用来排除重复数据
- 集合内的数据，str，int，float， tuple， 冰冻集合等，即内部自能放置可哈希数据

### 5.5.3成员检测
- in， not in


```python
# 成员检测
# in， not in
s = {4,5,6,'i','io','one'}
print (s) #打印的结果无序

if 'love' in s:
    print ('ok')
    
if 'two' not in s:
    print ('not ok')
```

    {4, 5, 6, 'i', 'one', 'io'}
    not ok
    

### 5.5.4集合的遍历操作
- for
- 带有元祖的集合遍历


```python
# for 循环
s = {4,5,6,'i','one','123'}

for i in s:
    print (i, end =" ") #说明set的无序性
```

    4 5 6 i one 123 


```python
# 集合里面可以有元祖
# 带有元祖的集合遍历
s = {(1,2,3),(4,5,6),('i','love','one')}

# 集合本身set不可hash，如果用for，内部不能放set 
# unhashable type: 'set'
# s = {{1,2,3},{4,5,6},{'i','love','one'}} 

for k,m,n in s:
    print(k, "...", m,"...",n)
print('')
for k in s:
    print(k) # k是tuple元素
```

    4 ... 5 ... 6
    i ... love ... one
    1 ... 2 ... 3
    
    (4, 5, 6)
    ('i', 'love', 'one')
    (1, 2, 3)
    

### 5.5.5集合的内涵
- 过滤掉重复元素
- 普通集合内涵
     - 带条件的集合内涵


```python
# 普通集合内涵
# 初始化之后自动过滤掉重复元素
s = {1,2,3,4,5,66,7,8,22,33,1,2,3,4,6,7,4,1,2,3}
print (s)

#普通集合内涵
ss = {i for i in s}
print (ss)
```

    {1, 2, 3, 4, 5, 66, 7, 8, 33, 6, 22}
    {1, 2, 3, 4, 5, 66, 7, 8, 33, 6, 22}
    


```python
# 带条件的集合内涵
# 保留偶数
sss = {i for i in s if i%2 ==0}
print (sss)
```

    {2, 66, 4, 6, 8, 22}
    


```python
# 多循环的集合内涵
# 对字符串的乘法就是让字符串变长
s1 = {1,2,3}
s2 = {"a","b","c"}

s = {m*n for m in s1 for n in s2} #无序
# 一共是m*n个元素
print(s)

s = {m*n for m in s1 for n in s2 if m==2} #无序
print(s)
```

    {'bbb', 'a', 'b', 'ccc', 'cc', 'c', 'aaa', 'aa', 'bb'}
    {'cc', 'aa', 'bb'}
    


```python
s1 = {1,2,3}
s2 = {5,6,7}

s = {m*n for m in s1 for n in s2} #无序
# 一共是m*n个元素
print(s)

s = {m*n for m in s1 for n in s2 if m==2} #无序
print(s)
```

    {5, 6, 7, 10, 12, 14, 15, 18, 21}
    {10, 12, 14}
    

### 5.5.6集合函数/关于集合的函数
- len
- max
- min
- set
    - 生成一个set集合
- add
    - 向集合内添加元素
- clear
    - clear函数只是原地清空
- copy
    - 拷贝
- remove
    - 移除指定的值, 直接改变原有值，要删除的值不存在，就报错
- discard
    - 移除集合中指定的值，要删除的值不存在，不报错
- pop
    - 随机移除一个元素
- difference
    - 差集
- union
    - 并集
- issubset
    - 检测一个集合是否为另一个子集
- '-'
    - difference类似


```python
# len, max, min: 跟其他基本函数一致
s1 = {1,2,3,4,1,2,3,5,6,8,9,9,10,10}
print (len(s1))
print (max(s1))
print (min(s1))
```

    9
    10
    1
    


```python
# set:生成一个set集合
s1 = [1,2,3,4,1,2,3,5,6,8,9,9,10]
s = set(s1)
print (s)
```

    {1, 2, 3, 4, 5, 6, 8, 9, 10}
    


```python
# add: 向集合内添加元素
s1 = {1,2,3,4,1,2,3,5,6,8,9,9,10}
s1.add(334)
print(s1)
```

    {1, 2, 3, 4, 5, 6, 8, 9, 10, 334}
    


```python
# clear
s1 = {1,2,3,4,1,2,3,5,6,8,9,9,10}
print (id(s1))
s1.clear()
print (id(s1)) #clear函数只是原地清空
```

    1815498336072
    1815498336072
    


```python
# copy：拷贝
# remove：移除指定的值, 直接改变原有值，要删除的值不存在，就报错
s1 = {1,2,3,4,1,2,3,5,6,8,9,9,10}
s1.remove(4)
print(s1)

```

    {1, 2, 3, 5, 6, 8, 9, 10}
    


```python
# discard： 移除集合中指定的值，要删除的值不存在，不报错
s1.discard(1)
print(s1)
```

    {2, 3, 5, 6, 8, 9, 10}
    


```python
s1.remove(4)
print(s1) #4已经不存在，报错
```


    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    <ipython-input-257-056635d0cc28> in <module>()
    ----> 1 s1.remove(4)
          2 print(s1) #4已经不存在，报错
    

    KeyError: 4



```python
s1.discard(1)
print(s1) # 虽然之前就不存在1，不报错
```

    {2, 3, 5, 6, 8, 9, 10}
    


```python
# pop 随机移除一个元素
s1 = {1,2,3,4,1,2,3,5,6,8,9,9,10}
d = s1.pop()
print(s1)
print(d)
```

    {2, 3, 4, 5, 6, 8, 9, 10}
    1
    


```python
# 集合函数
# intersection: 交集
# difference: 差集
# union: 并集
# issubset: 检测一个集合是否为另一个子集
# issuperset: 检测一个集合是否为另一个超集
s1 = {1,2,3,4,5,6}
s2 = {5,6,7,8,9,10}
```


```python
# intersection: 交集
s_1 = s1.intersection(s2)
print (s_1)
```

    {5, 6}
    


```python
# difference: 差集 
# s1中去除和s2相同的部分
s_2 = s1.difference(s2)
print (s_2)
```

    {1, 2, 3, 4}
    


```python
# union: 并集
s_3 = s1.union(s2)
print (s_3)
```

    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    


```python
print(s1.issubset(s2))
print(s2.issubset(s2))
print(s2.issuperset(s2))
```

    False
    True
    True
    


```python
# 集合的数学操作 
# difference类似
s1 = {1,2,3,4,5,6}
s2 = {5,6,7,8,9,10}

s_1 = s1 - s2
print (s_1)
```

    {1, 2, 3, 4}
    


```python
s1 = {1,2,3,4,5,6}
s2 = {5,6,7,8,9,10}
# + 不可行
s_1 = s1 + s2
print (s_1)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-269-759b832ced4b> in <module>()
          2 s2 = {5,6,7,8,9,10}
          3 
    ----> 4 s_1 = s1 + s2
          5 print (s_1)
    

    TypeError: unsupported operand type(s) for +: 'set' and 'set'


### 5.5.7frozen set: 冰冻集合
- 不可以进行任何修改的集合
- 定义成冰冻集合
- 就是一种特殊的集合


```python
# 创建
s = frozenset()
print(type(s))
```

    <class 'frozenset'>
    

## 5.6dict字典
- 字典是一种组合数据，没有顺序的组合数据
- 数据以健值对形式出现
- d.keys()
- d.values()
- d.items()

### 5.6.1字典的创建


```python
# 字典的创建, 大括号完事，里面不填内容，填了内容就是set
d = {}
print (d)
print (type(d))

d = dict()  # set()
print (d)
print (type(d))
```

    {}
    <class 'dict'>
    {}
    <class 'dict'>
    


```python
#放进去的值必须是健值对, 每一组数据用冒号隔开，每一对健值对用冒号隔开
d = {"one": 1,"two": 2,"three": 3}
print (d)
print (type(d))

# 用dict创建有内容的字典
d = dict({"one": 1,"two": 2,"three": 3})
print (d)
print (type(d))

# 用dict创建有内容的字典
# 利用关键字参数
d = dict(one= 1,two= 2,three= 3)
print (d)
print (type(d))
```

    {'one': 1, 'two': 2, 'three': 3}
    <class 'dict'>
    {'one': 1, 'two': 2, 'three': 3}
    <class 'dict'>
    {'one': 1, 'two': 2, 'three': 3}
    <class 'dict'>
    

### 5.6.2字典的特征
- 字典是序列类型，但是是**无序序列**，所以**没有分片和索引**
- 字典中的数据每个都有键值对组成，即kv对
    - key：必须是可哈希的值，比如int，string，float，tuple 但是 list，set，dict不行
    - value：任何值

### 5.6.3访问数据，给健值


```python
#访问数据，给健值
d = {'one': 1, 'two': 2, 'three': 3}
# 中括号内放健值，要有引号
print (d["one"])

# 赋值
d["one"] = "eins"
print (d)

# 删除某个操作
# 使用del操作
del d["one"]
print (d)
```

    1
    {'one': 'eins', 'two': 2, 'three': 3}
    {'two': 2, 'three': 3}
    

### 5.6.4成员检测
- in ，not in 
- 检测的是键key内容


```python
# 成员检测， in not in 
# 检测的是键key
d = {'one': 1, 'two': 2, 'three': 3}

if 2 in d:
    print("value1")    
if "two" in d:
    print("key")   
if ("two",2) in d:
    print("key, value2")
```

    key
    

### 5.6.5字典的遍历for循环
- 按k值来使用for循环
- 只访问字典的值


```python
# 按k值来使用for循环
d = {'one': 1, 'two': 2, 'three': 3}
# 使用for循环，直接按key值访问 访问的健值
for k in d:
    print(k,d[k])
print('')   

# 访问的健值
for k in d.keys():
    print(k,d[k])
print('')  

# 只访问字典的值 
for v in d.values():
    print(v)
print('')   
#
for k,v in d.items():
    print (k,"...",v)
print('')   

# 这样写不行  
# too many values to unpack (expected 2)
for k,v in d:
    print (k,"...",v)
```

    one 1
    two 2
    three 3
    
    one 1
    two 2
    three 3
    
    1
    2
    3
    
    one ... 1
    two ... 2
    three ... 3
    
    


    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    <ipython-input-282-1c2fd1921e9b> in <module>()
         18 print('')
         19 # 这样写不行
    ---> 20 for k,v in d:
         21     print (k,"...",v)
    

    ValueError: too many values to unpack (expected 2)


### 5.6.6字典生成式


```python
# 字典生成式
d = {'one': 1, 'two': 2, 'three': 3}

#常规字典生成式
dd = {k:v for k,v in d.items()}
print(dd)
```

    {'one': 1, 'two': 2, 'three': 3}
    


```python
#加限制条件，过滤后的字典生成式
d = {'one': 1, 'two': 2, 'three': 3}
dd = {k:v for k,v in d.items() if v%2==0}
print(dd)
```

    {'two': 2}
    

### 5.6.7字典相关函数
- len
- max
- min
- str
- clear
- items
    - d.items()
- keys
    - d.keys()
- values
    - d.values()
- get
    - 可以设置默认值
- fromkeys
    - 使用指定的序列作为键，使用一个值作为字典的所有键的值


```python
# 通用函数: len, max, min, dict
# str(字典): 返回字典的字符串格式
d = {'one': 1, 'two': 2, 'three': 3}
print(str(d))
```

    {'one': 1, 'two': 2, 'three': 3}
    


```python
# clear: 清空
d.clear()
print(d)
```

    {}
    


```python
# items: 返回字典的键值对组成的元祖格式
d = {'one': 1, 'two': 2, 'three': 3}
i = d.items() #特殊的类型 可以迭代
print(type(i))
print(i)
```

    <class 'dict_items'>
    dict_items([('one', 1), ('two', 2), ('three', 3)])
    


```python
# keys: 返回字典的键组成的一个结构, 可迭代的一个结构
k = d.keys()
print(type(k))
print(k)
```

    <class 'dict_keys'>
    dict_keys(['one', 'two', 'three'])
    


```python
# values: 同理，一个可迭代的结构
k = d.values()
print(type(k))
print(k)
```

    <class 'dict_values'>
    dict_values([1, 2, 3])
    


```python
# get: 根据指定的键返回相应的值，好处是，可以设置默认值
d = {'one': 1, 'two': 2, 'three': 3}
print(d.get('one'))
print(d.get('233'))

# get默认值是none，可以设置
print(d.get('233',100)) #默认值返回100
print(d.get('one',100))
print(d.get('233'))
```

    1
    None
    100
    1
    None
    


```python
# get的好处就是可以设置默认值
print(d['333'])
```


    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    <ipython-input-298-955be131c421> in <module>()
    ----> 1 print(d['333'])
    

    KeyError: '333'



```python
# fromkeys: 使用指定的序列作为键，使用一个值作为字典的所有键的值
L = ['a','b','c','d','e']
#注意fromkeys两个参数的类型
#注意fromkeys的调用主体
d = dict.fromkeys(L,'hahaha')
print(d)
```

    {'a': 'hahaha', 'b': 'hahaha', 'c': 'hahaha', 'd': 'hahaha', 'e': 'hahaha'}
    
