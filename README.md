# mysql-learning-notes

# MySQL学习笔记

## 📌 项目说明
这是我的MySQL学习记录，包含每节课的SQL练习作业。

## 📁 文件结构
- 按周/主题分类保存SQL文件
- 每个文件包含特定练习的SQL语句

## 🎯 学习目标
1. 掌握基础SQL语法
2. 理解数据库设计原理
3. 熟练使用DBeaver工具

## 2026 -4-2
今天完成了单表搜索和多表搜索的训练
- 不建议使用\作为通配符 
- 单词的大小写并不重要，不过写好一点容易看‘
- 注意select语句最后没有逗号

## 2026-4-9
- 带有any 或者 all 的父子查询
- 记得要写出==父查询块中的条件==
```sql
select Sname , Sbirthdate

from `mysql-study`.student

where Sbirthdate >all(

select Sbirthdate

from `mysql-study`.student

where Smajor = '计算机科学与技术')

and Smajor<>'计算机科学与技术'
```
- 带有exists的查询
- 若==*where子句返回值为真==*则去外层查询中该元祖的结果表
- where中的select后面直接写==‘星号’==就好 因为是为了返回真假
```sql
select Sname

from `mysql-study`.student

where exists (

select * from `mysql-study`.sc

where Sno = Student.Sno and Cno = '81001');
```

## 2026-4-19

- 年龄的表示方式
	- EXTRACT(year from current_date)-EXTRACT(year from Sbirthdate) as Sage
- 使用exists时==括号内的限制条件是对s2的不能搞错==

	查询其他系中某一学生比计算机科学年龄小的学生
```sql
select Sname,
EXTRACT(year from current_date)-
EXTRACT(year from Sbirthdate) as Sage

from student s1

where exists(select *

			from student s2

			where s2.Sbirthdate > s1.Sbirthdate and

			s2.Smajor ='计算机科学与技术')//这里注意是s2

	and Smajor <> '计算机科学与技术';
```

### - ==双重否定not exists==
	**“查询选修了全部课程的学生姓名”**，核心思路是用 `NOT EXISTS`+ **双重否定（逻辑上的“不存在没选修的课程”**
```sql
	select Sname

	from student

	where not exists(select* from Course

					where not exists(select *

									from sc

									where Cno = course.Cno

									and Sno =student.Sno)

					);
	```

```
	用自然语言翻译逻辑：
- 学生 `S`选修了全部课程 ⇨ 不存在任何一门课程，是学生 `S`没选的。SQL 通过两次 `NOT EXISTS`实现这个逻辑：
	1. 内层 `NOT EXISTS`：判断“学生是否选了某门课”（选了则排除，没选则保留）。
    
	2. 外层 `NOT EXISTS`：判断“是否存在没选的课程”（不存在则保留，存在则排除）。


查询选修2018002选修的全部课程的学生
意思是不存在==课程Y 学生x选修了y但是002没有选修y==
```sql
select Sno from student

where not exists (select * from sc x

where x.Sno ='2018002' and not exists(

select * from sc y

where y.Sno = student.Sno and

y.Cno =x.Cno )

);
```
### - 集合操作
	- union并集
	- intersect 交集
	- except差
### -基于派生表的查询
```mysql
select Sno , Cno

from sc ,(select Sno,AVG(Grade) from sc group by Sno)

		as avg_sc(Avg_sno,Avg_grade)

where sc.Sno = avg_sc.avg_sno and sc.Grade >= avg_sc.avg_grade ;
```

## 4-22
### 数据更新
- 插入元组
	- insert into <表名> （属性）
	 values()
	- into指出表名 指出哪些属性要赋值，属性的**顺序可以与table中的不一样**
		value子句要按照into子句指定的次序赋值
	- into后面**没有指出属性**
		values要在表的**所有属性列**上都指定值
		属性列的次序与table中的次序相同
	- **没有值的列，DBMS会自动赋空值**
- 插入子查询结果
	- insert into <表名>(属性)
	```sql
	-- create table Smajor_age(Smajor varchar(20),Avg_age smallint);

	insert into smajor_age(Smajor,Avg_age )

	select Smajor,AVG(extract(year from current_date)-
	extract(year from Sbirthdate))

	from student

	group by smajor;
	```
- 修改数据
	update<表名>
	set<列名> = <表达式> 
	where <条件>
- 删除数据
	delete from <表名>
	where <条件>
### 空值的处理
- 插入数据时 一些属性列可设置为null
- 修改时set后面可以把一些内容设置为null
- **无法设置为空**时需要修改表格设定
	==ALTER TABLE student MODIFY Smajor 数据类型 NULL;==
	
- 空值的判断 用is null 或者 is not null 表示属性是否为空
		主码不允许为空值，不许漏填 
		属性定义为not null也不允许为空值
- 
```sql	
select * from student
where Sname is null or Ssex is null		
or Sbirthdate is null or Smajor is null ;
```

- **空值的运算**
	- ![[Pasted image 20260422122010.png|614]]![[Pasted image 20260422122034.png|392]]
	- and 都是T结果才是T，既有T又有U 结果是U ，只要有F结果就是F
	- or   都是F结果才是F，既有F又有U 结果是U ，只要有T结果就是

### 视图
- 建立视图
	create view <视图名>（列名）
	as<子查询>
	【with check option】表示进行更新 插入 删除需要满足子查询表达式
	==尽可能不要省略列名，避免出错==
```sql
-- 建立信息管理与信息系统专业学生视图
create view is_student(Isno,Isname,Isex,Ibirthdate,Imajor)
as select Sno , Sname,ssex,sbirthdate,smajor
from student
where Smajor = '信息管理与信息系统'
with check option;/*保证数据更新时只有信息管理与信息系统专业的学生*/
```
- 视图也可以建立在一个或者多个已定义好的视图上
- 删除视图
	drop view <视图名> CASCADE
		**CASCADE表示删除有该视图导出的其他视图**
- 查询视图
	与查询基本表相同![[Pasted image 20260423211848.png]]
- 更新视图
	- 视图的更新操作通过视图消解转换为对==基本表的更新==操作
	- ==加上with check option==防止用户无意中对
		==不属于视图范围==的基本表进行操作
## 4-24 第三章练习题
- 建表时
	- ==默认值==写法是 Ssex CHAR(1) default '男'
	- ==限制值==的范围写法Sage INT check ( Sage between 15 and 45)
	- 最后保证中文可以使用==ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;==
- 通配符写法where Cname like 'MIS￥_%系_' escape '￥';
	- %指代多个字符  _指代单个字符![[Pasted image 20260424154012.png]]
- 聚集函数![[Pasted image 20260424154438.png]]
- order by 子句可以用于排序 asc升序 desc降序
- int类型一般比较时不需要带引号
- 基于派生表的查询 在from的括号里面再写一次select语句创立一个派生表，==必须起别名==
```sql
-- （14） 查询各不同平均成绩所对应的学生人数（给出平均成绩与其对应的人数）。

select avg_grade , count(*)

from (select sno ,avg(grade) as avg_grade

	from sc

	group by sno ) t

group by avg_grade ;

```