require_relative 'dotenv.rb'

banco = ENV.fetch('DB_CONN', 'mysql')

puts banco