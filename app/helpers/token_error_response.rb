def token_error_response
  body = { error: 'API_TOKEN_INVALIDO' }.to_json
  [401, { 'Content-Type' => 'application/json' }, body]
end
