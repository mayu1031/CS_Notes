# sklearn转换器和估计器
## 1转换器transformer
- 转换器是特征工程的父类，所有在进行特征工程的时候都是继承自transformer这个父类

### 1.2特征工程的步骤
    - 1.实例化 实例化一个转换器类 transformer
    - 2.调用fit_transform（对于文档建立分类词频矩阵，不能同时调用）
- 我们把特征工程的家口称之为转换器，其中转换器调用有着几个种形式
    - fit_transform()
    - fit() 
    - transform()
- 标准化公式:(x-mean)/std
    - fit_transform()
    - fit() 计算每一列的平均值和标准差
    - transform() 带入公式(x-mean)/std 进行最终的转换

## 2预估器estimator
- sklearn机器学习算法的实现都被封装到估计器estimator这个父类当中
- 在sklearn中，估计器estimator是一个重要的角色，是一类实现了算法的API；所有的估计器都是estimator的子类
- 用于分类的估计器：
    - sklearn.neighbors k-近邻
    - sklearn.naive_bayes 贝叶斯
    - sklearn.linear_model.LogisticRegression 逻辑回归
    - sklearn.tree 决策树与随机森林
- 用于回归的估计器
    - sklearn.linear_model.linearRegression 线性回归
    - sklearn.linear_model.Ridge 岭回归
- 用于无监督学习的估计器
    - sklearn.cluster.KMeans 聚类

### 2.1预估器流程
- 实例化一个estimator
- 调用实例 estimator.fit(x_trian，y_trian) #fit都是在计算
    - 调用完毕，模型生成
- 评估模型
    - 计算准确率
        - accuracy = estimator.score(x_test,y_test)
    - 直接对比真实值和预测值
        - y_pre = estimator.predict(x_test)
        - y_test == y_pre
