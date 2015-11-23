Feature: Tagging books with keywords
    As a seller
    So that my books can easily be found
    I want to tag them keywords

Background: ssmith32 has logged in and is selling the following books
 Given that ssmith32 has logged in
 Given ssmith32 is selling the following books:
  | title                                                              | author            | isbn               | quality | price | description                      | image                                                                           | auction_start_price |
  | Algorithm Design                                                   | Kleinberg Tardos  | 978-81-317-0310-6  | great   | 50.00 | for juinor ece class             | http://ecx.images-amazon.com/images/I/51BHNytrZCL._SX258_BO1,204,203,200_.jpg   | 2.00                |
  | Medical Imaging                                                    | Sonka Fitzpatrick | 0-8194-3622-4      | fair    | 60.00 | for a biomed grad level course   | http://ecx.images-amazon.com/images/I/418rcJjNnVL._SX335_BO1,204,203,200_.jpg   | 3.00                |
  | The adventures of Tom Sawyer                                       | Mark Twain        | 0451526538         | fair    | 40.00 | for rhetoric                     | https://covers.openlibrary.org/b/id/295577-S.jpg                                | 1.00                |
  | Classical Electromagnetic Theory (Fundamental Theories of Physics) | Jack VanderLinde  | 1402026994         | great   | 10.00 | great intro to em theory         | https://covers.openlibrary.org/b/id/1733064-S.jpg                               | 5.00                |
  | Calculus: Early Transcendentals                                    | James Stewart     | 1285741552         | fair    | 20.00 | freshman year calc               | http://ecx.images-amazon.com/images/I/51SWN%2BQre0L._SX258_BO1,204,203,200_.jpg | 1.00                |
 
 
  
Scenario: viewing keywords on the show book page
    When I am viewing information about "Calculus: Early Transcendentals"
    Then I should see a "Keyword" section
    
Scenario: tagging keywords to a book on the add books page
    When I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and keywords "circuits", "engineering", and "electronics"
    Then the book should have the keywords "circuits", "engineering", and "electronics"
    
Scenario: editing keywords for a book on the edit book page
  When ssmith32 is on the MyBooks page
  And ssmith32 has selected to edit "Calculus: Early Transcendentals"
  And I have put in the keywords "rhetoric", "classic", and "english"
  Then the book should have the keywords "rhetoric", "classic", and "english"
  