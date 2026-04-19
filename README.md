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

