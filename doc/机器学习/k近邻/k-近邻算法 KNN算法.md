# 1k-近邻算法 KNN算法
## 1KNN算法
- K Nearest Neighbor
- 如果一个样本在特征空间中的k个最相似(即特征空间中最邻近)的样本中的大多数属于某一个类别，则该样本也属于这个类别，但是k=1时，容易受到异常点的影响，选择一个合适的k值可以避免受到异常值的影响

## 2KNN距离计算
- 如何确定谁是邻居
- 欧式距离 两个样本的距离  
比如, a(a1,a2,a3), b(b1,b2,b3)  

![欧式距离](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/k%E8%BF%91%E9%82%BB/%E6%AC%A7%E5%BC%8F%E8%B7%9D%E7%A6%BB.png)

- 曼哈顿距离 也叫绝对值距离 |a1-b1|+|a2-b2|+|a3-b3|
- 明可夫斯基距离
- p=1是曼哈顿距离，p=2是欧式距离

## 3k取值
- 当k值取的过小的时候，容易受到异常值的影响 
- 当k值取的过大的时候，受到样本不均衡的影响，类型很容易分错
- 实际数值大小会影响距离，所以需要做无量纲化的处理，使不同规格的数据转换到同一规格
    - 标准化  (归一化也容易受到异常值的影响)

- 电影类型分析
    - 当k=1的时候，分类为爱情片
    - 当k=2的时候，取两个最近的值
    ...
    - 当k=6的时候，一共就6个样本，一半爱情片，一半动作片 分类无法确定
    - 当k=7的时候，加入一共电影为动作片，这样三个是爱情片，四个是动作片，这个电影归类到动作片，但是实际上这个片子偏向爱情片

## 4API
- **sklearn.neighbors.KNeighborsClassifier(n_neighbors=5, algorithm='auto')**
    - **n_neighbors**: int,可选(默认=5)，k值，k_neighbors 查询默认使用的邻居数
    - **algorithm**: {'auto','ball_tree','kd_tree','brute'},可选用于计算最近邻居的算法
        - ball_tree 使用BallTree
        - kd_tree 使用KDTree
        - auto 将尝试根据传递给fit方法的值来决定最合适的算法 不同现实方式影响效率

