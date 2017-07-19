require 'faker'
require_relative '../page/sign_up_page'
# common usage methods for user creation
class UserClient
attr_reader :valid_email, :valid_password

  def test_time
    Time.now.to_i
  end

  def user_email
    @valid_email = [Faker::Internet.slug,
     Time.now.to_i,
     '@mailcatch.com'].join
  end

  def user_fname
    Faker::Name.first_name
  end

  def user_lname
    Faker::Name.last_name
  end

  def user_password(min = 10, max = 20)
   @valid_password = Faker::Internet.password(min, max).to_s
  end
end