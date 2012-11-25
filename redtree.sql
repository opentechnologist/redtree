
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS dvd;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS rental;

DROP TABLE IF EXISTS dailytrans;
DROP TABLE IF EXISTS deductfile;
DROP TABLE IF EXISTS deducttable;
DROP TABLE IF EXISTS deducttrans;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS depttable;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS empstatus;
DROP TABLE IF EXISTS empstatustable;
DROP TABLE IF EXISTS hdmffile;
DROP TABLE IF EXISTS hdmftable;
DROP TABLE IF EXISTS hdmftrans;
DROP TABLE IF EXISTS incomefile;
DROP TABLE IF EXISTS incometable;
DROP TABLE IF EXISTS incometrans;
DROP TABLE IF EXISTS loanfile;
DROP TABLE IF EXISTS loantable;
DROP TABLE IF EXISTS loantrans;
DROP TABLE IF EXISTS otfile;
DROP TABLE IF EXISTS ottable;
DROP TABLE IF EXISTS ottrans;
DROP TABLE IF EXISTS payperiodtable;
DROP TABLE IF EXISTS payrollperiodtable;
DROP TABLE IF EXISTS payrolltrans;
DROP TABLE IF EXISTS phfile;
DROP TABLE IF EXISTS phtable;
DROP TABLE IF EXISTS phtrans;
DROP TABLE IF EXISTS sssfile;
DROP TABLE IF EXISTS ssstable;
DROP TABLE IF EXISTS ssstrans;
DROP TABLE IF EXISTS taxratetable;
DROP TABLE IF EXISTS taxstatustable;
DROP TABLE IF EXISTS taxtable;
DROP TABLE IF EXISTS taxtrans;

DROP TABLE IF EXISTS filestore_file;
DROP TABLE IF EXISTS filestore_image;
DROP TABLE IF EXISTS filestore_type;
DROP TABLE IF EXISTS filestore_volume;

DELIMITER //

DROP FUNCTION IF EXISTS HHMM2HRS; //
CREATE FUNCTION HHMM2HRS(HHMM VARCHAR(5))
RETURNS DECIMAL(8,5)
RETURN HOUR(CONCAT(HHMM,':00'))+(MINUTE(CONCAT(HHMM,':00'))/60); //

DROP FUNCTION IF EXISTS DDHHMM2DAYS; //
CREATE FUNCTION DDHHMM2DAYS(DDHHMM VARCHAR(5))
RETURNS DECIMAL(8,5)
RETURN HOUR(DDHHMM)+(MINUTE(DDHHMM)/24)+(SECOND(DDHHMM)/24/60); //

DROP FUNCTION IF EXISTS HHMM2MINS; //
CREATE FUNCTION HHMM2MINS(HHMM VARCHAR(5))
RETURNS SMALLINT
RETURN (HOUR(CONCAT(HHMM,':00'))*60)+MINUTE(CONCAT(HHMM,':00')); //

DROP FUNCTION IF EXISTS HHMM; //
CREATE FUNCTION HHMM(dt DATETIME)
RETURNS VARCHAR(5)
RETURN DATE_FORMAT(dt,'%H:%i'); //

DROP FUNCTION IF EXISTS MINS; //
DROP FUNCTION IF EXISTS GETMINUTES; //
CREATE FUNCTION GETMINUTES(dt DATETIME)
RETURNS SMALLINT
RETURN (HOUR(RIGHT(dt,8))*60)+MINUTE(RIGHT(dt,8)); //
DROP FUNCTION IF EXISTS SeqNo; //

DROP FUNCTION IF EXISTS reg_id_seq; //
CREATE FUNCTION reg_id_seq()
RETURNS INTEGER
BEGIN
SET @reg := IF(@reg,@reg+1,1);
RETURN @reg;
END; //

DROP FUNCTION IF EXISTS sss_id_seq; //
CREATE FUNCTION sss_id_seq()
RETURNS INTEGER
BEGIN
SET @sss := IF(@sss,@sss+1,1);
RETURN @sss;
END; //

DROP FUNCTION IF EXISTS hdmf_id_seq; //
CREATE FUNCTION hdmf_id_seq()
RETURNS INTEGER
BEGIN
SET @hdmf := IF(@hdmf,@hdmf+1,1);
RETURN @hdmf;
END; //

DROP FUNCTION IF EXISTS ph_id_seq; //
CREATE FUNCTION ph_id_seq()
RETURNS INTEGER
BEGIN
SET @ph := IF(@ph,@ph+1,1);
RETURN @ph;
END; //

DROP FUNCTION IF EXISTS tax_id_seq; //
CREATE FUNCTION tax_id_seq()
RETURNS INTEGER
BEGIN
SET @tax := IF(@tax,@tax+1,1);
RETURN @tax;
END; //

DROP FUNCTION IF EXISTS atm_id_seq; //
CREATE FUNCTION atm_id_seq()
RETURNS INTEGER
BEGIN
SET @atm := IF(@atm,@atm+1,1);
RETURN @atm;
END; //

DROP FUNCTION IF EXISTS otc_id_seq; //
CREATE FUNCTION otc_id_seq()
RETURNS INTEGER
BEGIN
SET @otc := IF(@otc,@otc+1,1);
RETURN @otc;
END; //

