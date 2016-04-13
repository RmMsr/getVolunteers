# Provides all information to generate a status badge for an event
class EventStatusBadge
  def initialize(event_model)
    @event = event_model
  end

  # Use shields.io API to generate the badge
  def shields_url(format)
    fail ArgumentError, 'Unknown format' unless %w{png svg}.include? format

    url = 'https://img.shields.io/badge/Mentors-'
    if @event.volunteers_reached?
      url += 'found-green'
    else
      url += 'needed-red'
    end
    "#{url}.#{format}"
  end
end
