# payment page object definition
class LoginPage
  include Capybara::DSL
  def login_page
    url = "#{BASE_URL}/login"
    puts url.color(33)
    visit url
  end

  def email_field
    'email'
  end

  def password_field
    'password'
  end

  def remember_user_checkbox

  end

  def click_sign_up_link
    click_link('Sign Up')
  end

  def click_login_link
    click_link('Log In', match: :first)
  end

  def login_link
    'Log In'
  end

  def login_btn
    'Login to Feeln'
  end

  def forgot_password_link
    'Forgot your password?'
  end

  def click_forgot_password_link
    click_link('Forgot your password?')
  end

  def forgot_pw_email_field
    'email'
  end

  def forgot_pw_btn
    'Request Password'
  end

  def reset_success_msg
    "We have sent your password reset email to #{@valid_email}"
  end

  def reset_fail_msg
    'An account cannot be found with this email address. Please try again.'
  end

  def click_logout
    click_link('Log Out')
  end
end