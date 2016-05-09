require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'Events Controller' do
  describe 'index' do
    it 'displays series information' do
      Series.create(slug: 'a-series', name: 'A Series')
      get '/a_series'
      last_response.must_be :ok?
      last_response.body.must_match 'A Series'
    end

    it 'returns file not found for unknown slug' do
      get '/unknown_series'
      last_response.must_be :not_found?
    end

    it 'lists future events' do
      Series.create(slug: 'a-series', name: 'A Series')
      Event.create(series_slug: 'a-series',
                   start:  Time.new(2010, 1, 1),
                   finish: Time.now + 10)
      get '/a-series'
      last_response.must_be :ok?
      last_response.body.must_match '01 Jan'
    end
  end

  describe 'show' do
    it 'displays event information' do
      Series.create(slug: 'a-series', name: 'A Series')
      event = Event.create(
          series_slug: 'a-series',
          start:  Time.new(2000, 1, 1, 12, 45),
          finish: Time.new(2000, 1, 1, 16, 45))
      get "/a-series/#{event.id}"
      last_response.status.must_equal 200
      last_response.body.must_match 'A Series'
      last_response.body.must_match 'January 01, 2000 12:45'
    end

    it 'returns file not found for unknown series slug' do
      Series.create(slug: 'a-slug')
      event = Event.new(series_slug: 'a-slug')
      get "/unknown_series/#{event.id}"
      last_response.status.must_equal 404
    end
  end
end
