require 'sinatra'
require 'json'
require_relative 'model/health'
require 'sequel'
require 'yaml'

Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
db_config = YAML.safe_load(File.open('config/database.yml'))

# rubocop:disable Style/GlobalVars
$DB = Sequel.connect(db_config[Sinatra::Application.environment.to_s])
# case Sinatra::Application.environment
# when :development
# Sequel.connect('postgres://telegram:telegram@localhost/telegram_development')
#   Sequel.connect(db_config['development'])
# when :test
#   test_db_host = ENV['DB_HOST'] || 'localhost'
#   Sequel.connect("postgres://telegram:telegram@#{test_db_host}/telegram_test")
# when :staging
#   Sequel.connect(ENV['DATABASE_URL'])
# when :production
#   Sequel.connect(ENV['DATABASE_URL'])
# end
# rubocop:enable Style/GlobalVars

get '/health' do
  content_type :json
  # input = JSON.parse(request.body.read)

  health = Health.new

  status 200
  { status: health.status }.to_json
end
