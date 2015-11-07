Feature: View seller's books
    As a seller
    So that I can look at everything I am selling
    I want a view that shows me information about the books I'm selling

Background: user has logged in and on homepage #implement more of the login stuff next iteration
  Given sgerard is selling the following books:
  | title                                                              | author            | isbn               | quality | price  | description                      | image                                                                           |
  | Algorithm Design                                                   | Kleinberg Tardos  | 978-81-317-0310-6  | great   | $50.00 |                                  | http://ecx.images-amazon.com/images/I/51BHNytrZCL._SX258_BO1,204,203,200_.jpg   |
  | Medical Imaging                                                    | Sonka Fitzpatrick | 0-8194-3622-4      | fair    | $60.00 | for a biomed grad level course   | http://ecx.images-amazon.com/images/I/418rcJjNnVL._SX335_BO1,204,203,200_.jpg   |
  | The adventures of Tom Sawyer                                       | Mark Twain        | 0451526538         | fair    | $40.00 | for rhetoric                     | https://covers.openlibrary.org/b/id/295577-S.jpg                                |
  #| Java                                                               | Paul J Deitel     | 0136053068         | bad     | $2.00  | for intro to software design     | http://www-fp.pearsonhighered.com/assets/hip/images/bigcovers/0132575663.jpg    |                       |
  | Classical Electromagnetic Theory (Fundamental Theories of Physics) | Jack VanderLinde  | 1402026994         | great   | $10.00 | great intro to em theory         | https://covers.openlibrary.org/b/id/1733064-S.jpg                               |
  | Calculus: Early Transcendentals                                    | James Stewart     | 1285741552         | fair    | $20.00 |                                  | http://ecx.images-amazon.com/images/I/51SWN%2BQre0L._SX258_BO1,204,203,200_.jpg |
 
Scenario: view the book you're selling
  When sgerard is on the MyBooks page
  Then I should see all of the books I am selling