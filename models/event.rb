class Event
  include DataMapper::Resource

  property :id, Serial
  property :start, DateTime, required: true
  property :finish, DateTime, required: true
  property :series_slug, Slug
  property :volunteers_goal, Integer
  property :volunteers_current, Integer, default: 0

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
end
