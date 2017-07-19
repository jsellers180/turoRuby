# payment page object definition
class PaymentPage
  include Capybara::DSL

  def fill_cc(value)
    fill_in "#{cc_field}", with: value
  end

  def fill_zip(value)
    fill_in "#{zip_field}", with: value
  end

  def fill_cvn(value)
    fill_in "#{cvn_field}", with: value
  end

  def fill_full_name(value)
    fill_in "#{full_name_field}", with: value
  end

  def select_exp_month(value)
    page.select value, from: exp_month_dropdown
  end

  def select_exp_year(value)
    page.select value, from: exp_year_dropdown
  end

  def start_watching_button
    '.Button.marketing'
  end

  def start_text
    'Start Membership'
  end

  def cc_field
    'vin_PaymentMethod_creditCard_account'
  end

  def zip_field
    'vin_PaymentMethod_billingAddress_postalCode'
  end

  def cvn_field
    'vin_PaymentMethod_nameValues_cvn'
  end

  def full_name_field
    'vin_PaymentMethod_accountHolderName'
  end

  def radio_id
    'vin_BillingPlan_merchantBillingPlanId'
  end

  def exp_month_dropdown
    'vin_PaymentMethod_creditCard_expirationDate_Month'
  end

  def exp_year_dropdown
    'vin_PaymentMethod_creditCard_expirationDate_Year'
  end

  def monthly_radio
    'vin_BillingPlan_merchantBillingPlanId'
  end

  def annual_radio
    'FN_BP_DJ_ANNUAL'
  end

  def click_start
    click_button(start_text)
  end
end