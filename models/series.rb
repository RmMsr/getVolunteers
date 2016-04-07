class Series
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :slug, String

  def events
    Event.all(series: slug)
  end
end
