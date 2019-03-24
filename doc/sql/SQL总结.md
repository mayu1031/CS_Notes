# SQL总结

1. 视图和表有什么区别

视图是一种外模式，属于窗口，是查看数据表的一种方法，可以查询数据表中某些字段构成的数据，是一些SQL语句的集合。相对来说，表是内模式，属于内容层面，建立和删除的是视图，不会影响对应的表

2. 用户登陆日志表为user_id，log_time，session_id，plat 用sql查询近30天，每天平均登陆用户数量？
```sql
select avg(table1.user_number) from
(select count(distinct user_id) as user_num from table
where date_format(log_time,'%y-%m-%d') > date_sub(current_date(),interval 30days) group by date_format(log_time,'%y-%m-%d')) as table1
```
3. 交易表结构user_id（用户ID），order_id（订单），pay_time（付款时间），order_amount（金额）

查询过去一个月付款用户量（提示：用户量需去重）最高的3天分别是哪几天？

```sql
select date_format(pay_time,'%y-%m-%d') from table
where month(date_format(pay_time,'%y-%m-%d')) = month(now())-1
group by data_format(pay_time,'%y-%m-%d')
order by use_num desc
limit 3;
```
查询昨天每个用户最后付款的订单ID及金额？

```sql
select user_id, order_id,order_amount from table
where data_format(pay_time,'%y-%m-%d') >= data_sub(curdate().interval 1 day)
group by user_id
order by pay_time desc 
limit 1;
```

4. 表删除操作须谨慎

表删除操作将把表的定义和表中的数据一起删除，并且MySQL在执行删除操作时，不会有 任何的确认信息提示，因此执行删除操时，应当慎重。在删除表前，最好对表中的数据进行备份， 这样当操作失误时，可以对数据进行恢复，以免造成无法挽回的后果。

同样的，在使用ALTER TABLE进行表的基本修改操作时，在执行操作过程之前，也应该 确保对数据进行完整的备份，因为数据库的改变是无法撤销的，如果添加了一个不需要的字段， 可以将其删除；相同的，如果删除了一个需要的列，该列下面的所有数据都将会丢失。

5. 每个表中都要有一个主键吗？

并不是每一个表中都需要主键，一般的，如果多个表之间进行连接操作时，需要用到主键。 因此并不需要为每个表建立主键，而且有些情况最好不使用主键。

6. 每个表都可以任意选择存储引擎吗？

外键约束（FOREIGN KEY)不能跨引擎使用。MySQL支持多种存储引擎，每一个表都可 以指定一个不同的存储引擎，但是要注意：外键约束是用来保证数据的参照完整性，如果表之间 需要关联外键，却指定了不同的存储引擎，这些表之间是不能创建外键约束的。所以说，存储引 擎的选择也不完全是随意的。

9. 带AUTO_INCREMENT约束的字段值是从1开始的吗？

默认的，在MySQL中，AUTO_INCREMENT的初始值是1，每新增一条记录，字段值自动加1。设置自增属性（AUTO_INCREMENT)的时候，还可以指定第一条插入记录的自增字段的 值，这样新插入的记录的自增字段值从初始值开始递增，如在tb_emp8中插入第一条记录，同时 指定id值为5,则以后插入的记录的id值就会从6开始往上增加。添加唯一性的主键约束时， 往往需要设置字段自动增加属性。

10. TIMESTAMP与DATATIME两者的区别

