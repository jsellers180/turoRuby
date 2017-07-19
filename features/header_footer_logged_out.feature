@header_footer @all
Feature: Verification of header and footer links across the site

  Scenario Outline: Verifying footer links on "<page_name>"
    Given I am on "<page_name>"
    When I scroll to the "#tombstone" of the page
    Then links in page should have paths:
      | LINK_NAME                | LINK_LOCATION    | LINK_PATH                           |
      | About Feeln              |                  | /about                              |
      | Careers                  |                  | http://hallmarklabs.applytojob.com/apply  |
      | Blog                     |                  | http://blog.feeln.com/              |
      | Hallmark.com             |                  | http://hallmark.com/                |
      | Hallmark eCards          |                  | https://www.hallmarkecards.com/     |
      | Help                     |                  | https://feeln.zendesk.com/hc/en-us/ |
      | Accessibility            |                  | /accessibility                      |
      | Contact                  |                  | https://feeln.zendesk.com/hc/en-us/ |
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

  Scenario Outline: Verifying header on <page_name> while logged out
    Given I am on <page_name>
    Then links in page should have paths:
      | LINK_NAME             | LINK_LOCATION    | LINK_PATH                     |
      | Join NOW!             |                  | /signup/startnow              |
      | Log In                |                  | /login                        |
      | MOVIES                |                  | /movies/all-movies            |
      | HALLMARK HALL OF FAME |                  | /movies/hallmark-hall-of-fame |
      | SERIES                |                  | /tv/series		             |
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

  Scenario: Verifying footer links on sign up page
    Given I am on the sign up page
    Then I scroll to the "#tombstone" of the page
    Then I should see the selector ".logo-hallmark-footer"

  Scenario: Verifying header on sign up page
    Given I am on the sign up page
    Then links in page should have paths:
      | LINK_NAME | LINK_LOCATION | LINK_PATH |
      | Log In    |               | /login    |