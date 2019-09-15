/*CREATION OF TABLES*/

CREATE TABLE Player
(
  Goals NUMBER(5) NOT NULL,
  Player_ID NUMBER(5) NOT NULL,
  Nationality VARCHAR2(15) NOT NULL,
  Last_Name VARCHAR2(10) NOT NULL,
  First_Name VARCHAR2(10) NULL,
  DoB DATE NOT NULL,
  Salary NUMBER(10) NOT NULL,
  Matches NUMBER(10) NOT NULL,
  PRIMARY KEY (Player_ID)
);

CREATE TABLE Teams
(
  Team_ID NUMBER(4) NOT NULL,
  Team_Name VARCHAR2(15) NOT NULL,
  PRIMARY KEY (Team_ID, Team_Name)
);

CREATE TABLE Stadiums
(
  Country VARCHAR2(15) NOT NULL,
  Ticket_Price NUMBER(6) NOT NULL,
  Capacity NUMBER(8) NOT NULL,
  Stadium_Name VARCHAR2(20) NOT NULL,
  PRIMARY KEY (Stadium_Name)
);

CREATE TABLE Versus
(
  Team_A VARCHAR2(15) NOT NULL,
  AtID NUMBER(4) NOT NULL,
  Team_B VARCHAR2(15) NOT NULL,
  BtID NUMBER(4) NOT NULL,
  Time TIMESTAMP NOT NULL,
  MatchNo NUMBER(4) NOT NULL,
  MDate DATE NOT NULL,
  PRIMARY KEY (Team_A,MDate),
  FOREIGN KEY (AtID,Team_A) references Teams(Team_ID,Team_Name),
  FOREIGN KEY (BtID,Team_B) references Teams(Team_ID,Team_Name)
);

CREATE TABLE Visitors
(
  Last_Name NUMBER(10) NOT NULL,
  First_Name NUMBER(10) NOT NULL,
  Amount_Paid NUMBER(6) NOT NULL,
  Match_No NUMBER(10) NOT NULL,
  Date_of_match DATE NOT NULL,
  Visitor_ID NUMBER(10) NOT NULL,
  Date_of_Birth DATE NOT NULL,
  PRIMARY KEY (Visitor_ID)
);

CREATE TABLE Player_Teams_Played_for
(
  Player_ID NUMBER(5) NOT NULL,
  Teams_Played_for NUMBER(5) NOT NULL,
  PRIMARY KEY (Player_ID, Teams_Played_for),
  FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID)
);

CREATE TABLE Managers
(
  Team_ID NUMBER(5) NOT NULL,
  Team_Name VARCHAR2(15) NOT NULL, 
  MName VARCHAR2(20) NOT NULL,
  mSalary NUMBER(10) NOT NULL,
  mID NUMBER(5) NOT NULL,
  mNationality VARCHAR2(15) NOT NULL,
  mDoB DATE NOT NULL,
  PRIMARY KEY (mID,Team_ID),
  FOREIGN KEY (Team_ID,Team_Name) references Teams(Team_ID,Team_Name)
);

/*TRIGGERS*/

CREATE OR REPLACE TRIGGER upper_trigger
BEFORE INSERT OR UPDATE OF First_Name ON Player
FOR EACH ROW
BEGIN
:new.First_Name:= UPPER (:new.First_Name);
END;

CREATE  OR REPLACE TRIGGER upper_trigger2
BEFORE INSERT OR UPDATE OF Last_Name ON Player
FOR EACH ROW
BEGIN
:new.Last_Name:= UPPER (:new.Last_Name);
END;

CREATE OR REPLACE TRIGGER check_team
AFTER INSERT OR UPDATE OF Team_A ON Versus
FOR EACH ROW
BEGIN
check :new.Team_B in {Teams(Team_Name)-Versus(Team_A)};
END;

/*CREATION OF PROCEDURES*/

CREATE OR REPLACE PROCEDURE insePlay(Goals INT, Player_ID INT, Nationality VARCHAR2, First_Name VARCHAR2, Last_Name VARCHAR2, DoB DATE, Salary INT, Matches INT)
IS
BEGIN
INSERT into Player values(Goals, Player_ID, Nationality, First_Name, Last_Name, DoB, Salary, Matches);
END;

CREATE OR REPLACE PROCEDURE inseTeam(Team_ID int, Team_Name varchar2)
IS
BEGIN
INSERT into Teams values(Team_ID, Team_Name);
END;

/*INSERTION OF VALUES*/

exec insePlay(349,1,'Argentina','Lionel','Messi',to_char('24-06-1987'),40000000,573);
exec insePlay(201,2,'Brazil','Neymar','Santos',to_char('05-02-1992'),38600000,342);
exec insePlay(471,3,'Portugal','Cristiano','Ronaldo',to_char('05-02-1985'),32000000,678);
exec insePlay(264,4,'UK','Wayne','Rooney',to_char('24-10-1985'),145000000,607);

exec inseTeam(1,'Barcelona');
exec inseTeam(2,'Real Madrid');
exec inseTeam(3,'PSG');
exec inseTeam(4,'Chelsea');
exec inseTeam(5,'Manchester United');
exec inseTeam(6,'Manchester City');
exec inseTeam(7,'Everton');
exec inseTeam(8,'Argentina');
exec inseTeam(9,'Brazil');
exec inseTeam(10,'Portugal');
exec inseTeam(11,'England');
exec inseTeam(12,'Santos');
exec inseTeam(13,'Sporting CP');

insert into Stadiums values('Spain',25,99354,'Camp Nou');
insert into Stadiums values('Spain',30,81044,'Santiego Bernabeu');
insert into Stadiums values('England',30,90000,'Wembley');
insert into Stadiums values('England',38,76100,'Old Trafford');
insert into Stadiums values('Brazil',50,96000,'Maracana');

