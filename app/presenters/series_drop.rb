class SeriesDrop < Liquid::Drop
  def initialize(series)
    @series = series
  end

  def name
    @series.name
  end

  def slug
    @series.slug
  end
end
