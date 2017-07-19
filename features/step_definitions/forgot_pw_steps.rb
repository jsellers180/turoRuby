# frozen_string_literal: true

login_page = LoginPage.new
user = UserClient.new

Given(/^I request a password reset with (.*?)$/) do |condition|
  case condition
  when 'a valid email'
    expect(page).to have_field(login_page.forgot_pw_email_field)
    fill_in(login_page.forgot_pw_email_field, with: @valid_email)
    click_button(login_page.forgot_pw_btn)
    sleep 15
  when 'an invalid email'
    fill_in(login_page.forgot_pw_email_field, with: user.user_email)
    click_button(login_page.forgot_pw_btn)
    sleep 15
  end
end

Then(/^I should see a reset success message$/) do
  expect(page).to have_content(login_page.reset_success_msg)
end