TIMESTAMP与DATETIME除了存储字节和支持的范围不同外，还有一个最大的区别就是： DATETIME在存储日期数据时，按实际输入的格式存储，即输入什么就存储什么，与时区无关； 而TIMESTAMP值的存储是以UTC(世界标准时间）格式保存的，存储时对当前时区进行转换， 检索时再转换回当前时区。即查询时，根据当前时区的不同，显示的时间值是不同的。

11. 选择数据类型的方法和技巧是什么？

MySQL提供了大量的数据类型，为了优化存储，提高数据库性能，在任何情况下均应使用 最精确的类型。即在所有可以表示该列值的类型中，该类型使用的存储最少。

整数和浮点数

如果不需要小数部分，则使用整数来保存数据；如果需要表示小数部分，则使用浮点数类 型。对于浮点数据列，存入的数值会对该列定义的小数位进行四舍五入。例如如果列的值的范 围为1〜99999，若使用整数，则MEDIUMINT UNSIGNED是最好的类型；若需要存储小数，则 使用FLOAT类型。浮点类型包括FLOAT和DOUBLE类型。DOUBLE类型精度比FLOAT类型高，因此，如要求存储精度较高时，应选择DOUBLE类型。

浮点数和定点数

浮点数FLOAT，DOUBLE相对于定点数DECIMAL的优势是：在长度一定的情况下，浮点 数能表示更大的数据范围。但是由于浮点数容易产生误差，因此对精确度要求比较高时，建议使 用DECIMAL来存储。DECIMAL在MySQL中是以字符串存储的，用于定义货币等对精确度要 求较高的数据。在数据迁移中，float(M,D)是非标准SQL定义，数据库迁移可能会出现问题，最 好不要这样使用。另外两个浮点数进行减法和比较运算时也容易出问题，因此在进行计算的时候， 一定要小心。如果进行数值比较，最好使用DECIMAL类型。

日期与时间类型

MySQL对于不同种类的日期和时间有很多的数据类型，比如YEAR和TIME。如果只需要 记录年份，则使用YEAR类型即可；如果只记录时间，只须使用TIME类型。如果同时需要记录日期和时间，则可以使用TIMESTAMP或者DATETIME类型。由于 TIMESTAMP列的取值范围小于DATETIME的取值范围，因此存储范围较大的日期最好使用 DATETIME。TIMESTAMP也有一个DATETIME不具备的属性。默认的情况下，当插入一条记录但并没 有指定TIMESTAMP这个列值时，MySQL会把TIMESTAMP列设为当前的时间。因此当需要 插入记录同时插入当前时间时，使用TIMESTAMP是方便的，另外TIMESTAMP在空间上比 DATETIME更有效。

CHAR与VARCHAR之间的特点与选择

CHAR和VARCHAR的区别：

CHAR是固定长度字符，VARCHAR是可变长度字符；CHAR会自动删除插入数据的尾部 空格，VARCHAR不会删除尾部空格。

CHAR是固定长度，所以它的处理速度比VARCHAR的速度要快，但是它的缺点就是浪费 存储空间。所以对存储不大，但在速度上有要求的可以使用CHAR类型，反之可以使用 VARCHAR类型来实现。

存储引擎对于选择CHAR和VARCHAR的影响：

对于MyISAM存储引擎：最好使用固定长度的数据列代替可变长度的数据列。这样可以使 整个表静态化，从而使数据检索更快，用空间换时间。

对于InnoDB存储引擎：使用可变长度的数据列，因为InnoDB数据表的存储格式不分固定 长度和可变长度，因此使用CHAR不一定比使用VARCHAR更好，但由于VARCHAR是按照 实际的长度存储，比较节省空间，所以对磁盘I/O和数据存储总量比较好。

ENUM 和 SET

ENUM只能取单值，它的数据列表是一个枚举集合。它的合法取值列表最多允许有65 535 个成员。因此，在需要从多个值中选取一个时，可以使用ENUM。比如：性别字段适合定义为 ENUM类型，每次只能从’男’或’女’中取一个值。SET可取多值。它的合法取值列表最多允许有64个成员。

空字符串也是一个合法的SET值。 在需要取多个值的时候，适合使用SET类型，比如：要存储一个人兴趣爱好，最好使用SET类型。ENUM和SET的值是以字符串形式出现的，但在内部，MySQL以数值的形式存储它们。

BLOB 和 TEXT

BLOB是二进制字符串，TEXT是非二进制字符串，两者均可存放大容量的信息。BLOB主 要存储图片、音频信息等，而TEXT只能存储纯文本文件。应分清两者的用途。

12. MySQL中如何使用特殊字符？

诸如单引号（’），双引号（"），反斜线（)等符号，这些符号在MySQL中不能直接输入 使用，否则会产生意料之外的结果。在MySQL中，这些特殊字符称为转义字符，在输入时需要 以反斜线符号（’\’）开头，所以在使用单引号和双引号时应分别输入（\’）或者（\")，输入反 斜线时应该输入（\)，其他特殊字符还有回车符（\r)，换行符（\n)，制表符（\tab)，退格 符（\b)等。在向数据库中插入这些特殊字符时，一定要进行转义处理。

13. MySQL中可以存储文件吗？

MySQL中的BLOB和TEXT字段类型可以存储数据量较大的文件，可以使用这些数据类型 存储图像、声音或者是大容量的文本内容，例如网页或者文档。虽然使用BLOB或者TEXT可 以存储大容量的数据，但是对这些字段的处理会降低数据库的性能。如果并非必要，可以选择只 储存文件的路径。

14. MySQL中如何执行区分大小写的字符串比较？

在Windows平台下，MySQL是不区分大小的，因此字符串比较函数也不区分大小写。如果 想执行区分大小写的比较，可以在字符串前面添加BINARY关键字。例如默认情况下，’a’=‘A’ 返回结果为1，如果使用BINARY关键字，BINARY’a’=‘A’结果为0,在区分大小写的情况下，’a’ 与’A’并不相同。

15. 如何从日期时间值中获取年、月、日等部分日期或时间值？

MySQL中，日期时间值以字符串形式存储在数据表中，因此可以使用字符串函数分别截取日期时间值的不同部分，例如某个名称为dt的字段有值“2010-10-01 12:00:30”，如果只需要获 得年值，可以输入LEFT(dt, 4)，这样就获得了字符串左边开始长度为4的子字符串，即YEAR 部分的值；如果要获取月份值，可以输入MID(dt,6,2)，字符串第6个字符开始，长度为2的子 字符串正好为dt中的月份值。同理，读者可以根据其他日期和时间的位置，计算并获取相应的值。

16. 如何改变默认的字符集？

CONVERT()函数改变指定字符串的默认字符集，在开始的章节中，向读者介绍使用GUI图形化安装配置工具进行MySQL的安装和配置，其中的一个步骤是可以选择MySQL的默认字符集。但是，如果只改变字符集，没有必要把配置过程重新执行一遍，在这里，一个简单的方式是 修改配置文件。在Windows中，MySQL配置文件名称为my.ini，该文件在MySQL的安装目录下面。修改配置文件中的default-character-set和character-set-server参数值，将其改为想要的字 符集名称，如gbk、gb2312、latinl等，修改完之后重新启动MySQL服务，即可生效。读者可以在修改字符集时使用SHOW VARIABLES LIKE ’character_set_°%’;命令查看当前字符集，以进行对比。

17. DISTINCT可以应用于所有的列吗？

查询结果中，如果需要对列进行降序排序，可以使用DESC，这个关键字只能对其前面的列 进行降序排列。例如，要对多列都进行降序排序，必须要在每一列的列名后面加DESC关键字。 

而DISTINCT不同，DISTINCT不能部分使用。换句话说，DISTINCT关键字应用于所有列而不 仅是它后面的第一个指定列。例如，查询3个字段s_id，f_name，f_price，如果不同记录的这3个字段的组合值都不同，则所有记录都会被查询出来。

18. ORDER BY可以和LIMIT混合使用吗？

在使用ORDER BY子句时，应保证其位于FROM子句之后，如果使用LIMIT，则必须位 于ORDER BY之后，如果子句顺序不正确，MySQL将产生错误消息。

19. 什么时候使用引号？

在查询的时候，会看到在WHERE子句中使用条件，有的值加上了单引号，而有的值未加。 单引号用来限定字符串，如果将值与字符串类型列进行比较，则需要限定引号；而用来与数值进 行比较则不需要用引号。

20. 在WHERE子句中必须使用圆括号吗？

任何时候使用具有AND和OR操作符的WHERE子句，都应该使用圆括号明确操作顺序。 如果条件较多，即使能确定计算次序，默认的计算次序也可能会使SQL语句不易理解，因此使 用括号明确操作符的次序，是一个好的习惯。

21. 更新或者删除表时必须指定WHERE子句吗？

在前面章节中可以看到，所有的UPDATE和DELETE语句全都在WHERE子句中指定了条 件。如果省略WHERE子句，则UPDATE或DELETE将被应用到表中所有的行。

因此，除非 确实打算更新或者删除所有记录，否则要注意使用不带WHERE子句的UPDATE或DELETE 语句。建议在对表进行更新和删除操作之前，使用SELECT语句确认需要删除的记录，以免造 成无法挽回的结果。

22. 索引对数据库性能如此重要，应该如何使用它？

为数据库选择正确的索引是一项复杂的任务。如果索引列较少，则需要的磁盘空间和维护开销 都较少。如果在一个大表上创建了多种组合索引，索引文件也会膨胀很快。

而另一方面，索引较多 可覆盖更多的查询。可能需要试验若干不同的设计，才能找到最有效的索引。可以添加、修改和删 除索引而不影响数据库架构或应用程序设计。因此，应尝试多个不同的索引从而建立最优的索引。

23. 尽量使用短索引。

对字符串类型的字段进行索引，如果可能应该指定一个前缀长度。例如，如果有一个 CHAR(255)的列，如果在前10个或30个字符内，多数值是惟一的，则不需要对整个列进行索引。 短索引不仅可以提高查询速度而且可以节省磁盘空间、减少I/O操作。

24. MySQL存储过程和函数有什么区别？

在本质上它们都是存储程序。函数只能通过return语句返回单个值或者表对象；而存储过程 不允许执行return，但是可以通过out参数返回多个值。函数限制比较多，不能用临时表，只能用表变量，还有一些函数都不可用等等；而存储过程的限制相对就比较少。函数可以嵌入在SQL 语句中使用，可以在SELECT语句中作为查询语句的一个部分调用；而存储过程一般是作为一个独立的部分来执行。

25. 存储过程中的代码可以改变吗？

目前，MySQL还不提供对已存在的存储过程代码的修改，如果必须要修改存储过程，必须使用DROP语句删除之后，再重新编写代码，或者创建一个新的存储过程。

26. 存储过程中可以调用其他存储过程吗？

存储过程包含用户定义的SQL语句集合，可以使用CALL语句调用存储过程，当然在存储 过程中也可以使用CALL语句调用其他存储过程，但是不能使用DROP语句删除其他存储过程。

27. 存储过程的参数不要与数据表中的字段名相同。

在定义存储过程参数列表时，应注意把参数名与数据库表中的字段名区别开来，否则将出 现无法预期的结果。

28. 存储过程的参数可以使用中文吗？

一般情况下，可能会出现存储过程中传入中文参数的情况，例如某个存储过程根据用户的 名字查找该用户的信息，传入的参数值可能是中文。这时需要在定义存储过程的时候，在后面加 上character set gbk,不然调用存储过程使用中文参数会出错，比如定义userInfo存储过程，代码 如下：

CREATE PROCEDURE useInfo(IN u_name VARCHAR(50) character set gbk, OUT u_age INT) 
29. MySQL中视图和表的区别以及联系是什么？

两者的区别：

(1)视图是已经编译好的SQL语句，是基于SQL语句的结果集的可视化的表，而表不是。

(2)视图没有实际的物理记录，而基本表有。

(3)表是内容，视图是窗口。

(4)表占用物理空间而视图不占用物理空间，视图只是逻辑概念的存在，表可以及时对它 进行修改，但视图只能用创建的语句来修改。

(5)视图是查看数据表的一种方法，可以查询数据表中某些字段构成的数据，只是一些SQL 语句的集合。从安全的角度来说，视图可以防止用户接触数据表，因而用户不知道表结构。

(6)表属于全局模式中的表，是实表；视图属于局部模式的表，是虚表。

(7)视图的建立和删除只影响视图本身，不影响对应的基本表。

两者的联系：

视图（view)是在基本表之上建立的表，它的结构（即所定义的列）和内容（即所有记录） 都来自基本表，它依据基本表存在而存在。一个视图可以对应一个基本表，也

