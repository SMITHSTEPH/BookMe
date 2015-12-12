Feature: Buyer bid notification
  As a buyer
  So that I can know if someone has outbid me
  I want to receive a notifcation when a new bid has been placed
  
  Background: user has logged in and on homepage #implement more of the login stuff next iteration
    Given the database is seeded
    
  Scenario: User bid
     When sarah has logged in
     And placed a "30.00" bid on "Algorithm Design"
     Then "segerard" should have placed the highest bid on "Algorithm Design"
 
 
  Scenario: Someone is outbid
    When sarah has logged in
    And placed a "30.00" bid on "Algorithm Design"
    Then "segerard" should have placed the highest bid on "Algorithm Design"
    When ssmith has logged in
    And placed a "31.00" bid on "Algorithm Design"
    And sarah has logged in
    Then sarah should have a mybids notification