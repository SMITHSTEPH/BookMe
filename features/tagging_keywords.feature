Feature: Tagging books with keywords
    As a seller
    So that my books can easily be found
    I want to tag them keywords

Background: ssmith has logged in and is selling the following books
  Given the database is seeded
  Given ssmith has logged in
  
Scenario: viewing keywords on the show book page
    When I am viewing information about "Medical Imaging"
    Then I should see a "Keyword" section
    
Scenario: tagging keywords to a book on the add books page
    When ssmith is on the MyBooks page
    And I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and keywords "circuits", "engineering", and "electronics"
    Then the book should have the keywords "circuits", "engineering", and "electronics"
    
Scenario: editing keywords for a book on the edit book page
  When ssmith has selected to edit "Medical Imaging"
  #And I have put in the keywords "rhetoric", "classic", and "english"
  #Then the book should have the keywords "rhetoric", "classic", and "english"
  