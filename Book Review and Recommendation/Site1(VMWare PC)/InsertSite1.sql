clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

drop table Author CASCADE CONSTRAINTS;;
create table Author(
	authorID number,
	authorName varchar2(20),
	noOfBooks number,
	primary key(authorID)
	);
	
insert into Author values (1,'Dan Brown',17);
insert into Author values (2,'Yuval Noah Harari',6);
insert into Author values (3,'Paulo Coelho',14);
insert into Author values (4,'Ernest Hemingway',16);
insert into Author values (5,'Chetan Bhagat',5);
insert into Author values (6,'Stephen Hawking',3);
insert into Author values (7,'Mohammad Nazim Uddin',12);

select * from Author;
	
drop table Shop CASCADE CONSTRAINTS;;
create table Shop(
	shopID number,
	shopName varchar2(20),
	shopAddress varchar2(30),
	shopMobile varchar2(12),
	primary key(shopID)
	);
	  
insert into Shop values (1,'Modern Books','Nilkhet','01521101582');
insert into Shop values (2,'Friends Book Corner','New Market','01521101584');
insert into Shop values (3,'Boi Ghor','Uttara','01521101585');
insert into Shop values (4,'Brothers Books','Shyamoli','01851101590');
insert into Shop values (5,'Rokomari','Dhanmondi','01921101685');

select * from Shop;

drop table Book2 CASCADE CONSTRAINTS;;
create table Book2(
	bookID number,
	authorID number,
	publisherName varchar2(20),
	publishedDate varchar2(20),
	primary key(bookID),
	FOREIGN KEY(authorID) REFERENCES Author(authorID)
	);
	
insert into Book2 values (1,1,'Bantam Press','2017');
insert into Book2 values (2,2,'Vintage Books','2014');
insert into Book2 values (3,3,'HarperCollins','1998');
insert into Book2 values (4,4,'Friends','2006');
insert into Book2 values (5,1,'Bantam Press','2013');
insert into Book2 values (6,5,'Westland','2020');
insert into Book2 values (7,6,'Bantam Press','1988');
insert into Book2 values (8,1,'Bantam Press','2003');
insert into Book2 values (9,3,'HarperCollins','2003');
insert into Book2 values (10,4,'Friends','2003');
insert into Book2 values (11,4,'Friends','2005');
insert into Book2 values (12,5,'Westland','2014');
insert into Book2 values (13,7,'Batighar','2010');
insert into Book2 values (14,7,'Batighar','2011');
insert into Book2 values (15,7,'Batighar','2012');
insert into Book2 values (16,7,'Batighar','2013');
insert into Book2 values (17,7,'Batighar','2015');
insert into Book2 values (18,7,'Batighar','2022');
insert into Book2 values (19,7,'Batighar','2015');
insert into Book2 values (20,7,'Batighar','2019');

select * from Book2;
	
drop table BookShop CASCADE CONSTRAINTS;;
create table BookShop(
	shopID number,
	bookID number,
	discount number,
	FOREIGN KEY(shopID) REFERENCES Shop(shopID),
	FOREIGN KEY(bookID) REFERENCES Book2(bookID)
	);
	
insert into BookShop values (1,5,25);
insert into BookShop values (1,10,20);
insert into BookShop values (1,15,15);
insert into BookShop values (1,20,25);
insert into BookShop values (1,1,35);
insert into BookShop values (5,2,30);
insert into BookShop values (3,6,20);
insert into BookShop values (5,9,23);
insert into BookShop values (2,3,18);
insert into BookShop values (5,8,12);
insert into BookShop values (3,13,10);
insert into BookShop values (2,7,17);
insert into BookShop values (5,4,40);
insert into BookShop values (4,11,35);
insert into BookShop values (2,14,30);
insert into BookShop values (3,16,20);
insert into BookShop values (4,19,15);
insert into BookShop values (5,12,14);
insert into BookShop values (4,17,19);
insert into BookShop values (3,7,22);
insert into BookShop values (1,13,25);
insert into BookShop values (5,18,25);
insert into BookShop values (2,15,30);
insert into BookShop values (4,19,33);
insert into BookShop values (1,17,21);
insert into BookShop values (4,3,18);
insert into BookShop values (3,9,5);
insert into BookShop values (2,4,15);
insert into BookShop values (4,15,20);
insert into BookShop values (5,17,35);

select * from BookShop;

	
drop table Review2 CASCADE CONSTRAINTS;;
create table Review2(
	reviewNo number,
	authorRating number,
	authorRecommendation number,
	primary key(reviewNo)
	);
	
insert into Review2 values (1,7,9);
insert into Review2 values (2,9,7);
insert into Review2 values (3,8,8);
insert into Review2 values (4,6,9);
insert into Review2 values (5,5,7);
insert into Review2 values (6,7,8);
insert into Review2 values (7,8,6);
insert into Review2 values (8,9,5);
insert into Review2 values (9,7,7);
insert into Review2 values (10,6,8);
insert into Review2 values (11,5,9);
insert into Review2 values (12,4,7);
insert into Review2 values (13,7,8);
insert into Review2 values (14,8,9);
insert into Review2 values (15,9,7);
insert into Review2 values (16,9,5);
insert into Review2 values (17,8,7);
insert into Review2 values (18,7,6);
insert into Review2 values (19,6,7);
insert into Review2 values (20,9,9);
insert into Review2 values (21,8,8);
insert into Review2 values (22,7,5);
insert into Review2 values (23,8,4);
insert into Review2 values (24,9,7);
insert into Review2 values (25,10,8);
insert into Review2 values (26,7,5);
insert into Review2 values (27,6,9);
insert into Review2 values (28,5,7);
insert into Review2 values (29,4,8);
insert into Review2 values (30,9,7);
insert into Review2 values (31,8,9);
insert into Review2 values (32,7,8);
insert into Review2 values (33,6,7);
insert into Review2 values (34,5,8);
insert into Review2 values (35,6,10);
insert into Review2 values (36,7,7);
insert into Review2 values (37,8,8);
insert into Review2 values (38,9,9);
insert into Review2 values (39,7,7);
insert into Review2 values (40,6,9);

select * from Review2;


commit;