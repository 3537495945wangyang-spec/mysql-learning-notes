/*select  Sno , Sname
from Student;*/

/*select  Sname , Sno , Smajor
from student ;*/

/*select *
from student ;*/

/*select Sname, (EXTRACT(year from current_date)-
EXTRACT(year from Sbirthdate))"年龄"
from Student ;*/

/*select Sname, 'Date of Birth:',Sbirthdate,Smajor
from Student; */

/*select Sno
from sc ；*/

/*select all Sno
from sc ；*/

/*select distinct Sno
from sc ；*/

/*
select Sname 
from student 
where Smajor ='计算机科学与技术';
*/

/*select Sname , Ssex
from student 
where EXTRACT( year from Sbirthdate ) >= 2000;*/

/*select distinct Sno 
from sc 
where Grade < 60;*/
/*
select Sname , Sbirthdate , Smajor
from student 
where extract(year from current_date) - EXTRACT(year from Sbirthdate )
between 20 and 23;*/


/*select Sname , Sbirthdate , Smajor
from student 
where extract(year from current_date) - EXTRACT(year from Sbirthdate )
not between 20 and 23;*/

/*select Sname , Ssex 
from student 
where Smajor in ('计算机科学与技术','信息安全');*/

/*select Sname , Ssex 
from student 
where Smajor not in ('计算机科学与技术','信息安全');*/

/*select * from Student
where Sno like '20180003';*/

/*select Sname , Sno, Ssex from student 
where Sname like '刘%';*/

/*select Sname , Sno  from student 
where Sno like '2018%';*/

/*select Sno , Sname , Ssex from Student
where Sname not like '刘%';*/

/*select Sno , Sname  from Student
where Sname  like '_阳%';*/

/*select Sno , Sname  from Student
where Sname not like '王%';*/

/*
select Cno , Credit from Course 
where Cname like 'DB$_Design'escape '$';
*/
/*
select * from course 
where Cname like'DB$_%i__'escape '$';*/

/*select Sno , Cno from sc 
where Grade is  null;*/

/*select * from sc 
where Grade is NOT  null;*/
 
/*
select Sno , Sname , Ssex  from student
where Smajor ='计算机科学与技术' and EXTRACT(year from Sbirthdate)>=2000;
*/

/*select Sno , Sname from student
where Smajor = '计算机科学与技术'or Smajor ='信息安全';*/

/*select Sno , Grade from sc 
where Cno = '81003' order by Grade desc;*/

/*select * from sc
order by Cno , grade desc;*/

/*
select count(*) from student ;
*/

/*
select count(distinct Sno) from SC;
*/

/*
select AVG(Grade) from sc 
where Cno = '81001';
*/

/*
select MAX(Grade) from sc 
where Cno = '81001';
*/

/*select SUM(Credit) from SC , course 
where Sno ='20180003' and SC.Cno = Course.Cno; */

/*
select Cno , Count(Sno)  from SC
group by Cno;
*/
/*
select Sno
from sc 
where Semester = '20191' 
group by Sno
having count(*)>10
*/
/*select Sno , AVG(Grade)
from sc 
group by Sno
having avg(Grade)<=90;*/


/*
select Sno
from sc , course 
where course.Cname='数据库系统概论' 
and course.Cno = sc.Cno  
order by Grade desc
limit 10;
*/


/*
select Sno,AVG(Grade)
from sc
group by Sno 
order by avg(Grade) desc
limit 5 offset 2;
*/

/*
select Student.*,sc.*
from Student,sc 
where Student.Sno = sc.Sno ;
*/

/*
select Student.Sno,Sname,Ssex,Sbirthdate ,Smajor,Cno,grade
from Student,sc 
where Student.Sno = sc.Sno ;
*/

/*select Student.Sno,Sname
from sc , student
where sc.Sno =student.Sno 
and sc.Cno ='81002' and sc.Grade >90;*/

/*
select first.cno,second.cpno
from Course first,Course second
where first.cpno=second.cno and second.cpno is not null;
*/

select Student.Sno,Sname,ssex ,sbirthdate,smajor,cno,grade
from Student left outer join sc on (student.sno=sc.sno);


select student.sno,sname,cname,grade
from student , sc , course 
where student.Sno =sc.Sno and sc.Cno =course.Cno ;

































