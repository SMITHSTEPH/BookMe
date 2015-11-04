Feature: View seller's books
    As a seller
    So that I can look at everything I am selling
    I want a view that shows me information about the books I'm selling

Background: user has logged in
  
  Given ssmith is logged into BookMe
  And ssmith is selling the following books:
  | title   | author     | isbn       | quality            | price  | description                                       |
  | Calculus| Ron Larson | 1285057090 | Perfect condidtion | $35.00 | Used in my Calc I class at the University of Iowa |
  |
 
  And I have selected to edit book titled "Calculus" and isbn "1285057090"