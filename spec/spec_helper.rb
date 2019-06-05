require_relative '../config/database'
require_relative '../config/token'

RSpec.configure do |conf|
  conf.around(:each) do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end

def post_with_body(uri, body)
  header 'Api-Token', TOKEN
  post(uri, body.to_json, CONTENT_TYPE: 'application/json')
end
