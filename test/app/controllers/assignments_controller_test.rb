require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'Assignments Controller' do
  before do
    @series = Series.create(name: 'A event', slug: 'some-series')
    @event  = Event.create(
        series_slug: @series.slug,
        start:  Time.now,
        finish: Time.now)
  end

  describe 'status' do
    it 'should redirect to a svg image' do
      get "/#{@series.slug}/#{@event.id}/status.svg"
      last_response.status.must_equal 307, 'No Temporary redirect'
      last_response.location.must_match %r{.svg$}
    end

    it 'should redirect to a png image' do
      get "/#{@series.slug}/#{@event.id}/status.png"
      last_response.status.must_equal 307, 'No Temporary redirect'
      last_response.location.must_match %r{.png$}
    end

    it 'rejects unknown extension' do
      get "/#{@series.slug}/#{@event.id}/status.tiff"
      last_response.status.must_equal 404, 'No not found error page'
    end

    it 'rejects missing extension' do
      get "/#{@series.slug}/#{@event.id}/status"
      last_response.status.must_equal 404, 'No not found error page'
    end

    it 'responds with not found for incorrect series' do
      get "/other-series/#{@event.id}/status.svg"
      last_response.must_be :not_found?
    end

    it 'redirects to shields.io badge url for png' do
      badge = Minitest::Mock.new
      badge.expect :shields_url, 'http://example.org', ['png']
      EventStatusBadge.stub :new, badge, 'png' do
        get "/#{@series.slug}/#{@event.id}/status.png"
      end
      last_response.status.must_equal 307
      last_response.location.must_equal 'http://example.org'
    end

    it 'returns the closest next event via id next' do
      Event.create(series_slug: 'a_series', start: Time.now, finish: Time.now + 10)
      get "/#{@series.slug}/next/status.png"
      last_response.status.must_equal 307
    end

    it 'redirects to shields.io badge url for incorrect event' do
      get "/#{@series.slug}/9999/status.svg"
      last_response.status.must_equal 307
    end
  end

  describe 'join' do
    before do
      env 'rack.session', csrf: 'secret_token'
    end

    it 'receives form to join' do
      post "/#{@series.slug}/#{@event.id}/join",
           assignment:         {name: 'Some User', email: 'user@example.org'},
           authenticity_token: 'secret_token'

      last_response.status.must_equal 302
      last_response.location.must_equal(
          "http://#{last_request.host}/#{@series.slug}/#{@event.id}")
    end

    it 'increases mentor count' do
      @event.volunteers_current.must_equal 0
      post "/#{@series.slug}/#{@event.id}/join",
           assignment:         { name: 'Other User',
                                 email: 'user@example.org' },
           authenticity_token: 'secret_token'
      @event.reload.volunteers_current.must_equal 1
    end

    it 'rejects missing data' do
      post "/#{@series.slug}/#{@event.id}/join",
           authenticity_token: 'secret_token'

      last_response.status.must_equal 302
      follow_redirect!
      last_response.body.must_match 'Submission incomplete'
    end
  end
end
