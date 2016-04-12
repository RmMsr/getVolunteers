GetVolunteers::App.controllers :events do
  get :index, map: ':slug' do
    series = Series.first slug: params[:slug]
    not_found unless series

    values = {
        series: SeriesDrop.new(series),
        future_events: series.future_events.map { |e| EventDrop.new(e) }
    }
    render 'index', layout: true, locals: values
  end

  get :show, map: ':slug/:id' do
    series = Series.first slug: params[:slug]
    not_found unless series

    event = Event.first id: params[:id]
    not_found unless event

    values = {
        series: SeriesDrop.new(series),
        event: EventDrop.new(event)
    }
    render 'show', layout: true, locals: values
  end
end
