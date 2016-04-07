class Event
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :start, DateTime
  property :finish, DateTime
  property :series, String
  property :volunteers_goal, Integer
  property :volunteers_current, Integer
end
