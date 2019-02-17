
# 探究用户对物品类别的喜好细分
## PCA降维
## KMeans
- 找到用户和物品类别的关系
- aisles 商品所属具体物品类别
    - aisle_id aisle
- order_products_prior 订单与商品信息
    - order_id product_id add_to_cart_order reordered
- orders 用户订单信息
    - order_id user_id eval_set order_number
- aisles 商品信息
    - product_id product_name aisle_id department_id
- 需要将user_id和aisle放在同一张表中
- 找到user_id和aisle之间的关系-交叉表和透视表
- 特征冗余过多，有134个，需要PCA降维

## 1.获取数据


```python
import pandas as pd
# 1.获取数据
aisles = pd.read_csv('./instacart/aisles.csv')
order_products__prior = pd.read_csv('./instacart/order_products__prior.csv')
orders = pd.read_csv('./instacart/orders.csv')
products = pd.read_csv('./instacart/products.csv')

```


```python
aisles.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>aisle_id</th>
      <th>aisle</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>prepared soups salads</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>specialty cheeses</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>energy granola bars</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>instant foods</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>marinades meat preparation</td>
    </tr>
  </tbody>
</table>
</div>




```python
order_products__prior.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>order_id</th>
      <th>product_id</th>
      <th>add_to_cart_order</th>
      <th>reordered</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2</td>
      <td>33120</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>28985</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>9327</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2</td>
      <td>45918</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>30035</td>
      <td>5</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




```python
orders.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>order_id</th>
      <th>user_id</th>
      <th>eval_set</th>
      <th>order_number</th>
      <th>order_dow</th>
      <th>order_hour_of_day</th>
      <th>days_since_prior_order</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2539329</td>
      <td>1</td>
      <td>prior</td>
      <td>1</td>
      <td>2</td>
      <td>8</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2398795</td>
      <td>1</td>
      <td>prior</td>
      <td>2</td>
      <td>3</td>
      <td>7</td>
      <td>15.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>473747</td>
      <td>1</td>
      <td>prior</td>
      <td>3</td>
      <td>3</td>
      <td>12</td>
      <td>21.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2254736</td>
      <td>1</td>
      <td>prior</td>
      <td>4</td>
      <td>4</td>
      <td>7</td>
      <td>29.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>431534</td>
      <td>1</td>
      <td>prior</td>
      <td>5</td>
      <td>4</td>
      <td>15</td>
      <td>28.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
products.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>product_id</th>
      <th>product_name</th>
      <th>aisle_id</th>
      <th>department_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Chocolate Sandwich Cookies</td>
      <td>61</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>All-Seasons Salt</td>
      <td>104</td>
      <td>13</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Robust Golden Unsweetened Oolong Tea</td>
      <td>94</td>
      <td>7</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>Smart Ones Classic Favorites Mini Rigatoni Wit...</td>
      <td>38</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>Green Chile Anytime Sauce</td>
      <td>5</td>
      <td>13</td>
    </tr>
  </tbody>
</table>
</div>



## 2.合并表
- 合并aisles和products两张表,aisles和product_id在一起
### 第一次合并
- merge 按索引进行合并,默认内连接


```python
table1 = pd.merge(aisles,products,on=['aisle_id','aisle_id'])
table1.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>aisle_id</th>
      <th>aisle</th>
      <th>product_id</th>
      <th>product_name</th>
      <th>department_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>554</td>
      <td>Turkey Chili</td>
      <td>20</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>886</td>
      <td>Whole Grain Salad with Roasted Pecans &amp; Mango ...</td>
      <td>20</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>1600</td>
      <td>Mediterranean Orzo Salad</td>
      <td>20</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>2539</td>
      <td>Original Potato Salad</td>
      <td>20</td>
    </tr>
  </tbody>
</table>
</div>



### 第二次合并
   


