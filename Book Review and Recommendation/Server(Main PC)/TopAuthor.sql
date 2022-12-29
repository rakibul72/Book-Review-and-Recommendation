clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE VIEW TopAuthor(Author, Books,AuthorRating) as
(select a.authorName,a.noOfBooks,R2.authorRating from Book2@site1 b2 INNER JOIN Review1 R1 ON b2.bookID= R1.bookID 
INNER JOIN Author@site1 a ON a.authorID= b2.authorID INNER JOIN Review2@site1 R2 ON R2.reviewNo=R1.reviewNo);

select * from TopAuthor WHERE AuthorRating IN (SELECT max(AuthorRating) FROM TopAuthor) ;

commit;

