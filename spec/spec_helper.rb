require_relative '../config/database'

RSpec.configure do |conf|
  conf.around(:each) do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end
