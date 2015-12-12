Feature: editing an existing item in seller's books
    As a seller
    So that I can edit items I am selling
    I want an edit button to change what I am selling
  
Background: ssmith has logged in and on mybooks page
    Given the database is seeded
    Given ssmith has logged in
    And ssmith is on the MyBooks page
    And ssmith has selected to edit "Medical Imaging"

Scenario: change price
    When I change field "Buy Now Price" to "2.00"
    And  ssmith is on the MyBooks page
    Then the "Buy Now Price $" of "Medical Imaging" should be "$2.00"


Scenario: change author
    When I change field "Author" to "Ron"
    And  ssmith is on the MyBooks page
    Then the "Author" of "Medical Imaging" should be "Ron"

Scenario: deleting too much information
  When I change field "Author" to ""
  Then I should see flash message "Author can't be blank"