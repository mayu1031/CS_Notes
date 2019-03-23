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

12.查询和“01”号同学所学课程完全相同的其他同学的学号
```sql
select s_id from score
where c_id in (select c_id from score where s_id = '1') and s_id != '1' 
group by s_id 
having count(c_id) = (select count(c_id) from score where s_id = '1')
```

13.把“SCORE”表中“张三”老师教的课的成绩都更改为此课程的平均成绩


14.查询和“02”号的同学学习的课程完全相同的其他同学学号和姓名(同12题）
```sql
select stu.s_id, stu.s_name from student as stu join score on stu.s_id = score.s_id
where score.c_id in (select c_id from score where s_id = '2') and stu.s_id != '2'
group by stu.s_id
having count(score.c_id) = (select count(c_id) from score where s_id = '2')
```

15、删除学习“张三”老师课的SC表记录

16.按平均成绩从高到低显示所有学生的“数据库”（c_id='04'）、“企业管理”（c_id='01'）、“英语”（c_id='06'）三门的课程成绩，按如下形式显示：学生ID，数据库，企业管理，英语，有效课程数，有效平均分
```sql
select s_id, (case when c_id = '4' then s_score else null end) as '数据库', 
(case when c_id = '1' then s_score else null end) as '企业管理', 
(case when c_id = '6' then s_score else null end) as '英语',
count(c_id), round(avg(s_score),2) from score
group by s_id
order by avg(s_score) desc;
```

17.查询各科成绩最高和最低的分： 以如下的形式显示：课程ID，最高分，最低分
```sql
select c_id, max(s_score),min(s_score) from score
group by c_id;
```

18.按各科平均成绩从低到高和及格率的百分数从高到低排列，以如下形式显示：课程号,课程名,平均成绩,及格百分数
```sql
select course.c_id, course.c_name, avg(s_score),
concat((select count(score2.s_score) from score as score2 where score2.s_score>=60 and score1.c_id = score2.c_id)
/(select count(score2.s_score) from score as score2 where score1.c_id = score2.c_id)*100,'%') as '及格率'
from  course join score as score1 on course.c_id = score1.c_id
group by course.c_id
order by avg(s_score) asc, '及格率' desc;
```

19.查询不同老师所教不同课程平均分从高到低显示
```sql
select teacher.t_id, teacher.t_name, course.c_name, avg(score.s_score) from teacher join course on teacher.t_id = course.t_id join score on course.c_id = score.c_id
group by teacher.t_id
order by avg(score.s_score) desc;
```

20.使用分段[100-85],[85-70],[70-60],[<60]来统计各科成绩，分别统计各分数段人数：课程ID和课程名称

```sql
select course.c_id, course.c_name,
sum(case when s_score >=85 then 1 else 0 end) as '[100-85]',
sum(case when s_score <85 and s_score >=70 then 1 else 0 end) as '[85-70]',
sum(case when s_score <70 and s_score >=60 then 1 else 0 end) as '[70-60]',
sum(case when s_score <60 then 1 else 0 end) as '[<60]'
from course join score on course.c_id = score.c_id

group by course.c_id;
```

21.查询学生平均成绩及其名次

要点：算出在所有同学中有几个同学的平均分高于某个ID,然后+1，就是名次

```sql
select score1.s_id, score1.score1_avg,

(select count(*) from 

(select s_id, avg(s_score) as score2_avg from score  group by s_id)as score2 

where score2.score2_avg > score1.score1_avg)+1 as 'rank'

from (select s_id, avg(s_score) as score1_avg from score  group by s_id)as score1

order by score1.score1_avg desc;
```

22. 查询各科成绩前三名的记录（不考虑成绩并列情况）

```sql
select c_id, s_id, s_score from score as score1
where (select count(*) from score as score2 where score1.c_id = score2.c_id and score2.s_score > score1.s_score)<=2
group by c_id, s_id, s_score
order by c_id asc, s_score desc;
```