可以对应多个基本 表。视图是基本表的抽象和在逻辑意义上建立的新关系。

30. 使用触发器时须特别注意。

在使用触发器的时候需要注意，对于相同的表，相同的事件只能创建一个触发器，比如对 表account创建了一个BEFORE INSERT触发器，那么如果对表account再次创建一个BEFORE INSERT触发器，MySQL将会报错，此时，只可以在表account上创建AFTER INSERT或者 BEFORE UPDATE类型的触发器。灵活的运用触发器将为操作省去很多麻烦。点击这里总结了55道去BAT面试的MYSQL面试题。

31. 及时删除不再需要的触发器。

触发器定义之后，每次执行触发事件，都会激活触发器并执行触发器中的语句。如果需求 发生变化，而触发器没有进行相应的改变或者删除，则触发器仍然会执行旧的语句，从而会影响 新的数据的完整性。因此，要将不再使用的触发器及时删除。

32. 应该使用哪种方法创建用户？

创建用户有几种方法：GRANT语句、CREATE USER语句和直接操作user表。一般情况， 最好使用GRANT或者CREATE USER语句，而不要直接将用户信息插入user表，因为user表中存储了全局级别的权限以及其他的账户信息，如果意外破坏了 user表中的记录，则可能会对 MySQL服务器造成很大影响。

