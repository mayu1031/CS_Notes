<br>

<div align="center">
    <br>
    <a href="https://github.com/mayu1031/CS_Notes"> <img src="https://raw.githubusercontent.com/mayu1031/CS_Notes/master/doc/others/icons/%E5%86%AC%E6%97%A5%E8%A3%85%E5%A4%87icon/%E8%80%B3%E7%BD%A9.png"></a>
  
</div> 

<br/>

# LeetCode
## 175.Combine Two Tables
- Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:  
- 编写一个 SQL 查询，满足条件：无论 person 是否有地址信息，都需要基于上述两表提供 person 的以下信息：

```
Table: Person
+-------------+---------+  
| 列名         | 类型     |  
+-------------+---------+  
| PersonId    | int     |  
| FirstName   | varchar |  
| LastName    | varchar |  
+-------------+---------+  
```  
PersonId is the primary key column for this table.

```
Table: Address
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
```
AddressId is the primary key column for this table.

```sql
select FirstName, LastName, City, State 
from Person left join Address on Person.PersonId = Address.PersonId
```

## 176.Second Highest Salary
- Write a SQL query to get the second highest salary from the Employee table.
- 编写一个 SQL 查询，获取 Employee 表中第二高的薪水（Salary） 。
```
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.  
例如上述 Employee 表，SQL查询应该返回 200。 作为第二高的薪水。如果不存在第二高的薪水，那么查询应返回 null。

```
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

```sql
select ifnull((select distinct Salary from Employee
group by Salary
order by Salary desc
limit 1,1), null) as SecondHighestSalary
```

## 177.Nth Highest Salary
Write a SQL query to get the nth highest salary from the Employee table.  
编写一个 SQL 查询，获取 Employee 表中第 n 高的薪水（Salary）。
```
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```  
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

```sql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    if((select count(*) from (select distinct e.Salary from Employee e)e)>= N,
       (select min(e.Salary) from 
        (select distinct e.Salary from Employee e group by e.Salary order by e.Salary desc limit N)e),
       null)
  );
END
```

## 178.Rank Scores  
Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. Note that after a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no "holes" between ranks.  
编写一个 SQL 查询来实现分数排名。如果两个分数相同，则两个分数排名（Rank）相同。请注意，平分后的下一个名次应该是下一个连续的整数值。换句话说，名次之间不应该有“间隔”。  
```
+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
```  
For example, given the above Scores table, your query should generate the following report (order by highest score):  
```
+-------+------+
| Score | Rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+
```

```sql
select score,(select count(distinct S1.score) from Scores S1 where S1.score >= S2.score)as Rank from Scores S2
order by score desc
```
```sql
select S1.score,sum(case when S2.Score >= S1.score then 1 end) as Rank from Scores S1, (select distinct Score from Scores)S2
group by S1.id  ##用id分类之后再排序 不要用score分类，有完全相同两行，会报错
order by S1.score desc

```

## 180.Consecutive Numbers
Write a SQL query to find all numbers that appear at least three times consecutively.  
编写一个 SQL 查询，查找所有至少连续出现三次的数字。
```
+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
```
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.
```
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
```  
```sql
select
    distinct Num as  ConsecutiveNums  from
    (select Logs_a.Num as Num,
            case when Logs_a.Num = Logs_b.Num and Logs_b.Num = Logs_c.Num then 1 
                else 0
                end as is_ConsecutiveNum 
                from Logs Logs_a left join Logs Logs_b on Logs_a.Id+1 =Logs_b. Id left join Logs Logs_c on Logs_a.Id +2 = Logs_c.Id where Logs_c.Id is not null
                    )as t
where is_ConsecutiveNum =1 

```

## 181.Employees Earning More Than Their Managers  
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
Employee 表包含所有员工，他们的经理也属于员工。每个员工都有一个 Id，此外还有一列对应员工的经理的 Id。
```
+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
```
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.
```
+----------+
| Employee |
+----------+
| Joe      |
+----------+
```

```sql
select e1.Name as Employee from Employee e1, Employee as e2 
where e1.ManagerId = e2.Id and e1.Salary >  e2.Salary
```

```sql
select e1.Name as Employee from Employee e1 
where e1.ManagerId is not null and e1.Salary > (select e2.Salary from Employee e2 where e1.ManagerId = e2.Id)
```

