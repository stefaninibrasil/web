require 'capybara'
require 'capybara/cucumber'
require 'dotenv/load'
require 'mysql2'
require 'os'
require 'pg'
require 'pry'
require 'rdoc/rdoc'
require 'selenium-webdriver'
require 'sqlite3'
require 'tiny_tds'

require_relative 'config/modules'

World(Modules)

Capybara.configure do |config|
    config.app_host = Modules::App.host
    config.default_driver = Modules::Browser.driver
    config.default_max_wait_time = Modules::Browser.driverWaiter
    config.ignore_hidden_elements = Modules::Browser.ignoreHiddenElements
end