
# Pandas日期数据处理：如何按日期筛选、显示及统计数据

## 一般在处理数据时，如果提供的数据集没有行列索引，我们需要先设置行列索引，将date设置为index是很好的选择

## 如果提供的数据集有行列索引，其中date为列索引中的一条，可以用以下的办法来处理数据
###  to_period()方法


```python
import pandas as pd
data = pd.read_csv('./E-Commerce Data.csv')
data.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>InvoiceDate</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>12/1/2010 8:26</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>1</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>12/1/2010 8:26</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>12/1/2010 8:26</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>3</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>12/1/2010 8:26</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>4</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>12/1/2010 8:26</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
data.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 541909 entries, 0 to 541908
    Data columns (total 8 columns):
    InvoiceNo      541909 non-null object
    StockCode      541909 non-null object
    Description    540455 non-null object
    Quantity       541909 non-null int64
    InvoiceDate    541909 non-null object
    UnitPrice      541909 non-null float64
    CustomerID     406829 non-null float64
    Country        541909 non-null object
    dtypes: float64(2), int64(1), object(5)
    memory usage: 33.1+ MB
    


```python
# 对其他数据暂不处理，我们需要求出每个月的销售额
# 提供的数据集中的InvoiceDate的type是object
# InvoiceDate 需要把数据类型转化成时间类型
# data这列我们只需要保留年月日
# 构造一个函数 把InvoiceDate分成两个部分，保留前面这部分
data['InvoiceDate'] = data['InvoiceDate'].apply(lambda x: x.split(' ')[0])
data.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>InvoiceDate</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>12/1/2010</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>1</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>12/1/2010</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>12/1/2010</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>3</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>12/1/2010</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>4</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>12/1/2010</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 把InvoiceDate类型转换成时间类型
data['InvoiceDate'] = pd.to_datetime(data['InvoiceDate'])
```


```python
# 观察修改完的数据集
data.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>InvoiceDate</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2010-12-01</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>1</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>2010-12-01</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2010-12-01</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>3</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>2010-12-01</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>4</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>2010-12-01</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 将InvoiceDate设置为index
data_new = data.set_index('InvoiceDate')
data_new.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 此时我们获得是一个年月日格式为行索引的数据，但是我们需要的是以月为单位
# 需要用到同to_period
data_period = data_new.to_period('M')
```


```python
data_period.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 列出了所有的月份
data_period.index.unique()
```




    PeriodIndex(['2010-12', '2011-01', '2011-02', '2011-03', '2011-04', '2011-05',
                 '2011-06', '2011-07', '2011-08', '2011-09', '2011-10', '2011-11',
                 '2011-12'],
                dtype='period[M]', name='InvoiceDate', freq='M')




```python
# 计算出每个月的销售额，并且排序
data_period['sales amount'] = data_period['Quantity'] * data_period['UnitPrice']
data_period.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
      <th>sales amount</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
      <td>15.30</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
      <td>20.34</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
      <td>22.00</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
      <td>20.34</td>
    </tr>
    <tr>
      <th>2010-12</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
      <td>20.34</td>
    </tr>
  </tbody>
</table>
</div>




```python
data_period.groupby('InvoiceDate')['sales amount'].sum().sort_values(ascending = False)
```




    InvoiceDate
    2011-11    1461756.250
    2011-10    1070704.670
    2011-09    1019687.622
    2010-12     748957.020
    2011-05     723333.510
    2011-06     691123.120
    2011-03     683267.080
    2011-08     682680.510
    2011-07     681300.111
    2011-01     560000.260
    2011-02     498062.650
    2011-04     493207.121
    2011-12     433668.010
    Freq: M, Name: sales amount, dtype: float64




```python
### 按年处理
data_period2 = data_new.to_period('A')
data_period2.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>



## 按日期筛选数据


```python
data_period2['2010'].head(2)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
data_period2['2010'].tail(2)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010</th>
      <td>539992</td>
      <td>22258</td>
      <td>FELT FARM ANIMAL RABBIT</td>
      <td>1</td>
      <td>1.25</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>539992</td>
      <td>21155</td>
      <td>RED RETROSPOT PEG BAG</td>
      <td>1</td>
      <td>2.10</td>
      <td>NaN</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