## 182.Duplicate Emails  
Write a SQL query to find all duplicate emails in a table named Person.
```
+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
```  
For example, your query should return the following for the above table:
```
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
```
```sql
select distinct a.Email from Person a
where a.Email in (select b.Email from Person b where a.Id <> b.id) 
```
```sql
select distinct a.Email from Person a join Person b on a.Email = b.Email and a.Id <> b.Id
```
## 183.Customers Who Never Order
Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.  
Table: Customers.
```
+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
```  
Table: Orders.  
```
+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
```  
Using the above tables as example, return the following:  
```
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
```  
```sql
select name as Customers from Customers
where Customers.id  not in (select CustomerId from orders join Customers on Customers.Id = Orders.CustomerId)
```

## 184.Department Highest Salary  
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.  
```
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
```  
The Department table holds all departments of the company.
```
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
```  
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, Max has the highest salary in the IT department and Henry has the highest salary in the Sales department.  
编写一个 SQL 查询，找出每个部门工资最高的员工。例如，根据上述给定的表格，Max 在 IT 部门有最高工资，Henry 在 Sales 部门有最高工资。
```
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
```

```sql
select Department.Name as Departmet, Employee.Name as Employee, Employee.Salary 
from Department inner join Employee on 
Employee.DepartmentId = Department.Id and Employee.Salary >=(select max(Employee.Salary) 
from Employee where Employee.DepartmentId = Department.Id) 
```
```sql
select d.Name as Department, e.Name as Employee, e.Salary from Department d inner join Employee e on d.Id = e.DepartmentId and e.Salary >= (select max(Salary) from Employee where DepartmentId = d.Id)
```


## 185.Department Top Three Salaries    
The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.  

```
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
+----+-------+--------+--------------+
```  
The Department table holds all departments of the company.  
```
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
```  
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows.  
编写一个 SQL 查询，找出每个部门工资前三高的员工。例如，根据上述给定的表格，查询结果应返回：  
```
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
```  
```sql
select d.Name as Department, e.Name as Employee, e.Salary from Department as d inner join Employee as e on e.DepartmentId = d.Id
where (select count(distinct e_2.Salary) from Employee e_2 where e_2.Salary > e.Salary and e_2.DepartmentId = e.DepartmentId) <3

order by e.DepartmentId, e.Salary desc;
```

## 196.Delete Duplicate Emails  
Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.
```
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
```
For example, after running your query, the above Person table should have the following rows:
```
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
```
Note:

Your output is the whole Person table after executing your sql. Use delete statement.  

```sql
DELETE p1 FROM Person p1, Person p2
where p1.Email = p2.Email and p1.Id > p2.Id
```


## 197.Rising Temperature  
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.
```
+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
```
For example, return the following Ids for the above Weather table:  
```
+----+
| Id |
+----+
|  2 |
|  4 |
+----+
```

```sql
select w1.Id as Id from Weather w1 Join Weather w2 on DATEDIFF(w1.RecordDate, w2.RecordDate) = 1
where w1.Temperature > w2.Temperature 
```

## 262.Trips and Users  
The Trips table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are both foreign keys to the Users_Id at the Users table. Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).
```
+----+-----------+-----------+---------+--------------------+----------+
| Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
+----+-----------+-----------+---------+--------------------+----------+
| 1  |     1     |    10     |    1    |     completed      |2013-10-01|
| 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |    6    |     completed      |2013-10-01|
| 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |    1    |     completed      |2013-10-02|
| 6  |     2     |    11     |    6    |     completed      |2013-10-02|
| 7  |     3     |    12     |    6    |     completed      |2013-10-02|
| 8  |     2     |    12     |    12   |     completed      |2013-10-03|
| 9  |     3     |    10     |    12   |     completed      |2013-10-03| 
| 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+---------+--------------------+----------+
```
The Users table holds all users. Each user has an unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).
```
+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
```
Write a SQL query to find the cancellation rate of requests made by unbanned users between Oct 1, 2013 and Oct 3, 2013. For the above tables, your SQL query should return the following rows with the cancellation rate being rounded to two decimal places.
```
+------------+-------------------+
|     Day    | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 |       0.33        |
| 2013-10-02 |       0.00        |
| 2013-10-03 |       0.50        |
+------------+-------------------+
```
```sql
SELECT t.request_at as Day, 
round(count( IF ( t.STATUS != "completed", t.STATUS, NULL ) ) / count(t.STATUS),2) as `Cancellation Rate` 

FROM trips t INNER JOIN users u ON u.Users_Id = t.Client_Id 

WHERE u.Banned = "No" and t.request_at between "2013-10-01" and "2013-10-03" 
GROUP BY t.request_at
```


