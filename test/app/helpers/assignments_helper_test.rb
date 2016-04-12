require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe GetVolunteers::App::AssignmentsHelper do
  before do
    @helpers = Class.new
    @helpers.extend GetVolunteers::App::AssignmentsHelper
  end

  def helpers
    @helpers
  end
end
