require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe EventDrop do
  before do
    @event = Event.create(
        start: Time.new(2000, 1, 1, 6, 30),
        finish: Time.new(2000, 1, 1, 8, 30)
    )
    @drop = EventDrop.new(@event)
  end

  it 'has Liquid Drop interface' do
    @drop.must_be_kind_of Liquid::Drop
  end

  it 'exposes start' do
    @drop.start.must_equal '01 Jan 06:30'
  end

  it 'exposes duration in words' do
    @drop.duration_in_words.must_equal 'about 2 hours'
  end

  it 'exposes id' do
    @drop.id.must_equal @event.id
  end

  it 'exposes series slug' do
    @drop.series.must_equal @event.series
  end
end
