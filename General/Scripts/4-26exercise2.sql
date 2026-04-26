create table S(-- 供应商
	Sno varchar(20),
	Sname varchar(50),
	Status int,
	City varchar(50),
	primary key (Sno,Sname)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create table P(-- 零件
	PNO VARCHAR(20),
	PNAME VARCHAR(50),
	COLOR VARCHAR(20),
	WEIGHT INT,
	primary key (PNO,PNAME)
	)ENGINe=InnoDB default CHARSET=utf8mb4;

create table J( -- 工程
	JNO VARCHAR(20),
	JNAME VARCHAR(50),
	City varchar(50),
	primary key (JNO,JNAME)
	)ENGINe=InnoDB default CHARSET=utf8mb4;

create table SPJ(
	SNO VARCHAR(20),
	PNO VARCHAR(20),
	JNO VARCHAR(20),
	QTY INT,
	primary key (SNO,PNO,JNO),-- 供应数量
	FOREIGN KEY (SNO) REFERENCES S(SNO),
    FOREIGN KEY (PNO) REFERENCES P(PNO),
    FOREIGN KEY (JNO) REFERENCES J(JNO)
	)ENGINe=InnoDB default CHARSET=utf8mb4;

INSERT INTO P VALUES
('P1', '螺母', '红', 12.0),
('P2', '螺栓', '绿', 17.0),
('P3', '螺丝刀', '蓝', 14.0),
('P4', '螺丝刀', '红', 14.0),
('P5', '凸轮', '蓝', 40.0),
('P6', '齿轮', '红', 30.0);

INSERT INTO S VALUES
('S1', '精益', 20, '天津'),
('S2', '盛锡', 10, '北京'),
('S3', '东方红', 30, '上海'),
('S4', '丰泰', 20, '天津'),
('S5', '为民', 30, '上海');

INSERT INTO J VALUES
('J1', '三建', '北京'),
('J2', '一汽', '长春'),
('J3', '弹簧厂', '天津'),
('J4', '造船厂', '上海'),
('J5', '机车厂', '唐山'),
('J6', '无线电厂', '常州'),
('J7', '半导体厂', '南京');
TRUNCATE TABLE SPJ;

INSERT INTO SPJ VALUES
('S1','P1','J1',200),
('S1','P1','J3',100),
('S2','P3','J1',400),
('S2','P3','J2',200),
('S2','P3','J4',500),
('S2','P5','J1',400),
('S3','P1','J1',200),
('S3','P3','J1',200),
('S4','P5','J1',100),
('S4','P6','J3',300),
('S5','P2','J4',100),
('S5','P3','J1',200),
('S5','P6','J2',200),
('S5','P6','J4',500);


-- ① 求供应工程 J1 零件的供应商代码 SNO
select SNO from SPJ
where JNO ='J1';

-- ② 求供应工程 J1 零件 P1 的供应商代码 SNO
select distinct SNO from spj 
where JNO ='J1' and PNO ='P1';

--  ③ 求供应工程 J1 零件为红色的供应商代码 SNO
select distinct sno from spj 
where JNO = 'J1'and PNO IN(
		select PNO 
		from P
		where COLOR = '红');

-- ④ 求没有使用天津供应商生产的红色零件的工程号 JNO
select distinct JNO 
FROM SPJ
where not exists(
	select *
	from s,p 
	where s.Sno =spj.SNO 
	and  p.pno = spj .PNO 
	and City  = '天津'
	and p.COLOR ='红');

-- 查询所有供应商的姓名和所在城市
select Sname,CITY from s ;

-- 查询所有零件的名称、颜色、重量
select  pname , color ,weight
from p ;

-- 找出使用供应商S1所供应零件的工程代码
select Jno from spj 
where SNO ='S1';

-- 找出工程项目J2使用的各种零件的名称及其数量
select Pname,QTY 
from p,spj
where p.PNO =spj.PNO and JNO ='J2';

-- 找出上海厂商供应的所有零件代码
select distinct  Pno 
from spj 
where sno in (
	select SNO 
	from s 
	where city = '上海');

-- 找出使用上海产的零件的工程名称
select Jname 
from J
where Jno in (
	select Jno 
	from spj 
	where PNO  in (
		select pno 
		from p 
		where city = '上海')
	);

-- 找出没有使用天津产的零件的工程代码
select distinct Jno 
from spj 
where not exists(
	select *
	from s
	where s.Sno =spj.SNO and City ='天津');

-- 把全部红色零件的颜色改成蓝色
 UPDATE P
SET COLOR = '蓝'
WHERE COLOR = '红';

-- 把由S5供给J2的零件P6改为由S3供应
update spj
set SNO='S3'
where SNO ='S5'and JNO ='J2'and Pno='P6';

-- 删除供应商S2及其相关供应记录
delete from spj 
where SNO = 'S2';
delete from s
where SNO = 'S2'; 

-- 插入一条新的供应记录
insert into spj (sno,pno,JNO ,qty)
values('S3','p4','J5',1234);

-- 建立视图
create view I(Isno,Ipno,Iqty)
as select SPJ.Sno , spj.Pno,spj.qty
from spj ,j 
where spj.jno = j.jno and j.jname='三建';

-- 找出三建工程使用的各种零件代码及其数量
select Ipno,sum(Iqty)
from  I
group by pno ;

-- 找出供应商S1供应三建工程的情况
select Isno,Ipno,Iqty
from  I
where Isno= 'S1' ;





























