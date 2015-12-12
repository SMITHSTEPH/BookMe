Feature: Seller bid notification
  As a seller
  So that I can know the status of the book I am seller
  I want to receive a notifcation when a new bid has been placed
  
  Background: user has logged in and on homepage #implement more of the login stuff next iteration
    Given the database is seeded
    
  Scenario: Someone bids on the sellers textbook
    When sarah has logged in
    And placed a "27.00" bid on "Medical Imaging"
    And ssmith has logged in
    Then ssmith should have a mybooks notification