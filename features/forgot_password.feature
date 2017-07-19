@forgot_password @all

Feature: Verifying forgot password flow

Scenario: Verifying Forgot your password link on login page
  Given I am on the login page
  When I click the Forgot your password? link
  Then I should see "FORGOT PASSWORD"
  And I should see "email"

Scenario: Requesting password reset with a valid email
  Given I create a user
  And I click the Log Out link
  And I click the Log In link
  And I click the Forgot your password? link
  When I request a password reset with a valid email
  Then I should see a reset success message

Scenario: Requesting password reset with an invalid email
  Given I am on the login page
  And I click the Forgot your password? link
  When I request a password reset with an invalid email
  Then I should see "An account cannot be found with this email address. Please try again."
  
Scenario: Four failed attempts leads to forgot password page
  Given I create a user
  And I click the Log Out link
  And I click the Log In link
  When I fill in the login form with valid email and invalid password four times
  Then I should see "You have attempted to log in too many times. Please reset your password and try again." within ".alert-danger"