#获取2010至2011年的数据
data_period2['2010':'2011'].tail(2)  
# 报错 Cannot compare type 'Period' with type 'int' 
```


```python
# 我们可以选择用period之前的数据
data_new['2010':'2011'].tail(2)  
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2011-12-09</th>
      <td>581587</td>
      <td>23255</td>
      <td>CHILDRENS CUTLERY CIRCUS PARADE</td>
      <td>4</td>
      <td>4.15</td>
      <td>12680.0</td>
      <td>France</td>
    </tr>
    <tr>
      <th>2011-12-09</th>
      <td>581587</td>
      <td>22138</td>
      <td>BAKING SET 9 PIECE RETROSPOT</td>
      <td>3</td>
      <td>4.95</td>
      <td>12680.0</td>
      <td>France</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 获取某月的数据
data_period['2011-10'].head(10)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
      <th>sales amount</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2011-10</th>
      <td>569203</td>
      <td>79321</td>
      <td>CHILLI LIGHTS</td>
      <td>48</td>
      <td>4.95</td>
      <td>16353.0</td>
      <td>United Kingdom</td>
      <td>237.60</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569203</td>
      <td>21154</td>
      <td>RED RETROSPOT OVEN GLOVE</td>
      <td>20</td>
      <td>1.25</td>
      <td>16353.0</td>
      <td>United Kingdom</td>
      <td>25.00</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>21790</td>
      <td>VINTAGE SNAP CARDS</td>
      <td>4</td>
      <td>0.85</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>3.40</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>23284</td>
      <td>DOORMAT KEEP CALM AND COME IN</td>
      <td>15</td>
      <td>7.08</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>106.20</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>23355</td>
      <td>HOT WATER BOTTLE KEEP CALM</td>
      <td>4</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>19.80</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>22207</td>
      <td>FRYING PAN UNION FLAG</td>
      <td>2</td>
      <td>4.25</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>8.50</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>22111</td>
      <td>SCOTTIE DOG HOT WATER BOTTLE</td>
      <td>2</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>9.90</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>22112</td>
      <td>CHOCOLATE HOT WATER BOTTLE</td>
      <td>3</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>14.85</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>22835</td>
      <td>HOT WATER BOTTLE I AM SO POORLY</td>
      <td>2</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>9.90</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>569204</td>
      <td>22476</td>
      <td>EMPIRE UNION JACK TV DINNER TRAY</td>
      <td>6</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
      <td>29.70</td>
    </tr>
  </tbody>
</table>
</div>




```python
data_new['2011-10'].head(10)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2011-10-02</th>
      <td>569203</td>
      <td>79321</td>
      <td>CHILLI LIGHTS</td>
      <td>48</td>
      <td>4.95</td>
      <td>16353.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569203</td>
      <td>21154</td>
      <td>RED RETROSPOT OVEN GLOVE</td>
      <td>20</td>
      <td>1.25</td>
      <td>16353.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>21790</td>
      <td>VINTAGE SNAP CARDS</td>
      <td>4</td>
      <td>0.85</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>23284</td>
      <td>DOORMAT KEEP CALM AND COME IN</td>
      <td>15</td>
      <td>7.08</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>23355</td>
      <td>HOT WATER BOTTLE KEEP CALM</td>
      <td>4</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>22207</td>
      <td>FRYING PAN UNION FLAG</td>
      <td>2</td>
      <td>4.25</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>22111</td>
      <td>SCOTTIE DOG HOT WATER BOTTLE</td>
      <td>2</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>22112</td>
      <td>CHOCOLATE HOT WATER BOTTLE</td>
      <td>3</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>22835</td>
      <td>HOT WATER BOTTLE I AM SO POORLY</td>
      <td>2</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>569204</td>
      <td>22476</td>
      <td>EMPIRE UNION JACK TV DINNER TRAY</td>
      <td>6</td>
      <td>4.95</td>
      <td>16591.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
#获取具体某天的数据
# 获取具体某天的数据，用datafrme直接选取某天时会报错，而series的数据就没有问题
# print(df[‘2013-11-06‘]) 这样会报错

#可以考虑用区间来获取某天的数据
data_new['2010-12-01':'2010-12-01'].head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
# dataframe的truncate函数可以获取某个时期之前或之后的数据，或者某个时间区间的数据
# 但一般建议直接用切片（slice），这样更为直观，方便
data_period.truncate(after = '2013-11')
# Cannot compare type 'Period' with type 'int'
```


