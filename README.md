# Book-Review-and-Recommendation
CSE4126: Distributed Database Systems Lab


#Introduction:
User can see book list and review from different persons. Based on ratings and recommendation of other users, one user can get recommendation about which books to read next. The user can also get information about where to buy these books. The user can also rate and review books as well as the author.

#Database Schema:
   Global Schema:
      Book (bookID, bookName, authorID, genre, publisherName, publishedDate, price)
      Author (authorID, authorName, noOfBooks)
      Review(reviewNo, bookID, bookReview, bookRating, authorRating, bookRecommendation, authorRecommendation)
      Shop(shopID, shopName,shopAddress, shopMobile)
      BookShop(shopID, bookID, discount)
   Fragmentation Schema:
      Book1 = PJbookID,bookName,genre,priceBook
      Book2 = PJbookID,authorID,publisherName,publishedDateBook
      Review1 = PJreviewNo,bookID,bookReview,bookRating,bookRecommendationReview
      Review2 = PJreviewNo,authorRating,authorRecommendationReview
   Allocation Schema:
      Book1 @server Book2 @site1
      Review1 @sever Review2 @site1

#Why Distributed Database:
Distributed database will allow different users to access our system from different sites. They can perform their cherished operation according to their access status.
