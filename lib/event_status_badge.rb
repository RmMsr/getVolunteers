# Provides all information to generate a status badge for an event
class EventStatusBadge
  def initialize(event_model)
    @event = event_model
  end

  # Use shields.io API to generate the badge
  def shields_url(format)
    fail ArgumentError, 'Unknown format' unless %w{png svg}.include? format

    url = 'https://img.shields.io/badge/'
    if @event && @event.volunteers_reached?
      url += 'Mentors-found-green'
    elsif @event
      url += 'Mentors-needed-red'
    else
      url += 'No-event-grey'
    end
    "#{url}.#{format}"
  end
end