- 在案例中鸢尾花数据使用knn算法中同时调用了模型优化 gridsearchcv 
- metric='minkowski' 这里是距离调用: 明可夫斯基距离
- p=1是曼哈顿距离，p=2是欧式距离
- GridSearchCV(cv=10, error_score='raise', estimator=KNeighborsClassifier(algorithm='auto', leaf_size=30, metric='minkowski', metric_params=None, n_jobs=1, n_neighbors=5, p=2, weights='uniform'),
    

## 5案例1 鸢尾花种类预测

### 数据集介绍
```
Iris数据集是常用的分类实验数据集，用称鸢尾花数据集，是一类多重变量分析的数据集。数据集的具体介绍：
实例数量： 150 三个类各有50个
属性数量： 4（数值型，数值型，帮助预测的属性和类）
属性信息：
    sepal length 萼片长度 cm
    sepal width 萼片宽度 cm
    petal length 花瓣长度 cm
    petal width 花瓣宽度 cm
类：
    Iris-SetosaN 山鸢尾
    Iris-Versicolour 变色鸢尾
    Iris-Virginica 维吉妮亚鸢尾
```

- 1.获取数据
- 2.数据处理
- 3.数据集划分
- 4.特征工程
    - 标准化
- 5.机器学习训练
    - KNN预估器流程
- 6.模型评估

```python
# 导入数据集
from sklearn.datasets import load_iris
# 划分数据集
from sklearn.model_selection import train_test_split
# 数据标准化
from sklearn.preprocessing import StandardScaler
# 调用knn算法
from sklearn.neighbors import KNeighborsClassifier

def knn_iris():
    '''
    用knn算法对鸢尾花进行分类
    :return: 
    '''
    # 1获取数据
    iris = load_iris()
    # 2划分数据集 random_state取6
    x_train, x_test, y_train, y_test = train_test_split(iris.data,iris.target,random_state=6)
    # 3特征工程：标准化
    transfer = StandardScaler()
    # 训练集标准化
    x_train = transfer.fit_transform(x_train)
    # 测试集也需要标准化，用训练集的平均值和标准差来对测试集数据标准化 
    x_test = transfer.transform(x_test)
    # 4KNN算法预估器,k取3
    # 放入训练集的特征值和目标值放进来
    estimator = KNeighborsClassifier(n_neighbors=3)
    # 相当于有了模型
    estimator.fit(x_train,y_train)
    # 5模型评估
    # 方法1，直接比对真实值和预测值
    # 根据x_train和y_trian模型，预测x_test会得到y_test,再和实际的y_test相比较
    # 得到预测的结果
    y_predict = estimator.predict(x_test)
    print("y_predict:\n", y_predict)
    print("对比真实值和预测值：", y_predict == y_test )
    # 方法2，计算准确率
    score = estimator.score(x_test,y_test)
    print("准确率：\n",score)
    return None

if __name__ == "__main__":
    knn_iris()
    
output:  
y_predict:
 [0 2 0 0 2 1 1 0 2 1 2 1 2 2 1 1 2 1 1 0 0 2 0 0 1 1 1 2 0 1 0 1 0 0 1 2 1
 2]
对比真实值和预测值： [ True  True  True  True  True  True False  True  True  True  True  True
  True  True  True False  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True False  True
  True  True]
准确率：
 0.921052631579
```

## 6KNN算法优缺点
- 优点：简单，易于理解，易于实现，无需训练
- 缺点：
    - 懒惰算法，对测试样本分类时的计算量大，内存开销大
    - 必须指定k值，k值选择不当则分类精度不能保证
- 使用场景：小数据场景，几千~几万样本，具体场景具体业务去测试，大数据不适合用KNN算法


# 2模型选择和调优GridSearchCV
## 1交叉验证(cross validation/cv)  
交叉验证：将拿到的训练数据，分为训练和验证集。将数据分成四份，其中一份作为验证集。然后经过4次(组)的测试，每次都更换不同的验证集，即得到4组模型的结果，取平均数作为最终结果，又称为4折交叉验证。
### 1分析  
我们之前知道数据分成训练集和测试集，但是为类让训练得到模型的结果更为准确，做以下处理  
- 训练集：训练集+验证集
- 测试集：测试集
- 得到不同的准确率，求平均值之后，平均值作为模型最终准确率

一组：**验证集** 训练集 训练集 训练集      
二组：训练集 **验证集** 训练集 训练集    
三组：训练集 训练集 **验证集** 训练集    
四组：训练集 训练集 训练集 **验证集**      

### 2为什么需要交叉验证
- 交叉验证目的：为了让被评估的模型更加准确可信
- 如何选择或者调优参数

## 2超参数搜索-网格搜索(Grid Search)
超参数 通常情况下，参数是需要手动指定的(如k-近邻算法中的k值)，这种叫超参数  

但是手动过程繁杂，所以需要对模型预设几种超参数组合。每组超参数都采用交叉验证来进行评估。最后选出最优参数组合建立模型。
```
k值   k=3   k=5   k=7
模型 模型1 模型2 模型3
```
## 3模型选择与调优API
- **sklearn.model_selection.GridSearchCV(estimator,param_grid=None,cv=None)**
- 对估计器的指定参数进行详尽搜索
    - estimator:估计器对象
    - param_grid:估计器参数(dict)("n_neighbors":[1,3,5]) 准备好的k的取值，以字典的 形式传进来
    - cv:指定几折交叉验证 经过几次交叉验证 一般是10折
        - cv=3 训练集分成三分，其中一份测试，一共训练三次
- fit():输入训练数据
    - estimator.fit(x_train,y_train)
- predict():预测测试集结果
    - y_predict = estimator.predict(x_test)
    - print("y_predict:\n", y_predict)
- score():准确率 准确率是test测试集中的结果
    - score = estimator.score(x_test,y_test)
    - print("准确率：\n",score)
- 结果分析:
    - 此最佳结果是训练集中验证集当中的结果
    - 最佳参数: best_params_
    - 最佳结果: best_score_
    - 最佳估计器: best_estimator_
    - 交叉验证结果: cv_results_

   

## 4鸢尾花案例增加K值调优

```
调用gridsearchcv
GridSearchCV(cv=10, error_score='raise',
       estimator=KNeighborsClassifier(algorithm='auto', leaf_size=30, metric='minkowski',
           metric_params=None, n_jobs=1, n_neighbors=5, p=2,
           weights='uniform'),
       fit_params=None, iid=True, n_jobs=1,
       param_grid={'n_neighbors': [1, 3, 5, 7, 9, 11]},
       pre_dispatch='2*n_jobs', refit=True, return_train_score='warn',
       scoring=None, verbose=0)
```

```python
# 导入数据集
from sklearn.datasets import load_iris
# 划分数据集
from sklearn.model_selection import train_test_split
# 数据标准化
from sklearn.preprocessing import StandardScaler
# 调用knn算法
from sklearn.neighbors import KNeighborsClassifier
# 调用gscv调优
from sklearn.model_selection import GridSearchCV

def knn_iris_gscv():
    '''
    用knn算法对鸢尾花进行分类, 添加网格搜索和交叉验证
    :return:
    '''
    # 获取数据
    iris = load_iris()
    # 划分数据
    x_train, x_test, y_train, y_test = train_test_split(iris.data,iris.target,random_state=6)
    # 特征工程：标准化
    transfer = StandardScaler()
    x_train = transfer.fit_transform(x_train)
    x_test = transfer.transform(x_test)
    # KNN算法预估器，因为要试，所以这里不需要加上k值
    estimator = KNeighborsClassifier()
    # 加入网格搜索和交叉验证
    ## 参数准备 k值 字典的格式
    param_dict = {"n_neighbors":[1,3,5,7,9,11]}
    estimator = GridSearchCV(estimator,param_grid=param_dict,cv=10)
    estimator.fit(x_train,y_train)
    # 模型评估
    y_predict = estimator.predict(x_test)
    print("y_predict:", y_predict)
    print("对比真实值和预测值：", y_predict == y_test )
    score = estimator.score(x_test,y_test)
    ## 准确率是test测试集中的结果
    print("准确率：",score)
    # 最佳参数: best_params_
    print("最佳参数：",estimator.best_params_)
    # 最佳结果: best_score_
    # 此最佳结果是训练集中验证集当中的结果
    print("最佳结果",estimator.best_score_)
    # 最佳估计器: best_estimator_
    print("最佳预估器",estimator.best_estimator_)
    # 交叉验证结果: cv_results_
    print("交叉验证结果",estimator.cv_results_)
    return None

if __name__ == "__main__":
    knn_iris_gscv()
```    
```
output:
y_predict: [0 2 0 0 2 1 2 0 2 1 2 1 2 2 1 1 2 1 1 0 0 2 0 0 1 1 1 2 0 1 0 1 0 0 1 2 1
 2]
对比真实值和预测值： [ True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True False  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True False  True
  True  True]
准确率： 0.947368421053
最佳参数： {'n_neighbors': 5}
最佳结果 0.973214285714
最佳预估器 KNeighborsClassifier(algorithm='auto', leaf_size=30, metric='minkowski',
           metric_params=None, n_jobs=1, n_neighbors=5, p=2,
           weights='uniform')
交叉验证结果 {'mean_fit_time': array([ 0.00059507,  0.00039799,  0.00039623,  0.00060136,  0.00019946,
        0.00039546]), 'std_fit_time': array([ 0.00048594,  0.00048747,  0.00048529,  0.00049103,  0.00039892,
        0.00048448]), 'mean_score_time': array([ 0.00069988,  0.00079751,  0.00050149,  0.00029955,  0.00070338,
        0.00049961]), 'std_score_time': array([ 0.00063947,  0.00059876,  0.00050157,  0.00045757,  0.00064549,
        0.00049961]), 'param_n_neighbors': masked_array(data = [1 3 5 7 9 11],
             mask = [False False False False False False],
       fill_value = ?)
, 'params': [{'n_neighbors': 1}, {'n_neighbors': 3}, {'n_neighbors': 5}, {'n_neighbors': 7}, {'n_neighbors': 9}, {'n_neighbors': 11}], 'split0_test_score': array([ 1.,  1.,  1.,  1.,  1.,  1.]), 'split1_test_score': array([ 0.91666667,  0.91666667,  1.        ,  0.91666667,  0.91666667,
        0.91666667]), 'split2_test_score': array([ 1.,  1.,  1.,  1.,  1.,  1.]), 'split3_test_score': array([ 1.        ,  1.        ,  1.        ,  1.        ,  0.91666667,  1.        ]), 'split4_test_score': array([ 1.,  1.,  1.,  1.,  1.,  1.]), 'split5_test_score': array([ 0.91666667,  0.91666667,  1.        ,  1.        ,  1.        ,  1.        ]), 'split6_test_score': array([ 0.90909091,  1.        ,  0.90909091,  0.90909091,  0.90909091,
        0.90909091]), 'split7_test_score': array([ 1.,  1.,  1.,  1.,  1.,  1.]), 'split8_test_score': array([ 1.,  1.,  1.,  1.,  1.,  1.]), 'split9_test_score': array([ 0.88888889,  0.77777778,  0.77777778,  0.77777778,  0.77777778,
        0.77777778]), 'mean_test_score': array([ 0.96428571,  0.96428571,  0.97321429,  0.96428571,  0.95535714,
        0.96428571]), 'std_test_score': array([ 0.04490364,  0.06465941,  0.06373749,  0.06518036,  0.06538389,
        0.06518036]), 'rank_test_score': array([2, 2, 1, 2, 6, 2]), 'split0_train_score': array([ 1.  ,  0.97,  0.98,  0.97,  0.97,  0.96]), 'split1_train_score': array([ 1.  ,  0.98,  0.99,  0.98,  0.97,  0.97]), 'split2_train_score': array([ 1.  ,  0.98,  0.99,  0.98,  0.97,  0.96]), 'split3_train_score': array([ 1.  ,  0.97,  0.98,  0.97,  0.96,  0.96]), 'split4_train_score': array([ 1.  ,  0.97,  0.98,  0.98,  0.97,  0.98]), 'split5_train_score': array([ 1.  ,  0.99,  0.98,  0.98,  0.97,  0.98]), 'split6_train_score': array([ 1.        ,  0.97029703,  0.98019802,  0.97029703,  0.97029703,
        0.97029703]), 'split7_train_score': array([ 1.        ,  0.97029703,  0.98019802,  0.97029703,  0.98019802,
        0.98019802]), 'split8_train_score': array([ 1.        ,  0.97087379,  0.98058252,  0.98058252,  0.96116505,
        0.96116505]), 'split9_train_score': array([ 1.        ,  0.98058252,  0.99029126,  0.99029126,  0.98058252,
        0.98058252]), 'mean_train_score': array([ 1.        ,  0.97520504,  0.98312698,  0.97714678,  0.97022426,
        0.97022426]), 'std_train_score': array([ 0.        ,  0.00664835,  0.0045667 ,  0.00642757,  0.006274  ,
        0.0089086 ])}
```
## 5随机森林算法中使用GridSearchCV
```python
# 模型调优与选择
# GridSearchCV
# param_grid 为参数；参数候选项写成字典的格式
# cv 进行几次交叉验证

from sklearn.grid_search import GridSearchCV
tree_param_grid = { 'min_samples_split': list((3,6,9)),'n_estimators':list((10,50,100))}
grid = GridSearchCV(RandomForestRegressor(),param_grid=tree_param_grid, cv=5)
grid.fit(x_train, y_train)
grid.grid_scores_, grid.best_params_, grid.best_score_
```
```
output:
([mean: 0.78405, std: 0.00505, params: {'min_samples_split': 3, 'n_estimators': 10},
  mean: 0.80529, std: 0.00448, params: {'min_samples_split': 3, 'n_estimators': 50},
  mean: 0.80673, std: 0.00433, params: {'min_samples_split': 3, 'n_estimators': 100},
  mean: 0.79016, std: 0.00124, params: {'min_samples_split': 6, 'n_estimators': 10},
  mean: 0.80496, std: 0.00491, params: {'min_samples_split': 6, 'n_estimators': 50},
  mean: 0.80671, std: 0.00408, params: {'min_samples_split': 6, 'n_estimators': 100},
  mean: 0.78747, std: 0.00341, params: {'min_samples_split': 9, 'n_estimators': 10},
  mean: 0.80481, std: 0.00322, params: {'min_samples_split': 9, 'n_estimators': 50},
  mean: 0.80603, std: 0.00437, params: {'min_samples_split': 9, 'n_estimators': 100}],
 {'min_samples_split': 3, 'n_estimators': 100},
 0.8067250881273065)
```

- 带入min_samples_split': 3, 'n_estimators': 100测试
```python
rfr = RandomForestRegressor( min_samples_split=3,n_estimators = 100,random_state = 42)
rfr.fit(data_train, target_train)
rfr.score(data_test, target_test)
```
```
#
output:
0.80908290496531576 

```
## 6流程分析
- 获取数据
- 数据处理
    - 特征值 x
    - 目标值 y
- 特征工程：标准化
- 算法预估流程
- 模型选择与调优
- 模型评估
