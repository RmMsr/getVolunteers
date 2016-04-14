GetVolunteers::App.controllers :assignments, map: ':series_slug/:event_id/' do
  get :status, provides: %i{png svg} do
    not_found unless event && params[:format]

    badge = EventStatusBadge.new(event)
    redirect to(badge.shields_url(params[:format])), 307
  end

  post :assignment do
    # TODO
  end
end
