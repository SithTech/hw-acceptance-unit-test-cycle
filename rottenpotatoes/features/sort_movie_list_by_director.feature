Feature: search for movies by director
 
  As a movie buff
  So that I can find movies with my favorite director
  I want to include and search on director information in movies I enter
 
Background: movies in database
 
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

# The 3 given tests

Scenario: add director to existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Alien" should be "Ridley Scott"
 
Scenario: find movie with same director
  Given I am on the details page for "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"
 
Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"
  


# My own 3 Cucumber tests

Scenario: remove director from existing movie and test sad path
  When I go to the edit page for "THX-1138"
  And  I fill in "Director" with ""
  And  I press "Update Movie Info"
  Then  I should be on the details page for "THX-1138"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'THX-1138' has no director info"
  
 
Scenario: test the 'Back to movie list' link from the similar movies page
  Given I am on the details page for "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  When  I follow "Back to movie list"
  Then  I should be on the home page
 
Scenario: test a long and pointless path
  Given I am on the home page
  Then  I go to the details page for "Alien"
  And   I should not see "Ridley Scott"
  When  I follow "Edit"
  Then  I should be on the edit page for "Alien"
  And   I fill in "Director" with "George Lucas"
  And   I press "Update Movie Info"
  Then  I go to the details page for "Alien"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Alien"
  And   I should see "THX-1138"
  And   I should see "Star Wars"
  But   I should not see "Blade Runner"
  When  I follow "More about Star Wars"
  Then  I should be on the details page for "Star Wars"
  Then  I follow "Back to movie list"
  And   I should be on the home page
  
  
  