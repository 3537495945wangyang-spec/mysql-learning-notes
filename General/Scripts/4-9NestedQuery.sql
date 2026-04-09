USE `mysql-study`;

select Sno,Sname,Smajor
from `mysql-study`.student 
where Smajor in(
	select Smajor 
	from `mysql-study`.student 
	where Sname = '刘晨');

select Sno,Sname
from `mysql-study`.student 
where Sno in(
	select Sno 
	from `mysql-study`.sc
	where Cno in(
		select Cno 
		from `mysql-study`.course 
		where Cname = '信息系统概论'));

select Sno , Cno 
from `mysql-study`.sc  x
where Grade >=(
	select AVG(grade)
	from `mysql-study`.sc y
	where y.Sno =x.Sno );

select Sname , Sbirthdate , Smajor from `mysql-study`.student 
where Sbirthdate > any(
	select Sbirthdate
	from `mysql-study`.student 
	where Smajor = '计算机科学与技术');
	
select Sname,Sbirthdate,Smajor
`mysql-study`.student 
where Sbirthdate >(
	select MIN(Sbirthdate)
	from `mysql-study`.student 
	where Smajor = '计算机科学与技术')
and Smajor<>'计算机科学与技术';

select Sname , Sbirthdate
from `mysql-study`.student 
where Sbirthdate >all(
	select Sbirthdate
	from `mysql-study`.student 
	where Smajor = '计算机科学与技术')
	and Smajor<>'计算机科学与技术'

select Sname 
from `mysql-study`.student ,`mysql-study`.sc 
where Grade > any(
	select Grade
	from `mysql-study`.sc 
	where Cno = '02')
	and Student.Sno = SC.Sno ;

select Sname
from `mysql-study`.student 
where exists (
	select * from `mysql-study`.sc 
	where Sno = Student.Sno and Cno = '81001');


select Sname from `mysql-study`.student 
where not exists
	(select *
	from `mysql-study`.sc 
	where Sno = Student.Sno and Cno = '81001'
	);

select Sname from `mysql-study`.student 
where exists (
		select *
		from `mysql-study`.sc 
		where Sno = Student.Sno 
		and Grade >90);











