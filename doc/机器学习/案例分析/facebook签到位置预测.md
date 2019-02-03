
# 数据集介绍  

本次大赛的目的是预测一个人想签入到哪个地方。FaceBook创建了一个人造的世界，10公里*10公里的一个区域。对于一个给定的坐标，你的任务是返回最有可能的地方的排名列表  

## 数据集数据  
```
train_csv, test_csv
row_id: id of the check_in event 登记事情的id
x y: coordiantes 坐标系
accuracy: location accuracy 定位准确度
time: timestamp 时间戳
place_id: id of the business. this is the target you are predicting   预测签到的位置 
```
## 流程分析
- [获取数据](#获取数据)
- [数据处理](#数据处理)
    - 为了减少时间，缩小数据范围
        - 2<x<2.5   1.0<y<1.5
    - time处理成有意义的数据年月日时分秒 
    - 过滤签到次数少的地点
    - 整理特征值 x 目标值y
- [数据集划分](#数据集划分)
- [特征工程：标准化](#特征工程)
- [KNN算法预估流程](#算法预估流程)
- [模型选择与调优](#模型选择与调优)
- [模型评估](#模型评估)
- [详细资料](https://github.com/mayu1031/CS_Notes/blob/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/FaceBook%E7%AD%BE%E5%88%B0%E4%BD%8D%E7%BD%AE%E9%A2%84%E6%B5%8B.ipynb)

### 获取数据

```python
import pandas as pd
data = pd.read_csv("./FBlocation/train.csv")
```


### 数据处理  

- 为了减少时间，缩小数据范围
- 数据处理
    - 缩小数据范围
        - 2<x<2.5 1.0<y<1.5

```python
data = data.query("x < 2.5 & x > 2 & y < 1.5 & y > 1.0")
```

- time处理成有意义的数据年月日时分秒
    - 修改时间戳
    - 添加合理的时间数据
    
```
# 处理时间戳成比较有意义的数据
time_value = pd.to_datetime(data['time'],unit='s')

## 转换成DatetimeIndex的格式，方便转换成星期几
date = pd.DatetimeIndex(time_value)

# 获取的时间年都是1970年，以及都是一月份，并不是有意义的数据
# 获取时间数据转换成星期数据，小时数据, 以及天数据
date.weekday
date.day
date.hour

# 对原数据进行添加
data["day"] = date.day
data["weekday"] = date.weekday
data["hour"] = date.hour
```
- 过滤签到次数少的地点
    - 先统计下地点的签到数据
        - 不同的place_id被签到了几次
        - 用分组聚合
        - 返回groupby
    - 过滤掉签到次数小于三的
    
```
# 签到次数
data.groupby("place_id").count().head()
place_count = data.groupby("place_id").count()
place_count_id = place_count["row_id"]

# 过滤掉签到次数小于三的
# 使用布尔索引
place_count_id[place_count_id>3].head()

# 过滤data
data["place_id"].isin(place_count_id[place_count_id>3].index.values).head()

# 在做一个对data的索引
data_final = data[data["place_id"].isin(place_count_id[place_count_id>3].index.values)]
data_final.head()
```
- 整理特征值 x 目标值y

```
# 删选特征值和目标值
x = data_final[["x","y","accuracy","day","weekday","hour"]]
y = data_final["place_id"]
```

### 数据集划分
```
# 数据集划分
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test = train_test_split(x,y)

```

### 特征工程
```
# 特征工程：数据标准化
transfer = StandardScaler()
x_train = transfer.fit_transform(x_train)
x_test = transfer.transform(x_test)
```
### 算法预估流程
```
# KNN算法预估器，因为要加入网格搜寻和交叉验证法，所以不需要添加k值
estimator = KNeighborsClassifier()
```
### 模型选择与调优
```
# 加入网格搜索与交叉验证
# 参数准备 k值为字典格式
param_dict = {"n_neighbors": [3, 5, 7, 9]}
estimator = GridSearchCV(estimator, param_grid=param_dict, cv=3)
estimator.fit(x_train, y_train)
```
### 模型评估
```
# 模型评估
# 方法1：直接比对真实值和预测值
y_predict = estimator.predict(x_test)
print("y_predict:\n", y_predict)
print("直接比对真实值和预测值:\n", y_test == y_predict)

# 方法2：计算准确率
score = estimator.score(x_test, y_test)
print("准确率为：\n", score)

# 最佳参数：best_params_
print("最佳参数：\n", estimator.best_params_)
# 最佳结果：best_score_
print("最佳结果：\n", estimator.best_score_)
# 最佳估计器：best_estimator_
print("最佳估计器:\n", estimator.best_estimator_)
# 交叉验证结果：cv_results_
print("交叉验证结果:\n", estimator.cv_results_)
```
```
output:
y_predict:
 [2585551753 5304570159 6706708436 ..., 5600661085 5801995519 9764078387]
直接比对真实值和预测值:
 19606411     True
3733238     False
23849836    False
27639088     True
5866275      True
26883481     True
12628841    False
26354845    False
8797661      True
2104761      True
20529480    False
11780123    False
27441634    False
19372956     True
17458468     True
8657405     False
4694924     False
17493647    False
14189075     True
8580097      True
7894380      True
15114892    False
16739797     True
10910858     True
26235923    False
5382207     False
23573702    False
4174870     False
18541202     True
116800      False
            ...  
7766770     False
26097873    False
22027458     True
12463524     True
3001035     False
18147152     True
14645989    False
18207724     True
11460414     True
6168768     False
15829678     True
11710752     True
28407512    False
17534533     True
25109375    False
21971723     True
8278330      True
23381708    False
17953927    False
17955457    False
12959591     True
27458549    False
10055960     True
3167005     False
14128185    False
24174176     True
25230768     True
21932810    False
26465115     True
26383660     True
Name: place_id, Length: 20228, dtype: bool
准确率为：
 0.361874629227
最佳参数：
 {'n_neighbors': 7}
最佳结果：
 0.337167529086
最佳估计器:
 KNeighborsClassifier(algorithm='auto', leaf_size=30, metric='minkowski',
           metric_params=None, n_jobs=1, n_neighbors=7, p=2,
           weights='uniform')
交叉验证结果:
 {'mean_fit_time': array([ 0.08042447,  0.08281231,  0.08544676,  0.07679605]), 'std_fit_time': array([ 0.00261876,  0.00246685,  0.00168433,  0.00216404]), 'mean_score_time': array([ 1.28719163,  1.61812123,  1.80276601,  1.97567185]), 'std_score_time': array([ 0.07765963,  0.02331619,  0.06988084,  0.04722305]), 'param_n_neighbors': masked_array(data = [3 5 7 9],
             mask = [False False False False],
       fill_value = ?)
, 'params': [{'n_neighbors': 3}, {'n_neighbors': 5}, {'n_neighbors': 7}, {'n_neighbors': 9}], 'split0_test_score': array([ 0.31719305,  0.32819115,  0.33072169,  0.32600127]), 'split1_test_score': array([ 0.3236574 ,  0.33572347,  0.33646524,  0.33354762]), 'split2_test_score': array([ 0.33192708,  0.34398071,  0.34453317,  0.33745166]), 'mean_test_score': array([ 0.3241818 ,  0.33588214,  0.33716753,  0.33227316]), 'std_test_score': array([ 0.0060262 ,  0.00644666,  0.00566   ,  0.00476038]), 'rank_test_score': array([4, 2, 1, 3]), 'split0_train_score': array([ 0.59390028,  0.5302868 ,  0.48713029,  0.45937259]), 'split1_train_score': array([ 0.59045971,  0.5252348 ,  0.48643104,  0.45845279]), 'split2_train_score': array([ 0.59022344,  0.5231905 ,  0.48389787,  0.45341051]), 'mean_train_score': array([ 0.59152781,  0.52623737,  0.48581973,  0.45707863]), 'std_train_score': array([ 0.00168036,  0.00298253,  0.00138862,  0.00262079])}

```
