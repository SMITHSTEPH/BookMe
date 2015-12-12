Feature: Describing book quality
  As a seller
  So that I can give an accurate representation of the book that I am selling
  I want to decribe the quality of the book with terms like 'new', 'gently used' using radio buttons
  
Background: ssmith has logged in and on mybooks page
  Given the database is seeded
  Given ssmith has logged in
  
Scenario: add information
  When I am on the add book page
  Then there should be a quality select box
    
Scenario: edit information
  When ssmith is on the MyBooks page
  And ssmith has selected to edit "Medical Imaging"
  Then there should be a quality select box

