GetVolunteers::App.controllers :events, map: ':series_slug' do
  get :index do
    not_found unless series

    values = {
        series: SeriesDrop.new(series),
        future_events: series.future_events.map { |e| EventDrop.new(e) }
    }
    render 'index', layout: true, locals: values
  end

  get :show, map: ':event_id' do
    not_found unless series
    not_found unless event

    values = {
        series: SeriesDrop.new(series),
        event: EventDrop.new(event)
    }
    render 'show', layout: true, locals: values
  end
end
