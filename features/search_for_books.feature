Feature: search for books
  As a user
  So that I can look for books
  I want to have a search functionality for books 
  
  Background: books have been added to database and user is on home page
  
  Given the following books have been added to BookMe: 
  | title                                                                       | author                | price        | bid_price | department | isbn      | auction_price |
  | Medical Imaging                                                             | Sonka Fitzpatrick     | 60.00        | 25.00     | music      | 0451526538| 25.00         |
  | Image Processing Analysis, and Machine Vision                               | Sonka Hlavac Boyle    | 55.00        | 25.00     | art        | 1451526538| 25.00         |
  | A Guide to Latex                                                            | Kopka Daly            | 40.00        | 10.00     | cool       | 2451526538| 10.00         |
  | Engineering Software as a Service: An Agile Approach Using Cloud Computing  | Fox Patterson         | 35.00        | 15.00     | engineering| 3451526538| 15.00         |
  | Algorithm Design                                                            | Kleinberg Tardos      | 50.00        | 20.00     | math       | 4451526538| 20.00         |

  And I am on the BookMe home page
    
  Scenario: frodo can search for books by keyword
    When frodo searches for a book by "greek"
    Then frodo sees a list with book "Classical mythology"
    
  Scenario: frodo can search for books by title
    When frodo searches for a book by "Medical"
    Then frodo sees a list with book "Medical"
    
  Scenario: frodo can search for books by author
    When frodo searches for a book by "Kopka"
    Then frodo sees a list with book "Guide"
    
  Scenario: frodo can search for books by isbn
    When frodo searches for a book by "4451526538"
    Then frodo sees a list with book "Algorithm"
    
  Scenario: frodo can search for books by department
    When frodo searches for a book by "music"
    Then frodo sees a list with book "Medical"
    
  
    
    
    