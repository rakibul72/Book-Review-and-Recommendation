clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE VIEW BookRecommendation(SerialNo, Name, Author, Genre, PublishedYear, Recommendation) as
(select b1.bookID,b1.bookName,a.authorName,b1.genre,b2.publishedDate,R1.bookRecommendation from Book1 b1 
INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID
INNER JOIN Review1 R1 ON b1.bookID= R1.bookID);

select Name,Author,Genre,PublishedYear from BookRecommendation WHERE Recommendation IN (SELECT max(Recommendation) FROM BookRecommendation) ;

commit;

