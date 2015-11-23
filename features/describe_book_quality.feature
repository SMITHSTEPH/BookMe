Feature: Describing book quality
  As a seller
  So that I can give an accurate representation of the book that I am selling
  I want to decribe the quality of the book with terms like 'new', 'gently used' using radio buttons
  
  
Background: ssmith32 has logged in and on mybooks page
 Given that ssmith32 has logged in
 
Scenario:  information
  When I am on the add book page
  Then there should be a quality select box
    
Scenario: edit information
  When ssmith32 has selected to edit "The adventures of Tom Sawyer"
  Then there should be a quality select box

