class Event
  include DataMapper::Resource

  property :id, Serial
  property :start, DateTime, required: true
  property :finish, DateTime, required: true
  property :series, Slug
  property :volunteers_goal, Integer
  property :volunteers_current, Integer, default: 0

  def volunteers_reached?
    return true if volunteers_goal.nil?
    volunteers_current >= volunteers_goal
  end
end
