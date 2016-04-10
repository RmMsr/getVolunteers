class EventDrop < Liquid::Drop
  include Padrino::Helpers::FormatHelpers

  def initialize(event)
    @event = event
  end

  def start
    I18n.localize(@event.start, format: :short)
  end

  def duration_in_words
    distance_of_time_in_words(@event.start, @event.finish)
  end

  def id
    @event.id
  end

  def series
    @event.series
  end
end
