clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE VIEW BookReviewAuthor(SerialNo, BookName, Author, Genre, Review) as
(select b1.bookID,b1.bookName,a.authorName,b1.genre,R1.bookReview from Book1 b1 
INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID INNER JOIN Review1 R1 ON b1.bookID= R1.bookID);

select * from BookReviewAuthor ORDER BY SerialNo;

commit;

