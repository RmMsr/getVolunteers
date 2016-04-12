class Event
  include DataMapper::Resource

  property :id, Serial
  property :start, DateTime
  property :finish, DateTime
  property :series, Slug
  property :volunteers_goal, Integer
  property :volunteers_current, Integer
end
