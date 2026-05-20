-- （1）定义院系表，其中编号为主关键字，名称应该唯一、并且不允许为空值。
create table department (
  	Dno varchar(4) not null,
  	Dname varchar(50) not null ,
  	primary key (Dno)
  );
alter table department 
change Dname 名称 varchar(50) not null;
-- （2）定义学生表，其中规定：
-- 	学号列是主关键字； 
-- 	院系列为计算列（取学号列的第3和第4个字符），并且院系值参照院系表的编号值
-- （院系表是被参照表，主关键字是编号；参照表是学生表，外部关键字是院系），此约束说明一名学生一定属于某个院系； 
-- 	姓名列不允许为空值； 
-- 	性别必须取值“男”或“女”； 
-- 	学生的学籍状态为正常、留级、休学或退学。 

create table Student (
	Sno varchar(10) not null,
    Dno VARCHAR(4) GENERATED ALWAYS AS (SUBSTRING(Sno, 3, 4)) STORED,
	Sname varchar(50) not null,
	Ssex char(1) check (Ssex in ('男','女')),
	Status varchar (2) check (Status in ('正常','留级','休学','退学')),
	primary key (Sno),
	FOREIGN KEY (Dno) REFERENCES Department(Dno)
	);

-- （3）定义教师表，其中规定：
-- 	教师编号是主关键字； 
-- 	院系列为计算列（取教师编号的第1和第2个字符），并且院系值参照院系表的编号值，
-- 此约束说明一名教师一定属于某个院系； 
-- 	姓名列不允许为空值； 
-- 	性别必须取值“男”或“女”； 
-- 	职称的取值为教授、副教授、讲师或助教。 
create table teacher(
	Tno  varchar(20) not null,
    Dno VARCHAR(4) GENERATED ALWAYS AS (SUBSTRING(Tno, 3, 4)) STORED,
	Tname varchar(50) not null,
	Tsex char(1) check (Tsex in ('男','女')),
	Title varchar (4) check (Title in ('教授','副教授','讲师','助教')),
	primary key(Tno),
	foreign key (Dno) references department(Dno)
	);
-- （4）定义课程表，其中规定：
-- 	课程编号是主关键字； 
-- 	课程名称不允许为空值； 
-- 	责任教师参照教师表的教师编号值，此约束说明责任教师一定是已经在编的教师； 
-- 	学时不允许为空值； 
-- 	课程性质分为公共基础、专业基础、专业选修和任意选修。 
create table course(
	Cno varchar(20) not null,
	Cname varchar(50) not null,
	Ctno varchar(20) not null,
	Credit int not null,
	Ctype varchar(4) check (Ctype in ('公共基础','专业基础','专业选修','任意选修')),
	primary key (Cno),
	foreign key(Ctno) references teacher(Tno) 
);
-- 	（5）定义选课表，其中规定：
-- 	学号和课程编号两列构成主关键字（需要表级完整性约束）； 
-- 	学号参照学生表的学号（约束选课的学生必须存在）； 
-- 	课程编号参照课程表的课程编号（约束被选的课程必须存在）； 
-- 	考试成绩取值在0~100之间，并且默认为空值。 
create table cs(
	Sno varchar(10) not null,
	Cno varchar(20) not null,
	grade int check(grade between 0 and 100),
	primary key(Sno,Cno),
	foreign key(Sno) references Student(Sno) ,
	foreign key(Cno) references Course(Cno) 
);

	-- （6）规定学生表的性别字段不允许为空值
	alter table Student
	modify Ssex char(1) not null ;
	-- （7）删除课程表中的责任教师列
	alter table course 
 DROP FOREIGN KEY course_ibfk_1;
	alter table course drop Ctno;
	
-- 	（8）为课程表增加责任教师列，列描述如下：
-- 	字符类型，长度为6；
-- 	允许空值；
alter table course add Ctno char(6); 
alter table department  add 负责人 varchar(4);
alter table department add 办公地点 varchar(20);

	