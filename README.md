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
