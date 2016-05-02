GetVolunteers::App.controllers :assignments, map: ':series_slug/:event_id/' do
  get :status, provides: %i{png svg} do
    not_found unless series && params[:format]

    badge = EventStatusBadge.new(event)
    redirect to(badge.shields_url(params[:format])), 307
  end

  post :join do
    not_found unless event
    event.volunteers_current += 1
    event.save
    redirect url_for(:events, :show,
                     event_id:    event.id,
                     series_slug: event.series),
             success: 'Thanks. We counted you as a volunteer.'
  end
end
