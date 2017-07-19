# frozen_string_literal: true

login_page = LoginPage.new
user = UserClient.new

Given(/^I enter login details$/) do
  fill_in(login_page.email_field, with: @valid_email)
  fill_in(login_page.password_field, with: @user_password)
end

Given(/^I login to Feeln$/) do
  step 'I enter login details'
  step 'I click the Login to Feeln link'
end

Given(/^I fill in the login form with (.*?)$/) do |login_test|
  case login_test
  when 'invalid email and password'
    fill_in(login_page.email_field, with: user.user_email)
    fill_in(login_page.password_field, with: user.user_password(2, 5))
    sleep 5
    step 'I click the Login to Feeln link'
  when 'invalid email and no password'
    fill_in(login_page.email_field, with: user.user_email)
  when 'valid email and an invalid password'
    fill_in(login_page.email_field, with: @valid_email)
    fill_in(login_page.password_field, with: user.user_password(2, 5))
    sleep 5
    step 'I click the Login to Feeln link'
  when 'valid email and invalid password four times'
    4.times do
      step 'I fill in the login form with valid email and an invalid password'
    end
  end
end

Given(/^I click the (.*?) link$/) do |click_link|
  case click_link
  when 'Log Out'
    visit path_to(click_link).to_s    # login_page.click_logout
    sleep 15
    # page.should have_css('#Log In')
    # find('.hidden-xs.hidden-sm.account-nav>a')
    # TODO: expect(login_page.login_link).to include("Log In")
  when 'Log In'
    login_page.click_login_link
    sleep 15
  when 'Sign Up'
    login_page.click_sign_up_link
    sleep 15
  when 'Login to Feeln'
    click_button(login_page.login_btn)
    sleep 5
  when 'Forgot your password?'
    login_page.click_forgot_password_link
    sleep 15
  end
end

Given(/^I check for "([^"]*)" within cookies$/) do |cookie_name|
  assert page.driver.browser.cookies[cookie_name].present?
end

Given(/^I check for "([^"]*)" within cookies does not exist$/) do |cookie_name|
  assert page.driver.browser.cookies[cookie_name].nil?
end
