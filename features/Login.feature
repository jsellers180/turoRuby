@smoketest @login @all

Feature: Verifying User Login
  Checking the response on login page for various scenarios

Background: Creating a user for the following test cases
  Given I entitle a user
  And I click the Log Out link
  And the page title should be "Feeln - Watch Family Movies & Shows Online"

Scenario: Verifying sign up link on login page
  Given I click the Log In link
  And I click the Sign Up link
  Then I should see "START WATCHING!" within ".HeadingAlt"

Scenario Outline: Login with "<neg test case>"
  Given I click the Log In link
  And I fill in the login form with <neg test case>
  Then <result>

  Examples:
  | neg test case                       | result                                                                        |
  | no inputs                           | id "submit" is disabled                                                       |
  | invalid email and no password       | id "submit" is disabled                                                       |
  | invalid email and password          | I should see "Unable to log you in. Please check your email and/or password." |
  | valid email and an invalid password | I should see "Unable to log you in. Please check your email and/or password." |

Scenario: Login with valid Email and Password
  And I click the Log In link
  And I display all the user info
  When I login to Feeln
  Then I should see "Welcome back"
  And I click the Log Out link

Scenario: Checking for "remember username" cookie
  Given I click the Log In link
  And I enter login details
  And I check "rememberMe"
  And I click the Login to Feeln link
  Then I should see "Welcome back"
  Then I check for "userName" within cookies
  And I click the Log Out link

Scenario: Verifying the "Remember me" cookie does not exist when not checked
  Given I am on the login page
  And I login to Feeln
  Then I should see "Welcome back"
  Then I check for "userName" within cookies does not exist
  And I click the Log Out link

Scenario: Verifying My Account page
  Given I am on the login page
  And I login to Feeln
  And I wait for the selector: ".account"
  And I click the ".close" css element
  When I click the ".account" css element
  Then links in page should have paths:
    | LINK_NAME            | LINK_LOCATION    | LINK_PATH           |
    | My Account           |                  | /account            |
    | Activate Your Devices|                  | /activate           |
    | My Watchlist         |                  | /account/watchlist  |
    | History              |                  | /account/history    |
    | Log Out              |                  | /logout             |
  And I click the ".account" css element
  And I click the Log Out link

Scenario: Verifying burger links
  Given I am on the login page
  And I login to Feeln
  And I click the ".close" css element
  When I click the ".browse" css element
  Then links in page should have paths:
    |  LINK_NAME              |  LINK_LOCATION    |  LINK_PATH                      |
    |  Supported Devices      |                   |  /supported-devices             |
    |  Most Popular           |                   |  /movies/most_popular           |
    |  New on Feeln           |                   |  /movies/new-movies             |
    |  Kids                   |                   |  /movies/kids                   |
  And I click the Log Out link