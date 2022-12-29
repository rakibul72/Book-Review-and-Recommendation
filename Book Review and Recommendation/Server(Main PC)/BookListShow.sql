clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE VIEW BookInfo(SerialNo, Name, Author, Genre, Publisher, PublishedYear, Price) as
(select b1.bookID,b1.bookName,a.authorName,b1.genre,b2.publisherName,b2.publishedDate,b1.price from Book1 b1 
INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID);

select * from BookInfo ORDER BY SerialNo;

commit;

