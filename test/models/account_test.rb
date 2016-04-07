require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Account Model" do
  it 'can construct a new instance' do
    @account = Account.new
    refute_nil @account
  end
end
