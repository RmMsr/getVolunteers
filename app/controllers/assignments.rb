GetVolunteers::App.controllers :assignments do
  get :status, map: ':series_slug/:id/status', provides: %i{png svg} do
    event = Event.first(series: params[:series_slug], id: params[:id])
    not_found unless event && params[:format]

    redirect(
      to(
        "https://img.shields.io/badge/mentors-needed-red.#{params[:format]}"),
      307)
  end

  post :assignment, map: ':series_slug/:id/assignments' do
    # TODO
  end
end
