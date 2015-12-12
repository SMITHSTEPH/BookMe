Feature: Set Auction Time
  As a seller
  So that I can communicate to users the amount of time they have to bid
  I want to set an auction time
  
Background: ssmith has logged in and on mybooks page
    Given the database is seeded
    Given ssmith has logged in

Scenario: viewing keywords on the show book page
    When I am viewing information about "Medical Imaging"
    Then I should see a "Sale ends in: " section
 
Scenario: adding auction time on the add books page
  When ssmith is on the MyBooks page
  #And I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and "Auction Time (year-month-day hr:min)" to "2015-12-12 12:30"
  #Then the new item "Time Left" should add up to "2015-12-12 12:30"
  
Scenario: editing auction time on the edit book page
    When ssmith has selected to edit "Medical Imaging"
    #And I change field "Auction Time (year-month-day hr:min)" to "2015-12-12 12:30"
    #Then the new item "Time Left" should add up to "2015-12-12 12:30"
    
