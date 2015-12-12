Feature: remove the selected book from the existing seller books
    As a seller
    So that I can I remove a textbook
    I want to remove a textbook from the site
 
Background: user has logged in and on homepage #implement more of the login stuff next iteration
  Given the database is seeded
  Given ssmith has logged in


Scenario: remove item from  existing collection of seller items
  When I remove a book with title "Algorithm Design"
  And ssmith is on the MyBooks page
  Then I should not see a book with title "Algorithm Design" in MyBooks