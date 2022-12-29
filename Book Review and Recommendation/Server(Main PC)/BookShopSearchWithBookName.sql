clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck78 AS 

	FUNCTION pick_bookid (bk1 IN Book1.bookName%TYPE)
	RETURN Shop.shopID@site1%TYPE;
	
	
END pck78;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck78 AS 

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

END pck78;
/

--USER INPUT PROMPT
ACCEPT bname CHAR prompt "Enter Book Name:  "

DECLARE
	inp_bname Book1.bookName%TYPE;
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_bname := '&bname';
    
	book_id := pck78.pick_bookid(inp_bname);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select s.shopName,s.shopAddress,s.shopMobile from Shop@site1 s 
					INNER JOIN BookShop@site1 bs ON s.shopID=bs.shopID INNER JOIN Book1 b1 ON b1.bookID=bs.bookID WHERE 
					   bookID IN(select bookID from Book1 WHERE	bookName= inp_bname )) LOOP
					DBMS_OUTPUT.PUT_LINE('ShopName: '|| R.shopName || ' ShopAddress: ' || R.shopAddress || ' Mobile: ' || R.shopMobile ||' BookName: ' || inp_bname);
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('No shop found for the book.');
END;
/

