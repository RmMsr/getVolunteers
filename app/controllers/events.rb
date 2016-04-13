GetVolunteers::App.controllers :events do
  get :index, map: ':series_slug' do
    not_found unless series

    values = {
        series: SeriesDrop.new(series),
        future_events: series.future_events.map { |e| EventDrop.new(e) }
    }
    render 'index', layout: true, locals: values
  end

  get :show, map: ':series_slug/:id' do
    not_found unless series
    not_found unless event

    values = {
        series: SeriesDrop.new(series),
        event: EventDrop.new(event)
    }
    render 'show', layout: true, locals: values
  end
end
