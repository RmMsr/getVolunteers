require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Events Controller" do
  describe 'index' do
    it 'displays series information' do
      Series.create!(slug: 'a_series', name: 'A Series')
      get '/a_series'
      last_response.must_be :ok?
      last_response.body.must_match 'A Series'
    end

    it 'returns file not found for unknown slug' do
      get '/unknown_series'
      last_response.must_be :not_found?
    end
  end

  describe 'assignments' do
    it 'should redirect to a svg image' do
      get '/a_series/next/assignments.svg'
      last_response.status.must_equal 307, 'No Temporary redirect'
      last_response.location.must_equal 'https://img.shields.io/badge/mentors-needed-red.svg'
    end

    it 'should redirect to a png image' do
      get '/a_series/next/assignments.png'
      last_response.status.must_equal 307, 'No Temporary redirect'
      last_response.location.must_equal 'https://img.shields.io/badge/mentors-needed-red.png'
    end

    it 'rejects unknown extension' do
      get '/a_series/next/assignments.tiff'
      last_response.status.must_equal 404, 'No not found error page'
    end

    it 'rejects missing extension' do
      get '/a_series/next/assignments'
      last_response.status.must_equal 404, 'No not found error page'
    end
  end
end