```python
data_new.truncate(after = '2013-11').head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010-12-01</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>




```python
### 按季度显示
data_period2 = data_new.to_period('Q')
data_period2.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>InvoiceNo</th>
      <th>StockCode</th>
      <th>Description</th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
      <th>Country</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010Q4</th>
      <td>536365</td>
      <td>85123A</td>
      <td>WHITE HANGING HEART T-LIGHT HOLDER</td>
      <td>6</td>
      <td>2.55</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010Q4</th>
      <td>536365</td>
      <td>71053</td>
      <td>WHITE METAL LANTERN</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010Q4</th>
      <td>536365</td>
      <td>84406B</td>
      <td>CREAM CUPID HEARTS COAT HANGER</td>
      <td>8</td>
      <td>2.75</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010Q4</th>
      <td>536365</td>
      <td>84029G</td>
      <td>KNITTED UNION FLAG HOT WATER BOTTLE</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
    <tr>
      <th>2010Q4</th>
      <td>536365</td>
      <td>84029E</td>
      <td>RED WOOLLY HOTTIE WHITE HEART.</td>
      <td>6</td>
      <td>3.39</td>
      <td>17850.0</td>
      <td>United Kingdom</td>
    </tr>
  </tbody>
</table>
</div>



### asfreq()方法


```python
#按年频率显示
data_period.index.asfreq('A').values
```




    array([Period('2010', 'A-DEC'), Period('2010', 'A-DEC'),
           Period('2010', 'A-DEC'), ..., Period('2011', 'A-DEC'),
           Period('2011', 'A-DEC'), Period('2011', 'A-DEC')], dtype=object)




```python
#按季度频率显示
data_period.index.asfreq('Q')
```




    PeriodIndex(['2010Q4', '2010Q4', '2010Q4', '2010Q4', '2010Q4', '2010Q4',
                 '2010Q4', '2010Q4', '2010Q4', '2010Q4',
                 ...
                 '2011Q4', '2011Q4', '2011Q4', '2011Q4', '2011Q4', '2011Q4',
                 '2011Q4', '2011Q4', '2011Q4', '2011Q4'],
                dtype='period[Q-DEC]', name='InvoiceDate', length=541909, freq='Q-DEC')




```python
#按月度频率显示
data_period.index.asfreq('M')
```




    PeriodIndex(['2010-12', '2010-12', '2010-12', '2010-12', '2010-12', '2010-12',
                 '2010-12', '2010-12', '2010-12', '2010-12',
                 ...
                 '2011-12', '2011-12', '2011-12', '2011-12', '2011-12', '2011-12',
                 '2011-12', '2011-12', '2011-12', '2011-12'],
                dtype='period[M]', name='InvoiceDate', length=541909, freq='M')




```python
#按工作日显示
data_period.index.asfreq('B', how='start')
```




    PeriodIndex(['2010-12-01', '2010-12-01', '2010-12-01', '2010-12-01',
                 '2010-12-01', '2010-12-01', '2010-12-01', '2010-12-01',
                 '2010-12-01', '2010-12-01',
                 ...
                 '2011-12-01', '2011-12-01', '2011-12-01', '2011-12-01',
                 '2011-12-01', '2011-12-01', '2011-12-01', '2011-12-01',
                 '2011-12-01', '2011-12-01'],
                dtype='period[B]', name='InvoiceDate', length=541909, freq='B')




