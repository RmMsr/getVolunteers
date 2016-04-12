class Event
  include DataMapper::Resource

  property :id, Serial
  property :start, DateTime, required: true
  property :finish, DateTime, required: true
  property :series, Slug
  property :volunteers_goal, Integer
  property :volunteers_current, Integer
end
