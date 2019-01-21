# LeetCode
## 175. Combine Two Tables
- Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:  

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
      SELECT(IF((SELECT COUNT(*) FROM (SELECT DISTINCT e.Salary from Employee e) e) >= N, 
      (SELECT min(e.Salary) FROM 
      (SELECT DISTINCT e.Salary FROM Employee e group by e.Salary ORDER BY e.Salary DESC LIMIT N) e), 
      NULL ))
  );
END
```




