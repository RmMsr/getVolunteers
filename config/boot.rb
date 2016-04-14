# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Enable logging of source location
#
# Padrino::Logger::Config[:development][:source_location] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, dialog: true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

Padrino::Logger::Config[:production] = {
    log_level: (ENV['LOG_LEVEL'] || 'info').to_sym,
    stream: :stdout
}

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  DataMapper::Model.raise_on_save_failure = true
  DataMapper.finalize

  # Extra dependencies
  Padrino.require_dependencies Padrino.root('app/presenters/**/*.rb')

  # Extra auto load path for development
  GetVolunteers::App.prerequisites << Padrino.root('app/presenters/**/*.rb')
end

Padrino.load!
