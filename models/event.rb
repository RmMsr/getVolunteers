require 'json'

class Event
  include DataMapper::Resource

  property :id, Serial
  property :start, DateTime, required: true
  property :finish, DateTime, required: true
  property :series_slug, Slug
  property :volunteer_ids, Text
  property :volunteers_goal, Integer
  property :volunteers_current, Integer, default: 0

  attr_writer :volunteers

  belongs_to :series, child_key: :series_slug, parent_key: :slug

  before :save, :serialize_volunteers

  def initialize(*args)
    super *args
    @volunteers = nil
  end

  def add_volunteer(name, email)
    account = Account.first(email: email)
    if account.nil?
      account = Account.create(email: email, name: name, role: 'user')
      self.volunteers_current += 1
    else
      account.name = name
    end
    account.save
    volunteers << account
  end

  def volunteers_reached?
    return true if volunteers_goal.nil?
    volunteers_current >= volunteers_goal
  end

  def self.future
    all(:finish.gte => Time.now, order: :start.asc)
  end

  def self.next
    future.first
  end

  def volunteers
    return @volunteers if @volunteers
    @volunteers = if self.volunteer_ids.present?
                    Account.all(id: JSON.parse(self.volunteer_ids))
                  else
                    []
                  end
  end

  def serialize_volunteers
    self.volunteer_ids = @volunteers ? @volunteers.map(&:id).to_json : nil
  end
end
