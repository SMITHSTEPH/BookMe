Feature: Set buy now price
  As a seller
  So that someone can buy my book instantly
  I want to set a 'buy now' price
  
Background: ssmith32 has logged in and on mybooks page
    Given that ssmith32 has logged in
    Given ssmith32 is selling the following books:
    | title                                                              | author            | isbn               | quality | price | description                      | image                                                                           | auction_start_price |
    | Algorithm Design                                                   | Kleinberg Tardos  | 978-81-317-0310-6  | great   | 50.00 | for juinor ece class             | http://ecx.images-amazon.com/images/I/51BHNytrZCL._SX258_BO1,204,203,200_.jpg   | 2.00                |
    | Medical Imaging                                                    | Sonka Fitzpatrick | 0-8194-3622-4      | fair    | 60.00 | for a biomed grad level course   | http://ecx.images-amazon.com/images/I/418rcJjNnVL._SX335_BO1,204,203,200_.jpg   | 3.00                |
    | The adventures of Tom Sawyer                                       | Mark Twain        | 0451526538         | fair    | 40.00 | for rhetoric                     | https://covers.openlibrary.org/b/id/295577-S.jpg                                | 1.00                |
    | Classical Electromagnetic Theory (Fundamental Theories of Physics) | Jack VanderLinde  | 1402026994         | great   | 10.00 | great intro to em theory         | https://covers.openlibrary.org/b/id/1733064-S.jpg                               | 5.00                |
    | Calculus: Early Transcendentals                                    | James Stewart     | 1285741552         | fair    | 20.00 | freshman year calc               | http://ecx.images-amazon.com/images/I/51SWN%2BQre0L._SX258_BO1,204,203,200_.jpg | 1.00                |

Scenario: viewing buy now price on the show book page
    When I am viewing information about "The adventures of Tom Sawyer"
    Then I should see a "Buy Now Price" section
 
Scenario: adding buy now price on the add books page
  When I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and "Buy Now Price" to "30.00"
  Then the new item "Buy Now Price" should be "30.00"
  
Scenario: editing buy now price on the edit book page
    When ssmith32 has selected to edit "The adventures of Tom Sawyer"
    And I change field "Buy Now Price" to "40.00"
    Then the new item "Buy Now Price" should be "40.00"