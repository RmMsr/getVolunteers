class EventDrop < Liquid::Drop
  include Padrino::Helpers::FormatHelpers

  def initialize(event)
    @event = event
  end

  def id
    @event.id
  end

  def start
    I18n.localize(@event.start, format: :long) if @event.start
  end

  def start_short
    I18n.localize(@event.start, format: :short) if @event.start
  end

  def start_date
    I18n.localize(@event.start.to_date, format: :long) if @event.start
  end

  def finish
    I18n.localize(@event.finish, format: :long) if @event.finish
  end

  def duration_in_words
    distance_of_time_in_words(@event.start, @event.finish)
  end

  def volunteers_goal
    @event.volunteers_goal
  end

  def volunteers_current
    @event.volunteers_current
  end
end
