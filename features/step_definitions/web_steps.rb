require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'rspec'

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator, match: :first) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^(?:|I )am on (.+)$/) do |page_name|
  page.driver.headers = { "User-Agent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36" }
  visit path_to(page_name).to_s
end

Given(/^I refresh the page$/) do
  visit(current_path)
end

Given(/^debugger$/) do
  nil
  binding.pry
  nil
end

When(/^I check all images are loaded$/) do

  results = {}
  assertions = []

  img_srcs = Nokogiri::HTML(page.body).css('img').map{ |i| i['src'] }

  img_srcs.delete_if { |a| a.eql?(nil) }
  foo = img_srcs.select { |a| a.include?('rackcdn.com') or a.include?('d2j769lqkt6xpm.cloudfront.net')}

  img_srcs = foo

  img_srcs.each do |img_src|
    begin
      if img_src[0..1] == '//'
        img_src = img_src.strip.gsub('//','http://')
      end
      results[img_src] = Net::HTTP.get_response(URI(img_src)).code
    rescue Errno::ECONNREFUSED, URI::InvalidURIError, Errno::ECONNRESET => e
      puts e
    end
  end

  results.each do |k,v|
    unless v == '200' || v == '401'
      assertions << "--> Code: #{v} for #{k} <--"
    end
  end

  raise "\n#{assertions.join("\n")}\n\n" unless assertions.empty?
end

When(/^I click the first result$/) do
  page.all(:css, 'li.col-sm-6').first.click
end

When(/^(?:|I )follow "([^"]*)"$/) do |link|
  click_link_or_button(link, match: :first)
end

When(/^(?:|I )trigger click on id "(.*?)"$/) do |id_name|
  page.find(:id, id_name).trigger('click')
end

When(/^(?:|I )follow "(.*?)" within "(.*?)"$/) do |link, selector|
  if selector
    with_scope(selector) {
      click_link_or_button(link, match: :first)
    }
  else
    click_link_or_button(link, match: :first)
  end
end

When(/^I click the "(.*?)" cucumber element$/) do |locator|
  find(locator, :visible => true).click
  begin
    first(:css, locator, :visible => true).click
  rescue Capybara::Poltergeist::MouseEventFailed, Capybara::Poltergeist::ObsoleteNode
    puts "JS Click: #{ locator }"
    page.execute_script(%Q{ $($("#{ locator }:visible").get(0)).click() })
  end
end

When(/^I click the "(.*?)" css element$/) do |locator|
  begin
    first(:css, locator, :visible => true).click
  rescue Capybara::Poltergeist::MouseEventFailed, Capybara::Poltergeist::ObsoleteNode
    puts "JS Click: #{ locator }"
    page.execute_script(%Q{ $($("#{ locator }:visible").get(0)).click() })
  rescue Selenium::WebDriver::Error::UnknownError => e
    $stdout.puts e.message
    end
  end

# I don't think this is used any more. TODO: verify that.
When(/^I click the ([0-9]*) "(.*?)" css element$/) do |i, locator|
  begin
    selected_element = page.find(:css, locator, :visible => true)[i.to_i]
    puts selected_element.text
    selected_element.click
  rescue Capybara::Poltergeist::MouseEventFailed
    puts "Underclick: #{locator}[#{i}]"
    page.execute_script(%Q{ $($("#{ locator}:visible").get(0)).click() })
  end
end

When(/^I scroll "(.*?)"$/) do |scroll_amount|
  page.execute_script(" window.scrollBy(0,#{ scroll_amount.to_i }) ")
end


When(/^(?:|I )fill in "(.*?)" with "(.*?)"(?: within "(.*?)")?$/) do |field, value, selector|
  with_scope(selector) do
    fill_in(field, with: value)
  end
end

When(/^I fill in selector "(.*?)" with "(.*?)"$/) do |selector, value|
  page.find(selector, :visible => true).set(value)
end

When(/^(?:|I )fill in "(.*?)" for "(.*?)"(?: within "(.*?)")?$/) do |value, field, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When(/^(?:|I )select "(.*?)" with "(.*?)"(?: within "(.*?)")?$/) do |name, value, selector|
  with_scope(selector) do
    select(value,:from=> name)
  end
end

When(/^(?:|I )press "(.*?)"(?: within "(.*?)")?$/) do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

Then(/^(?:|I )should see "(.*?)"(?: within "(.*?)")?$/) do |text, selector|
  if selector.blank?
    expect(page).to have_content(text)
  else
    with_scope(selector) { expect(page).to have_content(text) }
  end
end

Then(/^(?:|I )should see \/([^\/]*)\/(?: within "(.*?)")?$/) do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      page.should have_xpath('//*', :text => regexp)
    end
  end
