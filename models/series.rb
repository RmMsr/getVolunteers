class Series
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :slug, String

  def future_events
    Event.all(series: slug, :finish.gte => Time.now)
  end
end
