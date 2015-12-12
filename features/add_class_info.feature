Feature: Add class information to books
  As a seller
  So that users can find my books for a certain class
  I want to add the class number to my book
  
Background: ssmith has logged in and on mybooks page
  Given the database is seeded
  Given ssmith has logged in
 
Scenario: viewing buy now price on the show book page
    When I am viewing information about "Medical Imaging"
    Then I should see a "Course" section
 
Scenario: adding buy now price on the add books page
  When ssmith is on the MyBooks page
  And I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and "Course" to "Electronic Circuits"
  Then the new item "Course" shoud be "Electronic Circuits"
  
Scenario: editing buy now price on the edit book page
    When ssmith has selected to edit "Medical Imaging"
    And I change field "Course" to "Digital Image Processing"
    Then the new item "Course" should be "Digital Image Processing"

