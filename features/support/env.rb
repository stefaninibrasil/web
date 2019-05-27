require 'capybara'
require 'capybara/cucumber'
require 'dotenv/load'
require 'os'
require 'rdoc/rdoc'
require 'selenium-webdriver'

Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.default_max_wait_time = 15
    config.app_host = 'http://localhost:8080'
end
