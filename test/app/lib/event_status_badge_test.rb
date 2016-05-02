require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe EventStatusBadge do
  describe 'shields_url' do
    before do
      @event = Minitest::Mock.new
    end

    it 'returns shields.io url' do
      @event.expect :volunteers_reached?, false
      badge = EventStatusBadge.new(@event)
      badge.shields_url('svg').must_match %r{^https://img.shields.io/badge/}
    end

    it 'generates mentors needed badge url' do
      @event.expect :volunteers_reached?, false
      badge = EventStatusBadge.new(@event)
      badge.shields_url('png').must_match %r{/Mentors-needed-red.png$}
    end

    it 'generates mentors found badge url' do
      @event.expect :volunteers_reached?, true
      badge = EventStatusBadge.new(@event)
      badge.shields_url('png').must_match %r{/Mentors-found-green.png$}
    end

    it 'generates no event badge url' do
      badge = EventStatusBadge.new(nil)
      badge.shields_url('png').must_match %r{/No-event-grey.png$}
    end
  end
end