```python
data_period.index.asfreq('B', how='end')
```




    PeriodIndex(['2010-12-31', '2010-12-31', '2010-12-31', '2010-12-31',
                 '2010-12-31', '2010-12-31', '2010-12-31', '2010-12-31',
                 '2010-12-31', '2010-12-31',
                 ...
                 '2011-12-30', '2011-12-30', '2011-12-30', '2011-12-30',
                 '2011-12-30', '2011-12-30', '2011-12-30', '2011-12-30',
                 '2011-12-30', '2011-12-30'],
                dtype='period[B]', name='InvoiceDate', length=541909, freq='B')



## 按日期统计数据


```python
#按周统计数据
data_new.resample('w').sum()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12-05</th>
      <td>79062.0</td>
      <td>38727.190</td>
      <td>122249393.0</td>
    </tr>
    <tr>
      <th>2010-12-12</th>
      <td>118448.0</td>
      <td>144262.850</td>
      <td>153871225.0</td>
    </tr>
    <tr>
      <th>2010-12-19</th>
      <td>105446.0</td>
      <td>51191.060</td>
      <td>111863691.0</td>
    </tr>
    <tr>
      <th>2010-12-26</th>
      <td>39272.0</td>
      <td>26339.750</td>
      <td>28713439.0</td>
    </tr>
    <tr>
      <th>2011-01-02</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2011-01-09</th>
      <td>73491.0</td>
      <td>60913.670</td>
      <td>81041033.0</td>
    </tr>
    <tr>
      <th>2011-01-16</th>
      <td>85626.0</td>
      <td>34727.420</td>
      <td>73351916.0</td>
    </tr>
    <tr>
      <th>2011-01-23</th>
      <td>67969.0</td>
      <td>38492.160</td>
      <td>73526553.0</td>
    </tr>
    <tr>
      <th>2011-01-30</th>
      <td>69312.0</td>
      <td>32429.420</td>
      <td>87941705.0</td>
    </tr>
    <tr>
      <th>2011-02-06</th>
      <td>67613.0</td>
      <td>28663.970</td>
      <td>79426930.0</td>
    </tr>
    <tr>
      <th>2011-02-13</th>
      <td>50021.0</td>
      <td>26311.540</td>
      <td>62573920.0</td>
    </tr>
    <tr>
      <th>2011-02-20</th>
      <td>80047.0</td>
      <td>29282.140</td>
      <td>80735172.0</td>
    </tr>
    <tr>
      <th>2011-02-27</th>
      <td>82996.0</td>
      <td>41385.850</td>
      <td>90337061.0</td>
    </tr>
    <tr>
      <th>2011-03-06</th>
      <td>67230.0</td>
      <td>30481.970</td>
      <td>86758310.0</td>
    </tr>
    <tr>
      <th>2011-03-13</th>
      <td>54064.0</td>
      <td>36467.250</td>
      <td>83651389.0</td>
    </tr>
    <tr>
      <th>2011-03-20</th>
      <td>86728.0</td>
      <td>48927.710</td>
      <td>93657640.0</td>
    </tr>
    <tr>
      <th>2011-03-27</th>
      <td>72236.0</td>
      <td>30574.780</td>
      <td>99386623.0</td>
    </tr>
    <tr>
      <th>2011-04-03</th>
      <td>104528.0</td>
      <td>39502.710</td>
      <td>102622934.0</td>
    </tr>
    <tr>
      <th>2011-04-10</th>
      <td>61496.0</td>
      <td>45610.450</td>
      <td>95975056.0</td>
    </tr>
    <tr>
      <th>2011-04-17</th>
      <td>85028.0</td>
      <td>27304.941</td>
      <td>100166436.0</td>
    </tr>
    <tr>
      <th>2011-04-24</th>
      <td>72855.0</td>
      <td>32275.960</td>
      <td>77613219.0</td>
    </tr>
    <tr>
      <th>2011-05-01</th>
      <td>50499.0</td>
      <td>18799.510</td>
      <td>58207424.0</td>
    </tr>
    <tr>
      <th>2011-05-08</th>
      <td>75287.0</td>
      <td>50008.350</td>
      <td>93974490.0</td>
    </tr>
    <tr>
      <th>2011-05-15</th>
      <td>103016.0</td>
      <td>45982.080</td>
      <td>115402881.0</td>
    </tr>
    <tr>
      <th>2011-05-22</th>
      <td>105828.0</td>
      <td>52662.230</td>
      <td>120044922.0</td>
    </tr>
    <tr>
      <th>2011-05-29</th>
      <td>80900.0</td>
      <td>35654.010</td>
      <td>89151332.0</td>
    </tr>
    <tr>
      <th>2011-06-05</th>
      <td>57291.0</td>
      <td>26198.050</td>
      <td>75863724.0</td>
    </tr>
    <tr>
      <th>2011-06-12</th>
      <td>96304.0</td>
      <td>77522.070</td>
      <td>111610290.0</td>
    </tr>
    <tr>
      <th>2011-06-19</th>
      <td>70529.0</td>
      <td>31998.420</td>
      <td>104764996.0</td>
    </tr>
    <tr>
      <th>2011-06-26</th>
      <td>66727.0</td>
      <td>49730.910</td>
      <td>95844278.0</td>
    </tr>
    <tr>
      <th>2011-07-03</th>
      <td>72782.0</td>
      <td>25712.850</td>
      <td>75979262.0</td>
    </tr>
    <tr>
      <th>2011-07-10</th>
      <td>91504.0</td>
      <td>40038.650</td>
      <td>92077786.0</td>
    </tr>
    <tr>
      <th>2011-07-17</th>
      <td>79742.0</td>
      <td>40800.880</td>
      <td>99064889.0</td>
    </tr>
    <tr>
      <th>2011-07-24</th>
      <td>104485.0</td>
      <td>57900.860</td>
      <td>110115791.0</td>
    </tr>
    <tr>
      <th>2011-07-31</th>
      <td>104921.0</td>
      <td>27801.821</td>
      <td>96684210.0</td>
    </tr>
    <tr>
      <th>2011-08-07</th>
      <td>96503.0</td>
      <td>38169.240</td>
      <td>99657478.0</td>
    </tr>
    <tr>
      <th>2011-08-14</th>
      <td>98225.0</td>
      <td>28522.380</td>
      <td>84803514.0</td>
    </tr>
    <tr>
      <th>2011-08-21</th>
      <td>96816.0</td>
      <td>24458.550</td>
      <td>103336168.0</td>
    </tr>
    <tr>
      <th>2011-08-28</th>
      <td>97497.0</td>
      <td>37440.010</td>
      <td>114540053.0</td>
    </tr>
    <tr>
      <th>2011-09-04</th>
      <td>66653.0</td>
      <td>39854.020</td>
      <td>77967391.0</td>
    </tr>
    <tr>
      <th>2011-09-11</th>
      <td>108820.0</td>
      <td>35348.090</td>
      <td>123868447.0</td>
    </tr>
    <tr>
      <th>2011-09-18</th>
      <td>116893.0</td>
      <td>54952.230</td>
      <td>136557477.0</td>
    </tr>
    <tr>
      <th>2011-09-25</th>
      <td>165070.0</td>
      <td>54620.001</td>
      <td>168241331.0</td>
    </tr>
    <tr>
      <th>2011-10-02</th>
      <td>117919.0</td>
      <td>39998.801</td>
      <td>158169019.0</td>
    </tr>
    <tr>
      <th>2011-10-09</th>
      <td>158476.0</td>
      <td>57268.380</td>
      <td>185741235.0</td>
    </tr>
    <tr>
      <th>2011-10-16</th>
      <td>104666.0</td>
      <td>50639.820</td>
      <td>166106752.0</td>
    </tr>
    <tr>
      <th>2011-10-23</th>
      <td>150811.0</td>
      <td>58641.580</td>
      <td>181650776.0</td>
    </tr>
    <tr>
      <th>2011-10-30</th>
      <td>143273.0</td>
      <td>65759.310</td>
      <td>189207914.0</td>
    </tr>
    <tr>
      <th>2011-11-06</th>
      <td>140791.0</td>
      <td>67963.040</td>
      <td>206729185.0</td>
    </tr>
    <tr>
      <th>2011-11-13</th>
      <td>176997.0</td>
      <td>84864.810</td>
      <td>226622841.0</td>
    </tr>
    <tr>
      <th>2011-11-20</th>
      <td>179216.0</td>
      <td>79695.220</td>
      <td>249544522.0</td>
    </tr>
    <tr>
      <th>2011-11-27</th>
      <td>162568.0</td>
      <td>73579.150</td>
      <td>235668819.0</td>
    </tr>
    <tr>
      <th>2011-12-04</th>
      <td>151807.0</td>
      <td>74701.710</td>
      <td>210964893.0</td>
    </tr>
    <tr>
      <th>2011-12-11</th>
      <td>160166.0</td>
      <td>107644.150</td>
      <td>175848132.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 按月统计数据
# "MS"是每个月第一天为开始日期, "M"是每个月最后一天
data_new.resample('M').sum()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12-31</th>
      <td>342228</td>
      <td>260520.850</td>
      <td>4.166977e+08</td>
    </tr>
    <tr>
      <th>2011-01-31</th>
      <td>308966</td>
      <td>172752.800</td>
      <td>3.319198e+08</td>
    </tr>
    <tr>
      <th>2011-02-28</th>
      <td>277989</td>
      <td>127448.770</td>
      <td>3.117809e+08</td>
    </tr>
    <tr>
      <th>2011-03-31</th>
      <td>351872</td>
      <td>171486.510</td>
      <td>4.223298e+08</td>
    </tr>
    <tr>
      <th>2011-04-30</th>
      <td>289098</td>
      <td>129164.961</td>
      <td>3.541194e+08</td>
    </tr>
    <tr>
      <th>2011-05-31</th>
      <td>380391</td>
      <td>190685.460</td>
      <td>4.400088e+08</td>
    </tr>
    <tr>
      <th>2011-06-30</th>
      <td>341623</td>
      <td>200717.340</td>
      <td>4.264710e+08</td>
    </tr>
    <tr>
      <th>2011-07-31</th>
      <td>391116</td>
      <td>171906.791</td>
      <td>4.209226e+08</td>
    </tr>
    <tr>
      <th>2011-08-31</th>
      <td>406199</td>
      <td>150385.680</td>
      <td>4.219478e+08</td>
    </tr>
    <tr>
      <th>2011-09-30</th>
      <td>549817</td>
      <td>199235.212</td>
      <td>6.229373e+08</td>
    </tr>
    <tr>
      <th>2011-10-31</th>
      <td>570532</td>
      <td>263434.090</td>
      <td>7.727017e+08</td>
    </tr>
    <tr>
      <th>2011-11-30</th>
      <td>740286</td>
      <td>327149.850</td>
      <td>1.007384e+09</td>
    </tr>
    <tr>
      <th>2011-12-31</th>
      <td>226333</td>
      <td>133915.660</td>
      <td>2.702551e+08</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 按月度统计并显示
data_new.resample('M').sum().to_period('M')
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12</th>
      <td>342228</td>
      <td>260520.850</td>
      <td>4.166977e+08</td>
    </tr>
    <tr>
      <th>2011-01</th>
      <td>308966</td>
      <td>172752.800</td>
      <td>3.319198e+08</td>
    </tr>
    <tr>
      <th>2011-02</th>
      <td>277989</td>
      <td>127448.770</td>
      <td>3.117809e+08</td>
    </tr>
    <tr>
      <th>2011-03</th>
      <td>351872</td>
      <td>171486.510</td>
      <td>4.223298e+08</td>
    </tr>
    <tr>
      <th>2011-04</th>
      <td>289098</td>
      <td>129164.961</td>
      <td>3.541194e+08</td>
    </tr>
    <tr>
      <th>2011-05</th>
      <td>380391</td>
      <td>190685.460</td>
      <td>4.400088e+08</td>
    </tr>
    <tr>
      <th>2011-06</th>
      <td>341623</td>
      <td>200717.340</td>
      <td>4.264710e+08</td>
    </tr>
    <tr>
      <th>2011-07</th>
      <td>391116</td>
      <td>171906.791</td>
      <td>4.209226e+08</td>
    </tr>
    <tr>
      <th>2011-08</th>
      <td>406199</td>
      <td>150385.680</td>
      <td>4.219478e+08</td>
    </tr>
    <tr>
      <th>2011-09</th>
      <td>549817</td>
      <td>199235.212</td>
      <td>6.229373e+08</td>
    </tr>
    <tr>
      <th>2011-10</th>
      <td>570532</td>
      <td>263434.090</td>
      <td>7.727017e+08</td>
    </tr>
    <tr>
      <th>2011-11</th>
      <td>740286</td>
      <td>327149.850</td>
      <td>1.007384e+09</td>
    </tr>
    <tr>
      <th>2011-12</th>
      <td>226333</td>
      <td>133915.660</td>
      <td>2.702551e+08</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 按季度统计数据
data_new.resample('Q').sum()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-12-31</th>
      <td>342228</td>
      <td>260520.850</td>
      <td>4.166977e+08</td>
    </tr>
    <tr>
      <th>2011-03-31</th>
      <td>938827</td>
      <td>471688.080</td>
      <td>1.066030e+09</td>
    </tr>
    <tr>
      <th>2011-06-30</th>
      <td>1011112</td>
      <td>520567.761</td>
      <td>1.220599e+09</td>
    </tr>
    <tr>
      <th>2011-09-30</th>
      <td>1347132</td>
      <td>521527.683</td>
      <td>1.465808e+09</td>
    </tr>
    <tr>
      <th>2011-12-31</th>
      <td>1537151</td>
      <td>724499.600</td>
      <td>2.050341e+09</td>
    </tr>
  </tbody>
</table>
</div>




```python
#按季度统计并显示
data_new.resample('Q').sum().to_period('Q')
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010Q4</th>
      <td>342228</td>
      <td>260520.850</td>
      <td>4.166977e+08</td>
    </tr>
    <tr>
      <th>2011Q1</th>
      <td>938827</td>
      <td>471688.080</td>
      <td>1.066030e+09</td>
    </tr>
    <tr>
      <th>2011Q2</th>
      <td>1011112</td>
      <td>520567.761</td>
      <td>1.220599e+09</td>
    </tr>
    <tr>
      <th>2011Q3</th>
      <td>1347132</td>
      <td>521527.683</td>
      <td>1.465808e+09</td>
    </tr>
    <tr>
      <th>2011Q4</th>
      <td>1537151</td>
      <td>724499.600</td>
      <td>2.050341e+09</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 按年统计数据
# "AS"是每年第一天为开始日期, "A是每年最后一天
data_new.resample('AS').sum()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010-01-01</th>
      <td>342228</td>
      <td>2.605209e+05</td>
      <td>4.166977e+08</td>
    </tr>
    <tr>
      <th>2011-01-01</th>
      <td>4834222</td>
      <td>2.238283e+06</td>
      <td>5.802778e+09</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 按年统计并显示
data_new.resample('AS').sum().to_period('A')
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Quantity</th>
      <th>UnitPrice</th>
      <th>CustomerID</th>
    </tr>
    <tr>
      <th>InvoiceDate</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2010</th>
      <td>342228</td>
      <td>2.605209e+05</td>
      <td>4.166977e+08</td>
    </tr>
    <tr>
      <th>2011</th>
      <td>4834222</td>
      <td>2.238283e+06</td>
      <td>5.802778e+09</td>
    </tr>
  </tbody>
</table>
</div>



参考资料：http://www.mamicode.com/info-detail-1822406.html
