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
    When I change field "description" to "used in my rhetoric class"
    Then the description of of Calculus should be "$60"

Scenario: change description
    When I change field "price"to "$60"
    Then the description of of Calculus should be "used in my rhetoric class"
    
Scenario: change author
    When I change field "author" to "Ron"
    Then the description of Author should be "Ron"

Scenario: deleting too much information
  When I change field "title" to ""
  Then I should see the flash warning "need to have * fields filled out"