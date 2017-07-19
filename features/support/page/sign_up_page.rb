# sign up page object definition
class SignUpPage
  # require 'spec_helper'
  # require 'capybara/rails'
  # extend Capybara::DSL
  include Capybara::DSL

  def fill_first_name(fname)
    fill_in "#{fname_field}", with: fname
  end

  def fill_last_name(lname)
    fill_in "#{lname_field}", with: lname
  end

  def fill_email(email)
    fill_in "#{email_field}", with: email
  end

  def fill_confirm_email(email)
    fill_in "#{email_retype_field}", with: email
  end

  def fill_password(password)
    fill_in "#{password_field}", with: password
  end

  def lname_field
    'last-name'
  end

  def fname_field
    'first-name'
  end

  def password_field
    'password'
  end

  def email_field
    'email'
  end

  def email_retype_field
    'email-retype'
  end

  def click_continue
    click_button('Continue')
  end



end