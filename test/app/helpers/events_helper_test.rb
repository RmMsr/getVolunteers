require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "GetVolunteers::App::EventsHelper" do
  before do
    @helpers = Class.new
    @helpers.extend GetVolunteers::App::EventsHelper
  end

  def helpers
    @helpers
  end
end
