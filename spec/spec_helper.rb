require_relative '../config/database'

RSpec.configure do |conf|
  conf.around(:each) do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end

def post_with_body(uri, body)
  post(uri, body.to_json, CONTENT_TYPE: 'application/json')
end