33. mysqldump备份的文件只能在MySQL中使用吗？

mysqldump备份的文本文件实际是数据库的一个副本，使用该文件不仅可以在MySQL中恢 复数据库，而且通过对该文件的简单修改，可以使用该文件在SQL Server或者Sybase等其他数 据库中恢复数据库。这在某种程度上实现了数据库之间的迁移。

34. 如何选择备份工具？

直接复制数据文件是最为直接、快速的备份方法，但缺点是基本上不能实现增量备份。备 份时必须确保没有使用这些表。如果在复制一个表的同时服务器正在修改它，则复制无效。备份 文件时，最好关闭服务器，然后重新启动服务器。为了保证数据的一致性，需要在备份文件前， 执行以下SQL语句：

CREATE PROCEDURE useInfo(IN u_name VARCHAR(50) character set gbk, OUT u_age INT)
目录下即可。mysqlhotcopy 是一个 PERL 程序，它使用 LOCK TABLES、FLUSH TABLES 和 cp 或 scp来快速备份数据库。它是备份数据库或单个表的最快的途径，但它只能运行在数据库文件所在的 机器上，并且mysqlhotcopy只能用于备份MyISAM表。

mysqlhotcopy适合于小型数据库的备份， 数据量不大，可以使用mysqlhotcopy程序每天进行一次完全备份。mysqldump将数据表导成SQL脚本文件，在不同的MySQL版本之间升级时相对比较合适， 这也是最常用的备份方法。mysqldump比直接复制要慢些。也就是把内存中的数据都刷新到磁盘中，同时锁定数据表，以保证复制过程中不会有新的 数据写入。这种方法备份出来的数据恢复也很简单，直接复制回原来的数据库

