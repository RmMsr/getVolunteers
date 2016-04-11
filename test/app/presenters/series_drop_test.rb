require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe SeriesDrop do
  before do
    @series = Series.new(name: 'A Series', slug: 'a_series')
    @drop = SeriesDrop.new(@series)
  end

  it 'has Liquid Drop interface' do
    @drop.must_be_kind_of Liquid::Drop
  end

  it 'has defaults' do
    drop = SeriesDrop.new(Series.new)
    drop.name.must_be_nil
  end

  it 'exposes name' do
    @drop.name.must_equal 'A Series'
  end

  it 'exposes slug' do
    @drop.slug.must_equal 'a_series'
  end
end
