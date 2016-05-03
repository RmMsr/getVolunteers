require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'Web Root' do
  it 'returns a page' do
    get '/'
    last_response.must_be :ok?
    last_response.content_type.must_match 'text/html'
    last_response.content_length.must_be :>, 0, 'Empty body'
  end

  it 'includes upcoming events' do
    Series.create(slug: 's1', name: 'Series1')
    Event.create(series_slug: 's1', start: Time.now + 10, finish: Time.now + 20)
    get '/'
    last_response.body.must_match 'Upcoming events'
    last_response.body.must_match 'Series1'
  end
end
