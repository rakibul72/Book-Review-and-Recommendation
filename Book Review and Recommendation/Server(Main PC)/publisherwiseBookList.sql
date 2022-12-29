clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck76 AS 

	FUNCTION pick_bookid (bk1 IN Book2.publisherName@site1%TYPE)
	RETURN Book1.bookID%TYPE;
	
	
END pck76;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck76 AS 

	FUNCTION pick_bookid (bk1 IN Book2.publisherName@site1%TYPE)
	RETURN Book1.bookID%TYPE
	IS 
	   bid Book1.bookID%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  bookID FROM Book2@site1 WHERE publisherName= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;

END pck76;
/

--USER INPUT PROMPT
ACCEPT pname CHAR prompt "Enter Publisher Name:  "

DECLARE
	inp_pname Book2.publisherName@site1%TYPE;
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_pname := '&pname';
    
	book_id := pck76.pick_bookid(inp_pname);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select b1.bookName,a.authorName,b1.genre, b2.publisherName from Book1 b1 
					INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID 
					WHERE b2.publisherName=inp_pname ) LOOP
					DBMS_OUTPUT.PUT_LINE('BookName: '|| R.bookName || ' AuthorName: ' || R.authorName || ' Genre: ' || R.genre ||' Publisher: ' || inp_pname);
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('No Books found for the given publisher.');
END;
/

