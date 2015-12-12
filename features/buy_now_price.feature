Feature: Set buy now price
  As a seller
  So that someone can buy my book instantly
  I want to set a 'buy now' price
  
Background: ssmith has logged in and on mybooks page
  Given the database is seeded
  Given ssmith has logged in

Scenario: viewing buy now price on the show book page
    When I am viewing information about "Medical Imaging"
    Then I should see a "Buy Now Price" section
 
Scenario: adding buy now price on the add books page
  When ssmith is on the MyBooks page
  And I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and "Buy Now Price" to "30.00"
  Then the new item "Buy Now Price" should be "30.00"
  
Scenario: editing buy now price on the edit book page
    When ssmith has selected to edit "Medical Imaging"
    And I change field "Buy Now Price" to "40.00"
    Then the new item "Buy Now Price" should be "40.00"