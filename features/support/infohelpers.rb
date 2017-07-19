module InfoHelpers

  def fail_info(path=nil, options={})
    if $non_cuke
      time = Time.now.strftime("%m-%d_%H-%M_%S%L")
      page.driver.browser.save_screenshot("#{Dir::pwd}/features/results/#{time}.png")
      print "\n           Test failed on: #{page.driver.browser.current_url}\n"
      print "           Screenshot: #{Dir::pwd}/features/results/#{time}.png\n"
    end
  end

  def fail_info_cuke
    time = Time.now.strftime("%m-%d_%H-%M_%S%L")
    page.driver.render("#{Dir::pwd}/features/results/#{time}.png", :full => true)
    print "\n           Test failed on: #{page.driver.browser.current_url}\n"
    print "           Screenshot: #{Dir::pwd}/features/results/#{time}.png\n"
  end
  
  def get_attr(locator, attrib)
    Nokogiri::HTML(page.body).css(locator).attribute(attrib).to_s
  end
  
  def get_css(loc)
    Nokogiri::HTML(page.body).css(loc)
  end
  
  def take_screenshot
    time = Time.now.strftime("%m-%d_%H-%M_%S%L")
    page.driver.render("#{Dir::pwd}/features/results/#{time}.png", :full => true)
    `open #{Dir::pwd}/features/results/#{time}.png\n`
  end
  
end
World(InfoHelpers)
