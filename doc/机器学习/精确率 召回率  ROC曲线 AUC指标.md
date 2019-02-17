# 二分类模型评估
# 1精确率与召回率
- 混淆矩阵
    - 在分类任务下，预测结果(Predicted Codition)与正确标记(True Condition)之间存在四种不同的组合，构成混淆矩阵(适用于多分类)
    - TP True possitive
    - FN False Negative  

![混淆矩阵](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E9%80%BB%E8%BE%91%E5%9B%9E%E5%BD%92/%E6%B7%B7%E6%B7%86%E7%9F%A9%E9%98%B5.png)

- **精确率Precision**和**召回率Recall**
    - **精确率**: 预测结果为正例样本中真实为正例的比例
        - TP/(TP+FP)
    - **召回率**: 真实为正例的样本中预测结果为正例的比例(查的全，对正样本的区分能力)
        - TP/(TP+FN)
        - 真正患癌症的，能够被检测出来的概率；查的全不全
        - 应用场景: 癌症，工厂质量检测

- F1-score 反映模型的稳健性
    - F1-score高，代表精确率高，召回率也高

![F1-score](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E9%80%BB%E8%BE%91%E5%9B%9E%E5%BD%92/F1-score.png)

## 1.1分类评估API
- **sklearn.metrics.classification_report(y_ture,y_pred,label=[],target_names=None)** (classification_report分类结果报告)
    - y_true:真实目标值
    - y_pred:估计器预测目标值
    - labels:指定类别对应的数字 一般正例为1，负例为0
    - target_names:目标类别名称 比如:[良性，恶性]
    - return:每个目标精确率和召回率
```
print('精确率和召回率为:', classification.report(y_test,lr.predict(x_test)))
```
## 1.2 召回率应用场景
- 工厂里面质量检测，查次品

# 样本不平衡情况下
# 2ROC曲线与AUC指标

总共有100个样本，其中99个样本为癌症，一个样本非癌症  
不管怎么样，我们全部预测正例(默认癌症为正例)- 不负责任  
准确率: 99/100=99%  
召回率: 99/99=100%  
精确率: 99/100=99%  
F1-score: 99.497%  2*99%/(100%+99%)=99.497%  
AUC: 
TPR = 100%  
FPR = 1/1 =100%  
AUC: 1*1/2=0.5

- 造成这样的结果是因为**样本不均衡**，**正样本太多，反例太少**，我们需要找到能够衡量**样本不均衡**情况下分类器的效果引入ROC曲线与AUC指标  


## 2.1知道TPR与FPR
- TPR = TP/(TP+FN) 召回率 
    - 所有真实类别为1的样本中，预测类别为1的比例
- FPR = FP/(FP+TN)
    - 所有真实类别为0的样本中，预测类别为1的比例
- TPR = FPR 不负责任的模型
    - TPR = FPR 斜率为1，AUC为0.5

## 2.2ROC曲线  
![ROC曲线](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E9%80%BB%E8%BE%91%E5%9B%9E%E5%BD%92/ROC%E6%9B%B2%E7%BA%BF.png)  

- ROC曲线的横轴就是FPRate,纵轴就是TPRate，当二者相等时，表示的意义则是:对于不论真实类别是1还是0的样本，分类器预测通通都为1的概率是相等的，此时AUC为0.5，不负责任的模型
- TPR>FPR, 最小值AUC为0.5，最大值极限AUC为1，TPR为1，FPR为0，左上角的点，即所有真实类别为1的样本中，都预测正确为1

## 2.3AUC指标  

- 上图中虚线和x轴y轴包围起来的面积: 
- AUC的概率意义就是随机取一对正负样本，正样本得分大于负样本的概率
- AUC为0.5时，和random guess那条红线重合，是非常不负责任模型
- AUC的最小值为0.5 最大为1 取值越高越好
- **AUC为1，完美分类器，采用这个预测模型是，不管设定什么阈值都能得出完美预测，绝大多数预测的场合，不存在完美分类器**
- **0.5<AUC<1，优于随机猜测，这个分类器(模型)妥善设定阈值的话，能有预测价值**
- 最终AUC的范围在[0.5,1]之间，并且越接近1越好
- 如果出现AUC小于0.5的情况则反着看

## 2.4AUC计算API
- **from sklearn.metrics import roc_auc_score**
- **sklearn.metrics.roc_auc_score(y_true,y_score)**
    - 计算ROC曲线面积，即AUC值
    - y_true: 每个样本的真实类别，必须为0(反例)，1(正例)标记
    - y_score：预测得分，可以是正类的预计概率，置信值或者分类器方法的返回值

## 2.5总结
- AUC只能用来评价二分类
- AUC非常适合评价样本不平衡中的分类性能



