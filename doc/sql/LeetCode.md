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
select FirstName, LastName, City, State from Person left join Address on Person.PersonId = Address.PersonId
```

## 176. Second Highest Salary
- Write a SQL query to get the second highest salary from the Employee table.

```sql
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

```sql
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