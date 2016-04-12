class Series
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :slug, Slug

  def future_events
    Event.all(series: slug, :finish.gte => Time.now)
  end
end
