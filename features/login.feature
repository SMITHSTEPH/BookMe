Feature: login to an account 
  As a user
  So that I can view books
  I want to login to my account 
  
Background: I have visited the login page 
  Given I am on the login page and have an account
  
Scenario: I login with valid credentials 
    When I login with email "b@b.com" and password "password"
    Then I should see the flash message "You are logged in as b@b.com (User name: bdunham)"

Scenario: I try to login with invalid credentials
  When I try to login with email "d@b.com" and password "password"
  Then I should see the message "Invalid email/password combination"