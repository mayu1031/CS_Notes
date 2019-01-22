# LeetCode
## 175. Combine Two Tables
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

## 176. Second Highest Salary
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

## 177. Nth Highest Salary
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

## 180. Consecutive Numbers
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

## 181. Employees Earning More Than Their Managers  
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

## 182. Duplicate Emails  
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
## 183. Customers Who Never Order
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
