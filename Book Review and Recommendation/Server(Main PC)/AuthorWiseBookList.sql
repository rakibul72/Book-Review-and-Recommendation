clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck75 AS 

	FUNCTION pick_bookid (bk1 IN Author.authorName@site1%TYPE)
	RETURN Author.authorID@site1%TYPE;
	
	
END pck75;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck75 AS 

	FUNCTION pick_bookid (bk1 IN Author.authorName@site1%TYPE)
	RETURN Author.authorID@site1%TYPE
	IS 
	   bid Author.authorID@site1%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  authorID FROM Author@site1 WHERE authorName= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;

END pck75;
/

--USER INPUT PROMPT
ACCEPT aname CHAR prompt "Enter Author Name:  "

DECLARE
	inp_aname VARCHAR2(20);
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_aname := '&aname';
    
	book_id := pck75.pick_bookid(inp_aname);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select b1.bookName,a.authorName,b1.genre from Book1 b1 
					INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID 
					WHERE a.authorName=inp_aname ) LOOP
					DBMS_OUTPUT.PUT_LINE('BookName: '|| R.bookName || ' AuthorName: ' || R.authorName || ' Genre: ' || R.genre );
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('Author Not Found.');
END;
/

