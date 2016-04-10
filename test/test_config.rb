RACK_ENV = 'test' unless defined?(RACK_ENV)

# Hide gem warnings without side effects
Proc.new do
  verbose = $VERBOSE
  $VERBOSE = nil
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
  $VERBOSE = verbose
end.call

# Configure Test output
require 'minitest/reporters'
MiniTest::Reporters.use!

# Reset Database
DataMapper.repository.auto_migrate!

# Load Application presenters and helpers
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/presenters/**/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

class MiniTest::Spec
  include Rack::Test::Methods

  # You can use this method to custom specify a Rack app
  # you want rack-test to invoke:
  #
  #   app GetVolunteers::App
  #   app GetVolunteers::App.tap { |a| }
  #   app(GetVolunteers::App) do
  #     set :foo, :bar
  #   end
  #
  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end
end
