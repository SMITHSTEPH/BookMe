Feature: View seller's books
    As a seller
    So that I can look at everything I am selling
    I want a view that shows me information about the books I'm selling

Background: user has logged in and on homepage #implement more of the login stuff next iteration
  Given the database is seeded
  Given ssmith has logged in
  
  
Scenario: view the book you're selling
  When ssmith is on the MyBooks page
  Then I should see all of the books I am selling