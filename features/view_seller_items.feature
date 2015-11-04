Feature: View seller's books
    As a seller
    So that I can look at everything I am selling
    I want a view that shows me information about the books I'm selling

Background: user has logged in
  
  Given ssmith is logged into BookMe
  And I am on the seller items page
  And I have added "Calculus" to the books
  And I have selected to edit book titled "Calculus" and isbn "1285057090"