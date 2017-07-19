@smoketest @signup @all

Feature: Sign up flow for feeln.com

Scenario: Verify all fields are present
  Given I am on the sign up page
  When I verify the placeholder text on the sign up page

Scenario Outline: Registration with "<reg test case>"
  Given I am on the sign up page
  And I fill in the form with <reg test case>
  Then id "submit" is disabled

  Examples:
  | reg test case           |
  | only email and password |
  | an invalid email        |
  | a too short password    |
  | nothing                 |

Scenario: Registration with mismatching emails
  Given I am on the sign up page
  And I fill in the form with mismatching emails
  When I submit the user create form
  Then I should see an Emails do not match. error

  Scenario: Registration with valid credentials
  Given I am on the sign up page
  And I fill in the form with all the valid credentials
  When I submit the user create form
  Then I am taken to the payment page
  And I display all the user info

Scenario Outline: Submitting payment page with "<payment test case>"
  Given I create a user
  When I fill in the payment form fields with <payment test case>
  Then id "btn-submit" is disabled

  Examples:
  | payment test case           |
  | nothing                     |
  | no name on card             |
  | invalid credit card number  |

  @test2
Scenario Outline: Registration with all valid inputs for "<sub_type>" subscription
  Given I create a user
  And I fill in the payment form fields with all the credentials
  When I select <sub_type> subscription
  And I submit the payment form
  Then I should see "WELCOME TO FEELN!"
  And I capture the current url
  And I follow "Start Watching!"
  And I should see the Welcome back message
  And I follow "Log Out"

  Examples:
  | sub_type |
  | annual   |
  | monthly  |