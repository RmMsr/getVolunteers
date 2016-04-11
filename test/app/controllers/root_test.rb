require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe 'Web Root' do
  it 'returns a page' do
    get '/'
    last_response.must_be :ok?
    last_response.content_type.must_match 'text/html'
    last_response.content_length.must_be :>, 0, 'Empty body'
  end
end
