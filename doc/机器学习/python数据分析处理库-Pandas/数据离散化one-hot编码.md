# 数据离散化
## 1什么是数据离散化
- 连续属性的离散化就是将连续属性的值域上，将值域划分为若干个离散的区间，最后用不同的符号或者整数值代表落在每个子区间中的属性值
- 表现形式ont-hot编码，也叫哑变量
## 2为什么要离散化
- 连续属性离散化的目的是为了简化数据结构，数据离散化技术可以用来减少给定连续属性值的个数，离散化方法经常作为数据挖掘的工具
## 3如何实现数据的离散化
- 对分好组的数据求哑变量
    - **pandas.get_dummies(data,prefix=None)**
        - data: array-like, Series, or DataFrame
        - prefix: 分组名字，前缀
- 对数据进行分组
    - 对数据进行分组将数据分组 一般会与value_counts搭配使用，统计每组的个数
        - **series.value_counts()**: 统计分组每组成员个数


```python
# 准备数据
data = pd.Series([165,174,160,180,159,163,192,184], index=['No1:165', 'No2:174','No3:160', 'No4:180', 'No5:159', 'No6:163', 'No7:192', 'No8:184'])
data
```




    No1:165    165
    No2:174    174
    No3:160    160
    No4:180    180
    No5:159    159
    No6:163    163
    No7:192    192
    No8:184    184
    dtype: int64



### 3.1自动分组


```python
# 分组
## 自动分组
sr = pd.qcut(data,3)
```


```python
type(sr)
```




    pandas.core.series.Series




```python
sr
```




    No1:165      (163.667, 178.0]
    No2:174      (163.667, 178.0]
    No3:160    (158.999, 163.667]
    No4:180        (178.0, 192.0]
    No5:159    (158.999, 163.667]
    No6:163    (158.999, 163.667]
    No7:192        (178.0, 192.0]
    No8:184        (178.0, 192.0]
    dtype: category
    Categories (3, interval[float64]): [(158.999, 163.667] < (163.667, 178.0] < (178.0, 192.0]]




```python
sr.value_counts() # 可以观察没个区间有多少人
```




    (178.0, 192.0]        3
    (158.999, 163.667]    3
    (163.667, 178.0]      2
    dtype: int64




```python
# 转化成哑变量
pd.get_dummies(sr,prefix="身高")
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>身高_(158.999, 163.667]</th>
      <th>身高_(163.667, 178.0]</th>
      <th>身高_(178.0, 192.0]</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>No1:165</th>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No2:174</th>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No3:160</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No4:180</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>No5:159</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No6:163</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No7:192</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>No8:184</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



### 3.2自定义分组


```python
# 自定义分组
bins = [150, 165, 180, 195]
sr = pd.cut(data,bins)
```


```python
sr
```




    No1:165    (150, 165]
    No2:174    (165, 180]
    No3:160    (150, 165]
    No4:180    (165, 180]
    No5:159    (150, 165]
    No6:163    (150, 165]
    No7:192    (180, 195]
    No8:184    (180, 195]
    dtype: category
    Categories (3, interval[int64]): [(150, 165] < (165, 180] < (180, 195]]




```python
sr.value_counts()
```




    (150, 165]    4
    (180, 195]    2
    (165, 180]    2
    dtype: int64




```python
pd.get_dummies(sr, prefix="身高")
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>身高_(150, 165]</th>
      <th>身高_(165, 180]</th>
      <th>身高_(180, 195]</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>No1:165</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No2:174</th>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No3:160</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No4:180</th>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No5:159</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No6:163</th>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>No7:192</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>No8:184</th>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



## 4股票案例分析


