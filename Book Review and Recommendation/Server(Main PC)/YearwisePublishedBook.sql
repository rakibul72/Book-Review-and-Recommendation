clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck74 AS 

	FUNCTION pick_bookid (bk1 IN Book2.publishedDate@site1%TYPE)
	RETURN Book1.bookID%TYPE;
	
	
END pck74;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck74 AS 

	FUNCTION pick_bookid (bk1 IN Book2.publishedDate@site1%TYPE)
	RETURN Book1.bookID%TYPE
	IS 
	   bid Book1.bookID%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  bookID FROM Book2@site1 WHERE publishedDate= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;

END pck74;
/

--USER INPUT PROMPT
ACCEPT yr CHAR prompt "Enter Year:  "

DECLARE
	inp_yr Book2.publishedDate@site1%TYPE;
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_yr := '&yr';
    
	book_id := pck74.pick_bookid(inp_yr);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select b1.bookName,a.authorName,b1.genre, b2.publishedDate from Book1 b1 
					INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID 
					WHERE b2.publishedDate=inp_yr ) LOOP
					DBMS_OUTPUT.PUT_LINE('BookName: '|| R.bookName || ' AuthorName: ' || R.authorName || ' Genre: ' || R.genre ||' Year: ' || inp_yr);
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('No Books found for the given year.');
END;
/