end

Then(/^(?:|I )should not see "(.*?)"(?: within "(.*?)")?$/) do |text, selector|
  if selector.blank?
    # Make sure specific content selection is NOT SHOWN on the page.
    # NOTE: 'expect(page).to' prevents deprecation message from being shown as opposed to 'page.should_not'.
    expect(page).to have_no_content(text)
  else
    scope = page.first(:css, selector)
    scope.should_not have_content(text)
  end
end

Then(/^(?:|I )should see the selector "(.*?)"$/) do |selector|
  expect(page).to have_selector(selector)
end

Then(/^(?:|I )should not see the selector "(.*?)"$/) do |selector|
  page.should have_no_selector(selector)
end

Then(/^my current path should be "(.*?)"$/) do |path|
   assert_equal(page.current_path, path)
end

Then(/^my current path should not match "(.*?)"$/) do |path|
   page.current_path.should_not match(path)
end

Then(/^link "(.*?)" should match "(.*?)"$/) do |link_text, match|
  link = page.find_link(link_text)['href']
  assert link.match(match), "\t[[ \n\t\t#{link_text} did not match expected.\n\t\tLink found: #{link}\n\t]]\n"
end

Then(/^link "(.*?)" should link to "(.*?)"$/) do |link_text, expected_url|
  actual_url = page.find_link(link_text, match: :first)['href']
  if actual_url.include?(current_host)
    expected_url = current_host+expected_url
  end
  assert_equal(expected_url, actual_url, "#{link_text} links to #{actual_url} \nExpected: #{expected_url}")
end

Then(/^link locator "(.*?)" should match "(.*?)"$/) do |locator, expected|
  actual = find(locator, match: :first)[:href]
  assert(actual.match(expected), "\n\nLocator #{locator} did not match #{expected}.\nGot: #{actual}  (Using partial match on full URL)\n\n")
end

Then(/^the page title should be "(.*?)"$/) do |expected|
   assert_equal(expected, page.title)
end

