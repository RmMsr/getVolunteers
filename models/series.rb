class Series
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :slug, Slug

  def future_events
    Event.future.all(series_slug: slug)
  end
end
