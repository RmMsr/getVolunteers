source 'https://rubygems.org'

# Padrino supports Ruby version 1.9 and later
ruby '2.3.0'

# Distribute your app as a gem
# gemspec

# Server requirements
gem 'puma', '~> 3.2.0'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'bcrypt'
gem 'liquify'
gem 'liquid'
gem 'dm-sqlite-adapter'
gem 'dm-validations'
gem 'dm-timestamps'
gem 'dm-migrations'
gem 'dm-constraints'
gem 'dm-aggregates'
gem 'dm-types'
gem 'dm-core'

# Padrino Stable Gem
gem 'padrino', '0.13.1'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.13.1'
# end

# Debugging
gem 'pry', group: [:develop, :test]

# Testing
group :test do
  gem 'minitest', require: 'minitest/autorun'
  gem 'minitest-reporters', require: 'minitest/reporters'
  gem 'rack-test', require: 'rack/test'
end
