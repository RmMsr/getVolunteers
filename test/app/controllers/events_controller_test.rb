require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'Events Controller' do
  describe 'index' do
    it 'displays series information' do
      Series.create(slug: 'a_series', name: 'A Series')
      get '/a_series'
      last_response.must_be :ok?
      last_response.body.must_match 'A Series'
    end

    it 'returns file not found for unknown slug' do
      get '/unknown_series'
      last_response.must_be :not_found?
    end
  end

  describe 'show' do
    it 'displays event information' do
      Series.create(slug: 'a_series', name: 'A Series')
      event = Event.create(
          series: 'a_series',
          start: Time.new(2000, 1, 1, 12, 45),
          finish: Time.new(2000, 1, 1, 16, 45))
      get "/a_series/#{event.id}"
      last_response.must_be :ok?
      last_response.body.must_match 'A Series'
      last_response.body.must_match 'January 01, 2000 12:45'
    end

    it 'returns file not found for unknown slug' do
      Series.create(slug: 'a_slug')
      event = Event.new(series: 'a_slug')
      get "/unknown_series#{event.id}"
      last_response.must_be :not_found?
    end

    it 'returns file not found for unknown Series slug' do
      Series.create(slug: 'a_slug')
      event = Event.new(series: 'a_slug')
      get "/unknown_series/#{event.id}"
      last_response.must_be :not_found?
    end

    it 'returns file not found for unknown Series slug' do
      Series.create(slug: 'a-slug')
      event = Event.create(series: 'a-slug', start: Time.now, finish: Time.now)
      get "/unknown_series/#{event.id}"
      last_response.must_be :not_found?
    end
  end
end
