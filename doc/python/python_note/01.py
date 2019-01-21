'''
定义一个学生类，用来形容学生
'''
# 定义了一个空的类
class Student():
    #一个空类，pass代表直接跳过
    # 此处pass必须有
    pass

# 定义一个对象
student_a = Student()

# 定义一个类，用来描述听python的学生
class PythonStudent():
    # 用None来给不确定的值赋值
    name = None
    age = 18
    course = "Pyhton"

    #定义一个函数
    # 1. def doHomework的缩进层级
    # 2. 系统默认出一个self参数
    def doHomework(self):
        print("do homework")
        #推荐函数末尾使用return语句
        return None

# 示例化一个叫student_b的学生，是一个具体的人
student_b = PythonStudent()
print(student_b.name)
print(student_b.age)
# 注意成员函数的调用么有传递进入参数
# 执行做作业的函数
student_b.doHomework()



