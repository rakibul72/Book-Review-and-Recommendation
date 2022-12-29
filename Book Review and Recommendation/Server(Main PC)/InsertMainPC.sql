clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

drop table Book1 CASCADE CONSTRAINTS;;
create table Book1(
	bookID number,
	bookName varchar2(25),
	genre varchar2(20),
	price number,
	primary key(bookID)
	);
	
insert into Book1 values (1,'Origin','Mystery-Thriller',350);
insert into Book1 values (2,'Sapiens','Non-fiction',450);
insert into Book1 values (3,'The Alchemist','Adventure',180);
insert into Book1 values (4,'A Farewell to Arms','Realism',140);
insert into Book1 values (5,'Inferno','Mystery-Thriller',280);
insert into Book1 values (6,'One Arranged Murder','Mystery-Thriller',250);
insert into Book1 values (7,'A brief History of Time','Cosmology',300);
insert into Book1 values (8,'The Da Vinci Code','Mystery-Thriller',320);
insert into Book1 values (9,'Eleven Minutes','Novel',350);
insert into Book1 values (10,'A Moveable Feast','Autobiography',230);
insert into Book1 values (11,'Death in the Afternoon','Non-fiction',180);
insert into Book1 values (12,'Half Girlfriend','Romance',200);
insert into Book1 values (13,'Nemesis','Mystery-Thriller',250);
insert into Book1 values (14,'Contract','Mystery-Thriller',270);
insert into Book1 values (15,'Nexus','Mystery-Thriller',260);
insert into Book1 values (16,'Confession','Mystery-Thriller',300);
insert into Book1 values (17,'Karachi','Mystery-Thriller',320);
insert into Book1 values (18,'Next','Mystery-Thriller',375);
insert into Book1 values (19,'Rabindranath Ekhane Kokhono khete Asenni','Mystery-Thriller',350);
insert into Book1 values (20,'Rabindranath Ekhane kokhono Asenni','Mystery-Thriller',380);

select * from Book1;
	
drop table Review1 CASCADE CONSTRAINTS;;
create table Review1(
	reviewNo number,
	bookID number,
	bookReview varchar2(250),
	bookRating number,
	bookRecommendation number,
	primary key(reviewNo),
	FOREIGN KEY(bookID) REFERENCES Book1(bookID)
	);
	
