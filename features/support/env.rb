require 'capybara'
require 'capybara/cucumber'
require 'dotenv/load'
require 'os'
require 'rdoc/rdoc'
require 'selenium-webdriver'

require_relative 'config/modules'

World(Modules)

Capybara.configure do |config|
    config.default_driver = Modules::Browser.driver
    config.default_max_wait_time = Modules::Browser.driverWaiter
    config.app_host = Modules::App.host
end