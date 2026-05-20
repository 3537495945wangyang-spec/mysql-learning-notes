create table department (
  	编号 varchar(4) not null,
  	名称 varchar(50) not null ,
  	负责人 varchar(4),
  	办公地点 varchar(20),
  	primary key (编号)
  );
create table Student (
	学号 varchar(10) not null,
    院系 VARCHAR(4) GENERATED ALWAYS AS (SUBSTRING(学号, 3, 4)) STORED,
	姓名 varchar(50) not null,
	性别 char(1) check (性别 in ('男','女')),
	状态 varchar (2) check (状态 in ('正常','留级','休学','退学')),
	生源 varchar (2),
	primary key (学号),
	FOREIGN KEY (院系) REFERENCES Department(编号)
	);
create table teacher(
	教师编号  varchar(20) not null,
    院系 VARCHAR(4) GENERATED ALWAYS AS (SUBSTRING(教师编号, 3, 4)) STORED,
	姓名 varchar(50) not null,
	性别 char(1) check (性别 in ('男','女')),
	职称 varchar (4) check (职称 in ('教授','副教授','讲师','助教')),
	专业 varchar(10),
	primary key(教师编号),
	foreign key (院系) references department(编号)
	);
create table course(
	课程编号 varchar(20) not null,
	课程名称 varchar(50) not null,
	责任教师 varchar(20) not null,
	学时 int not null,
	课程性质 varchar(4) check (课程性质 in ('公共基础','专业基础','专业选修','任意选修')),
	primary key (课程编号),
	foreign key(责任教师) references teacher(教师编号)
);
create table cs(
	学号 varchar(10) not null,
	课程编号 varchar(20) not null,
	考试成绩 int check(考试成绩 between 0 and 100),
	primary key(学号,课程编号),
	foreign key(学号) references Student(学号) ,
	foreign key(课程编号) references Course(课程编号) 
);
-- （9）插入院系表的第1个元组(记录)
 insert into department(编号,名称,负责人,办公地点)
 values(01,'信息管理学院','李嘉','教一楼3层');

-- （10）省略列名、插入院系表的第2个元组
 insert into department
 values(02,'经济管理学院','吴鸿忠','教三楼4层');

-- （11）插入学生表的第1个元组
ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;
ALTER TABLE student
MODIFY COLUMN `院系` VARCHAR(2) GENERATED ALWAYS AS (SUBSTRING(`学号`, 3, 2)) stored;
ALTER TABLE student
ADD CONSTRAINT student_ibfk_1
FOREIGN KEY (`院系`) REFERENCES `department`(`编号`);

ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;
ALTER TABLE teacher  DROP FOREIGN KEY teacher_ibfk_1;
alter table department 
modify column  编号 varchar(2) not null;
ALTER TABLE teacher
MODIFY COLUMN `院系` VARCHAR(2) GENERATED ALWAYS AS (SUBSTRING(`教师编号`, 1, 2)) stored;
ALTER TABLE student
ADD CONSTRAINT student_ibfk_1
FOREIGN KEY (`院系`) REFERENCES `department`(`编号`);
ALTER TABLE teacher
ADD constraint teacher_ibfk_1
FOREIGN KEY (`院系`) REFERENCES `department`(`编号`);

update department  set  `编号` = '01' where `名称` ='信息管理学院';
update department  set  `编号` = '02' where `名称` ='经济管理学院';

insert into student (`学号`,`姓名` ,`性别`,`生源` ,`状态`)
values('04014101','曹波','男','湖北','正常');

-- （12） 插入所有表的记录，完成后续的查询。
INSERT INTO department (编号, 名称, 负责人, 办公地点) VALUES 
('03', '计算机学院', '张秋霞', '教二楼3层'),
('11', '通讯工程学院', '王跃红', '教四楼1层');
INSERT INTO teacher (教师编号,  姓名, 性别, 职称, 专业) VALUES 
('010194',  '刘昌勇', '男', '教授', '信息管理'),
('010126',  '顾波', '女', '副教授', '计算机'),
('011122', '张建平', '男', '讲师', '系统工程'),
('020112', '杜子意', '男', '教授', '经济学'),
('020555','黄梅', '女', '讲师', '金融'),
('030609', '李丽', '女', '助教', '软件工程');
INSERT INTO student (学号, 姓名, 性别, 生源, 状态) VALUES 
('04014111', '程鸣', '女', '湖南', '正常'),
('04014122', '吴红霞', '女', '浙江', '正常'),
('04026205', '张鸿飞', '男', '北京', '正常'),
('04026210', '张雪梅', '女', '贵州', '休学'),
('04016108', '林报国', '男', '上海', '正常'),
('04016116', '王丽', '女', '北京', '正常'),
('05113102', '郝海涛', '男', '河南', '正常'),
('05113110', '王伟', '男', '北京', '正常');
alter table course drop foreign key course_ibfk_1;
alter table course modify 责任教师 char(6); 
alter table  course ADD constraint course_ibfk_1
FOREIGN KEY (`责任教师`) REFERENCES  teacher (`教师编号`);

INSERT INTO course (课程编号, 课程名称, 学时, 课程性质, 责任教师) VALUES 
('B00016', '数据库', 56, '专业基础', '010126'),
('B00018', '系统分析与设计', 48, '专业基础', '010194'),
('B00101', '运筹学', 56, '专业基础', '011122'),
('X00201', '信息资源管理', 32, '专业选修', '010194'),
('B00221', '经济学原理', 56, '专业基础', '020112'),
('X00206', '系统开发工具与环境', 48, '专业选修', NULL);

INSERT INTO cs  (学号, 课程编号, 考试成绩) VALUES 
('04014122', 'B00016', 88),
('04014122', 'B00018', 98),
('04014122', 'B00101', 76),
('04014122', 'X00201', 55),
('04014122', 'B00221', 89),
('04014111', 'B00101', 90),
('04014111', 'X00201', NULL),
('04014111', 'B00016', NULL),
('04014101', 'B00018', NULL),
('04014101', 'B00016', 66),
('04016116', 'B00016', 52);

-- （13）删除经济管理学院考试成绩为NULL的学生记录。
delete from student 
where `学号`in(
	select `学号`  from cs 
	where `考试成绩` is null)
and 
	`院系` in(
	select `编号` from department 
	where `名称`='经济管理学院');

-- （14）删除经济管理学院学生考试成绩为NULL的选课记录。
delete from cs 
where `考试成绩`is null and 
	`学号` in(
	select `学号` from student 
	where `院系`in(
	select `编号` from department 
	where `名称`='经济管理学院')
	); 
-- （15）将04014122号学生的B00101课程的考试成绩修改为78分。
update  cs
set `考试成绩` = 78 
where `学号` = '04014122' and `课程编号` = 'B00101';

