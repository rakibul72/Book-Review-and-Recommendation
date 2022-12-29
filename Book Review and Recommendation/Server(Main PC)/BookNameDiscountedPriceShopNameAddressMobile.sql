clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE VIEW BookPriceShop(SerialNo, BookName, Author, Price, Rate, ShopName, Address, Mobile) as
(select b1.bookID,b1.bookName,a.authorName,b1.price,bs.discount,s.shopName,s.shopAddress,s.shopMobile from Book1 b1 
INNER JOIN Book2@site1 b2 ON b1.bookID= b2.bookID INNER JOIN Author@site1 a ON b2.authorID= a.authorID 
INNER JOIN BookShop@site1 bs ON b1.bookID= bs.bookID INNER JOIN Shop@site1 s ON s.shopID=bs.shopID);

select SerialNo,BookName,Author,ShopName,Address,Mobile,Price-(Price*Rate/100) AS DiscountPrice  from BookPriceShop ORDER BY SerialNo;

commit;

