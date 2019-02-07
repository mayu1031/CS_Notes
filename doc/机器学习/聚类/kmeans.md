# 聚类算法
## 什么是无监督学习
- 没有目标值-无监督学习
- airbnb需要将自己的房屋清单分组成不同的社区，以便用户能轻松地查阅这些清单
- 一个数据科学家需要降低一个大型数据集的维度的数量，以便简化建模和降低文件大小

## 无监督学习包含算法
- 聚类
    - k-means(k均值聚类)
- 降维
    - PCA

## k-mean原理
- K-超参数  
- 随机设置k个特征空间内的点作为初始的聚类中心
- 对于其他每个点计算到k个中心的聚类，未知的点选择最近的一个聚类中心作为标记类别
- 接着对着标记的聚类中心之后，重新计算出每个聚类的新中心点(平均值)
- 如果计算得出的新中心点与原来中心点一样，那么结束，否则重新进行第二步过程

## K-meanAPI
- sklearn.cluster.KMeans(n_clusters=8,init='k-means++')
    - k-means聚类
    - n_cluster:开始的聚类中心数量 k值
    - init:初始化方法，默认为'k-means++'
    - labels_:默认标记的类型，可以和真实值对比(不是值对比)

## 案例k-means对Instacart Market用户聚类
```
k=3  
流程分析:  
降维之后的数据 
1. 预估器流程
2. 看结果
3. 模型评估
````
## Kmeans性能评估指标
### 轮廓系数
![轮廓系数](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E8%81%9A%E7%B1%BB/kmeans%E8%BD%AE%E5%BB%93%E7%B3%BB%E6%95%B0.png)

### 轮廓系数分析
- 外部距离最大化，内部距离最小化 高内聚，低耦合
- b_i>>>a_i 外部距离很大 内部聚类很小，效果最好 Sc无限接近于b_i/b_i=1
- b_i<<<a_i 效果不好，Sc无限接近于-a_i/a_i=-1
- 轮廓系数的值是介于[-1,1]，越接近1代表内聚度和分离度都相对较优
![轮廓系数分析](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E8%81%9A%E7%B1%BB/kmeans%E8%BD%AE%E5%BB%93%E7%B3%BB%E6%95%B0%E5%88%86%E6%9E%90.png)

### 轮廓系数API
- sklearn.metrics.silhouette_score(X,labels)
    - 计算所有样本的平均轮廓系数
    - X:特征值
    - label:被聚类标记的目标值

### 用户聚类结果评估
```
silhouette_score(cust,pre)
```

### K-means总结
- 特点分析: 采用迭代式算法，直观易懂并且非常实用
- 缺点: 容易收敛到局部最优解(多次聚类)

### 应用场景
- 聚类一般做在分类之前
- 没有目标值的情况下，我们会先做聚类
- 之后再考虑分类