Then(/^I should match "(.*?)"(?: within "(.*)")?$/) do |expected, selector|
  expected = Regexp.new(expected)
  if selector
    found_text_match = false
    page.all(selector, :visible => false).each do |item|
      if item.text =~ /#{expected}/
        found_text_match = true
      end
    end

    if found_text_match == false
      match_found = page.find(selector, :text => /#{expected}/)
      if match_found
        assert match_found, "\n\n>\n>> #{expected} was not found!\n>\n"
      else
        assert get_css(selector).to_s.match(expected), "\n\n>\n>> #{expected} was not found!\n>\n"
      end
    end
  else
    assert page.body.match(expected), "\n\n>\n>> #{expected} was not found!\n>\n"
  end
end

Given(/^I wait for (.*?) seconds*$/) do |n|
  sleep n.to_f
end

Then(/^I execute script "(.*?)"$/) do |script|
  page.execute_script(script)
end

Given(/^I scroll to the (.+?) of the page$/) do |direction|
  case direction
  when 'bottom'
    page.execute_script "window.scrollBy(0,10000)"
  when 'top'
    page.execute_script "window.scrollBy(0,-10000)"
  end
end

Then(/^I wait a maximum of "(.*?)" seconds for "(.*?)" to be present$/) do |timeout,element|
  wait_until(timeout.to_i) { page.has_css?(element) }
end

Then(/^I wait a maximum of "(.*?)" seconds for "(.*?)" to not be there$/) do |timeout,element|
  wait_until(timeout.to_i) { page.has_no_selector?(element) }
end

Then(/^page should contain:$/) do |table|
  failures = Array.new
  table.hashes.each do |row|
      if row.keys.length > 1 # If there's two columns
          case row['CONDITION'].downcase # if condition is css/xpath/text/empty
            when 'css' # Find locator
                failures << " Locator: #{row['VALUE']}" unless page.has_selector?(row['VALUE'])
            when 'xpath' # Find xpath
                failures << " Locator: #{row['VALUE']}" unless page.has_xpath?(row['VALUE'])
            when 'title' # Assert Page Title
                title = page.title
                failures << " Expected title: #{row['VALUE']}, but was #{title}" unless title.include?(row['VALUE'])
            when '','text' # Find text
                failures << " Text: #{row['VALUE']}" unless page.has_content?(row["VALUE"])
            else # Text within locator (condition) matches expected value
                if row['CONDITION'].match("//") # Find XPATH with text
                    if page.has_xpath?(row['CONDITION']) # Element exists
                        failures << " Text: \"#{row['VALUE']}\", within xpath: #{row['CONDITION']}" unless first(:xpath, row['CONDITION']).has_content?(row['VALUE']) # If text doesn't match
                    else
                        failures << " Locator: #{row['CONDITION']}" # If locator is missing
                    end
                else # If it's CSS with text
                    if page.has_selector?(row['CONDITION']) # Element exists
                        #failures << " Text: \"#{row['VALUE']}\", within css: #{row['CONDITION']}" unless first(:css, row['CONDITION']).has_content?(row['VALUE']) # If text doesn't match
                        #failures << " Text: \"#{row['VALUE']}\", within css: #{row['CONDITION']}" unless 
                        node = first(:css, row['CONDITION'])
                        unless node.text =~ /#{ row['VALUE'] }/
                          failures << " Text: \"#{row['VALUE']}\", within css: #{row['CONDITION']}" 
                        end
                    else
                        failures << " Locator: #{row['CONDITION']}" # If locator is missing
                    end
                end
          end
      else  
        failures << row['VALUE'] unless page.has_content?(row["VALUE"]) # Single column text only match
      end
  end
  unless failures.empty?
    raise "\n*The following elements were not found in source:\n   -#{failures.join("\n   -")}\n\n"
  end
end

Then(/^links in page should have paths:$/) do |table|
  host = page.current_host
  failures = Array.new
  table.hashes.each do |row|
    if page.has_content?(row["LINK_NAME"])
      if row["LINK_LOCATION"].empty?
        link = page.find_first_link(row['LINK_NAME'])
        link_path = link['href']
        if link_path.include?(host)
          failures << " #{row['LINK_NAME']} url was #{link_path} expected: #{host}#{row['LINK_PATH']}" unless link_path == host + row['LINK_PATH']
        else
          failures << " #{row['LINK_NAME']} path was #{link_path} expected: #{row['LINK_PATH']}" unless link_path == row['LINK_PATH']
        end
      else
        if page.has_selector?(row["LINK_LOCATION"])
          link_path = find(row["LINK_LOCATION"])[:href]
          if link_path.include?(host)
            failures << " #{row['LINK_LOCATION']} url was #{link_path} expected: #{host}#{row['LINK_PATH']}" unless link_path == host + row['LINK_PATH']
          else
            failures << " #{row['LINK_LOCATION']} path was #{link_path} expected: #{row['LINK_PATH']}" unless link_path == row['LINK_PATH']
          end
        else
          failures << " Selector: #{row['LINK_LOCATION']} does not exist"
        end
      end

    else
      failures << " Link text: #{row['LINK_NAME']} does not exist"
    end
  end
  unless failures.empty? then
    raise "\n*following issues were found:\n   -#{failures.join("\n   -")}\n\n"
  end
end

Then(/^"(.*?)" attribute in "(.*?)" should equal "(.*?)"$/) do |attribute, selector, expected|
  assert_equal(expected, get_attr(selector, attribute))
end

Then(/^"(.*?)" attribute within "(.*?)" should match "(.*)"$/) do |attribute,selector,expected|
  expected = Regexp.new(expected)
  assert_match(expected, get_attr(selector,attribute), "\t[[ \n\t\t#{attribute} did not match #{expected}.\n\t\tGot: #{get_attr(selector,attribute)}\n\t]]\n")
end

Then(/^(?:|I )should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  if page_name.match('regex')
    assert_match path_to(page_name), current_path
  else
    if current_path.respond_to? :should
      current_path.should == path_to(page_name)
    else
      assert_equal path_to(page_name), current_path
    end
  end
end

When(/^(?:|I )check "(.*?)"(?: within "(.*?)")?$/) do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When(/^(?:|I )choose "(.*?)"(?: within "(.*?)")?$/) do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

Then(/^the "(.*?)" field(?: within "(.*?)")? should contain "(.*?)"$/) do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{ Regexp.escape(value) }/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

When(/^"(.*?)"(?: within "(.*?)")? should not be a link$/) do |link, selector|
  with_scope(selector) do
    assert page.has_no_link?(link), "#{link} is a link on page with in #{selector}"
  end
end

When(/^(?:|I )set "(.*?)"(?: with "(.*?)")?$/) do |selector, value|
  find(selector).set(value)
end

Then(/^I verify query params are present$/) do
  uri = URI.parse(current_url)
  uri.query.include?('azra=test1')
  uri.query.include?('azra2=test2')
end

Then(/^I wait for the selector: "(.*?)"$/) do |selector|
  page.find(selector)
end

Then(/^id "(.*?)" is disabled$/) do |btn|
  element = find(:id, btn)
  if element['disabled'] == nil
    raise('btn does not have a disabled flag')
  elsif ! element.disabled?
    raise('btn is not disabled')
  end
end
