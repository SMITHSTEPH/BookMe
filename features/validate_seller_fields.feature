Feature: Validate seller fields
  As a Seller
  So that I can only share valid information
  I want the app to check the price\isbn is valid
  
  Background: ssmith32 has logged in and on mybooks page
  Given that ssmith32 has logged in
  Given ssmith32 is on the MyBooks page
  
Scenario: add book with invalid isbn
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott" and isbn "333"
    Then I should see flash message "Isbn is invalid"
    
Scenario: add book with invalid price
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", and price "$99."
    Then I should see flash message "Price is invalid"
    
Scenario: add book with invalid auction_start_price
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", and auction_start_price "$99."
    Then I should see flash message "Auction start price is invalid"
    
Scenario: all valid fields
  When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", price "60.00", and auction_start_price "2.00"
  Then I should see a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0123456789", price "60.00", and auction_start_price "2.00"