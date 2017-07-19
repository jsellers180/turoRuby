#Spiritclips-Website-Tests
==========================

##This uses Cucumber, Ruby & Capybara to test the Feeln website in a headless fashion.

```ruby
Cucumber is a software tool used for testing other software.
```

```ruby
Ruby is an open-source programming language.
```

```ruby
Capybara is a test framework that helps you test web apps by simulating how a real user would interact with the app.
```

##To run the feature files on OSX

```ruby
Step 1 - Install rbenv & Ruby

=> Run the following commands to install rbenv to your $PATH

$ cd ~/.
$ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```
=> Open a new terminal tab and check if rbenv is installed
```ruby
$ type rbenv
```
=> Install rbenv plugin for rbenv install
```ruby
$ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
```
Step 2 - Clone the spiritclips-tests repository

Step 3 - cd (change directory) into the cloned repo and install Ruby
```ruby
$ cd /spiritclips-tests
$ rbenv install (This will automatically install the ruby version the tests are using)
```
Step 4 - Install the required gems. Execute:
```ruby
$ gem install bundler 
$ bundle install
```
=> Add the following gem to the gemfile -- may not be needed to complete this process
```ruby
gem 'test-unit'
```
=> Install phantomjs 
```ruby
brew install phantomjs
```
or
```ruby
sudo port install phantomjs
```

##To run individual features

```ruby
bundle exec cucumber features/"given feature" target="domain"
```

###Example:
```ruby
bundle exec cucumber features/login.feature target=staging
```

##To run individual or multiple tags

```ruby
bundle exec cucumber --tags @tag name target="domain" (dev,staging,prod, qa)
```

###Example:
```ruby
bundle exec cucumber --tags @smoketests target=staging
```

###API Example:
```ruby
bundle exec cucumber --tags @ios_user target=stg-apify
```

##Available Tags:
```ruby
@all, @api, @smoketest, @homepage, @login, @search, @signup, @firetv_user, @ios_user, @roku_user
```
