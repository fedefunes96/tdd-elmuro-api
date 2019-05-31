require 'sequel'
require 'sinatra'

DB = case Sinatra::Application.environment # ENV['RACK_ENV'].to_sym
     when :development
       Sequel.connect('postgres://telegram:telegram@localhost/telegram_development')
     when :test
       test_db_host = ENV['DB_HOST'] || 'localhost'
       Sequel.connect("postgres://telegram:telegram@#{test_db_host}/telegram_test")
     when :staging
       Sequel.connect(ENV['DATABASE_URL'])
     else
       Sequel.connect('postgres://telegram:telegram@localhost/telegram_development')
     end
