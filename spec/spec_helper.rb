RACK_ENV = 'test'.freeze unless defined?(RACK_ENV)

# DB = Sequel.connect()

RSpec.configure do |conf|
  # conf.include Rack::Test::Methods
  # conf.include Capybara
  conf.around(:each) do |example|
    # rubocop:disable Style/GlobalVars
    $DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
    # rubocop:enable Style/GlobalVars
  end
end
