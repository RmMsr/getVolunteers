GetVolunteers::App.controllers :assignments do
  get :status, map: ':series_slug/:id/status', provides: %i{png svg} do
    not_found unless event && params[:format]

    badge = EventStatusBadge.new(event)
    redirect to(badge.shields_url(params[:format])), 307
  end

  post :assignment, map: ':series_slug/:id/assignments' do
    # TODO
  end
end
