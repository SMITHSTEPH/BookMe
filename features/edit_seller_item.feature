Feature: editing an existing item in seller's books
    As a seller
    So that I can edit items I am selling
    I want an edit button to change what I am selling
  
Background: sgerard has logged in and on mybooks page
 Given sgerard is selling the following books:
  | title                                                              | author            | isbn               | quality | price  | description                      | image                                                                           |
  | Algorithm Design                                                   | Kleinberg Tardos  | 978-81-317-0310-6  | great   | $50.00 |                                  | http://ecx.images-amazon.com/images/I/51BHNytrZCL._SX258_BO1,204,203,200_.jpg   |
  | Medical Imaging                                                    | Sonka Fitzpatrick | 0-8194-3622-4      | fair    | $60.00 | for a biomed grad level course   | http://ecx.images-amazon.com/images/I/418rcJjNnVL._SX335_BO1,204,203,200_.jpg   |
  | The adventures of Tom Sawyer                                       | Mark Twain        | 0451526538         | fair    | $40.00 | for rhetoric                     | https://covers.openlibrary.org/b/id/295577-S.jpg                                |
  #| Java                                                               | Paul J Deitel     | 0136053068         | bad     | $2.00  | for intro to software design     | http://www-fp.pearsonhighered.com/assets/hip/images/bigcovers/0132575663.jpg    |                       |
  | Classical Electromagnetic Theory (Fundamental Theories of Physics) | Jack VanderLinde  | 1402026994         | great   | $10.00 | great intro to em theory         | https://covers.openlibrary.org/b/id/1733064-S.jpg                               |
  | Calculus: Early Transcendentals                                    | James Stewart     | 1285741552         | fair    | $20.00 |                                  | http://ecx.images-amazon.com/images/I/51SWN%2BQre0L._SX258_BO1,204,203,200_.jpg |
  And sgerard is on the MyBooks page
  And sgerard has selected to edit "Algorithm Design"

Scenario: change price
    When I change field "Price" to "$60"
    Then the "price" of "Algorithm Design" should be "$60"

Scenario: change description
    #When I change field "Description" to "used in Computer Science class"
    #Then the "description" of "Algorithm Design" should be "used in Computer Science class"
  
Scenario: change author
    When I change field "Author" to "Ron"
    Then the "author" of "Algorithm Design" should be "Ron"

Scenario: deleting too much information
  #When I change field "Author" to ""
  #Then I should see the flash warning "need to have * fields filled out"