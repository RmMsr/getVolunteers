require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Event Model" do
  it 'can construct a new instance' do
    @event = Event.new
    refute_nil @event
  end
end