35. 平时应该打开哪些日志？

日志既会影响MySQL的性能，又会占用大量磁盘空间。因此，如果不必要，应尽可能少地 开启日志。根据不同的使用环境，可以考虑开启不同的日志。例如，在开发环境中优化查询效率 低的语句，可以开启慢查询日志；如果需要记录用户的所有查询操作，可以开启通用查询日志； 如果需要记录数据的变更，可以开启二进制日志；错误日志是默认开启的。

36. 如何使用二进制日志？

二进制日志主要用来记录数据变更。如果需要记录数据库的变化，可以开启二进制日志。 基于二进制日志的特性，不仅可以用来进行数据恢复，还可用于数据复制。

在数据库定期备份的情况下，如果出现数据丢失，可以先用备份恢复大部分数据，然后使用二进制日志恢复最近备份 后变更的数据。在双机热备情况下，可以使用MySQL的二进制日志记录数据的变更，然后将变 更部分复制到备份服务器上。

37. 如何使用慢查询日志？

慢查询日志主要用来记录查询时间较长的日志。在开发环境下，可以开启慢查询日志来记 录查询时间较长的查询语句，然后对这些语句进行优化。通过配long_query_time的值，可以灵活地掌握不同程度的慢查询语句。

38. 是不是索引建立得越多越好？

合理的索引可以提高查询的速度，但不是索引越多越好。在执行插入语句的时候，MySQL 要为新插入的记录建立索引。所以过多的索引会导致插入操作变慢。原则上是只有查询用的字段 才建立索引。

39. 字符串类型

SET

BLOB

ENUM

CHAR

TEXT

VARCHAR

40. InnoDB是什么？

lnnoDB是一个由Oracle公司开发的Innobase Oy事务安全存储引擎。

41. Mysql表中允许有多少个TRIGGERS？

在Mysql表中允许有六个触发器，如下：

BEFORE INSERT

AFTER INSERT

BEFORE UPDATE

AFTER UPDATE

BEFORE DELETE

AFTER DELETE

49. 什么是非标准字符串类型？

以下是非标准字符串类型：

TINYTEXT

TEXT

MEDIUMTEXT

LONGTEXT

50. 什么是通用SQL函数？

CONCAT(A, B) - 连接两个字符串值以创建单个字符串输出。通常用于将两个或多个字段合并为一个字段。

FORMAT(X, D)- 格式化数字X到D有效数字。

CURRDATE(), CURRTIME()- 返回当前日期或时间。

NOW（） - 将当前日期和时间作为一个值返回。

MONTH（），DAY（），YEAR（），WEEK（），WEEKDAY（） - 从日期值中提取给定数据。

HOUR（），MINUTE（），SECOND（） - 从时间值中提取给定数据。

DATEDIFF（A，B） - 确定两个日期之间的差异，通常用于计算年龄

SUBTIMES（A，B） - 确定两次之间的差异。

FROMDAYS（INT） - 将整数天数转换为日期值。


1、一张表，里面有ID自增主键，当insert了17条记录之后，删除了第15,16,17条记录，再把Mysql重启，再insert一条记录，这条记录的ID是18还是15 ？

如果表的类型为MyISAM 那么是18，因为MyISAM表会把自增键最大ID记录放在数据文件中，重启MySQL自增主键的最大ID也不会丢失

如果表的类型是InnoDB，那就是15，InnoDB只会有自增主键最大ID记录在内存中，重启数据库或者对表进行optimize操作，都会导致最大ID丢失

2、Mysql的技术特点是什么？

Mysql数据库软件是一个客户端或服务器系统，其中包括：支持各种客户端程序和库的多线程SQL服务器、不同的后端、广泛的应用程序编程接口和管理工具。

3、Heap表是什么？

HEAP表存在于内存中，用于临时高速存储。

BLOB或TEXT字段是不允许的

只能使用比较运算符=，<，>，=>，= <