```python
table2 = pd.merge(table1,order_products__prior,on=['product_id','product_id'])
table2.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>aisle_id</th>
      <th>aisle</th>
      <th>product_id</th>
      <th>product_name</th>
      <th>department_id</th>
      <th>order_id</th>
      <th>add_to_cart_order</th>
      <th>reordered</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
      <td>94246</td>
      <td>5</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
      <td>192465</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
      <td>195206</td>
      <td>18</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
      <td>227717</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
      <td>260072</td>
      <td>13</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



### 第三次合并


```python
table3 = pd.merge(table2,orders,on=['order_id','order_id'])
table3.head()
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>aisle_id</th>
      <th>aisle</th>
      <th>product_id</th>
      <th>product_name</th>
      <th>department_id</th>
      <th>order_id</th>
      <th>add_to_cart_order</th>
      <th>reordered</th>
      <th>user_id</th>
      <th>eval_set</th>
      <th>order_number</th>
      <th>order_dow</th>
      <th>order_hour_of_day</th>
      <th>days_since_prior_order</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>209</td>
      <td>Italian Pasta Salad</td>
      <td>20</td>
      <td>94246</td>
      <td>5</td>
      <td>0</td>
      <td>114082</td>
      <td>prior</td>
      <td>26</td>
      <td>0</td>
      <td>20</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>prepared soups salads</td>
      <td>22853</td>
      <td>Pesto Pasta Salad</td>
      <td>20</td>
      <td>94246</td>
      <td>4</td>
      <td>0</td>
      <td>114082</td>
      <td>prior</td>
      <td>26</td>
      <td>0</td>
      <td>20</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4</td>
      <td>instant foods</td>
      <td>12087</td>
      <td>Chicken Flavor Ramen Noodle Soup</td>
      <td>9</td>
      <td>94246</td>
      <td>15</td>
      <td>0</td>
      <td>114082</td>
      <td>prior</td>
      <td>26</td>
      <td>0</td>
      <td>20</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>instant foods</td>
      <td>47570</td>
      <td>Original Flavor Macaroni &amp; Cheese Dinner</td>
      <td>9</td>
      <td>94246</td>
      <td>14</td>
      <td>1</td>
      <td>114082</td>
      <td>prior</td>
      <td>26</td>
      <td>0</td>
      <td>20</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>13</td>
      <td>prepared meals</td>
      <td>10089</td>
      <td>Dolmas</td>
      <td>20</td>
      <td>94246</td>
      <td>25</td>
      <td>0</td>
      <td>114082</td>
      <td>prior</td>
      <td>26</td>
      <td>0</td>
      <td>20</td>
      <td>1.0</td>
    </tr>
  </tbody>
</table>
</div>



## 3.找到user_id和aisle之间的关系
### 交叉表和透视表


```python
table = pd.crosstab(table3['user_id'],table3['aisle'])
table.head()
# 有134个特征，里面有很多的冗余，我们需要进行降维
```




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>aisle</th>
      <th>air fresheners candles</th>
      <th>asian foods</th>
      <th>baby accessories</th>
      <th>baby bath body care</th>
      <th>baby food formula</th>
      <th>bakery desserts</th>
      <th>baking ingredients</th>
      <th>baking supplies decor</th>
      <th>beauty</th>
      <th>beers coolers</th>
      <th>...</th>
      <th>spreads</th>
      <th>tea</th>
      <th>tofu meat alternatives</th>
      <th>tortillas flat bread</th>
      <th>trail mix snack mix</th>
      <th>trash bags liners</th>
      <th>vitamins supplements</th>
      <th>water seltzer sparkling water</th>
      <th>white wines</th>
      <th>yogurt</th>
    </tr>
    <tr>
      <th>user_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
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
      <th>1</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>3</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>0</td>
      <td>42</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>4</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0</td>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 134 columns</p>
</div>




```python
data = table[:10000]
```

## 4.pca降维
- 实例化一个转化器
- 调用fit_transform



```python
from sklearn.decomposition import PCA
```


```python
# 保存95%的信息
transfer = PCA(n_components=0.95)
data_new = transfer.fit_transform(data)
```


```python
data_new.shape
```




    (10000, 42)



## 5预估器流程


```python
from sklearn.cluster import KMeans
```


```python
#因为我们没有目标值，只有特征值，传特征值就可以了
estimator = KMeans(n_clusters=3)
estimator.fit(data_new)
```




    KMeans(algorithm='auto', copy_x=True, init='k-means++', max_iter=300,
        n_clusters=3, n_init=10, n_jobs=1, precompute_distances='auto',
        random_state=None, tol=0.0001, verbose=0)




```python
y_predict = estimator.predict(data_new)
```


```python
y_predict[:300] ## 用户分成了三类
```




    array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0,
           0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
           0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
           0, 1, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0,
           0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 2, 0, 1, 0, 0, 0, 2, 0, 0, 0,
           0, 1, 2, 2, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           0, 2, 0, 2, 2, 0, 0, 2, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0,
           2])



## 6模型评估
- 轮廓系数


```python
from sklearn.metrics import silhouette_score
```


```python
data_new
```




    array([[ -2.36456828e+01,   2.30028678e+00,  -2.71706275e+00, ...,
              8.24685231e-01,  -5.20365905e-01,   2.99847178e+00],
           [  6.95477119e+00,   3.54966052e+01,   2.52655545e+00, ...,
             -1.15326520e+00,  -1.37969318e+00,  -1.07115466e-02],
           [ -7.47792843e+00,   2.83147785e+00,  -1.07306519e+01, ...,
             -3.55104796e-01,   3.85595697e-02,   1.92318882e+00],
           ..., 
           [ -2.86664024e+01,  -1.26446961e+00,  -1.14908062e+00, ...,
              1.13859569e-03,   4.14189764e-01,   4.46163585e-01],
           [ -2.88378748e+01,  -1.70490822e+00,  -1.47059942e+00, ...,
             -1.62743887e-01,   6.72795951e-01,   9.64403654e-02],
           [  2.10412407e+02,  -3.51935647e+01,   1.33671987e+01, ...,
              1.46544596e+01,   1.56764794e+01,   1.67432890e+01]])




```python
silhouette_score(data_new, y_predict)
```




    0.53968199039938392


