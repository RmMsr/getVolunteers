require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Series Model" do
  it 'can construct a new instance' do
    @series = Series.new
    refute_nil @series
  end

  it 'knows upcoming events' do
    series = Series.new slug: 'some_series'
    event_a = Event.create!(series: 'some_series')
    event_b = Event.create!(series: 'some_series')
    series.events.must_include event_a, event_b
  end
end