## 595.Big Countries
There is a table World
```
+-----------------+------------+------------+--------------+---------------+
| name            | continent  | area       | population   | gdp           |
+-----------------+------------+------------+--------------+---------------+
| Afghanistan     | Asia       | 652230     | 25500100     | 20343000      |
| Albania         | Europe     | 28748      | 2831741      | 12960000      |
| Algeria         | Africa     | 2381741    | 37100000     | 188681000     |
| Andorra         | Europe     | 468        | 78115        | 3712000       |
| Angola          | Africa     | 1246700    | 20609294     | 100990000     |
+-----------------+------------+------------+--------------+---------------+
```
A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.

Write a SQL solution to output big countries' name, population and area.

For example, according to the above table, we should output:
```
+--------------+-------------+--------------+
| name         | population  | area         |
+--------------+-------------+--------------+
| Afghanistan  | 25500100    | 652230       |
| Algeria      | 37100000    | 2381741      |
+--------------+-------------+--------------+
```

```sql
select name, population, area from World
where area > 3000000 or population > 25000000
```

## 596.Classes More Than 5 Students
There is a table courses with columns: student and class

Please list out all classes which have more than or equal to 5 students.

For example, the table:
```
+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+
```
Should output:
```
+---------+
| class   |
+---------+
| Math    |
+---------+
```
Note:
The students should not be counted duplicate in each course.

```sql
select class from courses
group by class having count(distinct student) >=5
```

## 601.Human Traffic of Stadium
X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, date, people

Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

For example, the table stadium:
```
+------+------------+-----------+
| id   | date       | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
```
For the sample data above, the output is:
```
+------+------------+-----------+
| id   | date       | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
```
```sql
SELECT DISTINCT s4.id,s4.date,s4.people FROM stadium s1,stadium s2,stadium s3,stadium s4 
WHERE s1.id+1=s2.id AND s2.id+1=s3.id AND s1.people>=100 AND s2.people>=100 AND s3.people>=100 AND s4.id IN (s1.id,s2.id,s3.id)**
```
## 620.Not Boring Movies
X city opened a new cinema, many people would like to go to this cinema. The cinema also gives out a poster indicating the movies’ ratings and descriptions.
Please write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. Order the result by rating.

For example, table cinema:
```
+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War       |   great 3D   |   8.9     |
|   2     | Science   |   fiction    |   8.5     |
|   3     | irish     |   boring     |   6.2     |
|   4     | Ice song  |   Fantacy    |   8.6     |
|   5     | House card|   Interesting|   9.1     |
+---------+-----------+--------------+-----------+
```
For the example above, the output should be:
```
+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   5     | House card|   Interesting|   9.1     |
|   1     | War       |   great 3D   |   8.9     |
+---------+-----------+--------------+-----------+
```
```sql
select id,movie, description, rating from cinema 
where description != 'boring' and id%2 !=0 order by rating desc
```


## 626.Exchange Seats
Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

The column id is continuous increment.  
Mary wants to change seats for the adjacent students.  
Can you write a SQL query to output the result for Mary?  
```
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
```
For the sample input, the output is:
```
+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
```
Note:  
If the number of students is odd, there is no need to change the last one's seat.  
```sql
SELECT * FROM(
    SELECT id-1 AS id,student FROM seat WHERE id%2=0
    UNION
    SELECT id+1 AS id,student FROM seat WHERE id%2=1 AND (id+1) <= (SELECT COUNT(*) FROM seat)
    UNION
    SELECT id AS id,student FROM seat WHERE id%2=1 AND (id+1) > (SELECT COUNT(*) FROM seat)
) AS T1
ORDER BY id ASC
```

## 627.Swap Salary
Given a table salary, such as the one below, that has m=male and f=female values. Swap all f and m values (i.e., change all f values to m and vice versa) with a single update query and no intermediate temp table.  
For example:  
```
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
```
After running your query, the above salary table should have the following rows:
```
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |
```
```sql
update salary set sex = if(sex='m','f','m')
```




