create database Keepnote
use Keepnote


create table User_records
(
User_id int primary key,
User_name varchar(20),
User_added_date date,
User_password varchar(20),
User_mobile varchar(10),
)


create table Note_records
(
Note_id int primary key not null,
Note_title varchar(50),
Note_contents varchar(100),
Note_status varchar(50),
Note_creation date,
User_id int references User_records(User_id)
)


create table Category_records
(
Category_id int primary key,
Category_name varchar(20),
Category_description varchar(50),
Category_creation_date date,
Category_creator int references User_records(User_id)
)



create table Remainder_records
(
Remainder_id int primary key,
Remainder_name varchar(50),
Remainder_description varchar(50),
Remainder_type varchar(50),
Remainder_creation_date date,
Remainder_creator int references User_records(User_id)
)




create table NoteCategory
(
notecategory_id int,
note_id int references Note_records(Note_id),
category_id int references Category_records(Category_id)
)




create table NoteRemainder
(
noteremainder_id int,
note_id int references Note_records(Note_id),
remainder_id int
)
Alter table NoteRemainder add constraint fk_remainder_id foreign key (remainder_id) references Remainder_records(Remainder_id);





Insert into User_records values(112233,'Maya','2019-01-02','Maya1214', 8012345679),(112244,'Nair','2019-01-11','Welcome', 9023778467)

Insert into Note_records values(1,'Today Tasks','1.Check emails and reply to them 2.Start the pro...', 'InProgress','2019-01-21',112233),(2,'Training to plan', '1.Application related 2.Technical related','YetToStart','2019-01-31',112244),(3,'Thing to have today','1.Fruits 2.More water','InProgress','2019-01-25',112244)

Insert into Category_records values(1,'Official','Office related notes','2019-01-21',112233),(2,'Diet','health related notes','2019-01-24',112244)


insert into Remainder_records values(1,'KT remainder','Session Technical queries','Office Remainders','2019-02-12',112233),(2,'Personal remainder','Pick children','Personal Remainders','2019-02-14',112244)

insert into Notecategory values(1,1,1),(2,2,1),(3,3,2)


insert into NoteRemainder values(1,3,2),(2,2,1)

select*from User_records
select*from Note_records
select*from Category_records
select*from Remainder_records
select*from NoteCategory
select*from NoteRemainder

--Query1
select *from User_records where User_id=112233 and User_password='Maya1214'

--Query2
select * from Note_records where Note_creation='2019-01-31'

--Query3
select *from Category_records where Category_creation_date > '2019-01-22'

--Query4
select Category_id, Category_name,Category_description,Category_creation_date,Category_creator,  Note_id from Category_records inner join Note_records on Category_records.Category_creator=Note_records.User_id and Note_id=1


--Query5
select*from Note_records where User_id=112244

--Query6
select  Note_id, Note_title,Note_contents,Note_status,Note_creation,User_id, Category_id from Note_records inner join Category_records on Note_records.User_id=Category_records.Category_creator and Category_id=1


--Query7
(select  Remainder_id, Remainder_name,Remainder_description,Remainder_type,Remainder_creation_date,Remainder_creator, Note_id from Remainder_records inner join Note_records on Remainder_records.Remainder_creator=Note_records.User_id and Note_id=2)

--Query8
update Note_records set Note_status='Completed' where Note_id=3

--Query9
update Remainder_records set  Remainder_description='clean car' where Remainder_id=(select Remainder_id where Remainder_type='Personal Remainders') and Remainder_creator=(select User_id from Note_records where Note_id=1) 


--Query10
alter table NoteRemainder drop constraint fk_remainder_id
delete from Remainder_records where Remainder_creator=(select User_id from Note_records where Note_id=2)



