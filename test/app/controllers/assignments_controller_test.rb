require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'Assignments Controller' do
  before do
    @series = Series.create(slug: 'some-series')
    @event = Event.create(
        series: @series.slug,
        start: Time.now,
        finish: Time.now)
  end

  describe 'status' do
    it 'should redirect to a svg image' do
      get "/#{@series.slug}/#{@event.id}/status.svg"
      last_response.status.must_equal 307, 'No Temporary redirect'
      last_response.location.must_equal(
          'https://img.shields.io/badge/mentors-needed-red.svg')
    end

    it 'should redirect to a png image' do
      get "/#{@series.slug}/#{@event.id}/status.png"
      last_response.status.must_equal 307, 'No Temporary redirect'
      last_response.location.must_equal(
          'https://img.shields.io/badge/mentors-needed-red.png')
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

    it 'responds with not found for incorrect event' do
      get "/#{@series.slug}/9999/status.svg"
      last_response.must_be :not_found?
    end
  end
end
