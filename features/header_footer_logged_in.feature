@header_footer @all
Feature: Verification of header and footer links across the site

  Background: creating a user to view headers/footers behind the pay wall
    Given I create a user
    And I fill in the payment form fields with all the credentials
    And I submit the payment form

  Scenario Outline: Verifying footer links on "<page_name>"\
    Given I am on "<page_name>"
    When I scroll to the "#tombstone" of the page
    Then links in page should have paths:
    | LINK_NAME                | LINK_LOCATION    | LINK_PATH                           |
    | About Feeln              |                  | /about                              |
    | Careers                  |                  | http://hallmarklabs.applytojob.com/apply  |
    | Blog                     |                  | http://blog.feeln.com/              |
    | Hallmark.com             |                  | http://hallmark.com/                |
    | Hallmark eCards          |                  | https://www.hallmarkecards.com/     |
    | Help                     |                  | http://customercare.feeln.com/      |
    | Accessibility            |                  | /accessibility                      |
    | Contact                  |                  | http://customercare.feeln.com/      |
    | Privacy Policy           |                  | /privacypolicy                      |
    | Terms & Conditions       |                  | /termsandconditions                 |
    | Supported Devices        |                  | /supported-devices                  |
    | Activate Your Device     |                  | /activate                           |
    | All Categories           |                  | /all-categories                     |
    | Redeem Gift Card         |                  | /giftcards                          |

    Examples:

    | page_name                      |
    | the login page                 |
    | the homepage                   |
    | the forgot password page       |
    | the all categories page        |
    | the terms and conditions page  |
    | the privacy policy page        |
    | the forgot password page       |
    | the all movies page            |
    | the hallmark hall of fame page |
    | the series page                |
    | the feeln originals page       |
    | the supported devices page     |
    | the prices and membership page |
    | the most popular page          |
    | the new movies page            |
    | the kids movies page           |
    | the search page                |
    | the account page               |
    | the activate devices page      |
    | the watchlist page             |
    | the history page               |

  Scenario Outline: Verifying header on <page_name> while logged in
    And I wait for 5 seconds
    And I submit the payment form
    Given I am on <page_name>
    Then links in page should have paths:
    | LINK_NAME             | LINK_LOCATION    | LINK_PATH                     |
    | Log Out               |                  | /logout                       |
    | MOVIES                |                  | /movies/all-movies            |
    | HALLMARK HALL OF FAME |                  | /movies/hallmark-hall-of-fame |
    | SERIES                |                  | /tv/series			           |
    | ORIGINALS             |                  | /short-films/feeln-originals  |

    Examples:
      | page_name                      |
      | the login page                 |
      | the home page                  |
      | the forgot password page       |
      | the all categories page        |
      | the terms and conditions page  |
      | the privacy policy page        |
      | the forgot password page       |
      | the all movies page            |
      | the hallmark hall of fame page |
      | the series page                |
      | the feeln originals page       |
      | the supported devices page     |
      | the prices and membership page |
      | the most popular page          |
      | the new movies page            |
      | the kids movies page           |
      | the search page                |
      | the account page               |
      | the activate devices page      |
      | the watchlist page             |
      | the history page               |