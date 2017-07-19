require "#{File.dirname(__FILE__)}/extensions.rb"

$noncuke = false

@driver = ENV['driver']
# Sets default driver to poltergeist and allows for cuke or p to be used as aliases
if @driver.nil?
  @driver = 'poltergeist'
elsif @driver == 'cuke' or driver == 'p'
  @driver = 'poltergeist'
end

# sets test target to staging if no target= is not declared at runtime.
# Targets can be found in env_data.yml
# changed targets to work with apify urls
if ENV['target'].nil?
  puts 'target= not defined, defaulting to staging.'.color(33)
  ENV['target'] = 'staging'
end

require 'capybara/poltergeist'

# setting configuration options.
  target_config = File.expand_path(File.dirname(__FILE__) + '/env_data.yml')
  polt_config = YAML.load(File.open(target_config))
  target = polt_config[:target]
  application_server = target[ENV['target'].to_sym]

# This is a legacy capybara bug
# TODO look into this and see if it is still a problem.
  module Capybara::Poltergeist
    class Node < Capybara::Driver::Node
      alias :orig_set :set
      def set(value)
        if tag_name == 'input' && self[:type] == 'file'
          begin
            orig_set value
          rescue Capybara::Poltergeist::ObsoleteNode
            nil # There is known issue https://github.com/jonleighton/poltergeist/issues/115, so we just handle that
          end
        else
          orig_set value
        end
      end
    end
  end

# set capybara defaults to use poltergeist
  Capybara.javascript_driver = :poltergeist
  Capybara.default_driver = :poltergeist
  Capybara.run_server = false

# Set url that will be used in tests. Uses :host values from env.rb
  Capybara.app_host = "#{application_server[:host]}.feeln.com:#{application_server[:port]}"
  Capybara.default_host = Capybara.app_host

# sets phantomjs options and controls output to console. Ignore the error for
# Capybara::Poltergeist::Driver.new. It is invalid.
  Capybara.register_driver :poltergeist do |app|
    options = {
        inspector: true,
        window_size: [1080, 1920],
        phantomjs_logger: true,
        js_errors: false,
        timeout: 60,
        phantomjs_options: ['--debug=no', '--load-images=yes', '--ignore-ssl-errors=yes'],
        debug: false
    }
    Capybara::Poltergeist::Driver.new(app, options)
  end

  Capybara.configure do |config|
    config.match = :one
    config.exact_options = true
  end

Capybara::Session.class_eval do
  def find_first_link(name)
    found = all('a').detect {|a|
      a.text.strip == name.strip
    }
    unless found
      found = all('a').detect {|a|
        a.text.strip =~ /^#{Regexp.escape(name.strip)}/ ||
        a.text.strip =~ /#{Regexp.escape(name.strip)}/
      }
    end
    found
  end
end
