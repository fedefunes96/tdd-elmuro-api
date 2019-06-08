require 'rspec'

require_relative '../app/helpers/error_helper'
require_relative '../app/exceptions/no_message_found_error'

describe ErrorHelper do
  it 'throws exception if error is not known' do
    expect { described_class.new.message(NotImplementedError) }.to raise_error(NoMessageFoundError)
  end
end
