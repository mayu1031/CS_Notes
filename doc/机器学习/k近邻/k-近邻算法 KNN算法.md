# k-近邻算法 KNN算法
## 什么是KNN算法
- K Nearest Neighbor
- 如果一个样本在特征空间中的k个最相似(即特征空间中最邻近)的样本中的大多数属于某一个类别，则该样本也属于这个类别 但是k=1时，容易受到异常点的影响，选择一个合适的k值可以避免受到异常值的影响
- 如何确定谁是邻居
    - 欧式距离 两个样本的距离
    - 曼哈顿距离 绝对值距离 |a1-b1|+|a2-b2|+|a3-b3|
    - 明可夫斯基距离
- 电影类型分析
    - 当k=1的时候，分类为爱情片
    - 当k=2的时候，取两个最近的值
    ...
    - 当k=6的时候，一共就6个样本，一半爱情片，一半动作片 分类无法确定
    - 当k=7的时候，加入一共电影为动作片，这样三个是爱情片，四个是动作片，这个电影归类到动作片，但是实际上这个片子偏向爱情片
- 当k值取的过小的时候，容易受到异常值的影响 
- 当k值取的过大的时候，受到样本不均衡的影响，类型很容易分错
- 无量纲化的处理
    - 标准化
API

- sklearn.neighbors.KNeighborsClassifier(n_neighbors=5, algorithm='auto')
    - n_neighbors: int,可选(默认=5)，k值，k_neighbors 查询默认使用的邻居数
    - algorithm: {'auto','ball_tree','kd_tree','brute'},可选用于计算最近邻居的算法
        - ball_tree 使用BallTree
        - kd_tree 使用KDTree
        - auto 将尝试根据传递给fit方法的值来决定最合适的算法 不同现实方式影响效率
        
## 案例1 鸢尾花种类预测
- 1.数据集介绍
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
- 2.数据集划分
- 3.特征工程
    - 标准化
- 4.机器学习训练
    - KNN预估器流程
- 5.模型评估

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
    # 测试集也需要标准化，用训练集的平均值和标准差 模型用同样分布状况的数据
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
## KNN算法优缺点
- 优点：简单，易于理解，易于实现，无需训练
- 缺点：
    - 懒惰算法，对测试样本分类时的计算量大，内存开销大
    - 必须指定k值，k值选择不当则分类精度不能保证
- 使用场景：小数据场景，几千~几万样本，具体场景具体业务去测试，大数据不适合用KNN算法

# 模型选择和调优
## 什么是交叉验证(cross validation)  
交叉验证：将拿到的训练数据，分为训练和验证集。将数据分成四份，其中一份作为验证集。然后经过4次(组)的测试，每次都更换不同的验证集，即得到4组模型的结果，取平均数作为最终结果，又称为4折交叉验证。
### 分析  
我们之前知道数据分成训练集和测试集，但是为类让训练得到模型的结果更为准确，做以下处理  
- 训练集：训练集+验证集
- 测试集：测试集
- 得到不同的准确率，求平均值之后，平均值作为模型最终准确率
```
一组：验证集 训练集 训练集 训练集  80%
二组：训练集 验证集 训练集 训练集  78%
三组：训练集 训练集 验证集 训练集  75%
四组：训练集 训练集 训练集 验证集  82%
```
### 为什么需要交叉验证
- 交叉验证目的：为了让被评估的模型更加准确可信
- 如何选择或者调优参数

## 超参数搜索-网格搜索(Grid Search)
超参数 通常情况下，狠毒偶参数是需要手动指定的(如k-近邻算法中的k值)，这种叫超参数  

但是手动过程繁杂，所以需要对模型预设几种超参数组合。每组超参数都采用交叉验证来进行评估。最后选出最优参数组合建立模型。
```
k值   k=3   k=5   k=7
模型 模型1 模型2 模型3
```
## 模型选择与调优API
sklearn.model_selection.GridSearchCV(estimator,param_grid=None,cv=None)
    - 对估计器的指定参数进行详尽搜索
    - estimator:估计器对象
    - param_grid:估计器参数(dict)("n_neighbors":[1,3,5]) 准备好的k的取值，以字典的 形式传进来
    - cv:指定几折交叉验证 经过几次交叉验证 一般是10折
    - fit():输入训练数据
    - score():准确率
    - 结果分析:
        - 最佳参数: best_params_
        - 最佳结果: best_score_
        - 最佳估计器: best_estimator_
        - 交叉验证结果: cv_results_
        - p=1是曼哈顿距离，p=2是欧式距离
## 鸢尾花案例增加K值调优
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
    print("y_predict:\n", y_predict)
    print("对比真实值和预测值：", y_predict == y_test )
    score = estimator.score(x_test,y_test)
    print("准确率：\n",score)
    # 最佳参数: best_params_
    print("最佳参数：",estimator.best_params_)
    # 最佳结果: best_score_
    # 此最佳结果是训练集中验证集当中的结果
    print("最佳结果",estimator.best_score_)
    # 最佳估计器: best_estimator_
    print("最佳估计器",estimator.best_estimator_)
    # 交叉验证结果: cv_results_
    print("交叉验证结果",estimator.cv_results_)
    return None

if __name__ == "__main__":
    knn_iris_gscv()

output:
y_predict:
 [0 2 0 0 2 1 2 0 2 1 2 1 2 2 1 1 2 1 1 0 0 2 0 0 1 1 1 2 0 1 0 1 0 0 1 2 1
 2]
对比真实值和预测值： [ True  True  True  True  True  True  True  True  True  True  True  True
  True  True  True False  True  True  True  True  True  True  True  True
  True  True  True  True  True  True  True  True  True  True False  True
  True  True]
准确率：
 0.947368421053
最佳参数： {'n_neighbors': 5}
最佳结果 0.973214285714
```