DELIMITER ;

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees (
	id INT(11) NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	timerecid DECIMAL(5) NOT NULL DEFAULT 0,
	firstname VARCHAR(40) NOT NULL DEFAULT '',
	middlename VARCHAR(40) NOT NULL DEFAULT '',
	lastname VARCHAR(40) NOT NULL DEFAULT '',
	gender ENUM('Male','Female')DEFAULT NULL,
	maritalstatus ENUM('Single','Married','Divorced','Separated','Annulled')DEFAULT NULL,
	birthdate DATE NOT NULL DEFAULT '0000-00-00',
	position VARCHAR(40) NOT NULL DEFAULT '',
	hiredate DATE NOT NULL DEFAULT '0000-00-00',
	terminatedate DATE NOT NULL DEFAULT '0000-00-00',
	retireddate DATE NOT NULL DEFAULT '0000-00-00',
	paytype ENUM('Salary','Weekly','Daily','Hourly')DEFAULT 'Salary',
	taxstatustable_id TINYINT(1)DEFAULT NULL,
	payperiodtable_id TINYINT(4) NOT NULL DEFAULT 0,
	empstatustable_id TINYINT(1) NOT NULL DEFAULT 0,
	depttable_id TINYINT(2)DEFAULT NULL,
	atm_no VARCHAR(20) NOT NULL,
	sss_no VARCHAR(20) NOT NULL,
	hdmf_no VARCHAR(20) NOT NULL,
	ph_no VARCHAR(15) NOT NULL,
	tin_no VARCHAR(15) NOT NULL,
	basicpay DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	periodrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	dailyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	hourlyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	hrsperday DECIMAL(4,2) NOT NULL DEFAULT 8,
	portalpass VARCHAR(12) NOT NULL,
	is_active ENUM('Y','N') NOT NULL DEFAULT 'Y',
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

-- ALTER TABLE employees
-- 	ADD COLUMN hrsperday DECIMAL(4,2) NOT NULL DEFAULT 8
-- 		AFTER hourlyrate;

-- ALTER TABLE employees
-- 	CHANGE COLUMN hrsperday hrsperday DECIMAL(4,2) NOT NULL DEFAULT 8;

INSERT INTO employees
(empid   ,firstname,middlename,lastname   ,gender,maritalstatus,birthdate   ,position,hiredate    ,terminatedate,retireddate ,paytype ,taxstatustable_id,payperiodtable_id,empstatustable_id,depttable_id,atm_no,sss_no,hdmf_no,ph_no,tin_no,basicpay,periodrate,dailyrate,hourlyrate)
VALUES
('AAA888','Juan'   ,'Tamad'   ,'Dela Cruz','Male','Married'    ,'1980-01-01',''      ,'0000-00-00','0000-00-00' ,'0000-00-00','Salary',10               ,50               ,1                ,7           ,''    ,''    ,''     ,''   ,''    ,30000.00,15000.00  ,1153.85  ,229.98    );

-- ALTER TABLE employees
-- 	CHANGE COLUMN is_active
-- 		is_active ENUM('Y','N') NOT NULL DEFAULT 'Y';

UPDATE employees SET
	timerecid=id,
	paytype='Salary'
WHERE timerecid=0 AND paytype IS NULL;

DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS depttable;
CREATE TABLE IF NOT EXISTS depttable(
	id TINYINT NOT NULL AUTO_INCREMENT,
	deptdesc TINYTEXT NOT NULL DEFAULT '',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO depttable(deptdesc)VALUES('Accounting');
INSERT INTO depttable(deptdesc)VALUES('Administration');
INSERT INTO depttable(deptdesc)VALUES('Butler/FnB');
INSERT INTO depttable(deptdesc)VALUES('Design');
INSERT INTO depttable(deptdesc)VALUES('Human Resources');
INSERT INTO depttable(deptdesc)VALUES('Info Tech');
INSERT INTO depttable(deptdesc)VALUES('Kitchen');
INSERT INTO depttable(deptdesc)VALUES('Management');
INSERT INTO depttable(deptdesc)VALUES('Marketing');
INSERT INTO depttable(deptdesc)VALUES('Maintenance');
INSERT INTO depttable(deptdesc)VALUES('Operations');
INSERT INTO depttable(deptdesc)VALUES('Operation Front Desk');
INSERT INTO depttable(deptdesc)VALUES('Operation House Keeping');
INSERT INTO depttable(deptdesc)VALUES('Operation Motor Pool');
INSERT INTO depttable(deptdesc)VALUES('Operation Officer-In-Charge');

DROP TABLE IF EXISTS empstatus;
DROP TABLE IF EXISTS empstatustable;
CREATE TABLE IF NOT EXISTS empstatustable(
	id INT NOT NULL AUTO_INCREMENT,
	empstatus VARCHAR(15) NOT NULL DEFAULT '',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO empstatustable(empstatus)VALUES('Regular');
INSERT INTO empstatustable(empstatus)VALUES('Probationary');
INSERT INTO empstatustable(empstatus)VALUES('Fixed Term');
INSERT INTO empstatustable(empstatus)VALUES('Contractual');
INSERT INTO empstatustable(empstatus)VALUES('Trainee');

DROP TABLE IF EXISTS ssstable;
CREATE TABLE IF NOT EXISTS ssstable(
	id INT NOT NULL AUTO_INCREMENT,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	salarycredit DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employerecshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 1000.00,  1249.99, 1000.00,  70.70,10.00, 33.30,114.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 1250.00,  1749.99, 1500.00, 106.00,10.00, 50.00,166.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 1750.00,  2249.99, 2000.00, 141.30,10.00, 66.70,218.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 2250.00,  2749.99, 2500.00, 176.70,10.00, 83.30,270.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 2750.00,  3249.99, 3000.00, 212.00,10.00,100.00,322.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 3250.00,  3749.99, 3500.00, 247.30,10.00,116.70,374.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 3750.00,  4249.99, 4000.00, 282.70,10.00,133.30,426.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 4250.00,  4749.99, 4500.00, 318.00,10.00,150.00,478.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 4750.00,  5249.99, 5000.00, 353.30,10.00,166.70,530.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 5250.00,  5749.99, 5500.00, 388.70,10.00,183.30,582.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 5750.00,  6249.99, 6000.00, 424.00,10.00,200.00,634.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 6250.00,  6749.99, 6500.00, 459.30,10.00,216.70,686.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 6750.00,  7249.99, 7000.00, 494.70,10.00,233.30,738.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 7250.00,  7749.99, 7500.00, 530.00,10.00,250.00,790.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 7750.00,  8249.99, 8000.00, 565.30,10.00,266.70,842.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 8250.00,  8749.99, 8500.00, 600.70,10.00,283.30,894.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 8750.00,  9249.99, 9000.00, 636.00,10.00,300.00,946.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 9250.00,  9749.99, 9500.00, 671.30,10.00,316.70,998.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES( 9750.00, 10249.99,10000.00, 706.70,10.00,333.30,1050.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(10750.00, 11249.99,11000.00, 777.30,10.00,366.70,1154.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00);
INSERT INTO ssstable(rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt)VALUES(14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00);

DROP TABLE IF EXISTS sssfile;
CREATE TABLE IF NOT EXISTS sssfile(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	ssstable_id TINYINT NOT NULL DEFAULT 0,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	salarycredit DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employerecshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS ssstrans;
CREATE TABLE IF NOT EXISTS ssstrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	ssstable_id TINYINT NOT NULL DEFAULT 0,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	salarycredit DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employerecshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,1 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,2 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,3 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,4 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,5 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,6 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,7 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,8 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,9 ,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1010109057',11900.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1011415032',12000.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1022610005',10504.00,10250.00, 10749.99,10500.00, 742.00,10.00,350.00,1102.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1060107041',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1070511012',15000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1080109003',11630.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1080605070',12200.00,11750.00, 12249.99,12000.00, 848.00,10.00,400.00,1258.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1111709055',14500.00,14250.00, 14749.99,14500.00,1024.70,10.00,483.30,1518.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104028',13000.00,12750.00, 13249.99,13000.00, 918.70,10.00,433.30,1362.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104034',14000.00,13750.00, 14249.99,14000.00, 989.30,10.00,466.70,1466.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104058',12400.00,12250.00, 12749.99,12500.00, 883.30,10.00,416.70,1310.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104072',14800.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104089',13602.76,13250.00, 13749.99,13500.00, 954.00,10.00,450.00,1414.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120108002',11500.00,11250.00, 11749.99,11500.00, 812.70,10.00,383.30,1206.00,10,2011);
INSERT INTO ssstrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employerecshareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','AAA888'    ,30000.00,14750.00,999999.99,15000.00,1060.00,30.00,500.00,1590.00,10,2011);

DROP TABLE IF EXISTS hdmftable;
CREATE TABLE IF NOT EXISTS hdmftable(
	id INT NOT NULL AUTO_INCREMENT,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	employersharetype ENUM('Percentage','Fixed Amount') NULL,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeesharetype ENUM('Percentage','Fixed Amount') NULL,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO hdmftable(rangefrom,rangeto,employersharetype,employershareamt,employeesharetype,employeeshareamt)VALUES(    1.00,  1500.00,'Percentage'  ,  2.00,'Percentage'  ,  1.00);
INSERT INTO hdmftable(rangefrom,rangeto,employersharetype,employershareamt,employeesharetype,employeeshareamt)VALUES( 1500.01,999999.99,'Percentage'  ,  2.00,'Percentage'  ,  2.00);
INSERT INTO hdmftable(rangefrom,rangeto,employersharetype,employershareamt,employeesharetype,employeeshareamt)VALUES(    1.00,  5000.00,'Fixed Amount',100.00,'Fixed Amount',100.00);
INSERT INTO hdmftable(rangefrom,rangeto,employersharetype,employershareamt,employeesharetype,employeeshareamt)VALUES( 5000.01, 20000.00,'Fixed Amount',200.00,'Fixed Amount',200.00);
INSERT INTO hdmftable(rangefrom,rangeto,employersharetype,employershareamt,employeesharetype,employeeshareamt)VALUES(20000.01,999999.99,'Fixed Amount',200.00,'Fixed Amount',200.00);

DROP TABLE IF EXISTS hdmffile;
CREATE TABLE IF NOT EXISTS hdmffile(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	hdmftable_id TINYINT NOT NULL DEFAULT 0,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	employersharetype ENUM('Percentage','Fixed Amount') NOT NULL DEFAULT 'Percentage',
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeesharetype ENUM('Percentage','Fixed Amount') NOT NULL DEFAULT 'Percentage',
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS hdmftrans;
CREATE TABLE IF NOT EXISTS hdmftrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	hdmftable_id TINYINT NOT NULL DEFAULT 0,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	employersharetype ENUM('Percentage','Fixed Amount') NOT NULL DEFAULT 'Percentage',
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeesharetype ENUM('Percentage','Fixed Amount') NOT NULL DEFAULT 'Percentage',
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 1,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 2,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 3,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 4,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 5,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 6,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 7,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 8,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00, 9,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1010109057',11900.00,'Percentage',238.00,'Percentage',238.00, 476.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1011415032',12000.00,'Percentage',240.00,'Percentage',240.00, 480.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1022610005',10504.00,'Percentage',210.08,'Percentage',210.08, 420.16,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1060107041',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1070511012',15000.00,'Percentage',300.00,'Percentage',300.00, 600.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1080109003',11630.00,'Percentage',232.60,'Percentage',232.60, 465.20,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1080605070',12200.00,'Percentage',244.00,'Percentage',244.00, 488.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1111709055',14500.00,'Percentage',290.00,'Percentage',290.00, 580.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104028',13000.00,'Percentage',260.00,'Percentage',260.00, 520.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104034',14000.00,'Percentage',280.00,'Percentage',280.00, 560.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104058',12400.00,'Percentage',248.00,'Percentage',248.00, 496.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104072',14800.00,'Percentage',296.00,'Percentage',296.00, 592.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104089',13602.76,'Percentage',272.06,'Percentage',272.06, 544.11,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120108002',11500.00,'Percentage',230.00,'Percentage',230.00, 460.00,10,2011);
INSERT INTO hdmftrans(payrollperiod,empid,grossamt,employersharetype,employershareamt,employeesharetype,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','AAA888'    ,30000.00,'Percentage',600.00,'Percentage',600.00,1200.00,10,2011);

UPDATE hdmftrans SET
	rangefrom=1500.01,
	rangeto=999999.99,
	employersharetype='Percentage',
	employersharetype='Percentage';

DROP TABLE IF EXISTS phtable;
CREATE TABLE IF NOT EXISTS phtable(
	id INT NOT NULL AUTO_INCREMENT,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	salarycredit DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(    1.00,  4999.99, 4000.00, 50.00, 50.00,100.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES( 5000.00,  5999.99, 5000.00, 62.50, 62.50,125.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES( 6000.00,  6999.99, 6000.00, 75.00, 75.00,150.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES( 7000.00,  7999.99, 7000.00, 87.50, 87.50,175.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES( 8000.00,  8999.99, 8000.00,100.00,100.00,200.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES( 9000.00,  9999.99, 9000.00,112.50,112.50,225.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(10000.00, 10999.99,10000.00,125.00,125.00,250.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(11000.00, 11999.99,11000.00,137.50,137.50,275.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(12000.00, 12999.99,12000.00,150.00,150.00,300.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(13000.00, 13999.99,13000.00,162.50,162.50,325.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(14000.00, 14999.99,14000.00,175.00,175.00,350.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(15000.00, 15999.99,15000.00,187.50,187.50,375.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(16000.00, 16999.99,16000.00,200.00,200.00,400.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(17000.00, 17999.99,17000.00,212.50,212.50,425.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(18000.00, 18999.99,18000.00,225.00,225.00,450.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(19000.00, 19999.99,19000.00,237.50,237.50,475.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(20000.00, 20999.99,20000.00,250.00,250.00,500.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(21000.00, 21999.99,21000.00,262.50,262.50,525.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(22000.00, 22999.99,22000.00,275.00,275.00,550.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(23000.00, 23999.99,23000.00,287.50,287.50,575.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(24000.00, 24999.99,24000.00,300.00,300.00,600.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(25000.00, 25999.99,25000.00,312.50,312.50,625.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(26000.00, 26999.99,26000.00,325.00,325.00,650.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(27000.00, 27999.99,27000.00,337.50,337.50,675.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(28000.00, 28999.99,28000.00,350.00,350.00,700.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(29000.00, 29999.99,29000.00,362.50,362.50,725.00);
INSERT INTO phtable(rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt)VALUES(30000.00,999999.99,30000.00,375.00,375.00,750.00);

DROP TABLE IF EXISTS phfile;
CREATE TABLE IF NOT EXISTS phfile(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	phtable_id TINYINT NOT NULL DEFAULT 0,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	salarycredit DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS phtrans;
CREATE TABLE IF NOT EXISTS phtrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	phtable_id TINYINT NOT NULL DEFAULT 0,
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	salarycredit DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employershareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	employeeshareamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-01-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 1,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-02-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 2,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-03-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 3,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-04-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 4,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-05-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 5,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-06-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 6,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-07-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 7,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-08-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 8,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-09-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00, 9,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1010109057',11900.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1011415032',12000.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1022610005',10504.00,10000.00, 10999.99,10000.00,125.00,125.00,250.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1060107041',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1070511012',15000.00,15000.00, 15999.99,15000.00,187.50,187.50,375.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1080109003',11630.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1080605070',12200.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1111709055',14500.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104028',13000.00,13000.00, 13999.99,13000.00,162.50,162.50,325.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104034',14000.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104058',12400.00,12000.00, 12999.99,12000.00,150.00,150.00,300.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104072',14800.00,14000.00, 14999.99,14000.00,175.00,175.00,350.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120104089',13602.76,13000.00, 13999.99,13000.00,162.50,162.50,325.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','1120108002',11500.00,11000.00, 11999.99,11000.00,137.50,137.50,275.00,10,2011);
INSERT INTO phtrans(payrollperiod,empid,grossamt,rangefrom,rangeto,salarycredit,employershareamt,employeeshareamt,totalamt,fsmonth,fsyear)VALUES('2011-10-A','AAA888'    ,30000.00,30000.00,999999.99,30000.00,375.00,375.00,750.00,10,2011);

DROP TABLE IF EXISTS taxstatustable;
CREATE TABLE IF NOT EXISTS taxstatustable(
	id INT NOT NULL AUTO_INCREMENT,
	taxstatuscode VARCHAR(10) NOT NULL DEFAULT '',
	taxstatusdesc VARCHAR(40) NOT NULL DEFAULT '',
	dependents TINYINT(1) NOT NULL DEFAULT 0,
	personalexemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	additionalexemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	totalexemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE taxstatustable;
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('S'  ,'Single (with no dependents)',0,50000.00,     0.00, 50000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('S1' ,'Single with 1 dependent'    ,1,50000.00, 25000.00, 75000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('S2' ,'Single with 2 dependent'    ,2,50000.00, 50000.00,100000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('S3' ,'Single with 3 dependent'    ,3,50000.00, 75000.00,125000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('S4' ,'Single with 4 dependent'    ,4,50000.00,100000.00,150000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('ME' ,'Married (without children)' ,0,50000.00,     0.00, 50000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('ME1','Married with 1 child'       ,1,50000.00, 25000.00, 75000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('ME2','Married with 2 children'    ,2,50000.00, 50000.00,100000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('ME3','Married with 3 children'    ,3,50000.00, 75000.00,125000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('ME4','Married with 4 children'    ,4,50000.00,100000.00,150000.00);
INSERT INTO taxstatustable(taxstatuscode,taxstatusdesc,dependents,personalexemption,additionalexemption,totalexemption)VALUES('Z'  ,'Zero Exemption'             ,0,    0.00,     0.00,     0.00);

DROP TABLE IF EXISTS taxratetable;
DROP TABLE IF EXISTS taxtable;
CREATE TABLE IF NOT EXISTS taxtable(
	id INT NOT NULL AUTO_INCREMENT,
	taxstatuscode ENUM('Z','S','ME','S1','S2','S3','S4','ME1','ME2','ME3','ME4') NOT NULL DEFAULT 'S',
	payperiod ENUM('Daily','Weekly','Semi-Monthly','Monthly','Annual') NOT NULL DEFAULT 'Semi-Monthly',
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	exemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	dependents TINYINT(1) NOT NULL DEFAULT 0,
	fixedtaxableamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fixedtaxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	percentofexcessamt TINYINT(2) NOT NULL DEFAULT 1,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0,    1.00,   961.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0,  962.00,  1153.99,  962.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0, 1154.00,  1537.99, 1154.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0, 1538.00,  2307.99, 1538.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0, 2308.00,  3653.99, 2308.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0, 3654.00,  5768.99, 3654.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0, 5769.00, 10576.99, 5769.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S'  , 50000.00,0,10577.00,999999.99,10577.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0,    1.00,   961.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0,  962.00,  1153.99,  962.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0, 1154.00,  1537.99, 1154.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0, 1538.00,  2307.99, 1538.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0, 2308.00,  3653.99, 2308.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0, 3654.00,  5768.99, 3654.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0, 5769.00, 10576.99, 5769.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME' , 50000.00,0,10577.00,999999.99,10577.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1,    1.00,  1441.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1, 1442.00,  1634.99, 1442.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1, 1635.00,  2018.99, 1635.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1, 2019.00,  2787.99, 2019.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1, 2788.00,  4134.99, 2788.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1, 4135.00,  6249.99, 4135.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1, 6250.00, 11057.99, 6250.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S1' , 75000.00,1,11058.00,999999.99,11058.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2,    1.00,  1922.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2, 1923.00,  2114.99, 1923.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2, 2115.00,  2499.99, 2115.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2, 2500.00,  3268.99, 2500.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2, 3269.00,  4614.99, 3269.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2, 4615.00,  6730.99, 4615.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2, 6731.00, 11537.99, 6731.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S2' ,100000.00,2,11538.00,999999.99,11538.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3,    1.00,  2403.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3, 2404.00,  2595.99, 2404.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3, 2596.00,  2980.99, 2596.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3, 2981.00,  3749.99, 2981.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3, 3750.00,  5095.99, 3750.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3, 5096.00,  7211.99, 5096.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3, 7212.00, 12018.99, 7212.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S3' ,125000.00,3,12019.00,999999.99,12019.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4,    1.00,  2884.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4, 2885.00,  3076.99, 2885.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4, 3077.00,  3461.99, 3077.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4, 3462.00,  4230.99, 3462.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4, 4231.00,  5576.99, 4231.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4, 5577.00,  7691.99, 5577.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4, 7692.00, 12499.99, 7692.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'S4' ,150000.00,4,12500.00,999999.99,12500.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1,    1.00,  1441.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1, 1442.00,  1634.99, 1442.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1, 1635.00,  2018.99, 1635.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1, 2019.00,  2787.99, 2019.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1, 2788.00,  4134.99, 2788.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1, 4135.00,  6249.99, 4135.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1, 6250.00, 11057.99, 6250.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME1', 75000.00,1,11058.00,999999.99,11058.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2,    1.00,  1922.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2, 1923.00,  2114.99, 1923.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2, 2115.00,  2499.99, 2115.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2, 2500.00,  3268.99, 2500.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2, 3269.00,  4614.99, 3269.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2, 4615.00,  6730.99, 4615.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2, 6731.00, 11537.99, 6731.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME2',100000.00,2,11538.00,999999.99,11538.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3,    1.00,  2403.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3, 2404.00,  2595.99, 2404.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3, 2596.00,  2980.99, 2596.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3, 2981.00,  3749.99, 2981.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3, 3750.00,  5095.99, 3750.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3, 5096.00,  7211.99, 5096.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3, 7212.00, 12018.99, 7212.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME3',125000.00,3,12019.00,999999.99,12019.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4,    1.00,  2884.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4, 2885.00,  3076.99, 2885.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4, 3077.00,  3461.99, 3077.00,    9.62,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4, 3462.00,  4230.99, 3462.00,   48.08,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4, 4231.00,  5576.99, 4231.00,  163.46,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4, 5577.00,  7691.99, 5577.00,  432.69,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4, 7692.00, 12499.99, 7692.00,  961.54,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Weekly'      ,'ME4',150000.00,4,12500.00,999999.99,12500.00, 2403.85,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0,    1.00,  2082.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0, 2083.00,  2499.99, 2083.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0, 2500.00,  3332.99, 2500.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0, 3333.00,  4999.99, 3333.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0, 5000.00,  7916.99, 5000.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0, 7917.00, 12499.99, 7917.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0,12500.00, 22916.99,12500.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S'  , 50000.00,0,22917.00,999999.99,22917.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0,    1.00,  2082.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0, 2083.00,  2499.99, 2083.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0, 2500.00,  3332.99, 2500.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0, 3333.00,  4999.99, 3333.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0, 5000.00,  7916.99, 5000.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0, 7917.00, 12499.99, 7917.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0,12500.00, 22916.99,12500.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME' , 50000.00,0,22917.00,999999.99,22917.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1,    1.00,  3124.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1, 3125.00,  3541.99, 3125.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1, 3542.00,  4374.99, 3542.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1, 4375.00,  6041.99, 4375.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1, 6042.00,  8957.99, 6042.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1, 8958.00, 13541.99, 8958.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1,13542.00, 23957.99,13542.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S1' , 75000.00,1,23958.00,999999.99,23958.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2,    1.00,  4166.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2, 4167.00,  4582.99, 4167.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2, 4583.00,  5416.99, 4583.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2, 5417.00,  7082.99, 5417.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2, 7083.00,  9999.99, 7083.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2,10000.00, 14582.99,10000.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2,14583.00, 24999.99,14583.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S2' ,100000.00,2,25000.00,999999.99,25000.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3,    1.00,  5207.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3, 5208.00,  5624.99, 5208.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3, 5625.00,  6457.99, 5625.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3, 6458.00,  8124.99, 6458.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3, 8125.00, 11041.99, 8125.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3,11042.00, 15624.99,11042.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3,15625.00, 26041.99,15625.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S3' ,125000.00,3,26042.00,999999.99,26042.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4,    1.00,  6249.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4, 6250.00,  6666.99, 6250.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4, 6667.00,  7499.99, 6667.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4, 7500.00,  9166.99, 7500.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4, 9167.00, 12082.99, 9167.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4,12083.00, 16666.99,12083.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4,16667.00, 27082.99,16667.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','S4' ,150000.00,4,27083.00,999999.99,27083.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1,    1.00,  3124.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1, 3125.00,  3541.99, 3125.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1, 3542.00,  4374.99, 3542.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1, 4375.00,  6041.99, 4375.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1, 6042.00,  8957.99, 6042.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1, 8958.00, 13541.99, 8958.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1,13542.00, 23957.99,13542.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME1', 75000.00,1,23958.00,999999.99,23958.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2,    1.00,  4166.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2, 4167.00,  4582.99, 4167.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2, 4583.00,  5416.99, 4583.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2, 5417.00,  7082.99, 5417.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2, 7083.00,  9999.99, 7083.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2,10000.00, 14582.99,10000.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2,14583.00, 24999.99,14583.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME2',100000.00,2,25000.00,999999.99,25000.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3,    1.00,  5207.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3, 5208.00,  5624.99, 5208.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3, 5625.00,  6457.99, 5625.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3, 6458.00,  8124.99, 6458.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3, 8125.00, 11041.99, 8125.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3,11042.00, 15624.99,11042.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3,15625.00, 26041.99,15625.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME3',125000.00,3,26042.00,999999.99,26042.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4,    1.00,  6249.99,    1.00,    0.00, 0);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4, 6250.00,  6666.99, 6250.00,    0.00, 5);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4, 6667.00,  7499.99, 6667.00,   20.83,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4, 7500.00,  9166.99, 7500.00,  104.17,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4, 9167.00, 12082.99, 9167.00,  354.17,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4,12083.00, 16666.99,12083.00,  937.50,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4,16667.00, 27082.99,16667.00, 2083.33,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Semi-Monthly','ME4',150000.00,4,27083.00,999999.99,27083.00, 5208.33,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0,    1.00,  4166.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0, 4167.00,  4999.99, 4167.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0, 5000.00,  6666.99, 5000.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0, 6667.00,  9999.99, 6667.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0,10000.00, 15832.99,10000.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0,15833.00, 24999.99,15833.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0,25000.00, 45832.99,25000.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S'  , 50000.00,0,45833.00,999999.99,45833.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0,    1.00,  4166.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0, 4167.00,  4999.99, 4167.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0, 5000.00,  6666.99, 5000.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0, 6667.00,  9999.99, 6667.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0,10000.00, 15832.99,10000.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0,15833.00, 24999.99,15833.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0,25000.00, 45832.99,25000.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME' , 50000.00,0,45833.00,999999.99,45833.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1,    1.00,  6249.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1, 6250.00,  7082.99, 6250.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1, 7083.00,  8749.99, 7083.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1, 8750.00, 12082.99, 8750.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1,12083.00, 17916.99,12083.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1,17917.00, 27082.99,17917.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1,27083.00, 47916.99,27083.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S1' , 75000.00,1,47917.00,999999.99,47917.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2,    1.00,  8332.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2, 8333.00,  9166.99, 8333.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2, 9167.00, 10832.99, 9167.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2,10833.00, 14166.99,10833.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2,14167.00, 19999.99,14167.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2,20000.00, 29166.99,20000.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2,29167.00, 49999.99,29167.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S2' ,100000.00,2,50000.00,999999.99,50000.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,    1.00, 10416.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,10417.00, 11249.99,10417.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,11250.00, 12916.99,11250.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,12917.00, 16249.99,12917.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,16250.00, 22082.99,16250.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,22083.00, 31249.99,22083.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,31250.00, 52082.99,31250.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S3' ,125000.00,3,52083.00,999999.99,52083.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,    1.00, 12499.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,12500.00, 13332.99,12500.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,13333.00, 14999.99,13333.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,15000.00, 18332.99,15000.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,18333.00, 24166.99,18333.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,24167.00, 33332.99,24167.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,33333.00, 54166.99,33333.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'S4' ,150000.00,4,54167.00,999999.99,54167.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1,    1.00,  6249.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1, 6250.00,  7082.99, 6250.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1, 7083.00,  8749.99, 7083.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1, 8750.00, 12082.99, 8750.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1,12083.00, 17916.99,12083.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1,17917.00, 27082.99,17917.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1,27083.00, 47916.99,27083.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME1', 75000.00,1,47917.00,999999.99,47917.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2,    1.00,  8332.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2, 8333.00,  9166.99, 8333.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2, 9167.00, 10832.99, 9167.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2,10833.00, 14166.99,10833.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2,14167.00, 19999.99,14167.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2,20000.00, 29166.99,20000.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2,29167.00, 49999.99,29167.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME2',100000.00,2,50000.00,999999.99,50000.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,    1.00, 10416.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,10417.00, 11249.99,10417.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,11250.00, 12916.99,11250.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,12917.00, 16249.99,12917.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,16250.00, 22082.99,16250.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,22083.00, 31249.99,22083.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,31250.00, 52082.99,31250.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME3',125000.00,3,52083.00,999999.99,52083.00,10416.67,32);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,    1.00, 12499.99,    1.00,    0.00,0 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,12500.00, 13332.99,12500.00,    0.00,5 );
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,13333.00, 14999.99,13333.00,   41.67,10);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,15000.00, 18332.99,15000.00,  208.33,15);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,18333.00, 24166.99,18333.00,  708.33,20);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,24167.00, 33332.99,24167.00, 1875.00,25);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,33333.00, 54166.99,33333.00, 4166.67,30);
INSERT INTO taxtable(payperiod,taxstatuscode,exemption,dependents,rangefrom,rangeto,fixedtaxableamt,fixedtaxamt,percentofexcessamt)VALUES('Monthly'     ,'ME4',150000.00,4,54167.00,999999.99,54167.00,10416.67,32);

DROP TABLE IF EXISTS taxfile;
CREATE TABLE IF NOT EXISTS taxfile(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	taxtable_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	taxstatuscode ENUM('Z','S','ME','S1','S2','S3','S4','ME1','ME2','ME3','ME4') NOT NULL DEFAULT 'S',
	payperiod ENUM('Daily','Weekly','Semi-Monthly','Monthly','Annual') NOT NULL DEFAULT 'Semi-Monthly',
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	exemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	dependents TINYINT(1) NOT NULL DEFAULT 0,
	fixedtaxableamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fixedtaxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	percentofexcessamt TINYINT(2) NOT NULL DEFAULT 1,
	taxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS taxtrans;
CREATE TABLE IF NOT EXISTS taxtrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	taxtable_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	taxstatuscode ENUM('Z','S','ME','S1','S2','S3','S4','ME1','ME2','ME3','ME4') NOT NULL DEFAULT 'S',
	payperiod ENUM('Daily','Weekly','Semi-Monthly','Monthly','Annual') NOT NULL DEFAULT 'Semi-Monthly',
	rangefrom DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	rangeto DECIMAL(8,2) NOT NULL DEFAULT 999999.99,
	exemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	dependents TINYINT(1) NOT NULL DEFAULT 0,
	fixedtaxableamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fixedtaxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	percentofexcessamt TINYINT(2) NOT NULL DEFAULT 1,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	taxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1010109057',11124.50,2607.45, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1011415032',11210.00,1593.72, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1022610005', 3354.92, 232.88, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1060107041',12144.20,2920.70, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1070511012',14012.50,2454.64, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1080109003',10876.60,1837.96, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1080605070',11406.00,2693.93, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1111709055',13551.70,3353.09, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1120104028',12144.20,2227.37, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1120104034',13078.30,2167.66, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1120104058',11585.30,2402.33, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1120104072',13829.00,3438.27, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1120104089',12718.20,1710.36, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','1120108002',10749.20,2492.16, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-01-B','AAA888'    ,36525.00,9023.81, 1,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1010109057',11124.50,2566.04, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1011415032',11210.00,1507.04, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1060107041',12144.20,2878.73, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1070511012',14012.50,2366.41, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1080109003',10876.60,1766.54, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1080605070',11406.00,2652.36, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1111709055',13551.70,3310.33, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1120104028',12144.20,2155.24, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1120104034',13078.30,2079.95, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1120104058',11585.30,2345.60, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1120104072',13829.00,3395.36, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1120104089',12718.20,1607.77, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','1120108002',10749.20,2450.96, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-02-B','AAA888'    ,36525.00,8907.97, 2,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1010109057',11124.50,2518.72, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1011415032',11210.00,1407.99, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1060107041',12144.20,2830.75, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1070511012',14012.50,2265.57, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1080109003',10876.60,1684.93, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1080605070',11406.00,2604.86, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1111709055',13551.70,3261.46, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1120104028',12144.20,2072.82, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1120104034',13078.30,1979.70, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1120104058',11585.30,2280.75, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1120104072',13829.00,3346.32, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1120104089',12718.20,1490.53, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','1120108002',10749.20,2403.87, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-03-B','AAA888'    ,36525.00,8775.59, 3,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1010109057',11124.50,2463.92, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1011415032',11210.00,1293.29, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1060107041',12144.20,2775.21, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1070511012',14012.50,2148.82, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1080109003',10876.60,1590.42, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1080605070',11406.00,2549.86, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1111709055',13551.70,3204.88, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1120104028',12144.20,1977.38, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1120104034',13078.30,1863.63, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1120104058',11585.30,2205.67, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1120104072',13829.00,3289.53, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1120104089',12718.20,1354.78, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','1120108002',10749.20,2349.35, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-04-B','AAA888'    ,36525.00,8622.31, 4,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1010109057',11124.50,2399.46, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1011415032',11210.00,1158.36, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1060107041',12144.20,2709.86, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1070511012',14012.50,2011.45, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1080109003',10876.60,1479.24, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1080605070',11406.00,2485.15, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1111709055',13551.70,3138.31, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1120104028',12144.20,1865.10, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1120104034',13078.30,1727.08, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1120104058',11585.30,2117.34, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1120104072',13829.00,3222.72, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1120104089',12718.20,1195.07, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','1120108002',10749.20,2285.21, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-05-B','AAA888'    ,36525.00,8441.97, 5,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1010109057',11124.50,2322.10, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1011415032',11210.00, 996.43, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1060107041',12144.20,2631.44, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1070511012',14012.50,1846.61, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1080109003',10876.60,1345.82, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1080605070',11406.00,2407.50, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1111709055',13551.70,3058.43, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1120104028',12144.20,1730.37, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1120104034',13078.30,1563.21, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1120104058',11585.30,2011.34, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1120104072',13829.00,3142.55, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1120104089',12718.20,1003.43, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','1120108002',10749.20,2208.25, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-06-B','AAA888'    ,36525.00,8225.57, 6,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1010109057',11124.50,2226.89, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1011415032',11210.00, 797.14, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1060107041',12144.20,2534.92, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1070511012',14012.50,1643.74, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1080109003',10876.60,1181.61, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1080605070',11406.00,2311.92, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1111709055',13551.70,2960.11, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1120104028',12144.20,1564.54, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1120104034',13078.30,1361.53, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1120104058',11585.30,1880.89, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1120104072',13829.00,3043.88, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1120104089',12718.20, 767.55, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','1120108002',10749.20,2113.52, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-07-B','AAA888'    ,36525.00,7959.23, 7,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1010109057',11124.50,2105.71, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1011415032',11210.00, 543.50, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1060107041',12144.20,2412.09, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1070511012',14012.50,1385.53, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1080109003',10876.60, 972.62, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1080605070',11406.00,2190.29, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1111709055',13551.70,2834.98, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1120104028',12144.20,1353.48, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1120104034',13078.30,1104.85, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1120104058',11585.30,1714.85, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1120104072',13829.00,2918.29, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1120104089',12718.20, 467.34, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','1120108002',10749.20,1992.95, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-08-B','AAA888'    ,36525.00,7620.25, 8,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1010109057',11124.50,1944.14, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1011415032',11210.00, 205.32, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1060107041',12144.20,2248.30, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1070511012',14012.50,1041.26, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1080109003',10876.60, 693.97, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1080605070',11406.00,2028.11, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1111709055',13551.70,2668.14, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1120104028',12144.20,1072.07, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1120104034',13078.30, 762.60, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1120104058',11585.30,1493.47, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1120104072',13829.00,2750.85, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1120104089',12718.20,  68.59, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','1120108002',10749.20,1832.19, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-09-B','AAA888'    ,36525.00,7168.28, 9,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1010109057',11124.50,1713.33,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1011415032',11210.00,-252.30,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1060107041',12144.20,2014.32,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1070511012',14012.50, 549.44,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1080109003',10876.60, 295.89,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1080605070',11406.00,1796.42,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1111709055',13551.70,2429.79,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1120104028',12144.20, 670.07,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1120104034',13078.30, 273.68,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1120104058',11585.30,1177.20,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1120104072',13829.00,2511.65,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1120104089',12718.20,-466.68,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','1120108002',10749.20,1602.54,10,2011);
INSERT INTO taxtrans(payrollperiod,empid,grossamt,taxamt,fsmonth,fsyear)VALUES('2011-10-B','AAA888'    ,36525.00,6522.61,10,2011);

DROP TABLE IF EXISTS loantable;
CREATE TABLE IF NOT EXISTS loantable(
	id TINYINT NOT NULL AUTO_INCREMENT,
	loandesc TINYTEXT NOT NULL DEFAULT '',
	acctcode VARCHAR(10) NULL,
	contraacct VARCHAR(10) NULL,
	normalbal ENUM('Debit','Credit') NULL,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO loantable(loandesc)VALUES('SSS Salary Loan');
INSERT INTO loantable(loandesc)VALUES('Pag-ibig Housing Loan');
INSERT INTO loantable(loandesc)VALUES('Cash Advance');
INSERT INTO loantable(loandesc)VALUES('Cooperative Loan');

DROP TABLE IF EXISTS loanfile;
CREATE TABLE IF NOT EXISTS loanfile(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	filedate DATE NOT NULL DEFAULT '0000-00-00',
	loantable_id TINYINT NOT NULL DEFAULT 0,
	loandesc TINYTEXT NOT NULL DEFAULT '',
	loanamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	amortization DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	startdate DATE NOT NULL DEFAULT '0000-00-00',
	is_active ENUM('Y','N') NOT NULL DEFAULT 'Y',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO loanfile
(empid,filedate,loantable_id,loandesc,loanamt,amortization,startdate)
VALUES
('AAA888','2011-01-01',4,'Employee Loan(Cooperative Loan)',100000.00,400.00,'2011-01-01');

DROP TABLE IF EXISTS loantrans;
CREATE TABLE IF NOT EXISTS loantrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10)DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	loanfile_id INT NOT NULL DEFAULT 0,
	payamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	origpayrollperiod VARCHAR(10),
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-01-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-01-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-02-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-02-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-03-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-03-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-04-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-04-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-05-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-05-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-06-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-06-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-07-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-07-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-08-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-08-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-09-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-09-B','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-10-A','AAA888',1,400.00);
INSERT INTO loantrans(payrollperiod,empid,loanfile_id,payamt)VALUES('2011-10-B','AAA888',1,400.00);

DROP TABLE IF EXISTS incometable;
CREATE TABLE IF NOT EXISTS incometable(
	id TINYINT NOT NULL AUTO_INCREMENT,
	incomedesc TINYTEXT NOT NULL DEFAULT '',
	frequency ENUM('Recurring','One-Time') DEFAULT 'One-Time',
	is_taxable ENUM('Y','N') NOT NULL DEFAULT 'Y',
	acctcode VARCHAR(10) NULL,
	contraacct VARCHAR(10) NULL,
	normalbal ENUM('Debit','Credit') NULL,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE incometable;
INSERT INTO incometable(incomedesc,frequency,is_taxable)VALUES('Meal Allowance'          ,'Recurring','N');
INSERT INTO incometable(incomedesc,frequency,is_taxable)VALUES('Transportation Allowance','Recurring','N');
INSERT INTO incometable(incomedesc,frequency,is_taxable)VALUES('Housing Allowance'       ,'One-Time' ,'Y');
INSERT INTO incometable(incomedesc,frequency,is_taxable)VALUES('Management Allowance'    ,'Recurring','N');
INSERT INTO incometable(incomedesc,frequency,is_taxable)VALUES('Communications Allowance','Recurring','N');
INSERT INTO incometable(incomedesc,frequency,is_taxable)VALUES('Clothing Allowance'      ,'Recurring','N');

DROP TABLE IF EXISTS incomefile;
CREATE TABLE IF NOT EXISTS incomefile(
	id INT NOT NULL AUTO_INCREMENT,
	fileref VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	filedate DATE NOT NULL DEFAULT '0000-00-00',
	incomedesc TINYTEXT NOT NULL DEFAULT '',
	incometable_id TINYINT NOT NULL DEFAULT 0,
	payamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	startdate DATE NOT NULL DEFAULT '0000-00-00',
	partno DECIMAL(1) NOT NULL DEFAULT 1,
	is_active ENUM('Y','N') NOT NULL DEFAULT 'Y',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO incomefile(incomedesc,empid,filedate,incometable_id,payamt)VALUES('Other Income(Meal Allowance)'          ,'AAA888','2011-01-01',1, 800.00);
INSERT INTO incomefile(incomedesc,empid,filedate,incometable_id,payamt)VALUES('Other Income(Clothing Allowance)'      ,'AAA888','2011-01-01',6, 500.00);
INSERT INTO incomefile(incomedesc,empid,filedate,incometable_id,payamt)VALUES('Other Income(Transportation Allowance)','AAA888','2011-01-01',2,1200.00);
INSERT INTO incomefile(incomedesc,empid,filedate,incometable_id,payamt)VALUES('Other Income(Communications Allowance)','AAA888','2011-01-01',5,1500.00);

DROP TABLE IF EXISTS incometrans;
CREATE TABLE IF NOT EXISTS incometrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10)DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	incomefile_id INT NOT NULL DEFAULT 0,
	payamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	origpayrollperiod VARCHAR(10),
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-01-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-02-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-03-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-04-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-05-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-06-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-07-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-08-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-09-B','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-A','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-A','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-A','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-A','AAA888',6,1500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-B','AAA888',3, 800.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-B','AAA888',4, 500.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-B','AAA888',5,1200.00);
INSERT INTO incometrans(payrollperiod,empid,incomefile_id,payamt)VALUES('2011-10-B','AAA888',6,1500.00);

UPDATE incometrans SET incomefile_id=incomefile_id-2;

DROP TABLE IF EXISTS deducttable;
CREATE TABLE IF NOT EXISTS deducttable(
	id TINYINT NOT NULL AUTO_INCREMENT,
	deductdesc TINYTEXT NOT NULL DEFAULT '',
	frequency ENUM('Recurring','One-Time') DEFAULT 'Recurring',
	acctcode VARCHAR(10) NULL,
	contraacct VARCHAR(10) NULL,
	normalbal ENUM('Debit','Credit') NULL,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO deducttable(deductdesc,frequency)VALUES('Cooperative Deposit'   ,'Recurring');
INSERT INTO deducttable(deductdesc,frequency)VALUES('Cooperative Membership','One-Time' );
INSERT INTO deducttable(deductdesc,frequency)VALUES('Company Uniform'       ,'Recurring');
INSERT INTO deducttable(deductdesc,frequency)VALUES('Bereavement Donation'  ,'One-Time' );

DROP TABLE IF EXISTS deductfile;
CREATE TABLE IF NOT EXISTS deductfile(
	id INT NOT NULL AUTO_INCREMENT,
	fileref VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	filedate DATE NOT NULL DEFAULT '0000-00-00',
	deductdesc TINYTEXT NOT NULL DEFAULT '',
	deducttable_id TINYINT NOT NULL DEFAULT 0,
	payamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	startdate DATE NOT NULL DEFAULT '0000-00-00',
	partno DECIMAL(1) NOT NULL DEFAULT 1,
	is_active ENUM('Y','N') NOT NULL DEFAULT 'Y',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO deductfile(deductdesc,empid,filedate,deducttable_id,payamt)VALUES('Other Deduction(Cooperative Deposit)','AAA888','2011-01-01',1,500.00);
INSERT INTO deductfile(deductdesc,empid,filedate,deducttable_id,payamt)VALUES('Other Deduction(Company Uniform)'    ,'AAA888','2011-01-01',3, 50.00);

DROP TABLE IF EXISTS deducttrans;
CREATE TABLE IF NOT EXISTS deducttrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10)DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	deductfile_id INT NOT NULL DEFAULT 0,
	payamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	origpayrollperiod VARCHAR(10),
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-01-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-01-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-01-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-01-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-02-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-02-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-02-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-02-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-03-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-03-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-03-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-03-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-04-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-04-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-04-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-04-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-05-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-05-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-05-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-05-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-06-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-06-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-06-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-06-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-07-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-07-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-07-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-07-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-08-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-08-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-08-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-08-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-09-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-09-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-09-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-09-B','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-10-A','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-10-A','AAA888',2, 50.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-10-B','AAA888',1,500.00);
INSERT INTO deducttrans(payrollperiod,empid,deductfile_id,payamt)VALUES('2011-10-B','AAA888',2, 50.00);

DROP TABLE IF EXISTS ottable;
CREATE TABLE IF NOT EXISTS ottable(
	id TINYINT NOT NULL AUTO_INCREMENT,
	otdesc TINYTEXT NOT NULL DEFAULT '',
	otrate DECIMAL(4,2) NOT NULL DEFAULT 1,
	acctcode VARCHAR(10) NULL,
	contraacct VARCHAR(10) NULL,
	normalbal ENUM('Debit','Credit') NULL,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE ottable;
INSERT INTO ottable(otdesc,otrate)VALUES('Regular Work / No Overtime / Adjustment OR Reversal',1.00);
INSERT INTO ottable(otdesc,otrate)VALUES('Regular Day Overtime Work'                          ,1.25);
INSERT INTO ottable(otdesc,otrate)VALUES('Graveyard / Night Shift / Night Differential Only'  ,0.10);
INSERT INTO ottable(otdesc,otrate)VALUES('Regular Work with Night Differential'               ,1.10);
INSERT INTO ottable(otdesc,otrate)VALUES('Rest Day OR Special Day Overtime Work'              ,1.30);
INSERT INTO ottable(otdesc,otrate)VALUES('Rest Day OR Special Day Overtime Work +8hrs'        ,1.69);
INSERT INTO ottable(otdesc,otrate)VALUES('Regular Holiday Overtime Work'                      ,2.00);
INSERT INTO ottable(otdesc,otrate)VALUES('Regular Holiday Overtime Work +8hrs'                ,2.60);
INSERT INTO ottable(otdesc,otrate)VALUES('Rest Day AND Regular Holiday Overtime Work'         ,2.60);
INSERT INTO ottable(otdesc,otrate)VALUES('Rest Day AND Regular Holiday Overtime Work +8hr'    ,3.38);

DROP TABLE IF EXISTS otfile;
CREATE TABLE IF NOT EXISTS otfile(
	id TINYINT NOT NULL AUTO_INCREMENT,
	fileref VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	filedate DATE NOT NULL DEFAULT '0000-00-00',
	ottable_id TINYINT NOT NULL DEFAULT 0,
	otdesc TINYTEXT NOT NULL DEFAULT '',
	othrs DECIMAL(7,5) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS ottrans;
CREATE TABLE IF NOT EXISTS ottrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10)DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	otdate DATE NOT NULL DEFAULT '0000-00-00',
	otdesc TINYTEXT NOT NULL DEFAULT '',
	otmins SMALLINT NOT NULL DEFAULT 0,
	othhmm VARCHAR(6) NOT NULL DEFAULT '00:00',
	otrate DECIMAL(4,2) NOT NULL DEFAULT 1,
	hourlyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	otamt DECIMAL(8,2) NOT NULL DEFAULT 0,
	otfile_id INT NOT NULL DEFAULT 0,
	ottable_id TINYINT NOT NULL DEFAULT 0,
	is_manual ENUM('Y','N') NOT NULL DEFAULT 'Y',
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

-- ALTER TABLE ottrans
-- 	CHANGE COLUMN otrate otrate DECIMAL(4,2) NOT NULL DEFAULT 1;

-- ALTER TABLE ottrans
-- 	ADD COLUMN hourlyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00
-- 		AFTER otrate;

DROP TABLE IF EXISTS payperiodtable;
CREATE TABLE IF NOT EXISTS payperiodtable(
	id INT NOT NULL AUTO_INCREMENT,
	payperiod VARCHAR(15) NOT NULL DEFAULT '',
	paydays DECIMAL(3) NOT NULL DEFAULT 0,
	wrkdayspermo DECIMAL(2) NOT NULL DEFAULT 0,
	wrkdaysperwk DECIMAL(1) NOT NULL DEFAULT 0,
	wrkhrsperday DECIMAL(7,5) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO payperiodtable(payperiod,paydays)VALUES('Semi-Monthly', 24);
INSERT INTO payperiodtable(payperiod,paydays)VALUES('Monthly'     , 12);
INSERT INTO payperiodtable(payperiod,paydays)VALUES('Weekly'      , 52);
INSERT INTO payperiodtable(payperiod,paydays)VALUES('Monthly'     , 24);
INSERT INTO payperiodtable(payperiod,paydays)VALUES('Daily'       ,261);
INSERT INTO payperiodtable(payperiod,paydays)VALUES('Bi-Weekly'   , 26);
INSERT INTO payperiodtable(payperiod,paydays)VALUES('Annual'      ,  1);

UPDATE employees SET
	payperiodtable_id=4;

DROP TABLE IF EXISTS payrollperiodtable;
CREATE TABLE IF NOT EXISTS payrollperiodtable(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	payrolldesc TINYTEXT NOT NULL DEFAULT '',
	payperiodtable_id TINYINT(1) NOT NULL DEFAULT 0,
	startdate DATE NOT NULL DEFAULT '0000-00-00',
	enddate DATE NOT NULL DEFAULT '0000-00-00',
	startcoverdt DATE NOT NULL DEFAULT '0000-00-00',
	endcoverdt DATE NOT NULL DEFAULT '0000-00-00',
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	partno DECIMAL(1) NOT NULL DEFAULT 1,
	totalparts DECIMAL(1) NOT NULL DEFAULT 1,
	deductsss TINYINT(1) NOT NULL DEFAULT 0,
	deducthdmf TINYINT(1) NOT NULL DEFAULT 0,
	deductph TINYINT(1) NOT NULL DEFAULT 0,
	deductothers TINYINT(1) NOT NULL DEFAULT 0,
	deductwtax TINYINT(1) NOT NULL DEFAULT 0,
	earnleaves TINYINT(1) NOT NULL DEFAULT 0,
	nthmonthpay TINYINT(2) NOT NULL DEFAULT 0,
	is_generated ENUM('Y','N') NOT NULL DEFAULT 'N',
	is_closed ENUM('Y','N') NOT NULL DEFAULT 'N',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

-- ALTER TABLE payrollperiodtable
-- 	ADD COLUMN earnleaves TINYINT(1) NOT NULL DEFAULT 0
-- 		AFTER deductwtax;

-- ALTER TABLE payrollperiodtable
-- 	ADD COLUMN is_generate ENUM('Y','N') NOT NULL DEFAULT 'N'
-- 		AFTER nthmonthpay;

-- ALTER TABLE payrollperiodtable
-- 	CHANGE COLUMN is_generate is_generated ENUM('Y','N') NOT NULL DEFAULT 'N';

TRUNCATE TABLE payrollperiodtable;
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-01-A','Jan 01-Jan 15,2011'     ,50,'2010-12-26','2011-01-10','2011-01-01','2011-01-15',1 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-01-B','Jan 16-Jan 31,2011'     ,50,'2011-01-11','2011-01-25','2011-01-16','2011-01-31',1 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-02-A','Feb 01-Feb 15,2011'     ,50,'2011-01-26','2011-02-10','2011-02-01','2011-02-15',2 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-02-B','Feb 16-Feb 31,2011'     ,50,'2011-02-16','2011-02-25','2011-02-16','2011-02-28',2 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-03-A','Mar 01-Mar 15,2011'     ,50,'2011-02-26','2011-03-10','2011-03-01','2011-03-15',3 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-03-B','Mar 16-Mar 31,2011'     ,50,'2011-03-11','2011-03-25','2011-03-16','2011-03-31',3 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-04-A','Apr 01-Apr 15,2011'     ,50,'2011-03-26','2011-04-10','2011-04-01','2011-04-15',4 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-04-B','Apr 16-Apr 31,2011'     ,50,'2011-04-11','2011-04-25','2011-04-16','2011-04-30',4 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-05-A','May 01-May 15,2011'     ,50,'2011-04-26','2011-05-10','2011-05-01','2011-05-15',5 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-05-B','May 16-May 31,2011'     ,50,'2011-05-11','2011-05-25','2011-05-16','2011-05-31',5 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-06-A','Jun 01-Jun 15,2011'     ,50,'2011-05-26','2011-06-10','2011-06-01','2011-06-15',6 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-06-B','Jun 16-Jun 31,2011'     ,50,'2011-06-11','2011-06-25','2011-06-16','2011-06-30',6 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-07-A','Jul 01-Jul 15,2011'     ,50,'2011-06-26','2011-07-10','2011-07-01','2011-07-15',7 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-07-B','Jul 16-Jul 31,2011'     ,50,'2011-07-11','2011-07-25','2011-07-16','2011-07-31',7 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-08-A','Aug 01-Aug 15,2011'     ,50,'2011-07-26','2011-08-10','2011-08-01','2011-08-15',8 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-08-B','Aug 16-Aug 31,2011'     ,50,'2011-08-11','2011-08-25','2011-08-16','2011-08-31',8 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-09-A','Sep 01-Sep 15,2011'     ,50,'2011-08-26','2011-09-10','2011-09-01','2011-09-15',9 ,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-09-B','Sep 16-Sep 31,2011'     ,50,'2011-09-11','2011-09-25','2011-09-16','2011-09-30',9 ,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-10-A','Oct 01-Oct 15,2011'     ,50,'2011-09-26','2011-10-10','2011-10-01','2011-10-15',10,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-10-B','Oct 16-Oct 31,2011'     ,50,'2011-10-11','2011-10-25','2011-10-16','2011-10-31',10,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-11-A','Nov 01-Nov 15,2011'     ,50,'2011-10-26','2011-11-10','2011-11-01','2011-11-15',11,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-11-B','Nov 16-Nov 31,2011'     ,50,'2011-11-11','2011-11-25','2011-11-16','2011-11-30',11,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-12-A','Dec 01-Dec 15,2011'     ,50,'2011-11-26','2011-12-10','2011-12-01','2011-12-15',12,2011,1,2,2,2,2,0,1,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-12-B','Dec 16-Dec 31,2011'     ,50,'2011-12-11','2011-12-25','2011-12-16','2011-12-31',12,2011,2,2,1,1,1,0,2,1);
-- INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2011-12-C','13th Month Pay for 2011',50,'2011-01-01','2011-12-31','2011-01-01','2011-12-31',12,2011,1,1,1,1,1,1,2,0);

INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-01-MA','Jan 01-Jan 15,2012'     ,4,'2011-12-26','2012-01-10','2012-01-01','2012-01-15', 1,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-01-MB','Jan 16-Jan 31,2012'     ,4,'2012-01-11','2012-01-25','2012-01-16','2012-01-31', 1,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-02-MA','Feb 01-Feb 15,2012'     ,4,'2012-01-26','2012-02-10','2012-02-01','2012-02-15', 2,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-02-MB','Feb 16-Feb 31,2012'     ,4,'2012-02-16','2012-02-25','2012-02-16','2012-02-28', 2,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-MA','Mar 01-Mar 15,2012'     ,4,'2012-02-26','2012-03-10','2012-03-01','2012-03-15', 3,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-MB','Mar 16-Mar 31,2012'     ,4,'2012-03-11','2012-03-25','2012-03-16','2012-03-31', 3,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-04-MA','Apr 01-Apr 15,2012'     ,4,'2012-03-26','2012-04-10','2012-04-01','2012-04-15', 4,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-04-MB','Apr 16-Apr 31,2012'     ,4,'2012-04-11','2012-04-25','2012-04-16','2012-04-30', 4,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-MA','May 01-May 15,2012'     ,4,'2012-04-26','2012-05-10','2012-05-01','2012-05-15', 5,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-MB','May 16-May 31,2012'     ,4,'2012-05-11','2012-05-25','2012-05-16','2012-05-31', 5,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-06-MA','Jun 01-Jun 15,2012'     ,4,'2012-05-26','2012-06-10','2012-06-01','2012-06-15', 6,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-06-MB','Jun 16-Jun 31,2012'     ,4,'2012-06-11','2012-06-25','2012-06-16','2012-06-30', 6,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-07-MA','Jul 01-Jul 15,2012'     ,4,'2012-06-26','2012-07-10','2012-07-01','2012-07-15', 7,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-07-MB','Jul 16-Jul 31,2012'     ,4,'2012-07-11','2012-07-25','2012-07-16','2012-07-31', 7,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-MA','Aug 01-Aug 15,2012'     ,4,'2012-07-26','2012-08-10','2012-08-01','2012-08-15', 8,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-MB','Aug 16-Aug 31,2012'     ,4,'2012-08-11','2012-08-25','2012-08-16','2012-08-31', 8,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-09-MA','Sep 01-Sep 15,2012'     ,4,'2012-08-26','2012-09-10','2012-09-01','2012-09-15', 9,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-09-MB','Sep 16-Sep 31,2012'     ,4,'2012-09-11','2012-09-25','2012-09-16','2012-09-30', 9,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-10-MA','Oct 01-Oct 15,2012'     ,4,'2012-09-26','2012-10-10','2012-10-01','2012-10-15',10,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-10-MB','Oct 16-Oct 31,2012'     ,4,'2012-10-11','2012-10-25','2012-10-16','2012-10-31',10,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-MA','Nov 01-Nov 15,2012'     ,4,'2012-10-26','2012-11-10','2012-11-01','2012-11-15',11,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-MB','Nov 16-Nov 31,2012'     ,4,'2012-11-11','2012-11-25','2012-11-16','2012-11-30',11,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-MA','Dec 01-Dec 15,2012'     ,4,'2012-11-26','2012-12-10','2012-12-01','2012-12-15',12,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-MB','Dec 16-Dec 31,2012'     ,4,'2012-12-11','2012-12-25','2012-12-16','2012-12-31',12,2012,2,2,1,1,1,1,2,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-MC','13th Month Pay for 2012',4,'2011-02-01','2011-12-31','2012-01-01','2012-12-31',12,2012,1,1,1,1,1,1,2,0);

INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-01-W1','Jan 01-Jan 07,2012'     ,3,'2012-01-01','2012-01-07','2012-01-01','2012-01-07', 1,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-01-W2','Jan 08-Jan 14,2012'     ,3,'2012-01-08','2012-01-14','2012-01-08','2012-01-14', 1,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-01-W3','Jan 15-Jan 21,2012'     ,3,'2012-01-15','2012-01-21','2012-01-15','2012-01-21', 1,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-01-W4','Jan 22-Jan 28,2012'     ,3,'2012-01-22','2012-01-28','2012-01-22','2012-01-28', 1,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-02-W1','Jan 29-Feb 04,2012'     ,3,'2012-01-29','2012-02-04','2012-01-29','2012-02-04', 2,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-02-W2','Feb 05-Feb 11,2012'     ,3,'2012-02-05','2012-02-11','2012-02-05','2012-02-11', 2,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-02-W3','Feb 12-Feb 18,2012'     ,3,'2012-02-12','2012-02-18','2012-02-12','2012-02-18', 2,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-02-W4','Feb 19-Feb 25,2012'     ,3,'2012-02-19','2012-02-25','2012-02-19','2012-02-25', 2,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-W1','Feb 26-Mar 03,2012'     ,3,'2012-02-26','2012-03-03','2012-02-26','2012-03-03', 3,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-W2','Mar 04-Mar 10,2012'     ,3,'2012-03-04','2012-03-10','2012-03-04','2012-03-10', 3,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-W3','Mar 11-Mar 17,2012'     ,3,'2012-03-11','2012-03-17','2012-03-11','2012-03-17', 3,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-W4','Mar 18-Mar 24,2012'     ,3,'2012-03-18','2012-03-24','2012-03-18','2012-03-24', 3,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-03-W5','Mar 25-Mar 31,2012'     ,3,'2012-03-25','2012-03-31','2012-03-25','2012-03-31', 3,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-04-W1','Apr 01-Apr 07,2012'     ,3,'2012-04-01','2012-04-07','2012-04-01','2012-04-07', 4,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-04-W2','Apr 08-Apr 14,2012'     ,3,'2012-04-08','2012-04-14','2012-04-08','2012-04-14', 4,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-04-W3','Apr 15-Apr 21,2012'     ,3,'2012-04-15','2012-04-21','2012-04-15','2012-04-21', 4,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-04-W4','Apr 22-Apr 28,2012'     ,3,'2012-04-22','2012-04-28','2012-04-22','2012-04-28', 4,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-W1','Apr 29-May 05,2012'     ,3,'2012-04-29','2012-05-05','2012-04-29','2012-05-05', 5,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-W2','May 06-May 12,2012'     ,3,'2012-05-06','2012-05-12','2012-05-06','2012-05-12', 5,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-W3','May 13-May 19,2012'     ,3,'2012-05-13','2012-05-19','2012-05-13','2012-05-19', 5,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-W4','May 20-May 26,2012'     ,3,'2012-05-20','2012-05-26','2012-05-20','2012-05-26', 5,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-05-W5','May 27-Jun 02,2012'     ,3,'2012-05-27','2012-06-02','2012-05-27','2012-06-02', 5,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-06-W1','Jun 03-Jun 09,2012'     ,3,'2012-06-03','2012-06-09','2012-06-03','2012-06-09', 6,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-06-W2','Jun 10-Jun 16,2012'     ,3,'2012-06-10','2012-06-16','2012-06-10','2012-06-16', 6,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-06-W3','Jun 17-Jun 23,2012'     ,3,'2012-06-17','2012-06-23','2012-06-17','2012-06-23', 6,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-06-W4','Jun 24-Jun 30,2012'     ,3,'2012-06-24','2012-06-30','2012-06-24','2012-06-30', 6,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-07-W1','Jul 01-Jul 07,2012'     ,3,'2012-07-01','2012-07-07','2012-07-01','2012-07-07', 7,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-07-W2','Jul 08-Jul 14,2012'     ,3,'2012-07-08','2012-07-14','2012-07-08','2012-07-14', 7,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-07-W3','Jul 15-Jul 21,2012'     ,3,'2012-07-15','2012-07-21','2012-07-15','2012-07-21', 7,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-07-W4','Jul 22-Jul 28,2012'     ,3,'2012-07-22','2012-07-28','2012-07-22','2012-07-28', 7,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-W1','Jul 29-Aug 04,2012'     ,3,'2012-07-29','2012-08-04','2012-07-29','2012-08-04', 8,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-W2','Aug 05-Aug 11,2012'     ,3,'2012-08-05','2012-08-11','2012-08-05','2012-08-11', 8,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-W3','Aug 12-Aug 18,2012'     ,3,'2012-08-12','2012-08-18','2012-08-12','2012-08-18', 8,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-W4','Aug 19-Aug 25,2012'     ,3,'2012-08-19','2012-08-25','2012-08-19','2012-08-25', 8,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-08-W5','Aug 26-Sep 01,2012'     ,3,'2012-08-26','2012-09-01','2012-08-26','2012-09-01', 8,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-09-W1','Sep 02-Sep 08,2012'     ,3,'2012-09-02','2012-09-08','2012-09-02','2012-09-08', 9,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-09-W2','Sep 09-Sep 15,2012'     ,3,'2012-09-09','2012-09-15','2012-09-09','2012-09-15', 9,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-09-W3','Sep 16-Sep 22,2012'     ,3,'2012-09-16','2012-09-22','2012-09-16','2012-09-22', 9,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-09-W4','Sep 23-Sep 29,2012'     ,3,'2012-09-23','2012-09-29','2012-09-23','2012-09-29', 9,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-10-W1','Sep 30-Oct 06,2012'     ,3,'2012-09-30','2012-10-06','2012-09-30','2012-10-06',10,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-10-W2','Oct 07-Oct 13,2012'     ,3,'2012-10-07','2012-10-13','2012-10-07','2012-10-13',10,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-10-W3','Oct 14-Oct 20,2012'     ,3,'2012-10-14','2012-10-20','2012-10-14','2012-10-20',10,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-10-W4','Oct 21-Oct 27,2012'     ,3,'2012-10-21','2012-10-27','2012-10-21','2012-10-27',10,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-W1','Oct 28-Nov 03,2012'     ,3,'2012-10-28','2012-11-03','2012-10-28','2012-11-03',11,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-W2','Nov 04-Nov 10,2012'     ,3,'2012-11-04','2012-11-10','2012-11-04','2012-11-10',11,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-W3','Nov 11-Nov 17,2012'     ,3,'2012-11-11','2012-11-17','2012-11-11','2012-11-17',11,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-W4','Nov 18-Nov 24,2012'     ,3,'2012-11-18','2012-11-24','2012-11-18','2012-11-24',11,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-11-W5','Nov 25-Dec 01,2012'     ,3,'2012-11-25','2012-12-01','2012-11-25','2012-12-01',11,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-W1','Dec 02-Dec 08,2012'     ,3,'2012-12-02','2012-12-08','2012-12-02','2012-12-08',12,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-W2','Dec 09-Dec 15,2012'     ,3,'2012-12-09','2012-12-15','2012-12-09','2012-12-15',12,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-W3','Dec 16-Dec 22,2012'     ,3,'2012-12-16','2012-12-22','2012-12-16','2012-12-22',12,2012,1,2,2,2,2,2,1,1);
INSERT INTO payrollperiodtable(payrollperiod,payrolldesc,payperiodtable_id,startdate,enddate,startcoverdt,endcoverdt,fsmonth,fsyear,partno,totalparts,deductsss,deducthdmf,deductph,deductothers,deductwtax,nthmonthpay)VALUES('2012-12-W4','Dec 23-Dec 29,2012'     ,3,'2012-12-23','2012-12-29','2012-12-23','2012-12-29',12,2012,1,2,2,2,2,2,1,1);

UPDATE payrollperiodtable SET
	payperiodtable_id=4;

UPDATE payrollperiodtable SET
	nthmonthpay=0;

UPDATE payrollperiodtable SET
	deductsss=2,
	deducthdmf=2,
	deductph=2,
	deductothers=2,
	deductwtax=0
WHERE partno=1;

UPDATE payrollperiodtable SET
	deductsss=0,
	deducthdmf=0,
	deductph=0,
	deductothers=0,
	deductwtax=2
WHERE partno=2;

UPDATE payrollperiodtable SET
	deductsss=0,
	deducthdmf=0,
	deductph=0,
	deductothers=0,
	deductwtax=2,
	nthmonthpay=13
WHERE SUBSTRING(payrollperiod,-2)='-C';

UPDATE payrollperiodtable SET
	is_generated='N',
	is_closed='N';

DROP TABLE IF EXISTS payrolltrans;
CREATE TABLE IF NOT EXISTS payrolltrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10)DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
-- timerecid VARCHAR(10) NOT NULL DEFAULT '',
	workhrs DECIMAL(8,5) NOT NULL DEFAULT 0.00,
	othrs DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	latehrs DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	absentdays DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	basicpay DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	periodrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	dailyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	hourlyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	workamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	otamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	lateamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	absentamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	incomeamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	incomenotax DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	deductamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	loanamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	sssamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	hdmfamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	phamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	taxableamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	taxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	netamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	partno DECIMAL(1) NOT NULL DEFAULT 1,
	totalparts DECIMAL(1) NOT NULL DEFAULT 1,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

-- ALTER TABLE payrolltrans
-- 	DROP COLUMN timerecid;

-- ALTER TABLE payrolltrans
-- 	CHANGE COLUMN absenthrs absentdays DECIMAL(7,5) NOT NULL DEFAULT 0.00;

-- ALTER TABLE payrolltrans
-- 	CHANGE COLUMN wrkhrs workhrs DECIMAL(7,5) NOT NULL DEFAULT 0.00;

-- ALTER TABLE payrolltrans
-- 	ADD COLUMN wrkamt DECIMAL(8,2) NOT NULL DEFAULT 0.00
-- 		AFTER hourlyrate;

-- ALTER TABLE payrolltrans
-- 	CHANGE COLUMN wrkamt workamt DECIMAL(8,2) NOT NULL DEFAULT 0.00;

-- ALTER TABLE payrolltrans
-- 	ADD COLUMN incomenotax DECIMAL(8,2) NOT NULL DEFAULT 0.00
-- 		AFTER incomeamt;

-- ALTER TABLE payrolltrans
-- 	ADD COLUMN taxableamt DECIMAL(8,2) NOT NULL DEFAULT 0.00
-- 		AFTER phamt;

TRUNCATE TABLE payrolltrans;
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-01-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 1,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-01-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,9023.81,550.00, 9026.19, 1,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-02-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 2,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-02-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,8907.97,550.00, 9142.03, 2,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-03-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 3,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-03-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,8775.59,550.00, 9274.41, 3,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-04-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 4,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-04-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,8622.31,550.00, 9427.69, 4,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-05-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 5,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-05-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,8441.97,550.00, 9608.03, 5,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-06-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 6,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-06-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,8225.57,550.00, 9824.43, 6,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-07-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 7,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-07-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,7959.23,550.00,10090.77, 7,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-08-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 8,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-08-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,7620.25,550.00,10429.75, 8,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-09-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00, 9,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-09-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,7168.28,550.00,10881.72, 9,2011,2,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-10-A','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,500.00,600.00,375.00,   0.00,550.00,16575.00,10,2011,1,2);
INSERT INTO payrolltrans(payrollperiod,empid,workhrs,absentdays,latehrs,basicpay,periodrate,hourlyrate,incomeamt,absentamt,lateamt,otamt,grossamt,loanamt,sssamt,hdmfamt,phamt,taxamt,deductamt,netamt,fsmonth,fsyear,partno,totalparts)VALUES('2011-10-B','AAA888'    ,0.00,0.00,0.00,30000.00,15000.00,229.98,4000.00,0.00,0.00,0.00,19000.00,400.00,  0.00,  0.00,  0.00,6522.61,550.00,11527.39,10,2011,2,2);

DROP TABLE IF EXISTS dailytrans;
CREATE TABLE IF NOT EXISTS dailytrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	wrkref VARCHAR(11) NOT NULL DEFAULT '',
	wrkdate DATE NOT NULL DEFAULT '0000-00-00',
	wrkdesc TINYTEXT NOT NULL DEFAULT '',
	wrkhrs DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	latehrs DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	latemins TINYINT(2) NOT NULL DEFAULT 0.00,
	absentdays DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	absenthrs DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	wrkamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	lateamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	absentamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT INTO dailytrans(wrkref,wrkdesc,wrkdate,payrollperiod,empid,wrkhrs,absentdays,absenthrs,latehrs,latemins,wrkamt,absentamt,lateamt)VALUES('005Q7THU46','Hourly/Daily Time Attendance','2011-01-01','2011-01-A','1022610005',80.00,0.00,0.00,0.00,0.00,0.00,4040.00,0.00);

DROP TABLE IF EXISTS worktrans;
CREATE TABLE IF NOT EXISTS worktrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	workdate DATE NOT NULL DEFAULT '0000-00-00',
	workdesc TINYTEXT NOT NULL DEFAULT '',
	workmins SMALLINT NOT NULL DEFAULT 0,
	workhhmm VARCHAR(6) NOT NULL DEFAULT '00:00',
	workrate DECIMAL(4,2) NOT NULL DEFAULT 1,
	hourlyrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	workamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	worktype ENUM('Regular') NOT NULL DEFAULT 'Regular',
	is_manual ENUM('Y','N') NOT NULL DEFAULT 'Y',
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS latetrans;
CREATE TABLE IF NOT EXISTS latetrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	latedate DATE NOT NULL DEFAULT '0000-00-00',
	latedesc TINYTEXT NOT NULL DEFAULT '',
	latemins SMALLINT NOT NULL DEFAULT 0,
--	latedt DATETIME NOT NULL DEFAULT 0,
	latehhmm VARCHAR(6) NOT NULL DEFAULT '00:00',
	laterate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	lateamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	latetype ENUM('Late','Undertime') NOT NULL DEFAULT 'Late',
	is_manual ENUM('Y','N') NOT NULL DEFAULT 'Y',
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

-- ALTER TABLE latetrans
-- 	ADD COLUMN laterate DECIMAL(8,2) NOT NULL DEFAULT 0.00
-- 		AFTER latehhmm;

-- ALTER TABLE latetrans
-- 	CHANGE COLUMN latehhmm latehhmm VARCHAR(6) NOT NULL DEFAULT '000:00';

-- ALTER TABLE latetrans
-- 	DROP COLUMN latedt;

DROP TABLE IF EXISTS absenttrans;
CREATE TABLE IF NOT EXISTS absenttrans(
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	absentdate DATE NOT NULL DEFAULT '0000-00-00',
	absentdesc TINYTEXT NOT NULL DEFAULT '',
	absentdays DECIMAL(8,5) NOT NULL DEFAULT 0,
	absentddhhmm VARCHAR(9) NOT NULL DEFAULT '000:00:00',
	absentrate DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	absentamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	absenttype ENUM('Absent','Half-Day') NOT NULL DEFAULT 'Absent',
	is_manual ENUM('Y','N') NOT NULL DEFAULT 'Y',
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP VIEW IF EXISTS empname;
CREATE VIEW empname AS
SELECT
	e.id,
	e.empid,
	CONCAT(e.firstname,' ',e.lastname) AS fullname,
	d.deptdesc,
	e.atm_no,
	e.sss_no,
	e.hdmf_no,
	e.ph_no,
	e.tin_no
FROM employees e
LEFT JOIN depttable d
	ON d.id=e.depttable_id
ORDER BY empid;
-- SELECT * FROM empname;

DROP VIEW IF EXISTS sssreport;
CREATE VIEW sssreport AS
SELECT
	sss_id_seq() AS id,
	t.empid,
	e.sss_no,
	e.fullname,
	SUM(t.grossamt) AS grossamt,
	SUM(t.employershareamt) AS employershareamt,
	SUM(t.employerecshareamt) AS employerecshareamt,
	SUM(t.employeeshareamt) AS employeeshareamt,
	t.fsmonth,
	t.fsyear
FROM ssstrans t
LEFT JOIN empname e
	ON e.empid=t.empid
GROUP BY t.fsyear, t.fsmonth, t.empid
ORDER BY t.fsyear DESC, t.fsmonth DESC, t.empid;

DROP VIEW IF EXISTS hdmfreport;
CREATE VIEW hdmfreport AS
SELECT
	hdmf_id_seq() AS id,
	t.empid,
	e.hdmf_no,
	e.fullname,
	SUM(t.grossamt) AS grossamt,
	SUM(t.employershareamt) AS employershareamt,
	SUM(t.employeeshareamt) AS employeeshareamt,
	t.fsmonth,
	t.fsyear
FROM hdmftrans t
LEFT JOIN empname e
	ON e.empid=t.empid
GROUP BY t.fsyear, t.fsmonth, t.empid
ORDER BY t.fsyear DESC, t.fsmonth DESC, t.empid;

DROP VIEW IF EXISTS phreport;
CREATE VIEW phreport AS
SELECT
	ph_id_seq() AS id,
	t.empid,
	e.ph_no,
	e.fullname,
	SUM(t.grossamt) AS grossamt,
	SUM(t.employershareamt) AS employershareamt,
	SUM(t.employeeshareamt) AS employeeshareamt,
	t.fsmonth,
	t.fsyear
FROM phtrans t
LEFT JOIN empname e
	ON e.empid=t.empid
GROUP BY t.fsyear, t.fsmonth, t.empid
ORDER BY t.fsyear DESC, t.fsmonth DESC, t.empid;

DROP VIEW IF EXISTS taxreport;
CREATE VIEW taxreport AS
SELECT
	tax_id_seq() AS id,
	t.empid,
	e.tin_no,
	e.fullname,
	t.taxstatuscode,
	t.payperiod,
	SUM(t.grossamt) AS grossamt,
	SUM(t.taxamt) AS taxamt,
	t.fsmonth,
	t.fsyear
FROM taxtrans t
LEFT JOIN empname e
	ON e.empid=t.empid
GROUP BY t.fsyear, t.fsmonth, t.empid
ORDER BY t.fsyear DESC, t.fsmonth DESC, t.empid;

DROP VIEW IF EXISTS emplist;
DROP VIEW IF EXISTS employeelist;
CREATE VIEW employeelist AS
SELECT
	id,
	empid,
	CONCAT('(',empid,') ',firstname,' ',lastname) AS empname
FROM employees
ORDER BY empid;

DROP VIEW IF EXISTS payrollperiodlist;
CREATE VIEW payrollperiodlist AS
SELECT
	id,
	payrollperiod,
	CONCAT('(',payrollperiod,') ',payrolldesc) AS payrollperioddesc
FROM payrollperiodtable
ORDER BY payrollperiod;

DROP VIEW IF EXISTS atmlist;
DROP VIEW IF EXISTS payrollatmlist;
CREATE VIEW payrollatmlist AS
SELECT
	atm_id_seq() AS id,
--	p.id,
	p.payrollperiod,
	p.fsmonth,
	p.fsyear,
	e.empid,
	e.fullname,
	e.atm_no,
	p.netamt
FROM empname e
LEFT JOIN payrolltrans p
ON p.empid=e.empid
WHERE TRIM(e.atm_no)<>''
-- HAVING payrollperiod IS NOT NULL
AND p.payrollperiod IS NOT NULL
ORDER BY p.fsyear DESC,p.fsmonth DESC,p.payrollperiod DESC,e.empid;
-- SELECT * FROM payrollatmlist;
SELECT * FROM payrollatmlist;

DROP VIEW IF EXISTS otclist;
DROP VIEW IF EXISTS payrollotclist;
CREATE VIEW payrollotclist AS
SELECT
	otc_id_seq() AS id,
--	p.id,
	p.payrollperiod,
	p.fsmonth,
	p.fsyear,
	e.empid,
	e.fullname,
	p.netamt
FROM empname e
LEFT JOIN payrolltrans p
ON p.empid=e.empid
WHERE TRIM(e.atm_no)=''
-- HAVING payrollperiod IS NOT NULL
AND p.payrollperiod IS NOT NULL
ORDER BY p.fsyear DESC,p.fsmonth DESC,p.payrollperiod DESC,e.empid;
-- SELECT * FROM payrollotclist;
SELECT * FROM payrollotclist;

DROP VIEW IF EXISTS ytdlist;
DROP VIEW IF EXISTS payrollytdlist;
CREATE VIEW payrollytdlist AS
SELECT
	p.id,
	e.empid,
	e.fullname,
	SUM(p.workamt) AS workamt,
	SUM(p.otamt) AS otamt,
	SUM(p.lateamt) AS lateamt,
	SUM(p.absentamt) AS absentamt,
	SUM(p.incomeamt) AS incomeamt,
	SUM(p.incomenotax) AS incomenotax,
	SUM(p.deductamt) AS deductamt,
	SUM(p.loanamt) AS loanamt,
	SUM(p.sssamt) AS sssamt,
	SUM(p.hdmfamt) AS hdmfamt,
	SUM(p.phamt) AS phamt,
	SUM(p.taxableamt) AS taxableamt,
	SUM(p.taxamt) AS taxamt,
	SUM(p.grossamt) AS grossamt,
	SUM(p.netamt) AS netamt,
	p.fsyear
FROM empname e
LEFT JOIN payrolltrans p
ON p.empid=e.empid
GROUP BY p.fsyear,e.empid
ORDER BY p.fsyear DESC,e.empid;
-- SELECT * FROM payrollytdlist;

DROP TABLE IF EXISTS taxytdlist;
DROP TABLE IF EXISTS taxytdfile;
CREATE TABLE IF NOT EXISTS taxytdfile(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	tin_no VARCHAR(15) NOT NULL,
	taxstatuscode ENUM('Z','S','ME','S1','S2','S3','S4','ME1','ME2','ME3','ME4') NOT NULL DEFAULT 'S',
	payperiod ENUM('Daily','Weekly','Semi-Monthly','Monthly','Annual') NOT NULL DEFAULT 'Semi-Monthly',
	paydays DECIMAL(3) NOT NULL DEFAULT 0,
	dependents TINYINT(1) NOT NULL DEFAULT 0,
	exemption DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	grossamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	taxamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	refundamt DECIMAL(8,2) NOT NULL DEFAULT 0.00,
	paycount DECIMAL(3) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;
-- SELECT * FROM taxytdfile;

DROP VIEW IF EXISTS taxytdlist;
CREATE VIEW taxytdlist AS
SELECT
	e.empid,
	e.id AS employees_id,
	e.tin_no,
	s.taxstatuscode,
	p.payperiod,
	p.paydays,
	s.totalexemption AS exemption,
	s.dependents,
	SUM(f.grossamt) AS grossamt,
	SUM(f.taxamt) AS taxamt,
	f.fsyear
FROM employees e
LEFT JOIN taxstatustable s
ON s.id=e.taxstatustable_id
LEFT JOIN payperiodtable p
ON p.id=e.payperiodtable_id
LEFT JOIN taxtrans f
ON f.empid=e.empid
GROUP BY f.fsyear,e.empid;

TRUNCATE TABLE taxytdfile;
INSERT INTO taxytdfile
(empid,employees_id,tin_no,taxstatuscode,payperiod,paydays,exemption,dependents,grossamt,taxamt,fsyear)
SELECT
empid,employees_id,tin_no,taxstatuscode,payperiod,paydays,exemption,dependents,grossamt,taxamt,fsyear
FROM taxytdlist;

UPDATE dailytrans   x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE deductfile   x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE deducttrans  x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE hdmffile     x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE hdmftrans    x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE incomefile   x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE incometrans  x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE loanfile     x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE loantrans    x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE otfile       x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE ottrans      x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE payrolltrans x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE phfile       x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE phtrans      x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE sssfile      x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE ssstrans     x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;
UPDATE taxtrans     x, employees e SET x.employees_id=e.id WHERE x.empid=e.empid;



DROP TABLE IF EXISTS filestore_file;
CREATE TABLE IF NOT EXISTS filestore_file(
	id INT NOT NULL AUTO_INCREMENT,
	filenum INT NOT NULL DEFAULT 0,
	original_filename TINYTEXT NOT NULL DEFAULT '',
	filename TINYTEXT NOT NULL DEFAULT '',
	filesize INT NOT NULL DEFAULT 0,
	storedate DATETIME NOT NULL,
	deleted ENUM('Y','N') NOT NULL DEFAULT 'N',
	filestore_type_id INT NOT NULL DEFAULT 0,
	filestore_volume_id INT NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

-- TRUNCATE TABLE filestore_file;
-- ALTER TABLE filestore_file
-- 	DROP COLUMN storedate,
-- 	ADD COLUMN storedate DATETIME NOT NULL
-- 		AFTER filesize;
-- UPDATE filestore_file SET storedate = NOW();

DROP TABLE IF EXISTS filestore_type;
CREATE TABLE IF NOT EXISTS filestore_type(
	id INT NOT NULL AUTO_INCREMENT,
	name TINYTEXT NOT NULL DEFAULT '',
	mime_type VARCHAR(64) NOT NULL DEFAULT '',
	extension VARCHAR(5) NOT NULL DEFAULT '',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS filestore_volume;
CREATE TABLE IF NOT EXISTS filestore_volume(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(32) NOT NULL DEFAULT '',
	dirname TINYTEXT NOT NULL DEFAULT '',
	total_space INT NOT NULL DEFAULT 0,
	used_space INT NOT NULL DEFAULT 0,
	stored_files_cnt SMALLINT NOT NULL DEFAULT 0,
	enabled ENUM('Y','N') DEFAULT 'Y',
	last_filenum INT DEFAULT NULL,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS filestore_image;
CREATE TABLE IF NOT EXISTS filestore_image(
	id INT NOT NULL AUTO_INCREMENT,
	name TINYTEXT NOT NULL DEFAULT '',
	original_file_id INT NOT NULL DEFAULT 0,
	thumb_file_id INT NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE filestore_type;
INSERT INTO filestore_type (mime_type,extension) VALUES ('image/jpeg','jpg');
INSERT INTO filestore_type (mime_type,extension) VALUES ('image/jpeg','jpeg');
INSERT INTO filestore_type (mime_type,extension) VALUES ('image/gif','gif');
INSERT INTO filestore_type (mime_type,extension) VALUES ('image/png','png');
INSERT INTO filestore_type (mime_type,extension) VALUES ('text/plain','txt');
INSERT INTO filestore_type (mime_type,extension) VALUES ('text/rtf','rtf');
INSERT INTO filestore_type (mime_type,extension) VALUES ('text/html','html');
INSERT INTO filestore_type (mime_type,extension) VALUES ('application/vnd.ms-office','doc');
INSERT INTO filestore_type (mime_type,extension) VALUES ('application/pdf','pdf');
INSERT INTO filestore_type (mime_type,extension) VALUES ('application/vnd.oasis.opendocument.text','odt');

TRUNCATE TABLE filestore_volume;
INSERT INTO filestore_volume (name,dirname,total_space)VALUES('upload','/home/~mariorey/projects/atk4/redtree/upload/',1024*1024*1024);

TRUNCATE TABLE filestore_file;
UPDATE filestore_volume SET stored_files_cnt=0;






DROP VIEW IF EXISTS ottablelist;
CREATE VIEW ottablelist AS
SELECT
	id,
	CONCAT(otdesc,' (x',otrate,')') AS otdesc,
	otrate
FROM ottable;

DROP VIEW IF EXISTS incomefilelist;
CREATE VIEW incomefilelist AS
SELECT
	f.id,
	f.empid,
	f.filedate,
	f.payamt,
	f.startdate,
	f.is_active,
	t.frequency,
	t.is_taxable
FROM incomefile f
LEFT JOIN incometable t
	ON t.id=f.incometable_id
ORDER BY f.empid;

DROP VIEW IF EXISTS incometranslist;
CREATE VIEW incometranslist AS
SELECT
	x.id,
	x.payrollperiod,
	x.empid,
	x.employees_id,
	x.payamt,
	f.filedate,
	f.startdate,
	f.is_active,
	t.frequency,
	t.is_taxable
FROM incometrans x
LEFT JOIN incomefile f
	ON f.id=x.incomefile_id
LEFT JOIN incometable t
	ON t.id=f.incometable_id
ORDER BY x.payrollperiod,x.empid;











DROP TABLE IF EXISTS shifttable;
CREATE TABLE IF NOT EXISTS shifttable(
	id TINYINT NOT NULL AUTO_INCREMENT,
--	shiftid VARCHAR(25) NOT NULL DEFAULT '',
	shiftdesc TINYTEXT NOT NULL DEFAULT '',
	depttable_id TINYINT(2) NOT NULL DEFAULT 0,
	day1hhmm VARCHAR(5)  DEFAULT '00:00',
	day1work VARCHAR(12) DEFAULT '8',
	day1dt   MEDIUMINT   DEFAULT 28800,
	day1mins SMALLINT    DEFAULT 480,
	day2hhmm VARCHAR(5)  DEFAULT '00:00',
	day2work VARCHAR(12) DEFAULT '8',
	day2dt   MEDIUMINT   DEFAULT 28800,
	day2mins SMALLINT    DEFAULT 480,
	day3hhmm VARCHAR(5)  DEFAULT '00:00',
	day3work VARCHAR(12) DEFAULT '8',
	day3dt   MEDIUMINT   DEFAULT 28800,
	day3mins SMALLINT    DEFAULT 480,
	day4hhmm VARCHAR(5)  DEFAULT '00:00',
	day4work VARCHAR(12) DEFAULT '8',
	day4dt   MEDIUMINT   DEFAULT 28800,
	day4mins SMALLINT    DEFAULT 480,
	day5hhmm VARCHAR(5)  DEFAULT '00:00',
	day5work VARCHAR(12) DEFAULT '8',
	day5dt   MEDIUMINT   DEFAULT 28800,
	day5mins SMALLINT    DEFAULT 480,
	day6hhmm VARCHAR(5)  DEFAULT '00:00',
	day6work VARCHAR(12) DEFAULT '8',
	day6dt   MEDIUMINT   DEFAULT 28800,
	day6mins SMALLINT    DEFAULT 480,
	day7hhmm VARCHAR(5)  DEFAULT '00:00',
	day7work VARCHAR(12) DEFAULT '8',
	day7dt   MEDIUMINT   DEFAULT 28800,
	day7mins SMALLINT    DEFAULT 480,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

-- ALTER TABLE shifttable
-- 	ADD COLUMN depttable_id TINYINT(2) DEFAULT NULL
-- 		AFTER shiftdesc;

-- ALTER TABLE shifttable
-- 	CHANGE COLUMN depttable_id depttable_id TINYINT(2) NOT NULL DEFAULT 0;

TRUNCATE TABLE shifttable;
INSERT INTO shifttable(shiftdesc,day1hhmm,day1work,day1dt,day1mins,day2hhmm,day2work,day2dt,day2mins,day3hhmm,day3work,day3dt,day3mins,day4hhmm,day4work,day4dt,day4mins,day5hhmm,day5work,day5dt,day5mins,day6hhmm,day6work,day6dt,day6mins,day7hhmm,day7work,day7dt,day7mins)VALUES('Regular Day Shift - 7am to 4pm - Monday to Friday'   ,NULL,NULL,NULL,NULL,'07:00','9hrs',25200,540,'07:00','9hrs',25200,540,'07:00','9hrs',25200,540,'07:00','9hrs',25200,540,'07:00','9hrs',25200,540,NULL,NULL,NULL,NULL);
INSERT INTO shifttable(shiftdesc,day1hhmm,day1work,day1dt,day1mins,day2hhmm,day2work,day2dt,day2mins,day3hhmm,day3work,day3dt,day3mins,day4hhmm,day4work,day4dt,day4mins,day5hhmm,day5work,day5dt,day5mins,day6hhmm,day6work,day6dt,day6mins,day7hhmm,day7work,day7dt,day7mins)VALUES('Regular Night Shift - 10pm to 6am - Monday to Friday',NULL,NULL,NULL,NULL,'10pm' ,'8hrs',79200,480,'10pm' ,'8hrs',79200,480,'10pm' ,'8hrs',79200,480,'10pm' ,'8hrs',79200,480,'10pm' ,'8hrs',79200,480,NULL,NULL,NULL,NULL);

DROP TABLE IF EXISTS shiftfile;
CREATE TABLE IF NOT EXISTS shiftfile(
	id SMALLINT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	shifttable_id TINYINT NOT NULL DEFAULT 0,
	startdate DATE NOT NULL DEFAULT '0000-00-00',
	enddate DATE NOT NULL DEFAULT '0000-00-00',
	restdays VARCHAR(6) NOT NULL DEFAULT '',
	is_generated ENUM('Y','N') NOT NULL DEFAULT 'N',
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

ALTER TABLE shiftfile
	ADD COLUMN restdays VARCHAR(6) NOT NULL DEFAULT ''
		AFTER enddate;

TRUNCATE TABLE shiftfile;
INSERT INTO shiftfile(empid,employees_id,shifttable_id,startdate,enddate,is_generated)VALUES('AAA888',1,1,'2010-12-26','2011-01-10','N');
INSERT INTO shiftfile(empid,employees_id,shifttable_id,startdate,enddate,is_generated)VALUES('AAA888',1,2,'2011-01-11','2011-01-25','N');

DROP TABLE IF EXISTS shifttrans;
CREATE TABLE IF NOT EXISTS shifttrans (
	id INT NOT NULL AUTO_INCREMENT,
	payrollperiod VARCHAR(10) NOT NULL DEFAULT '',
	empid varchar(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	timerecid DECIMAL(5) NOT NULL DEFAULT 0,
	shiftfile_id SMALLINT NOT NULL DEFAULT 0,
	shifttable_id SMALLINT NOT NULL DEFAULT 0,
	shiftdate DATE NOT NULL DEFAULT '0000-00-00',
	startshift INT NOT NULL DEFAULT 0,
	endshift INT NOT NULL DEFAULT 0,
--	latemins SMALLINT NOT NULL DEFAULT 0,
--	is_latebreak ENUM('Y','N') NOT NULL DEFAULT 'N',
--	is_undertime ENUM('Y','N') NOT NULL DEFAULT 'N',
--	is_absent ENUM('Y','N') NOT NULL DEFAULT 'N',
	shifttype ENUM('Regular Shift','Special Shift','No Schedule')
		NOT NULL DEFAULT 'Regular Shift',
--	shiftstatus ENUM('Unprocessed','Present','Absent','Authorized','Unauthorized','Exception')
--		NOT NULL DEFAULT 'Unprocessed',
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE shifttrans;

UPDATE shiftfile SET is_generated = 'N';

DROP VIEW IF EXISTS shiftfilelist;
CREATE VIEW shiftfilelist AS
SELECT
	f.id,
	f.payrollperiod,
	f.empid,
	f.employees_id,
	f.startdate,
	f.enddate,
	f.restdays,
	f.is_generated,
	f.shifttable_id,
	t.shiftdesc,
	t.day1hhmm,t.day1work,t.day1dt,t.day1mins,
	t.day2hhmm,t.day2work,t.day2dt,t.day2mins,
	t.day3hhmm,t.day3work,t.day3dt,t.day3mins,
	t.day4hhmm,t.day4work,t.day4dt,t.day4mins,
	t.day5hhmm,t.day5work,t.day5dt,t.day5mins,
	t.day6hhmm,t.day6work,t.day6dt,t.day6mins,
	t.day7hhmm,t.day7work,t.day7dt,t.day7mins
FROM shiftfile f
LEFT JOIN shifttable t
ON t.id=f.shifttable_id;
-- SELECT * FROM shiftfilelist;

DROP VIEW IF EXISTS empshiftlist;
CREATE VIEW empshiftlist AS
SELECT
	e.id,
	e.empid,
	e.fullname,
	f.shiftdesc,
	f.startdate,
	f.enddate,
	f.restdays,
	f.id AS shiftfile_id,
	f.shifttable_id
FROM empname e
LEFT JOIN shiftfilelist f
ON f.empid=e.empid;
-- SELECT * FROM empshiftlist;

DROP VIEW IF EXISTS shifttranslist;
CREATE VIEW shifttranslist AS
SELECT
	x.id,
	x.empid,
	x.employees_id,
	x.timerecid,
	x.shiftdate,
	f.shiftdesc,
	IF(x.startshift,
		FROM_UNIXTIME(x.startshift),
			NULL) AS timein,
	IF(x.endshift,
		FROM_UNIXTIME(x.endshift),
			NULL) AS timeout,
	x.startshift,
	x.endshift,
	x.shifttype
FROM shifttrans x
LEFT JOIN shiftfilelist f
ON f.id=x.shiftfile_id
ORDER BY x.empid,x.shiftdate,x.startshift,x.endshift;
-- SELECT * FROM shifttranslist;








-- SELECT empid,shiftdate,
-- 	FROM_UNIXTIME(startshift),
-- 	FROM_UNIXTIME(endshift),
-- 	startshift,endshift
-- 		FROM shifttrans;

















-- DROP TABLE IF EXISTS timerecfile;
-- CREATE TABLE IF NOT EXISTS timerecfile (
-- 	id INT NOT NULL AUTO_INCREMENT,
-- 	empid VARCHAR(10) NOT NULL DEFAULT '',
-- 	employees_id SMALLINT NOT NULL DEFAULT 0,
-- 	timerecid DECIMAL(5) NOT NULL DEFAULT 0,
-- 	timerecdt DATE NOT NULL DEFAULT '0000-00-00',
-- 	workmins SMALLINT NOT NULL DEFAULT 0,
-- 	latemins SMALLINT NOT NULL DEFAULT 0,
-- 	breakmins SMALLINT NOT NULL DEFAULT 0,
-- 	latebrkmins SMALLINT NOT NULL DEFAULT 0,
-- 	undertimemins SMALLINT NOT NULL DEFAULT 0,
-- 	otmins SMALLINT NOT NULL DEFAULT 0,
-- 	is_absent ENUM('Y','N') NOT NULL DEFAULT 'N',
-- 	is_onleave ENUM('Y','N') NOT NULL DEFAULT 'N',
-- 	is_exception ENUM('Y','N') NOT NULL DEFAULT 'N',
-- 	shifttrans_id INT NOT NULL DEFAULT 0,
-- 	PRIMARY KEY (id)
-- ) DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS timerecfile;
DROP TABLE IF EXISTS timereccalc;
CREATE TABLE IF NOT EXISTS timereccalc (
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	timerecid DECIMAL(5) NOT NULL DEFAULT 0,
	timerecdt DATE NOT NULL DEFAULT '0000-00-00',
	calcmins SMALLINT NOT NULL DEFAULT 0,
	calchrs DECIMAL(7,5) NOT NULL DEFAULT 0.00,
	calctag TINYINT NOT NULL DEFAULT 0,
	timerectrans_id INT NOT NULL DEFAULT 0,
	shifttrans_id INT NOT NULL DEFAULT 0,
	shiftfile_id INT NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

--- ALTER TABLE timerecfile
--- 	ADD COLUMN is_exception ENUM('Y','N') NOT NULL DEFAULT 'N'
--- 		AFTER is_absent;

TRUNCATE TABLE timerecfile;

DROP TABLE IF EXISTS timerectrans;
CREATE TABLE IF NOT EXISTS timerectrans (
	id INT NOT NULL AUTO_INCREMENT,
--	batch SMALLINT NOT NULL DEFAULT 0,
	empid VARCHAR(10) NOT NULL DEFAULT '',
-- wrkdate DATE NOT NULL DEFAULT '0000-00-00',
--	grpid TINYINT(1) NOT NULL DEFAULT 0,
--	seqid TINYINT(2) NOT NULL DEFAULT 0,
	timerecid DECIMAL(5) NOT NULL DEFAULT 0,
	timerecdt VARCHAR(19) NOT NULL DEFAULT '0000-00-00 00:00:00',
--	dtstamp DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
	dtstamp INT NOT NULL DEFAULT 0,
	entry TINYTEXT NOT NULL,
	chksum INT UNSIGNED NOT NULL DEFAULT 0,
--	trecstatus ENUM('Invalid','Exception','In','Out') DEFAULT NULL,
	shifttrans_id INT NOT NULL DEFAULT 0,
--	timerectype ENUM('None','In','Out','Ignore','Break','Lunch') NOT NULL DEFAULT 'None',
	trgroup TINYINT(2) NOT NULL DEFAULT 0,
	trstatus TINYINT NOT NULL DEFAULT 0,
	is_processed ENUM('Y','N') NOT NULL DEFAULT 'N',
	PRIMARY KEY (id),
	UNIQUE KEY chksum (chksum)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE timerectrans;

DROP VIEW IF EXISTS timerectranslist;
CREATE VIEW timerectranslist AS
SELECT
	x.id,x.empid,e.id AS employees_id,
	x.timerecid,x.timerecdt,
	FROM_UNIXTIME(x.dtstamp) AS timeentry,
	t.shiftdate,
	FROM_UNIXTIME(t.startshift) AS timein,
	FROM_UNIXTIME(t.endshift) AS timeout,
	x.trgroup,x.is_processed,x.shifttrans_id
FROM timerectrans x
LEFT JOIN shifttrans t
ON t.id=x.shifttrans_id
LEFT JOIN empname e
ON e.empid=x.empid
ORDER BY x.timerecid, x.timerecdt
;
-- SELECT * FROM timerectranslist;

DROP TABLE IF EXISTS timetrans;
CREATE TABLE IF NOT EXISTS timetrans (
	id int(11) NOT NULL AUTO_INCREMENT,
	payrollperiod varchar(10) NOT NULL DEFAULT '',
	empid varchar(10) NOT NULL DEFAULT '',
	shifttable_id smallint(6) NOT NULL DEFAULT '0',
	wrkdate date NOT NULL DEFAULT '0000-00-00',
	wrkhrs decimal(7,5) NOT NULL DEFAULT '0.00000',
	hrsworked tinyint(1) NOT NULL DEFAULT '0',
	is_crossover tinyint(1) NOT NULL DEFAULT '0',
	fsmonth decimal(2,0) NOT NULL DEFAULT '0',
	fsyear YEAR(4,0) NOT NULL DEFAULT '0',
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

















DROP VIEW IF EXISTS emptaxlist;
CREATE VIEW emptaxlist AS
SELECTÁ
	x.id,
	x.empid,
	t.taxstatuscode,
	p.payperiod
FROM employees x
LEFT JOIN taxstatustable t
	ON t.id=x.taxstatustable_id
LEFT JOIN payperiodtable p
	ON p.id=x.payperiodtable_id;
-- SELECT * FROM emptaxlist;















DROP TABLE IF EXISTS overrides;
CREATE TABLE IF NOT EXISTS overrides(
	id INT NOT NULL AUTO_INCREMENT,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	ssstable_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	phtable_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	hdmftable_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	taxtable_id TINYINT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

TRUNCATE TABLE overrides;

DROP VIEW IF EXISTS sssoverride;
CREATE VIEW sssoverride AS
SELECT
	e.id,
	e.empid,
	e.fullname,
	e.sss_no,
	t.rangefrom,
	t.rangeto,
	t.salarycredit,
	t.employershareamt,
	t.employerecshareamt,
	t.employeeshareamt,
	IF(o.ssstable_id,'Y','N') AS is_override
FROM empname e
LEFT JOIN overrides o
	ON o.empid=e.empid
LEFT JOIN ssstable t
	ON t.id=o.ssstable_id
ORDER BY o.empid, e.empid;

DROP VIEW IF EXISTS hdmfoverride;
CREATE VIEW hdmfoverride AS
SELECT
	e.id,
	e.empid,
	e.fullname,
	e.hdmf_no,
	t.rangefrom,
	t.rangeto,
	t.employersharetype,
	t.employershareamt,
	t.employeesharetype,
	t.employeeshareamt,
	IF(o.hdmftable_id,'Y','N') AS is_override
FROM empname e
LEFT JOIN overrides o
	ON o.empid=e.empid
LEFT JOIN hdmftable t
	ON t.id=o.hdmftable_id
ORDER BY o.empid, e.empid;

DROP VIEW IF EXISTS phoverride;
CREATE VIEW phoverride AS
SELECT
	e.id,
	e.empid,
	e.fullname,
	e.ph_no,
	t.rangefrom,
	t.rangeto,
	t.salarycredit,
	t.employershareamt,
	t.employeeshareamt,
	IF(o.phtable_id,'Y','N') AS is_override
FROM empname e
LEFT JOIN overrides o
	ON o.empid=e.empid
LEFT JOIN phtable t
	ON t.id=o.phtable_id
ORDER BY o.empid, e.empid;

DROP VIEW IF EXISTS taxoverride;
CREATE VIEW taxoverride AS
SELECT
	e.id,
	e.empid,
	e.fullname,
	e.tin_no,
	t.taxstatuscode,
	t.payperiod,
	t.rangefrom,
	t.rangeto,
	t.exemption,
	t.dependents,
	t.fixedtaxableamt,
	t.fixedtaxamt,
	t.percentofexcessamt,
	IF(o.taxtable_id,'Y','N') AS is_override
FROM empname e
LEFT JOIN overrides o
	ON o.empid=e.empid
LEFT JOIN taxtable t
	ON t.id=o.taxtable_id
ORDER BY o.empid, e.empid;








































DROP VIEW IF EXISTS sssfilelist;
CREATE VIEW sssfilelist AS
SELECT
	sss_id_seq() AS id,
	f.empid,
	e.sss_no,
	e.fullname,
	f.grossamt,
	f.employershareamt,
	f.employerecshareamt,
	f.employeeshareamt,
	f.totalamt,
	f.fsmonth,
	f.fsyear
FROM sssfile f
LEFT JOIN empname e
	ON e.empid=f.empid
GROUP BY f.fsyear, f.fsmonth, f.empid
ORDER BY f.fsyear DESC, f.fsmonth DESC, f.empid;

DROP VIEW IF EXISTS hdmffilelist;
CREATE VIEW hdmffilelist AS
SELECT
	hdmf_id_seq() AS id,
	f.empid,
	e.hdmf_no,
	e.fullname,
	f.grossamt,
	f.employershareamt,
	f.employeeshareamt,
	f.totalamt,
	f.fsmonth,
	f.fsyear
FROM hdmffile f
LEFT JOIN empname e
	ON e.empid=f.empid
GROUP BY f.fsyear, f.fsmonth, f.empid
ORDER BY f.fsyear DESC, f.fsmonth DESC, f.empid;

DROP VIEW IF EXISTS phfilelist;
CREATE VIEW phfilelist AS
SELECT
	ph_id_seq() AS id,
	f.empid,
	e.ph_no,
	e.fullname,
	f.grossamt,
	f.employershareamt,
	f.employeeshareamt,
	f.totalamt,
	f.fsmonth,
	f.fsyear
FROM phfile f
LEFT JOIN empname e
	ON e.empid=f.empid
GROUP BY f.fsyear, f.fsmonth, f.empid
ORDER BY f.fsyear DESC, f.fsmonth DESC, f.empid;

DROP VIEW IF EXISTS taxfilelist;
CREATE VIEW taxfilelist AS
SELECT
	tax_id_seq() AS id,
	f.empid,
	e.tin_no,
	e.fullname,
	f.taxstatuscode,
	f.payperiod,
	f.grossamt,
	f.taxamt,
	f.fsmonth,
	f.fsyear
FROM taxfile f
LEFT JOIN empname e
	ON e.empid=f.empid
GROUP BY f.fsyear, f.fsmonth, f.empid
ORDER BY f.fsyear DESC, f.fsmonth DESC, f.empid;













DROP VIEW IF EXISTS payrollreport;
CREATE VIEW payrollreport AS
SELECT
	t.payrollperiod,
	t.empid,
	e.fullname,
	t.workamt,
	t.otamt,
	t.lateamt,
	t.absentamt,
	t.incomeamt,
	t.incomenotax,
	t.deductamt,
	t.loanamt,
	t.sssamt,
	t.hdmfamt,
	t.phamt,
	t.taxableamt,
	t.taxamt,
	t.grossamt,
	t.netamt,
	t.partno,
	t.totalparts,
	t.fsmonth,
	t.fsyear
FROM payrolltrans t
LEFT JOIN empname e
	ON e.empid=t.empid
GROUP BY t.fsyear, t.fsmonth, t.empid
ORDER BY t.fsyear DESC, t.fsmonth DESC, t.payrollperiod DESC, t.empid;
















DROP TABLE IF EXISTS calendar;
CREATE TABLE IF NOT EXISTS calendar(
	id INT NOT NULL AUTO_INCREMENT,
	rangefrom DATE NOT NULL DEFAULT '0000-00-00',
	rangeto DATE NOT NULL DEFAULT '0000-00-00',
--	caldate DATE NOT NULL DEFAULT '0000-00-00',
	caldesc TINYTEXT NOT NULL DEFAULT '',
--	calgrp TINYINT NOT NULL DEFAULT 0,
--	calrate DECIMAL(4,2) NOT NULL DEFAULT 1,
	regrate DECIMAL(4,2) NOT NULL DEFAULT 1,
	otrate DECIMAL(4,2) NOT NULL DEFAULT 1,
--	caltype TINYINT NOT NULL DEFAULT 0,
--	ottable_id TINYINT NOT NULL DEFAULT 0,
	fsmonth DECIMAL(2) NOT NULL DEFAULT 0,
	fsyear YEAR(4) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

DROP VIEW IF EXISTS calendarlist;
CREATE VIEW calendarlist AS
SELECT
	t.id,
	t.rangefrom,
	t.rangeto,
	DATEDIFF(t.rangeto,t.rangefrom)+1 AS noofdays,
	t.caldesc,
	t.regrate,
	t.otrate,
	t.fsmonth,
	t.fsyear
FROM calendar t
ORDER BY t.fsyear,t.fsmonth,t.rangefrom,t.rangeto;


DROP TABLE IF EXISTS leavetable;
CREATE TABLE IF NOT EXISTS leavetable(
	id TINYINT NOT NULL AUTO_INCREMENT,
	leavedesc TINYTEXT NOT NULL DEFAULT '',
	earnamt DECIMAL(7,5) NOT NULL DEFAULT 0,
	earntype ENUM('Accumulated','Fixed') NOT NULL DEFAULT 'Fixed',
	is_convert ENUM('Y','N') NOT NULL DEFAULT 'N',
	acctcode VARCHAR(10) NULL,
	contraacct VARCHAR(10) NULL,
	normalbal ENUM('Debit','Credit') NULL,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS otfile;
CREATE TABLE IF NOT EXISTS otfile(
	id TINYINT NOT NULL AUTO_INCREMENT,
	fileref VARCHAR(10) NOT NULL DEFAULT '',
	empid VARCHAR(10) NOT NULL DEFAULT '',
	employees_id SMALLINT NOT NULL DEFAULT 0,
	filedate DATE NOT NULL DEFAULT '0000-00-00',
	ottable_id TINYINT NOT NULL DEFAULT 0,
	otdesc TINYTEXT NOT NULL DEFAULT '',
	othrs DECIMAL(7,5) NOT NULL DEFAULT 0,
	PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;
















DROP TABLE IF EXISTS request;
DROP TABLE IF EXISTS requestfile;
CREATE TABLE requestfile (
	id INT NOT NULL auto_increment,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	fullname TINYTEXT NOT NULL DEFAULT '',
	birthdate DATE NOT NULL DEFAULT '0000-00-00',
	`password` VARCHAR(25) DEFAULT NULL,
	remarks TINYTEXT,
	is_approve ENUM('Y','N') NOT NULL DEFAULT 'N',
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

INSERT INTO requestfile (id, empid, fullname, birthdate, `password`) VALUES(1, '', 'Demo User', '0000-00-00', 'demo');
INSERT INTO requestfile (id, empid, fullname, birthdate, `password`) VALUES(2, '', 'Admin User', '0000-00-00', 'admin');
INSERT INTO requestfile (id, empid, fullname, birthdate, `password`) VALUES(3, 'AAA888', 'Juan Dela Cruz', '1985-01-01', 'q1w2e3r4t5y6');



DROP TABLE IF EXISTS useraccess;
CREATE TABLE useraccess (
	id INT NOT NULL auto_increment,
	empid VARCHAR(10) NOT NULL DEFAULT '',
	userid VARCHAR(15) NOT NULL DEFAULT '',
	fullname TINYTEXT NOT NULL DEFAULT '',
	accesslist TINYTEXT NOT NULL DEFAULT '',
	`password` VARCHAR(25) DEFAULT NULL,
	is_blocked ENUM('Y','N') NOT NULL DEFAULT 'N',
	is_active ENUM('Y','N') NOT NULL DEFAULT 'N',
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


















TRUNCATE TABLE deductfile;
TRUNCATE TABLE incomefile;
TRUNCATE TABLE loanfile;

TRUNCATE TABLE dailytrans;
TRUNCATE TABLE payrolltrans;
TRUNCATE TABLE loantrans;
TRUNCATE TABLE absenttrans;
TRUNCATE TABLE latetrans;
TRUNCATE TABLE ottrans;
TRUNCATE TABLE worktrans;
TRUNCATE TABLE deducttrans;
TRUNCATE TABLE incometrans;
TRUNCATE TABLE sssfile;
TRUNCATE TABLE ssstrans;
TRUNCATE TABLE hdmffile;
TRUNCATE TABLE hdmftrans;
TRUNCATE TABLE phfile;
TRUNCATE TABLE phtrans;
TRUNCATE TABLE taxfile;
TRUNCATE TABLE taxtrans;
TRUNCATE TABLE taxtrans;










































UPDATE sssfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE ssstrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE hdmffile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE hdmftrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE phfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE phtrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE taxfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE taxtrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE loanfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE loantrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE incomefile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE incometrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE deductfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE deducttrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE otfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE ottrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE payrolltrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE dailytrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE worktrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE latetrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE absenttrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE taxytdfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE shiftfile x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE shifttrans x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';

UPDATE overrides x, employees y
	SET x.employees_id=y.id
WHERE x.empid=y.empid AND TRIM(x.empid)<>'';










































