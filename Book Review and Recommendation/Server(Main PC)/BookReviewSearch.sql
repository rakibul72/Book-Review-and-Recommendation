clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck79 AS 

	FUNCTION pick_bookid (bk1 IN Book1.bookName%TYPE)
	RETURN Shop.shopID@site1%TYPE;
	
	
END pck79;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck79 AS 

	FUNCTION pick_bookid (bk1 IN Book1.bookName%TYPE)
	RETURN Shop.shopID@site1%TYPE
	IS 
	   bid Book1.bookID%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  bookID FROM Book1 b1 WHERE b1.bookName= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;

END pck79;
/

--USER INPUT PROMPT
ACCEPT bname CHAR prompt "Enter Book Name:  "

DECLARE
	inp_bname Book1.bookName%TYPE;
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_bname := '&bname';
    
	book_id := pck79.pick_bookid(inp_bname);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select b1.bookName,b1.genre,R1.bookReview from Book1 b1 
					INNER JOIN Review1 R1 ON b1.bookID=R1.bookID WHERE 
					   b1.bookID IN(select b1.bookID from Book1 b1 WHERE	b1.bookName=inp_bname )) LOOP
					DBMS_OUTPUT.PUT_LINE('BookName: '|| R.bookName || ' Genre: ' || R.genre || ' Review: ' || R.bookReview);
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('No review found for the book.');
END;
/

