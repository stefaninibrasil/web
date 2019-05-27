require 'dotenv'

file = File.join(File.dirname(__dir__), "/.env")
Dotenv.load(file)