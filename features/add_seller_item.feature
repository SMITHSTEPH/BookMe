Feature: create a new item when a seller adds a book to their seller items
  As a seller
  So that I can sell my textbooks
  I want to add my textbooks to the site
  
Background: ssmith has logged in and on mybooks page
  Given the database is seeded
  Given ssmith has logged in
  Given ssmith is on the MyBooks page
  
Scenario: add item (without required information) to existing collection of seller items
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott", isbn "0130331929", buy now price "2.00", and auction start price "20.00"
    Then I should see a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott" and isbn "0130331929" added mybooks

Scenario: add an invalid item to existing collection of seller items
  When I add a book with title "", author "", isbn "", buy now price "2.00", and auction start price "20.00"
  Then I should see flash message ""
