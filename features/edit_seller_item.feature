Feature: editing an existing item in seller's books
    As a seller
    So that I can edit items I am selling
    I want an edit button to change what I am selling
  
Background: user has logged in
  
  Given ssmith is logged into BookMe
  And I am on the seller items page
  And I have added "Calculus" to the books
  And I have selected to edit book titled "Calculus" and isbn "1285057090"

Scenario: change price
    When I change price to "$60"
    Then the price of of "Calculus should be $60"

Scenario: change condition

Scenario: invalid change