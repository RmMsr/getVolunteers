require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe EventDrop do
  before do
    @event = Event.new(
        start: Time.new(2000, 1, 1, 6, 30),
        finish: Time.new(2000, 1, 1, 8, 30)
    )
    @drop = EventDrop.new(@event)
  end

  it 'has Liquid Drop interface' do
    @drop.must_be_kind_of Liquid::Drop
  end

  it 'has defaults' do
    drop = EventDrop.new(Event.new)
    drop.id.must_be_nil
    drop.start.must_be_nil
    drop.start_short.must_be_nil
    drop.duration_in_words.must_equal 'less than a minute'
    drop.series.must_be_nil
    drop.volunteers_goal.must_be_nil
    drop.volunteers_current.must_be_nil
  end

  it 'exposes start time' do
    @drop.start.must_equal 'January 01, 2000 06:30'
  end

  it 'exposes start time in short format' do
    @drop.start_short.must_equal '01 Jan 06:30'
  end

  it 'exposes finish time' do
    @drop.finish.must_equal 'January 01, 2000 08:30'
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

  it 'exposes volunteers goal' do
    @drop.volunteers_goal.must_equal @event.volunteers_goal
  end

  it 'exposes volunteers current' do
    @drop.volunteers_current.must_equal @event.volunteers_current
  end
end