HEAP表不支持AUTO_INCREMENT

索引不可为NULL

4、Mysql服务器默认端口是什么？

Mysql服务器的默认端口是3306。

5、与Oracle相比，Mysql有什么优势？

Mysql是开源软件，随时可用，无需付费。

Mysql是便携式的

带有命令提示符的GUI。

使用Mysql查询浏览器支持管理

6、如何区分FLOAT和DOUBLE？

以下是FLOAT和DOUBLE的区别：

浮点数以8位精度存储在FLOAT中，并且有四个字节。

浮点数存储在DOUBLE中，精度为18位，有八个字节。

7、区分CHAR_LENGTH和LENGTH？

CHAR_LENGTH是字符数，而LENGTH是字节数。Latin字符的这两个数据是相同的，但是对于Unicode和其他编码，它们是不同的。

8、请简洁描述Mysql中InnoDB支持的四种事务隔离级别名称，以及逐级之间的区别？

SQL标准定义的四个隔离级别为：

read uncommited ：读到未提交数据

read committed：脏读，不可重复读

dirty read： 一个事物可以读取另一个尚未提交事务所的修改数据

repeatable read：可重读

serializable ：串行事物


9、在Mysql中ENUM的用法是什么？

ENUM是一个字符串对象，用于指定一组预定义的值，并可在创建表时使用。

