GetVolunteers::App.controllers :events, map: ':series_slug' do
  get :index do
    not_found unless series

    values = {
        next_event_url: absolute_url(:events,
                                     :show,
                                     series_slug: series.slug,
                                     event_id:    'next'),
        series:         SeriesDrop.new(series),
        future_events:  series.future_events.map { |e| EventDrop.new(e) }
    }
    render 'index', layout: true, locals: values
  end

  get :show, map: ':event_id' do
    not_found unless series && event

    values = {
        series:     SeriesDrop.new(series),
        event:      EventDrop.new(event),
        csrf_token: csrf_token
    }
    render 'show', layout: true, locals: values
  end
end