insert into Versus values('Argentina',8,'Portugal',10,to_char('9:00:00pm'),1,to_char('15-12-2017')); 
insert into Versus values('Brazil',9,'England',11,to_char('9:00:00pm'),2,to_char('19-12-2017'));
insert into Versus values('Chelsea',4,'Everton',7,to_char('9:00:00pm'),3,to_char('22-12-2017'));
insert into Versus values('Barcelona',1,'Real Madrid',2,to_char('9:00:00pm'),4,to_char('27-12-2017'));
insert into Versus values('Argentina',8,'England',11,to_char('9:00:00pm'),5,to_char('01-01-2018'));
insert into Versus values('Man United',5,'Barcelona',1,to_char('9:00:00pm'),6,to_char('02-01-2018'));
insert into Versus values('Everton',7,'Real Madrid',2,to_char('9:00:00pm'),7,to_char('03-01-2018'));

insert into Visitors values('Sharma','Rohan',25,1,to_char('15-12-2017'),1,to_char('24-06-1989'));
insert into Visitors values('Mehta','Vikas',30,5,to_char('01-01-2018'),2,to_char('25-01-1992'));
insert into Visitors values('Jain','Raman',30,7,to_char('07-01-2018'),3,to_char('15-02-1965'));
insert into Visitors values('Sharma','Vani',38,3,to_char('15-12-2017'),4,to_char('24-10-1985'));

insert into Player_Teams_Played_for values(1,1);
insert into Player_Teams_Played_for values(1,8);
insert into Player_Teams_Played_for values(2,1);
insert into Player_Teams_Played_for values(2,3);
insert into Player_Teams_Played_for values(2,9);
insert into Player_Teams_Played_for values(2,12);
insert into Player_Teams_Played_for values(3,2);
insert into Player_Teams_Played_for values(3,5);
insert into Player_Teams_Played_for values(3,10);
insert into Player_Teams_Played_for values(3,13);
insert into Player_Teams_Played_for values(4,5);
insert into Player_Teams_Played_for values(4,7);
insert into Player_Teams_Played_for values(4,11);

insert into Managers values(1,'FC Barcelona','abc',8900000,1,'Spain',to_char('02-05-1981'));
insert into Managers values(2,'Real Madrid','def',4100000,2,'England',to_char('21-05-1979'));
insert into Managers values(3,'PSG','ghi',9800000,3,'Portugal',to_char('09-05-1976'));
insert into Managers values(4,'Chelsea','jkl',5000000,4,'Africa',to_char('24-04-1983'));
insert into Managers values(5,'Man United','mno',3200000,5,'Australia',to_char('16-01-1980'));
insert into Managers values(6,'Manchester City','pqr',4200000,6,'Spain',to_char('02-03-1974'));
insert into Managers values(7,'Everton','stu',6500000,7,'Brazil',to_char('02-05-1981'));
insert into Managers values(8,'Argentina','vwx',5100000,8,'England',to_char('11-06-1981'));
insert into Managers values(9,'Brazil','yza',2300000,9,'Africa',to_char('11-05-1982'));
insert into Managers values(10,'Portugal','bcd',2000000,10,'Australia',to_char('13-07-1975'));
insert into Managers values(11,'England','efg',3000000,11,'Portugal',to_char('28-02-1973'));
insert into Managers values(12,'Santos','hij',1900000,12,'India',to_char('26-11-1972'));
insert into Managers values(13,'Sporting CP','klm',3500000,13,'Spain',to_char('07-08-1981'));

/*CREATION OF CURSORS*/

set serveroutput on;

DECLARE
CURSOR C1 IS SELECT First_Name, Last_Name, Salary FROM Player WHERE Player_ID=1;
REC C1%ROWTYPE; 
BEGIN
OPEN C1;
LOOP
FETCH C1 INTO REC;
EXIT WHEN C1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('First_Name '||REC.First_Name);
DBMS_OUTPUT.PUT_LINE('Last_Name '||REC.Last_Name);
DBMS_OUTPUT.PUT_LINE('Salary '||REC.Salary);
END LOOP;
CLOSE C1;
END;

DECLARE
NAME Player.First_Name%TYPE;
SALARY Player.salary%TYPE;
CURSOR TEMP1 IS SELECT First_Name, salary FROM Player ORDER BY
salary DESC;
BEGIN
OPEN TEMP1;
LOOP
FETCH TEMP1 INTO NAME, SALARY;
EXIT WHEN TEMP1%ROWCOUNT>5 OR TEMP1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(NAME || SALARY);
END LOOP;
CLOSE TEMP1;
END;

BEGIN
DELETE from Managers WHERE mID=&mID;
IF SQL%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('RECORD NOT DELETED');
ELSE
DBMS_OUTPUT.PUT_LINE('RECORD DELETED');
END IF;
END;

DECLARE
N NUMBER;
BEGIN
DELETE from Managers WHERE mID=&mID;
N:=SQL%ROWCOUNT;
DBMS_OUTPUT.PUT_LINE('TOTAL NUMBER OF RECORD
DELETED' || N);
END;

/*EXCEPTION HANDLING*/

DECLARE
Multiple_Entries EXCEPTION;
BEGIN
INT Flag=0;
Z=count(select Team_B from Versus where Team_A='Argentina' AND DATE=(select Date from Versus where Team_A='Argentina'));
Y=count(select Team_A from Versus where Team_B='Argentina' AND DATE=(select Date from Versus where Team_A='Argentina'));
IF(Z+Y>1)
Flag=Flag+1;
END IF
EXCEPTION
WHEN Flag>1
DBMS_OUTPUT.PUT_LINE('ONE TEAM CAN'T PLAY MULTIPLE MATCHES IN A SINGLE DAY');
END
