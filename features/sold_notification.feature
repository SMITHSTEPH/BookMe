Feature: Sold Notification
  As a seller
  So that I can know when any of my books have been bought
  I want to receive a notifcation
  
  Background: user has logged in and on homepage #implement more of the login stuff next iteration
    Given the database is seeded
  
  Scenario: Someone buys the sellers textbook
    When sarah has logged in
    And purchased "Medical Imaging"
    And ssmith has logged in
    Then ssmith should have a mybooks notification