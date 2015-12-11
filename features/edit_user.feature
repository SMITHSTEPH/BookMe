Feature: edit an account 
  As a user
  So that I can edit an account
  I want to edit an account 
  
Background: I have visited the edit account page 
  Given I am on the edit account page
  
Scenario: I edit an account with valid information 
    When I edit an account with firstName "Blake", lastName "Dunham", user_id "bdunham", email "b@b.com", password "password", confirmPassword "password"
    Then I should go to my books page

Scenario: edit an account with invalid information
  When I edit an account with no parameters
  Then I should return to user edit page