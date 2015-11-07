Feature: Allow BookMe user add a new book to sell

Scenario:  Add a book to sell (Declarative)
  When I have added a book with title "Algorithm Design", author "Kleinberg Tardos", isbn "978-81-317-0310-6", quality "great", and price "50.00"
  And I am on my user page for BookMe 
  Then I should see a book listed for sale with title "Algorithm Design", author "Kleinberg Tardos", isbn "978-81-317-0310-6", quality "great", and price "50.00"