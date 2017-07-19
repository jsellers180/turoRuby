@smoketest @homepage @all

Feature: Verifying Homepage
  Checking if all the links are working fine and all the images are getting loaded

Scenario: Verifying Images on homepage when logged out
  Given I am on the homepage
  Then I check all images are loaded