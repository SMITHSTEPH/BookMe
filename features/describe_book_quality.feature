Feature: Describing book quality
  As a seller
  So that I can give an accurate representation of the book that I am selling
  I want to decribe the quality of the book with terms like 'new', 'gently used' using radio buttons
  
  
Background: ssmith32 has logged in and on mybooks page
 Given that ssmith32 has logged in
 Given ssmith32 is selling the following books:
  | title                                                              | author            | isbn               | quality | price | description                      | image                                                                           | auction_start_price |
  | Algorithm Design                                                   | Kleinberg Tardos  | 978-81-317-0310-6  | great   | 50.00 | for juinor ece class             | http://ecx.images-amazon.com/images/I/51BHNytrZCL._SX258_BO1,204,203,200_.jpg   | 2.00                |
  | Medical Imaging                                                    | Sonka Fitzpatrick | 0-8194-3622-4      | fair    | 60.00 | for a biomed grad level course   | http://ecx.images-amazon.com/images/I/418rcJjNnVL._SX335_BO1,204,203,200_.jpg   | 3.00                |
  | The adventures of Tom Sawyer                                       | Mark Twain        | 0451526538         | fair    | 40.00 | for rhetoric                     | https://covers.openlibrary.org/b/id/295577-S.jpg                                | 1.00                |
  | Classical Electromagnetic Theory (Fundamental Theories of Physics) | Jack VanderLinde  | 1402026994         | great   | 10.00 | great intro to em theory         | https://covers.openlibrary.org/b/id/1733064-S.jpg                               | 5.00                |
  | Calculus: Early Transcendentals                                    | James Stewart     | 1285741552         | fair    | 20.00 | freshman year calc               | http://ecx.images-amazon.com/images/I/51SWN%2BQre0L._SX258_BO1,204,203,200_.jpg | 1.00                |


Scenario:  information
  When I am on the add book page
  Then there should be a quality select box
    
Scenario: edit information
  When ssmith32 is on the MyBooks page
  And ssmith32 has selected to edit "The adventures of Tom Sawyer"
  Then there should be a quality select box