```python
### 股票涨跌幅离散化处理 p_change
# 读取数据
stock = pd.read_csv("stock_day.csv")
stock.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>open</th>
      <th>high</th>
      <th>close</th>
      <th>low</th>
      <th>volume</th>
      <th>price_change</th>
      <th>p_change</th>
      <th>ma5</th>
      <th>ma10</th>
      <th>ma20</th>
      <th>v_ma5</th>
      <th>v_ma10</th>
      <th>v_ma20</th>
      <th>turnover</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2018-02-27</th>
      <td>23.53</td>
      <td>25.88</td>
      <td>24.16</td>
      <td>23.53</td>
      <td>95578.03</td>
      <td>0.63</td>
      <td>2.68</td>
      <td>22.942</td>
      <td>22.142</td>
      <td>22.875</td>
      <td>53782.64</td>
      <td>46738.65</td>
      <td>55576.11</td>
      <td>2.39</td>
    </tr>
    <tr>
      <th>2018-02-26</th>
      <td>22.80</td>
      <td>23.78</td>
      <td>23.53</td>
      <td>22.80</td>
      <td>60985.11</td>
      <td>0.69</td>
      <td>3.02</td>
      <td>22.406</td>
      <td>21.955</td>
      <td>22.942</td>
      <td>40827.52</td>
      <td>42736.34</td>
      <td>56007.50</td>
      <td>1.53</td>
    </tr>
    <tr>
      <th>2018-02-23</th>
      <td>22.88</td>
      <td>23.37</td>
      <td>22.82</td>
      <td>22.71</td>
      <td>52914.01</td>
      <td>0.54</td>
      <td>2.42</td>
      <td>21.938</td>
      <td>21.929</td>
      <td>23.022</td>
      <td>35119.58</td>
      <td>41871.97</td>
      <td>56372.85</td>
      <td>1.32</td>
    </tr>
    <tr>
      <th>2018-02-22</th>
      <td>22.25</td>
      <td>22.76</td>
      <td>22.28</td>
      <td>22.02</td>
      <td>36105.01</td>
      <td>0.36</td>
      <td>1.64</td>
      <td>21.446</td>
      <td>21.909</td>
      <td>23.137</td>
      <td>35397.58</td>
      <td>39904.78</td>
      <td>60149.60</td>
      <td>0.90</td>
    </tr>
    <tr>
      <th>2018-02-14</th>
      <td>21.49</td>
      <td>21.99</td>
      <td>21.92</td>
      <td>21.48</td>
      <td>23331.04</td>
      <td>0.44</td>
      <td>2.05</td>
      <td>21.366</td>
      <td>21.923</td>
      <td>23.253</td>
      <td>33590.21</td>
      <td>42935.74</td>
      <td>61716.11</td>
      <td>0.58</td>
    </tr>
  </tbody>
</table>
</div>




```python
p_change = stock['p_change']
```


```python
p_change.head()
```




    2018-02-27    2.68
    2018-02-26    3.02
    2018-02-23    2.42
    2018-02-22    1.64
    2018-02-14    2.05
    Name: p_change, dtype: float64




```python
# 分组
## 自动分组
sr = pd.qcut(p_change,10)
sr.head()
```




    2018-02-27    (1.738, 2.938]
    2018-02-26     (2.938, 5.27]
    2018-02-23    (1.738, 2.938]
    2018-02-22     (0.94, 1.738]
    2018-02-14    (1.738, 2.938]
    Name: p_change, dtype: category
    Categories (10, interval[float64]): [(-10.031, -4.836] < (-4.836, -2.444] < (-2.444, -1.352] < (-1.352, -0.462] ... (0.94, 1.738] < (1.738, 2.938] < (2.938, 5.27] < (5.27, 10.03]]




```python
sr.value_counts()
```




    (5.27, 10.03]        65
    (0.26, 0.94]         65
    (-0.462, 0.26]       65
    (-10.031, -4.836]    65
    (2.938, 5.27]        64
    (1.738, 2.938]       64
    (-1.352, -0.462]     64
    (-2.444, -1.352]     64
    (-4.836, -2.444]     64
    (0.94, 1.738]        63
    Name: p_change, dtype: int64




```python
## 离散化
pd.get_dummies(sr,prefix="涨跌幅").head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>涨跌幅_(-10.031, -4.836]</th>
      <th>涨跌幅_(-4.836, -2.444]</th>
      <th>涨跌幅_(-2.444, -1.352]</th>
      <th>涨跌幅_(-1.352, -0.462]</th>
      <th>涨跌幅_(-0.462, 0.26]</th>
      <th>涨跌幅_(0.26, 0.94]</th>
      <th>涨跌幅_(0.94, 1.738]</th>
      <th>涨跌幅_(1.738, 2.938]</th>
      <th>涨跌幅_(2.938, 5.27]</th>
      <th>涨跌幅_(5.27, 10.03]</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2018-02-27</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-26</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-23</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-22</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-14</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




```python
## 自定义分组
bins = [-100, -7, -5, -3, 0, 3, 5, 7, 100]
sr = pd.cut(p_change,bins)
```


```python
sr.value_counts()
```




    (0, 3]        215
    (-3, 0]       188
    (3, 5]         57
    (-5, -3]       51
    (7, 100]       35
    (5, 7]         35
    (-100, -7]     34
    (-7, -5]       28
    Name: p_change, dtype: int64




```python
stock_change = pd.get_dummies(sr,prefix="rise")
stock_change.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>rise_(-100, -7]</th>
      <th>rise_(-7, -5]</th>
      <th>rise_(-5, -3]</th>
      <th>rise_(-3, 0]</th>
      <th>rise_(0, 3]</th>
      <th>rise_(3, 5]</th>
      <th>rise_(5, 7]</th>
      <th>rise_(7, 100]</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2018-02-27</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-26</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-23</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-22</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2018-02-14</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>
