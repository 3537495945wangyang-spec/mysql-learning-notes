-- （1） 建立上述3张表。
create table student(
	 Sno        VARCHAR(20)    ,
    Sname      VARCHAR(50)    ,
    Ssex       CHAR(1)       default '男',
    Sage  		INT      check ( Sage between 15 and 45)    ,
    Sdept     VARCHAR(100)   ,
    PRIMARY KEY (Sno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create table course(
	Cno varchar(20),
	Cname varchar(100),
	Cpno varchar(20),	Ccredit int  ,
	primary key(cno)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create table sc(
	sno varchar(20),
	Cno varchar(20),
	grade int check(grade between 0 and 100) default null,
	primary key(sno,cno)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2） 查询以“MIS_”开头，且倒数第二个汉字为“系”字的课程的详细情况。
select * from course 
where Cname like 'MIS$_%系_' escape '$';

-- （3） 查询选修了课程的学生人数。
select count(distinct Sno)
from sc;

-- （4） 查询性别为男，课程成绩及格的学生信息及课程号、成绩。
select  student.Sno, Sname ,Ssex,Sage,Sdept,sc.Cno  ,grade
from student,course ,sc 
where student.sno =sc.sno  and sc.Cno = course.Cno and
Ssex = '男'and grade >=60;

-- （5） 查询与“钱恒”在同一个系学习的学生。
select * from student
where Sdept in(
	select Sdept from student 
	where Sname='钱恒');

-- （6） 查询选修了课程名为“信息系统工程”的学生学号、姓名和所在系。
select Sno,Sname,Sdept 
from student 
where Sno in (
	select  Sno
	from sc
	where Cno in (
		select cno 
		from course 
		where cname='信息系统工程')
	);
-- （7） 查询其他系中比CS系所有学生年龄均大的学生名单，并按年龄降序输出。
select Sno
from student s1
where not exists(
	select*
	from student s2
	where Sdept <> 'CS'and not exists(
		select *
		from student s3
		where s3.Sno =s1.Sno and s3.Sage < s2.Sage )
	)
	order by s1.Sage desc;
-- （8） 查询所有未修1号课程的学生姓名。
select Sname 
from student	
	where not exists(
	select *
	from sc 
	where sc.Cno = 1 and sc.sno =student.Sno );

-- （9） 查询选修了“数据结构”课程的学生的学号、姓名。
select Sno,Sname
from student 
where sno in(
	select Sno from sc 
	where cno in(
		select cno from course 
		where cname = '数据结构')
		);
-- （10） 查询选修了课程1或者选修了课程2的学生。
select sno from sc
where cno=1 or cno = 2;

-- （11） 查询计算机科学系的且年龄不大于19岁的学生名单。
select sname from student 
where Sage <=19 and Sdept ='计算机科学系';

-- （12） 查询选修了课程1，但没有选修课程2的学生姓名。
select sname from student 
where sno in (
	select sno from sc
	where Cno =1
	)and not exists(
	select* from sc 
	where Cno =2);

-- （13） 查询平均成绩大于85分的学生的学号、姓名和平均成绩。
select student.Sname ,student.Sno,avg(grade) as avg_grade
from student ,sc
where student.Sno =sc.sno 
group by student.Sno ,student.Sname 
having avg(sc.grade)>=85; 

-- （14） 查询各不同平均成绩所对应的学生人数（给出平均成绩与其对应的人数）。
select avg_grade , count(*)
from (select sno ,avg(grade) as avg_grade
			from sc 
			group by sno ) t
group by avg_grade ;

-- （15） 查出课程成绩在90分以上的女学生的姓名、课程名和成绩。
select student.Sname , course.cname ,  grade
from student ,sc , course 
where student.Sno =sc.sno and course.cno = sc.Cno and 
	ssex = '女'  and grade > 90;

-- （16） 查询被所有学生选修的课程名称。
select cname
from course c
where not exists (
    select *
    from student s
    where not exists (
        select *
        from sc
        where sc.cno = c.cno
          and sc.sno = s.sno
    )
);

-- （17） 查询所有课程考试成绩都大于90分的学生姓名。
select sname 
from student s
where not exists (
	select *
	from sc 
	where grade < 90
	and sc.sno = s.sno);

-- （18） 查询选修了所有课程并且成绩都大于90分的学生姓名。
select Sname
from student s
where not exists(
	select*
	from course c 
	where not exists(
		select *
		from sc 
		where sc.cno = c.cno
          and sc.sno = s.sno)
          );
intersect
select sname 
from student s
where not exists (
	select *
	from sc 
	where grade < 90
	and sc.sno = s.sno);




