insert into Review1 values (1,1,'I just finished the book. It is not the best Robert Langdon book in my opinion but it is entertaining as hell.',8,6);
insert into Review1 values (2,2,'This book is a superficial gloss on human history. Nice try.',7,7);
insert into Review1 values (3,3,'My heart and I chatted, and we agreed, this book was short. My heart thinks it was also stupid, and after spending some time talking to the wind, I came to agree with my heart.',6,8);
insert into Review1 values (4,4,'I just finished it, and I am disappointed. And not only disappointed; I am also bothered by it.',7,9);
insert into Review1 values (5,5,'An entertaining read. At times I felt like the author was stretching it out by repeating things that he had just said only pages before.',8,5);
insert into Review1 values (6,6,'Loved the ending! Definitely, there was an "aha" moment for me. I did not see that brilliant twist coming!',9,4);
insert into Review1 values (7,7,'It is not clear to me who is in the target audience for this book. At times it tries to explain basic concepts of modern physics in simple language, and at other times it assumes a familiarity with the same subject.',8,7);
insert into Review1 values (8,8,'This is a pretty formulaic page turner, a fun quick read. Written at about the level of the average Nancy Drew mystery, it is best appreciated at that level.',7,8);
insert into Review1 values (9,9,'I did not find this nearly as good as The Alchemist. I do not know if Coelho was trying to really get in the mindset of a woman by over-analyzing sex, but I felt a real woman would be less philosophical and more emotional about her experiences.',6,9);
insert into Review1 values (10,10,'Loved it!Like Hemingway, I love Paris from the bottom of my heart.',7,10);
insert into Review1 values (11,11,'Death in the Afternoon can be seen as Ernest Hemingway’s attempt to equate the ritualized dance of the matador with that of the writer.',7,6);
insert into Review1 values (12,12,'I love this book so much...every time I think about it I wonder how could someone write just a piece of shit and still be called Indias greatest author!',8,5);
insert into Review1 values (13,13,'It did not let me get up until I finished.',8,7);
insert into Review1 values (14,14,'There was tension throughout the story. I am satisfied after reading the book.',9,9);
insert into Review1 values (15,15,'Authentic thriller! I mean, I can not find any adjectives for the book. The story is absolutely tense.',9,8);
insert into Review1 values (16,16,'Compared to the previous three books in this series, it is relatively dull, but very interesting to observe.',10,7);
insert into Review1 values (17,17,'The plot is remarkable. The coincidence in the thriller will be justified.',9,9);
insert into Review1 values (18,18,'Absolutely a great thriller book from the writer.',9,8);
insert into Review1 values (19,19,'Hands down one of my favourite reads of this year. The plot, the setting, the characters, the story everything was bang on.',8,9);
insert into Review1 values (20,20,'Simply, it is a treasure of Bengali literature.',10,7);
insert into Review1 values (21,20,'Mohammad Nazim Uddin wrote this masterpiece. One of the best thrillers I have ever read.',8,6);
insert into Review1 values (22,19,'wow!!a gem among bangla thriller books.',7,8);
insert into Review1 values (23,18,'Enjoyed every moment of reading this book.',9,10);
insert into Review1 values (24,17,'I would say, this one is the best of the series.However, the storyline, the concept and versatility of this book is remarkable.',8,7);
insert into Review1 values (25,16,'Not bad, but not good! We read the stories of the beginning of Bastards Confession on contract, so there was no need for such details of those events.',7,6);
insert into Review1 values (26,15,'Nice plot!The simple murder of an ordinary clerk takes a turn in a very thrilling story.',9,9);
insert into Review1 values (27,14,'Great. In a word, great. The whole novel is rocket-propelled.',8,8);
insert into Review1 values (28,13,'I finished reading last night. I like it very much.',7,7);
insert into Review1 values (29,12,'Worst book written in the history of literature.',5,6);
insert into Review1 values (30,11,'What an unusual book. Macho, macho man Hemingway tells you everything you never wanted to know about bullfighting and will probably forget as soon as you put the book down.',6,8);
insert into Review1 values (31,10,'How have I not read this before?? Absolute perfection from beginning to end.',5,7);
insert into Review1 values (32,9,'In comparison to my experiences with his other pieces. I can confidently say that this Paulo Cohelo work tests the reader in a unique and dangerous way.',9,6);
insert into Review1 values (33,8,'A thriller devoid of pacing or exciting language. A mystery devoid of clues, foreshadowing, or facts.',7,7);
insert into Review1 values (34,7,'Stephen Hawking writes in a very simple and approachable way. On the surface the book has been written for the common man, for he who has little knowledge of theoretical physics.',6,8);
insert into Review1 values (35,6,'Not bad. It is fast-paced, has all the drama one can expect from a Chetan Bhagat book, and has a convincing mystery.',4,6);
insert into Review1 values (36,5,'I really enjoyed this book. I have read the previous books Brown has written about Langdon, and I enjoyed those too. I find the book well written and descriptive.',9,9);
insert into Review1 values (37,4,'Damn. That ending. Even whilst still dusting off the cover I already knew it is finale. It is simply been impossible to ignore.',7,7);
insert into Review1 values (38,3,'I really disliked this book. I dislike it in the way that I dislike a great deal of modern self help books.',8,6);
insert into Review1 values (39,2,'What a fantastic book. I can see why everyone from Bill Gates to Barack Obama was raving about it.',10,8);
insert into Review1 values (40,1,'Even though I spent quite some money on this book, I can’t finish it. That’s because this book is an exact replica of all of Dan Brown’s previous books about Robert Langdon and I’m so bored and frustrated.',7,4);

select * from Review1;

commit;



CREATE OR REPLACE VIEW AuthorInfo(Name,NumberOfBooks) as
(select a.authorName,a.noOfBooks from Author@site1 a);

select * from AuthorInfo;

commit;

