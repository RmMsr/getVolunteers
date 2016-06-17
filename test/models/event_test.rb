require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Event Model' do
  before do
    @event = Event.new start: Time.now, finish: Time.now
    @user = Account.create email: 'user@example.org',
                          role: 'user',
                          password: 'abcd',
                          password_confirmation: 'abcd'

  end

  it 'can construct a new instance' do
    Event.new.wont_be_nil
  end

  it 'has defaults' do
    event = Event.new
    event.volunteers_current.must_equal 0
    event.volunteers_goal.must_equal nil
    event.volunteers.must_equal []
  end

  it 'belongs to Series' do
    series = Series.create(slug: 'a-slug')
    Event.new(series_slug: 'a-slug').series.must_equal series
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

  it 'future returns not finished events' do
    events = [
        Event.create(start: Time.now - 90, finish: Time.now - 10),
        Event.create(start: Time.now + 30, finish: Time.now + 90),
        Event.create(start: Time.now - 10, finish: Time.now + 10)
    ]
    Event.future.must_include events[1]
    Event.future.must_include events[2]
  end

  it 'next returns closest not finished event' do
    events = [
        Event.create(start: Time.now - 90, finish: Time.now - 10),
        Event.create(start: Time.now + 30, finish: Time.now + 90),
        Event.create(start: Time.now - 10, finish: Time.now + 10)
    ]
    Event.next.must_equal events[2]
  end

  it 'volunteers= accepts collection of Accounts' do
    @event.volunteers = [@user]
    @event.save.must_equal true
  end

  it 'volunteers returns collection of Accounts' do
    @event.volunteers = [@user]
    @event.save
    Event.get(@event.id).volunteers.must_equal [@user]
  end

  it 'volunteers can be modified' do
    @event.volunteers << @user
    @event.volunteers.must_include @user
  end

  it 'add_volunteer links existing account' do
    @event.add_volunteer @user.name, @user.email
    @event.save
    @event.volunteers.must_equal [@user]
  end

  it 'add_volunteer links new account' do
    @event.add_volunteer 'New volunteer', 'new@example.org'
    @event.volunteers.size.must_equal 1
    @event.volunteers.first.name.must_equal 'New volunteer'
    @event.volunteers.first.email.must_equal 'new@example.org'
  end

  it 'add_volunteer increases volunteer_count' do
    @event.volunteers_current.must_equal 0
    @event.add_volunteer 'New volunteer', 'new@example.org'
    @event.volunteers_current.must_equal 1
  end

  it 'add_volunteer does not increase volunteer_count if duplicate' do
    @event.add_volunteer 'New volunteer', 'new@example.org'
    @event.volunteers_current.must_equal 1
    @event.add_volunteer 'New volunteer', 'new@example.org'
    @event.volunteers_current.must_equal 1
  end
end
