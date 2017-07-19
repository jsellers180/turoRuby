@smoketest @all @search
Feature: Verifying search functionality from the point of view of a paid and unpaid user

Scenario: Verifying search functionality
  Given I am on the search page
  And I fill in "ss" with "Sally"
  When I click the ".fa.fa-search.submit" css element
  Then I should see "YOUR RESULTS FOR ( SALLY )"

Scenario: The user is presented with the payment option when searching for a movie when not logged in
  Given I am on the search page
  And I fill in "ss" with "Sally"
  When I click the ".fa.fa-search.submit" css element
  And I click the first result
  Then I should see "Watch this and more!"

Scenario: The user is not shown the payment option when logged in
  Given I entitle a user
  Given I am on the search page
  And I fill in "ss" with "Sally"
  When I click the ".fa.fa-search.submit" css element
  And I click the first result
  Then I should not see "Watch this and more!"

# Scenario: Verifying a user can watch a rank=0 movie when not logged in
#  Given I am on the search page
#  And I fill in "ss" with "The Fork"
#  When I click the 0 ".fa.fa-search.submit" css element
#  Then I should see "YOUR RESULTS FOR ( THE FORK )" within ".search-results"
#  And I wait for 10 seconds
#  And I click the first result
#  Then I click the ".fa-play" css element
#  Then I wait for 10 seconds
#  Then I should see the selector "#hero-wrapper"