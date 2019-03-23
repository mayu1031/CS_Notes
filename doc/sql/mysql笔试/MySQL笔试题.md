# MySQL笔试题
- 建表
已知有如下4张表：

学生表：

Student(s_id,s_name,s_birth,s_sex) –学生编号,学生姓名, 出生年月,学生性别

课程表：

Course(c_id,c_name,t_id) – –课程编号, 课程名称, 教师编号

教师表：

Teacher(t_id,t_name) –教师编号,教师姓名

成绩表：

Score(s_id,c_id,s_s_score) –学生编号,课程编号,分数

- 学生表
```sql
CREATE TABLE student(
s_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
s_name VARCHAR(20) NOT NULL DEFAULT ' ',
s_birth VARCHAR(20) NOT NULL DEFAULT ' ',
s_sex VARCHAR(10) NOT NULL DEFAULT ' ',
PRIMARY key (s_id)
);

DESC student;
```
- 课程表
```sql
CREATE TABLE course(
c_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
c_name VARCHAR(20) NOT NULL DEFAULT '',
t_id VARCHAR(20) NOT NULL DEFAULT'',
PRIMARY KEY (c_id)
);
```
- 教师表
```sql
CREATE TABLE teacher(
t_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
t_name VARCHAR(20) NOT NULL DEFAULT '',
PRIMARY key (t_id)
);
```
- 成绩表
```sql
CREATE TABLE score(
s_id int,
c_id int,
s_score int(3),
PRIMARY KEY (s_id,c_id)
);
```


- 插入数据
```sql
insert into student values('01' , '赵雷' , '1990-01-01' , '男');
insert into student values('02' , '钱电' , '1990-12-21' , '男');
insert into student values('03' , '孙风' , '1990-05-20' , '男');
insert into student values('04' , '李云' , '1990-08-06' , '男');
insert into student values('05' , '周梅' , '1991-12-01' , '女');
insert into student values('06' , '吴兰' , '1992-03-01' , '女');
insert into student values('07' , '郑竹' , '1989-07-01' , '女');
insert into student values('08' , '王菊' , '1990-01-20' , '女');


insert into course values('01' , '语文' , '02');
insert into course values('02' , '数学' , '01');
insert into course values('03' , '英语' , '03');


insert into teacher values('01' , '张三');
insert into teacher values('02' , '李四');
insert into teacher values('03' , '王五');

insert into Score values('01' , '01' , 80);
insert into Score values('01' , '02' , 90);
insert into Score values('01' , '03' , 99);
insert into Score values('02' , '01' , 70);
insert into Score values('02' , '02' , 60);
insert into Score values('02' , '03' , 80);
insert into Score values('03' , '01' , 80);
insert into Score values('03' , '02' , 80);
insert into Score values('03' , '03' , 80);
insert into Score values('04' , '01' , 50);
insert into Score values('04' , '02' , 30);
insert into Score values('04' , '03' , 20);
insert into Score values('05' , '01' , 76);
insert into Score values('05' , '02' , 87);
insert into Score values('06' , '01' , 31);
insert into Score values('06' , '03' , 34);
insert into Score values('07' , '02' , 89);
insert into Score values('07' , '03' , 98);
```
- student
![studnet](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/sql/mysql%E7%AC%94%E8%AF%95/student.jpg)
- teacher
![teacher](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/sql/mysql%E7%AC%94%E8%AF%95/teacher.jpg)
- course
![course](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/sql/mysql%E7%AC%94%E8%AF%95/course.jpg)
- score
![score](https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/sql/mysql%E7%AC%94%E8%AF%95/score.jpg)

笔试题

1.查询课程编号为“01”的课程比“02”的课程成绩高的所有学生的学号。

```sql
SELECT s1.s_id FROM score s1 JOIN score s2 ON s1.s_id = s2.s_id
WHERE s1.c_id = 1 AND  s2.c_id =2 AND s1.s_score > s2.s_score;
```

2.查询平均成绩大于60分的学生的学号和平均成绩

```sql
select s_id, round(sum(s_score)/count(c_id),2) as 均分 from score
group by s_id
having sum(s_score)/count(c_id) > 60
```

```sql
select s_id, round(avg(s_score),2) as 均分 from score
group by s_id
having avg(s_score) > 60
```

3.查询所有学生的学号、姓名、选课数、总成绩

```sql
select student.s_id, s_name,count(c_id),sum(s_score) from student join score on student.s_id = score.s_id
group by student.s_id;
```

4.查询姓“张”的老师的个数
```
select count(*) from teacher
where t_name like '张%'
```

**5.查询没学过“张三”老师课的学生的学号、姓名(重点)**

这题要考虑到有的学生上了好几门课，其中有一门是张三教的，剩下存在几门是张三教的情况 不是直接用！=这个方法
```sql
select s_id, s_name from student 
where s_id not in(
select stu.s_id from student as stu join score on stu.s_id = score.s_id join course on score.c_id = course.c_id join teacher on course.t_id = teacher.t_id
where teacher.t_name = '张三');
```


6.查询学过“张三”老师所教的所有课的同学的学号、姓名
```sql
select stu.s_id, stu.s_name from student as stu join score on stu.s_id = score.s_id join course on score.c_id = course.c_id join teacher on course.t_id = teacher.t_id
where teacher.t_name = '张三';
```

- 7.查询学过编号为“01”的课程并且也学过编号为“02”的课程的学生的学号、姓名
```sql
select s_id,s_name from student
where s_id in (select score1.s_id from (select s_id from score where c_id = '1') as score1 join (select s_id from score where c_id = '2') as score2 on score1.s_id = score2.s_id)
```


```sql
select stu.s_id,stu.s_name from student as stu join score as score1 on stu.s_id = score1.s_id join score as score2 on stu.s_id = score2.s_id
where score1.c_id = '1' and score2.c_id = '2' and score1.s_id = score2.s_id;
```

8、查询课程编号为“02”的总成绩
```sql
select sum(s_score) from score
where c_id = '2';
```

9.查询所有课程成绩小于60分的学生的学号、姓名
- 所有成绩小于60分即排除存在有60分往上的学生
```
select stu.s_id,stu.s_name from student as stu
where stu.s_id not in (select s_id from score where s_score>=60)
```

10.查询没有学全所有课的学生的学号、姓名
```sql
select stu.s_id, stu.s_name from student as stu join score on stu.s_id = score.s_id
group by stu.s_id 
having count(score.c_id)<(select count(*) from course)
```

11.查询至少有一门课与学号为“01”的学生所学课程相同的学生的学号和姓名
```sql
select distinct stu.s_id, stu.s_name from student as stu join score on stu.s_id = score.s_id
where score.c_id in (
select c_id from score
where s_id = '1' ) and stu.s_id != '1';
```