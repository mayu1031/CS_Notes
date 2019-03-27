# 泰坦尼克号分析
## 数据来源
泰坦尼克号是当时世界上体积最庞大、内部设施最豪华的客运轮船，有“永不沉没”的美誉 。然而不幸的是，在它的处女航中，泰坦尼克号便遭厄运——它从英国南安普敦出发，途经法国瑟堡-奥克特维尔以及爱尔兰科夫(Cobh)，驶向美国纽约。1912年4月14日23时40分左右，泰坦尼克号与一座冰山相撞，造成右舷船艏至船中部破裂，五间水密舱进水。次日凌晨2时20分左右，泰坦尼克船体断裂成两截后沉入大西洋底3700米处。2224名船员及乘客中，逾1500人丧生，其中仅333具罹难者遗体被寻回。


## 数据信息
- PassengerId    乘客编码
- Survived       是否幸存 (0=遇难 1=幸存)
- Pclass         船票类型 (1=一等票，2=二等票，3=三等票)
- Name           名字
- Sex            性别
- Age            年龄
- SibSp          船上该成员兄弟姐妹的数量
- Parch          船上该成员的父母或子女数量
- Ticket         船票编号
- Fare           乘客票价
- Cabin          客舱号码
- Embarked       起航运港（C = Cherbourg, Q = Queenstown, S = Southampton）

## 使用Python科学数据包对数据进行分析
- [Python分析泰坦尼克号获救数据](https://github.com/mayu1031/CS_Notes/blob/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E6%B3%B0%E5%A1%94%E5%B0%BC%E5%85%8B%E5%8F%B7/python%E5%88%86%E6%9E%90%E6%B3%B0%E5%9D%A6%E5%B0%BC%E5%85%8B%E5%8F%B7%E5%AD%98%E6%B4%BB.md)

## 使用机器语言泰坦尼克号获救预测案例
### 本次预测中，对年龄，港口，船票单纯做了分类处理，没有用到one-hot编码
- [用机器语言泰坦尼克号获救预测案例](https://github.com/mayu1031/CS_Notes/blob/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E6%B3%B0%E5%A1%94%E5%B0%BC%E5%85%8B%E5%8F%B7/%E6%B3%B0%E5%9D%A6%E5%B0%BC%E5%85%8B%E5%8F%B7%E4%B9%98%E5%AE%A2%E7%94%9F%E5%AD%98%E9%A2%84%E6%B5%8B%E5%90%84%E9%A2%84%E4%BC%B0%E5%99%A8.md)

- [用机器语言泰坦尼克号获救预测案例](https://github.com/mayu1031/CS_Notes/blob/master/doc/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90/%E6%B3%B0%E5%A1%94%E5%B0%BC%E5%85%8B%E5%8F%B7/%E6%B3%B0%E5%9D%A6%E5%B0%BC%E5%85%8B%E5%8F%B7%E4%B9%98%E5%AE%A2%E7%94%9F%E5%AD%98%E9%A2%84%E6%B5%8B%E5%90%84%E9%A2%84%E4%BC%B0%E5%99%A82.md)
