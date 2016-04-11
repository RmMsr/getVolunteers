class SeriesDrop < Liquid::Drop
  def initialize(series)
    @series = series
  end

  def name
    @series.name
  end
end
