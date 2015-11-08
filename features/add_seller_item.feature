Feature: create a new item when a seller adds a book to their seller items
  As a seller
  So that I can sell my textbooks
  I want to add my textbooks to the site
  
Background: ssmith32 has logged in and on mybooks page
  Given that ssmith32 has logged in
  Given ssmith32 is on the MyBooks page
  
Scenario: add item (without required information) to existing collection of seller items
    When I add a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott" and isbn "0130331929"
    Then I should see a book with title "Analog Electronic Design: Principles and Practice of Creative Design", author "Johnathan Scott" and isbn "0130331929" added mybooks

Scenario: add an invalid item to existing collection of seller items
  When I add a book with title "", author "" and isbn ""
  Then I should see flash message "fill out all fields marked with '*' to add book"
  