Feature: create an account 
  As a user
  So that I can have an account
  I want to create an account 
  
Background: I has visited the create account page 
  Given I am on the create account page
  
Scenario: I create an account with valid information 
    When I create an account with firstName "Blake", lastName "Dunham", user_id "bdunham", email "b@b.com", password "password", confirmPassword "password"
    Then I should see flash message "Welcome bdunham. Your account has been created."

Scenario: create an account with invalid information
  When I create an account with no parameters
  Then I should see a message "Password can't be blank Password can't be blank Password is too short (minimum is 6 characters) First name can't be blank Last name can't be blank Email can't be blank Email is invalid Password confirmation can't be blank"