Feature: create a new item when a seller adds a book to their seller items
  As a seller
  So that I can sell my textbooks
  I want to add my textbooks to the site
  
Background: user has logged in
  
  Given ssmith is logged into BookMe
  And I am on the seller items page

Scenario: add valid item to existing collection of seller items
    When I have added book with title "Calculus" and isbn "1285057090" and author "Ron Larson"
    Then I should see a new book enty "Calculus"
    
Scenario: add invalid item to existing collection of seller items
  When I have added book with title "ccgg"
  Then I should see the flash warning "invalid book entry"