require 'dotenv'

module EnvironmentModule
    Dotenv.load(File.expand_path('../../../.env', File.dirname(__FILE__)))
end