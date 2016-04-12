require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Event Model' do
  it 'can construct a new instance' do
    Event.new.wont_be_nil
  end

  it 'has defaults' do
    event = Event.new
    event.volunteers_current.must_equal 0
    event.volunteers_goal.must_equal nil
  end

  describe 'volunteers_reached?' do
    it 'returns true when current equals goal' do
      event = Event.new(volunteers_current: 2, volunteers_goal: 2)
      event.must_be :volunteers_reached?
    end

    it 'returns true when current is greater than goal' do
      event = Event.new(volunteers_current: 3, volunteers_goal: 2)
      event.must_be :volunteers_reached?
    end

    it 'returns false when current is less than goal' do
      event = Event.new(volunteers_current: 1, volunteers_goal: 2)
      event.wont_be :volunteers_reached?
    end

    it 'returns true when current and goal equal 0' do
      event = Event.new(volunteers_current: 0, volunteers_goal: 0)
      event.must_be :volunteers_reached?
    end

    it 'returns true when goal is nil' do
      event = Event.new
      event.volunteers_goal = nil
      event.volunteers_current = 0
      event.must_be :volunteers_reached?
    end
  end
end
