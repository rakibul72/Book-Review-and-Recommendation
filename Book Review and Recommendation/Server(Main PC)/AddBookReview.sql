clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER BookInsert
After INSERT 
ON Book1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('New Book Inserted');
END;
/

CREATE OR REPLACE TRIGGER ReviewInsert
After INSERT 
ON Review1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('New Review Inserted');
END;
/

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck72 AS 

	FUNCTION pick_bookid (bk1 IN Book1.bookName%TYPE)
	RETURN Book1.bookID%TYPE;
	
	PROCEDURE pick_authorID(at1 IN Author.authorName@site1%TYPE,at2 OUT Author.authorID@site1%TYPE);
	
END pck72;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck72 AS 

	FUNCTION pick_bookid (bk1 IN Book1.bookName%TYPE)
	RETURN Book1.bookID%TYPE
	IS 
	   bid Book1.bookID%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  bookID FROM Book1  WHERE bookName= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;
	
	PROCEDURE pick_authorID(at1 IN Author.authorName@site1%TYPE,at2 OUT Author.authorID@site1%TYPE)
	IS	
		CURSOR pick_auth IS
		SELECT  authorID FROM Author@site1  WHERE authorName= at1;
	BEGIN
		OPEN pick_auth;
		FETCH pick_auth INTO at2;
		CLOSE pick_auth;
	END pick_authorID;

END pck72;
/

--USER INPUT PROMPT
ACCEPT bname CHAR prompt "Enter Book Name:  "
ACCEPT aname CHAR prompt "Enter Author Name:  "
ACCEPT gnr CHAR prompt "Enter Genre:  "
ACCEPT pname CHAR prompt "Enter Publisher Name:  "
ACCEPT pdate CHAR prompt "Enter Publication Year:  "
ACCEPT prc NUMBER prompt "Enter Book Price:  "
ACCEPT rev CHAR prompt "Enter Book Review:  "
ACCEPT brate NUMBER prompt "Enter Book Rating:  "
ACCEPT arate NUMBER prompt "Enter Author Rating:  "
ACCEPT brec NUMBER prompt "Enter Book Recommendation:  "
ACCEPT arec NUMBER prompt "Enter Author Recommendation:  "

DECLARE
	inp_bname Book1.bookName%TYPE;
	inp_aname VARCHAR2(20);
	inp_gnr Book1.genre%TYPE;
	inp_pname varchar2(20);
	inp_pdate varchar2(20);
	inp_prc Book1.price%TYPE;
	inp_rev Review1.bookReview%TYPE;
	inp_brate Review1.bookRating%TYPE;
	inp_arate Review2.authorRating@site1%TYPE;
	inp_brec Review1.bookRecommendation%TYPE;
	inp_arec Review2.authorRecommendation@site1%TYPE;
	book_id Book1.bookID%TYPE;
	author_id Author.authorID@site1%TYPE;
	Exccp EXCEPTION;
	bid2 NUMBER;
	aid2 NUMBER;
	rev2 NUMBER;
		
BEGIN
    inp_bname := '&bname';
	inp_aname := '&aname';
	inp_gnr := '&gnr';
	inp_pname := '&pname';
	inp_pdate := '&pdate';
	inp_prc := &prc;
	inp_rev := '&rev';
	inp_brate := &brate;
	inp_arate := &arate;
	inp_brec := &brec;
	inp_arec := &arec;
    
	book_id := pck72.pick_bookid(inp_bname);
	pck72.pick_authorID(inp_aname,author_id);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
	BEGIN
		select max(reviewNo) into rev2 from Review1;
		insert into Review1 values (rev2+1,book_id,inp_rev,inp_brate,inp_brec);
		insert into Review2@site1 values (rev2+1,inp_arate,inp_arec);
	END;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('Book does not exist.');
		select max(bookID) into bid2 from Book1;
		insert into Book1 values (bid2+1,inp_bname,inp_gnr,inp_prc);
		book_id:=bid2+1;
		IF author_id IS NULL THEN
		BEGIN
			DBMS_OUTPUT.PUT_LINE('Author does not exist.');
			select max(authorID) into aid2 from Author@site1;
			insert into Author@site1 values (aid2+1,inp_aname,8);
			DBMS_OUTPUT.PUT_LINE('New Author Inserted.');
			author_id:=aid2+1;
		END;
		END IF;
		
		insert into Book2@site1 values (bid2+1,author_id,inp_pname,inp_pdate);
		
		select max(reviewNo) into rev2 from Review1;
		insert into Review1 values (rev2+1,book_id,inp_rev,inp_brate,inp_brec);
		insert into Review2@site1 values (rev2+1,inp_arate,inp_arec);
END;
/

CREATE OR REPLACE VIEW BookReviewAuthorNew(SerialNo, BookName, Author, Genre, Review) as
(select b1.bookID,b1.bookName,a.authorName,b1.genre,R1.bookReview from Book1 b1 
INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID INNER JOIN Review1 R1 ON b1.bookID= R1.bookID);

select * from BookReviewAuthorNew where SerialNo IN (select max(SerialNo) from BookReviewAuthorNew) ;

commit;
