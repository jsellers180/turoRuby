require 'faker'
require 'luhnacy'
require 'time'
# class containing methods to generate cc info
class CcClient
  def cc_num
    Luhnacy.generate(16, prefix: '53')
  end

  def zip_code
    Faker::Address.zip
  end

  def cvn
    Faker::Number.number(3)
  end

  def full_name
    Faker::Name.name
  end

  def exp_month
    month = Faker::Number.between(01, 12)
    sprintf("%2.2d", month)
  end

  def exp_year
    Faker::Number.between(2018, 2032)
  end

end