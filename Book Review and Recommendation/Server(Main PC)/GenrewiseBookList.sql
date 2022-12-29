clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck73 AS 

	FUNCTION pick_bookid (bk1 IN Book1.genre%TYPE)
	RETURN Book1.bookID%TYPE;
	
	
END pck73;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck73 AS 

	FUNCTION pick_bookid (bk1 IN Book1.genre%TYPE)
	RETURN Book1.bookID%TYPE
	IS 
	   bid Book1.bookID%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  bookID FROM Book1  WHERE genre= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;

END pck73;
/

--USER INPUT PROMPT
ACCEPT gnr CHAR prompt "Enter Genre:  "

DECLARE
	inp_gnr Book1.genre%TYPE;
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_gnr := '&gnr';
    
	book_id := pck73.pick_bookid(inp_gnr);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select b1.bookName,a.authorName,b1.genre from Book1 b1 
					INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID 
					WHERE b1.genre=inp_gnr ) LOOP
					DBMS_OUTPUT.PUT_LINE('BookName: '|| R.bookName || ' AuthorName: ' || R.authorName || ' Genre: ' || R.genre);
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('Genre does not exist.');
END;
/

