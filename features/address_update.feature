@address_update @all

Feature: Verifying company address on the following pages

Scenario: Verifying Terms and Conditions New Company Address is shown
  Given I am on the terms and conditions page
  Then I should see "3130 Wilshire Blvd. 4th Flr. Santa Monica, CA 90403"

Scenario: Verifying Terms and Conditions Old Company Address not shown
  Given I am on the terms and conditions page
  Then I should not see "1990 South Bundy Dr. Suite 620, Los Angeles, CA 90025"
  Then I should not see "1990 S. Bundy Ave, Los Angeles, California, 90025, USA"

  Scenario: Verifying Privacy Policy page New Company Address is shown
    Given I am on the privacy policy page
    Then I should see "3130 Wilshire Blvd. 4th Flr. Santa Monica, CA 90403"

  Scenario: Verifying Privacy Policy page Old Company Address not shown
    Given I am on the privacy policy page
    Then I should not see "1990 South Bundy Dr. Suite 620, Los Angeles, CA 90025"
    Then I should not see "1990 S. Bundy Ave, Los Angeles, California, 90025, USA"