Feature: Validate seller fields
  As a Seller
  So that I can only share valid information
  I want the app to check the price\isbn is valid
  
  Background: ssmith has logged in and on mybooks page
    Given the database is seeded
    Given ssmith has logged in
    And ssmith is on the MyBooks page
  
Scenario: add book with invalid isbn
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "333", buy now price "4.00", and auction start price "20.00"
    Then I should see flash message "Isbn is invalid"
    
Scenario: add book with invalid price
   When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", buy now price "$99.", and auction start price "20.00"
   Then I should see flash message "Price is invalid"
    
Scenario: add book with invalid auction_start_price
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", buy now price "$99.", and auction start price "2fdsaf"
    Then I should see flash message "Auction start price is invalid"
    
Scenario: all valid fields
  When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", buy now price "60.00", and auction start price "2.00"
  Then I should see a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", price "60.00", and Auction Price "2.00"