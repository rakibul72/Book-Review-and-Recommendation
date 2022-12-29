clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

--CREATING PACKAGE 
CREATE OR REPLACE PACKAGE  pck77 AS 

	FUNCTION pick_bookid (bk1 IN Shop.shopAddress@site1%TYPE)
	RETURN Shop.shopID@site1%TYPE;
	
	
END pck77;
/

--PACKAGE BODY 
CREATE OR REPLACE PACKAGE BODY pck77 AS 

	FUNCTION pick_bookid (bk1 IN Shop.shopAddress@site1%TYPE)
	RETURN Shop.shopID@site1%TYPE
	IS 
	   bid Book1.bookID%TYPE;
	   
	   CURSOR pick_book IS
	   SELECT  shopID FROM Shop@site1 WHERE shopAddress= bk1;
	   
	BEGIN
		OPEN pick_book;
		FETCH pick_book INTO bid;
		CLOSE pick_book;
		
		RETURN bid;
	END pick_bookid;

END pck77;
/

--USER INPUT PROMPT
ACCEPT addr CHAR prompt "Enter Address:  "

DECLARE
	inp_addr Shop.shopAddress@site1%TYPE;
	book_id Book1.bookID%TYPE;
	Exccp EXCEPTION;
		
BEGIN
	inp_addr := '&addr';
    
	book_id := pck77.pick_bookid(inp_addr);
		
	IF book_id IS NULL THEN
		RAISE Exccp;
	ELSE
		FOR R IN (select s.shopName,s.shopAddress,s.shopMobile from Shop@site1 s WHERE s.shopAddress=inp_addr ) LOOP
					DBMS_OUTPUT.PUT_LINE('ShopName: '|| R.shopName || ' ShopAddress: ' || R.shopAddress || ' Mobile: ' || R.shopMobile);
		END LOOP;
	END IF;
	
	
EXCEPTION
	WHEN Exccp THEN
		DBMS_OUTPUT.PUT_LINE('No shop found.');
END;
/

