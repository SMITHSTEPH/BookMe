Feature: search for books
  As a user
  So that I can look for books
  I want to have a search functionality for books 
  
  Background:
    frodo has logged in and on mybooks page
    
  Scenario: frodo can search for books by keyword
    Given frodo is on the all books page
    When frodo searches for a book by "greek"
    Then frodo sees a list with book "Classical mythology"
    