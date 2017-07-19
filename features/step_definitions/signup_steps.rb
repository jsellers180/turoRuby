# frozen_string_literal: true

# require_relative './../../features/support/clients/user_client'

user = UserClient.new
cc_info = CcClient.new
sign_up_page = SignUpPage.new
payment_page = PaymentPage.new

Given(/^I verify the placeholder text on the sign up page$/) do
  expect(page).to have_field(sign_up_page.fname_field)
  expect(page).to have_field(sign_up_page.lname_field)
  expect(page).to have_field(sign_up_page.email_field)
  expect(page).to have_field(sign_up_page.email_retype_field)
  expect(page).to have_field(sign_up_page.password_field)
end

When(/^I fill in the form with (.*?)$/) do |condition|
  @valid_email = user.user_email
  case condition.strip.downcase
  when 'an invalid email'
    sign_up_page.fill_first_name(user.user_fname)
    sign_up_page.fill_last_name(user.user_lname)
    sign_up_page.fill_password(user.user_password)
    sign_up_page.fill_email('asdasd')
    sign_up_page.fill_confirm_email('asdasd')
  when 'a too short password'
    sign_up_page.fill_first_name(user.user_fname)
    sign_up_page.fill_last_name(user.user_lname)
    sign_up_page.fill_password(user.user_password(1, 7))
    sign_up_page.fill_email(@valid_email)
    sign_up_page.fill_confirm_email(@valid_email)
  when 'only email and password'
    sign_up_page.fill_password(user.user_password)
    sign_up_page.fill_email(@valid_email)
    sign_up_page.fill_confirm_email(@valid_email)
  when 'mismatching emails'
    sign_up_page.fill_first_name(user.user_fname)
    sign_up_page.fill_last_name(user.user_lname)
    sign_up_page.fill_password(user.user_password)
    sign_up_page.fill_email(@valid_email)
    sign_up_page.fill_confirm_email('someotheremail@mailcatch.com')
  when 'all the valid credentials'
    @user_fname = user.user_fname
    sign_up_page.fill_first_name(@user_fname)
    @user_lname = user.user_lname
    sign_up_page.fill_last_name(@user_lname)
    @user_password = user.user_password
    sign_up_page.fill_password(@user_password)
    sign_up_page.fill_email(@valid_email)
    sign_up_page.fill_confirm_email(@valid_email)
  when 'nothing'
    # no inputs here
  else
    puts 'Invalid entries'
  end
end

Given(/^I display all the user info$/) do
  puts @valid_email, @user_lname, @user_fname, @user_password
end

When(/^I submit the (.*?) form$/) do |condition|
  case condition.strip.downcase
  when 'user create'
    sleep 5
    sign_up_page.click_continue
  when 'payment'
    payment_page.click_start
    sleep 30
  end
end

When(/^I am taken to the payment page$/) do
  find("input[name='#{payment_page.radio_id}']", match: :first)
  puts "Account successfully created\n Email: #{@valid_email}"
end

Given(/^I create a user$/) do
  step 'I am on the sign up page'
  step 'I fill in the form with all the valid credentials'
  step 'I submit the user create form'
  step 'I display all the user info'
end

Given(/^I entitle a user$/) do
  step 'I create a user'
  step 'I fill in the payment form fields with all the credentials'
  step 'I select monthly subscription'
  step 'I submit the payment form'
end

Given(/^I entitle a user with verification$/) do
  step 'I create a user'
  step 'I fill in the payment form fields with all the credentials'
  step 'I select monthly subscription'
  step 'I submit the payment form'
  step 'I follow "Start Watching!"'
  step 'I should see "WELCOME TO FEELN!"'
  step 'I should see the Welcome back message'
  step 'I click the Log Out link'
  step 'I wait for 5 seconds'
end

Given(/^I entitle 100 users$/) do
  2.times do
    step 'I entitle a user with verification'
  end
end

When(/^I capture the current url$/) do
  purchaseUrl = URI.parse(current_url)
  puts purchaseUrl.to_s
end


When(/^I fill in the payment form fields with (.*?)$/) do |condition|
  case condition.strip.downcase
  when 'no name on card'
    payment_page.fill_cc(cc_info.cc_num)
    payment_page.fill_zip(cc_info.zip_code)
    payment_page.fill_cvn(cc_info.cvn)
    # payment_page.fill_full_name(cc_info.full_name)
    payment_page.select_exp_month(cc_info.exp_month)
    payment_page.select_exp_year(cc_info.exp_year)
  when 'invalid credit card number'
    payment_page.fill_cc('1111111111111111')
    payment_page.fill_zip(cc_info.zip_code)
    payment_page.fill_cvn(cc_info.cvn)
    payment_page.fill_full_name(cc_info.full_name)
    payment_page.select_exp_month(cc_info.exp_month)
    payment_page.select_exp_year(cc_info.exp_year)
  when 'all the credentials'
    payment_page.fill_cc(cc_info.cc_num)
    payment_page.fill_zip(cc_info.zip_code)
    payment_page.fill_cvn(cc_info.cvn)
    payment_page.fill_full_name(cc_info.full_name)
    payment_page.select_exp_month(cc_info.exp_month)
    payment_page.select_exp_year(cc_info.exp_year)
    page.has_css?(payment_page.start_watching_button,
                  text: payment_page.start_text,
                  visible: true)
  when 'nothing'
    # no inputs here
  end
end

Given(/^I select (.*?) subscription$/) do |type|
  case type.strip.downcase
  when 'monthly'
    choose(payment_page.monthly_radio, match: :first)
  else
    puts 'Defaulting to annual'
  end
end

And(/^I should see the Welcome back message$/) do
  expect(page).to have_content("Welcome back #{@user_fname}")
end

Then(/^I should see an (.*?) error$/) do |error_message|
  expect(page).to have_content(error_message)
end

# Given(/^I should receive email with the password reset information$/) do
#  sleep 60
#  Gmail.connect("spiritclipsqa@gmail.com", "spiritqa123") do |gmail|
#    assert gmail.inbox.find(:unread).count >= 1
#    gmail.inbox.find(:unread, :subject => "").each do |email|
#  assert_equal(email.message.subject,
# "Welcome to SpiritClips from Hallmark!",
# "\nEmail subject does not match\n")
# message_body = If you're still having trouble logging in, please email
#      assert email.message.body.match(/message_body/)
#    end
#  end
# end
