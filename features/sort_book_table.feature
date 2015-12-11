Feature: display list of all books sorted by different criteria
 
  As an user
  So that I can quickly browse books based on what i want
  I want to see books sorted by title or release date

Background: books have been added to database and user is on home page
  
  Given the following books have been added to BookMe: 
  | title                                                                       | author                | price        | bid_price |
  | Medical Imaging                                                             | Sonka Fitzpatrick     | 60.00        | 25.00     |
  | Image Processing Analysis, and Machine Vision                               | Sonka Hlavac Boyle    | 55.00        | 25.00     |
  | A Guide to Latex                                                            | Kopka Daly            | 40.00        | 10.00     |
  | Engineering Software as a Service: An Agile Approach Using Cloud Computing  | Fox Patterson         | 35.00        | 15.00     |
  | Algorithm Design                                                            | Kleinberg Tardos      | 50.00        | 20.00     |

  And I am on the BookMe home page

Scenario: sort books by title
  When I have sorted books by title
  Then I should see book title "Algorithm Design" before "Medical Imaging"
  
Scenario: sort books by author
  When I have sorted books by author
  Then I should see author "Fox Patterson" before "Kopka Daly"
  
Scenario: sort books in increasing order of buy now price
  When I have sorted books by buy now price
  Then I should see price "35.00" before "55.00"
  
Scenario: sort books in increasing order of auction price
  When I have sorted books by auction price
  Then I should see auction price "10.00" before "25.00"