Create table size(name ENUM('Smail,'Medium','Large');

10、如何定义REGEXP？

REGEXP是模式匹配，其中匹配模式在搜索值的任何位置。

11、CHAR和VARCHAR的区别？

以下是CHAR和VARCHAR的区别：

CHAR和VARCHAR类型在存储和检索方面有所不同

CHAR列长度固定为创建表时声明的长度，长度值范围是1到255

当CHAR值被存储时，它们被用空格填充到特定长度，检索CHAR值时需删除尾随空格。

12、列的字符串类型可以是什么？

字符串类型是：

SET

BLOB

ENUM

CHAR

TEXT

VARCHAR

13、如何获取当前的Mysql版本？

SELECT VERSION();用于获取当前Mysql的版本。

14、Mysql中使用什么存储引擎？

存储引擎称为表类型，数据使用各种技术存储在文件中。

技术涉及：

Storage mechanism

Locking levels

Indexing

Capabilities and functions.

15、Mysql驱动程序是什么？

以下是Mysql中可用的驱动程序：

PHP驱动程序

JDBC驱动程序

ODBC驱动程序

CWRAPPER

PYTHON驱动程序

PERL驱动程序

RUBY驱动程序

CAP11PHP驱动程序

Ado.net5.mxj

16、TIMESTAMP在UPDATE CURRENT_TIMESTAMP数据类型上做什么？

创建表时TIMESTAMP列用Zero更新。只要表中的其他字段发生更改，UPDATE CURRENT_TIMESTAMP修饰符就将时间戳字段更新为当前时间。

17、主键和候选键有什么区别？

表格的每一行都由主键唯一标识,一个表只有一个主键。

主键也是候选键。按照惯例，候选键可以被指定为主键，并且可以用于任何外键引用。

18、如何使用Unix shell登录Mysql？

我们可以通过以下命令登录：

# [mysql dir]/bin/mysql -h hostname -u <UserName> -p <password>

19、 myisamchk是用来做什么的？

它用来压缩MyISAM表，这减少了磁盘或内存使用。

20、MYSQL数据库服务器性能分析的方法命令有哪些?

21、如何控制HEAP表的最大尺寸？

Heal表的大小可通过称为max_heap_table_size的Mysql配置变量来控制。

22、MyISAM Static和MyISAM Dynamic有什么区别？

在MyISAM Static上的所有字段有固定宽度。动态MyISAM表将具有像TEXT，BLOB等字段，以适应不同长度的数据类型。点击这里有一套最全阿里面试题总结。

MyISAM Static在受损情况下更容易恢复。

23、federated表是什么？

federated表，允许访问位于其他服务器数据库上的表。

24、如果一个表有一列定义为TIMESTAMP，将发生什么？

每当行被更改时，时间戳字段将获取当前时间戳。

25、列设置为AUTO INCREMENT时，如果在表中达到最大值，会发生什么情况？

它会停止递增，任何进一步的插入都将产生错误，因为密钥已被使用。

26、怎样才能找出最后一次插入时分配了哪个自动增量？

LAST_INSERT_ID将返回由Auto_increment分配的最后一个值，并且不需要指定表名称。

27、你怎么看到为表格定义的所有索引？

索引是通过以下方式为表格定义的：

SHOW INDEX FROM <tablename>;

28.、LIKE声明中的％和_是什么意思？

％对应于0个或更多字符，_只是LIKE语句中的一个字符。

29、如何在Unix和Mysql时间戳之间进行转换？

UNIX_TIMESTAMP是从Mysql时间戳转换为Unix时间戳的命令

FROM_UNIXTIME是从Unix时间戳转换为Mysql时间戳的命令

30、列对比运算符是什么？

在SELECT语句的列比较中使用=，<>，<=，<，> =，>，<<，>>，<=>，AND，OR或LIKE运算符。

31、我们如何得到受查询影响的行数？

行数可以通过以下代码获得：

SELECT COUNT(user_id)FROM users;

32、Mysql查询是否区分大小写？

不区分

SELECT VERSION(), CURRENT_DATE;

SeLect version(), current_date;

seleCt vErSiOn(), current_DATE;

所有这些例子都是一样的，Mysql不区分大小写。

33.、LIKE和REGEXP操作有什么区别？

LIKE和REGEXP运算符用于表示^和％。

SELECT * FROM employee WHERE emp_name REGEXP "^b";

SELECT * FROM employee WHERE emp_name LIKE "%b";

34.、BLOB和TEXT有什么区别？

BLOB是一个二进制对象，可以容纳可变数量的数据。有四种类型的BLOB -

TINYBLOB

BLOB

MEDIUMBLOB和

LONGBLOB

它们只能在所能容纳价值的最大长度上有所不同。

TEXT是一个不区分大小写的BLOB。四种TEXT类型

TINYTEXT

TEXT

MEDIUMTEXT和

LONGTEXT

它们对应于四种BLOB类型，并具有相同的最大长度和存储要求。

BLOB和TEXT类型之间的唯一区别在于对BLOB值进行排序和比较时区分大小写，对TEXT值不区分大小写。

35、mysql_fetch_array和mysql_fetch_object的区别是什么？

以下是mysql_fetch_array和mysql_fetch_object的区别：

mysql_fetch_array（） - 将结果行作为关联数组或来自数据库的常规数组返回。

mysql_fetch_object - 从数据库返回结果行作为对象。

36、我们如何在mysql中运行批处理模式？

以下命令用于在批处理模式下运行：

mysql;

mysql mysql.out

37、MyISAM表格将在哪里存储，并且还提供其存储格式？

每个MyISAM表格以三种格式存储在磁盘上：

·“.frm”文件存储表定义

·数据文件具有“.MYD”（MYData）扩展名

索引文件具有“.MYI”（MYIndex）扩展名

38.、Mysql中有哪些不同的表格？

共有5种类型的表格：

MyISAM

Heap

Merge

INNODB

ISAM

MyISAM是Mysql的默认存储引擎。

39、ISAM是什么？

ISAM简称为索引顺序访问方法。它是由IBM开发的，用于在磁带等辅助存储系统上存储和检索数据。

40、InnoDB是什么？

lnnoDB是一个由Oracle公司开发的Innobase Oy事务安全存储引擎。

41、Mysql如何优化DISTINCT？

DISTINCT在所有列上转换为GROUP BY，并与ORDER BY子句结合使用。


SELECT DISTINCT t1.a FROM t1,t2 where t1.a=t2.a;

42、如何输入字符为十六进制数字？

如果想输入字符为十六进制数字，可以输入带有单引号的十六进制数字和前缀（X），或者只用（Ox）前缀输入十六进制数字。

如果表达式上下文是字符串，则十六进制数字串将自动转换为字符串。

43、如何显示前50行？

在Mysql中，使用以下代码查询显示前50行：

SELECT*FROM

LIMIT 0,50;

44、可以使用多少列创建索引？

任何标准表最多可以创建16个索引列。

45、NOW（）和CURRENT_DATE（）有什么区别？

NOW（）命令用于显示当前年份，月份，日期，小时，分钟和秒。

CURRENT_DATE（）仅显示当前年份，月份和日期。

46、什么样的对象可以使用CREATE语句创建？

以下对象是使用CREATE语句创建的：

DATABASE

EVENT

FUNCTION

INDEX

PROCEDURE

TABLE

TRIGGER

USER

VIEW

47、Mysql表中允许有多少个TRIGGERS？

在Mysql表中允许有六个触发器，如下：

BEFORE INSERT

AFTER INSERT

BEFORE UPDATE

AFTER UPDATE

BEFORE DELETE

AFTER DELETE

48、什么是非标准字符串类型？

以下是非标准字符串类型：

TINYTEXT

TEXT

MEDIUMTEXT

LONGTEXT

49、什么是通用SQL函数？

CONCAT(A, B) - 连接两个字符串值以创建单个字符串输出。通常用于将两个或多个字段合并为一个字段

FORMAT(X, D)- 格式化数字X到D有效数字。

CURRDATE(), CURRTIME()- 返回当前日期或时间。

NOW（） - 将当前日期和时间作为一个值返回。

MONTH（），DAY（），YEAR（），WEEK（），WEEKDAY（） - 从日期值中提取给定数据。

HOUR（），MINUTE（），SECOND（） - 从时间值中提取给定数据。

DATEDIFF（A，B） - 确定两个日期之间的差异，通常用于计算年龄

SUBTIMES（A，B） - 确定两次之间的差异。

FROMDAYS（INT） - 将整数天数转换为日期值。

50、解释访问控制列表

ACL（访问控制列表）是与对象关联的权限列表。这个列表是Mysql服务器安全模型的基础，它有助于排除用户无法连接的问题。

Mysql将ACL（也称为授权表）缓存在内存中。当用户尝试认证或运行命令时，Mysql会按照预定的顺序检查ACL的认证信息和权限。

51、MYSQL支持事务吗？

在缺省模式下，MYSQL是autocommit模式的，所有的数据库更新操作都会即时提交，所以在缺省情况下，mysql是不支持事务的。

但是如果你的MYSQL表类型是使用InnoDB Tables 或 BDB tables的话，你的MYSQL就可以使用事务处理,使用SET AUTOCOMMIT=0就可以使MYSQL允许在非autocommit模式，在非autocommit模式下，你必须使用COMMIT来提交你的更改，或者用ROLLBACK来回滚你的更改。

示例如下：

START TRANSACTION;

SELECT @A:=SUM(salary) FROM table1 WHERE type=1;

UPDATE table2 SET summmary=@A WHERE type=1;

COMMIT;

52、 mysql里记录货币用什么字段类型好

NUMERIC和DECIMAL类型被Mysql实现为同样的类型，这在SQL92标准允许。他们被用于保存值，该值的准确精度是极其重要的值，例如与金钱有关的数据。当声明一个类是这些类型之一时，精度和规模的能被(并且通常是)指定；点击这里有一套最全阿里面试题总结。

例如：

salary DECIMAL(9,2)

在这个例子中，9(precision)代表将被用于存储值的总的小数位数，而2(scale)代表将被用于存储小数点后的位数。

因此，在这种情况下，能被存储在salary列中的值的范围是从-9999999.99到9999999.99。在ANSI/ISO SQL92中，句法DECIMAL(p)等价于DECIMAL(p,0)。

同样，句法DECIMAL等价于DECIMAL(p,0)，这里实现被允许决定值p。Mysql当前不支持DECIMAL/NUMERIC数据类型的这些变种形式的任一种。

这一般说来不是一个严重的问题，因为这些类型的主要益处得自于明显地控制精度和规模的能力。

DECIMAL和NUMERIC值作为字符串存储，而不是作为二进制浮点数，以便保存那些值的小数精度。

一个字符用于值的每一位、小数点(如果scale>0)和“-”符号(对于负值)。如果scale是0，DECIMAL和NUMERIC值不包含小数点或小数部分。

DECIMAL和NUMERIC值得最大的范围与DOUBLE一样，但是对于一个给定的DECIMAL或NUMERIC列，实际的范围可由制由给定列的precision或scale限制。

当这样的列赋给了小数点后面的位超过指定scale所允许的位的值，该值根据scale四舍五入。

当一个DECIMAL或NUMERIC列被赋给了其大小超过指定(或缺省的）precision和scale隐含的范围的值，Mysql存储表示那个范围的相应的端点值。

我希望本文可以帮助你提升技术水平。那些，感觉学的好难，甚至会令你沮丧的人，别担心，我认为，如果你愿意试一试本文介绍的几点，会向前迈进，克服这种感觉。这些要点也许对你不适用，但你会明确一个重要的道理：接受自己觉得受困这个事实是摆脱这个困境的第一步。

53、MYSQL数据表在什么情况下容易损坏？

服务器突然断电导致数据文件损坏。

强制关机，没有先关闭mysql 服务等。

54、mysql有关权限的表都有哪几个？
Mysql服务器通过权限表来控制用户对数据库的访问，权限表存放在mysql数据库里，由mysql_install_db脚本初始化。这些权限表分别user，db，table_priv，columns_priv和host。

55、Mysql中有哪几种锁？

MyISAM支持表锁，InnoDB支持表锁和行锁，默认为行锁

表级锁：开销小，加锁快，不会出现死锁。锁定粒度大，发生锁冲突的概率最高，并发量最低

行级锁：开销大，加锁慢，会出现死锁。锁力度小，发生锁冲突的概率小，并发度最高