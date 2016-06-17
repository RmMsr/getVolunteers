require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Account Model' do
  it 'can be validated' do
    account = Account.new
    account.wont_be :valid?
    account.email = 'account@example.org'
    account.wont_be :valid?
    account.role = 'role'
    account.must_be :valid?
  end

  it 'can have a password' do
    Account.new(role: 'role',
                email: 'mail@example.org',
                password: 'pass123',
                password_confirmation: 'pass123').must_be :valid?
  end

  it 'requires matching password confirmation' do
    Account.new(role: 'role',
                email: 'mail@example.org',
                password: 'pass123',
                password_confirmation: '456pass').wont_be :valid?
    Account.new(role: 'role',
                email: 'mail@example.org',
                password_confirmation: 'pass123').wont_be :valid?
    Account.new(role: 'role',
                email: 'mail@example.org',
                password: 'a',
                password_confirmation: 'a').wont_be :valid?
  end

  it 'does not require a password' do
    account = Account.new(role: 'user', email: 'account@example.org')
    account.must_be :valid?
  end

  it 'requires a unique email' do
    account = Account.new(email: 'mail@example.org', role: 'role')
    account.save.must_equal true
    Account.new(email: 'mail@example.org', role: 'role').wont_be :valid?
  end
end
