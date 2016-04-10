GetVolunteers::App.controllers :events do
  get :index, map: ':slug' do
    series = Series.first slug: params[:slug]
    not_found unless series

    values = {
        series_name: series.name,
        future_events: series.future_events.map { |e| EventDrop.new(e) }
    }
    render 'events/index', layout: true, locals: values
  end

  get :show, map: ':slug/:id' do

  end

  post :assignment, map: ':slug/:id/assignments' do

  end

  get :assignments, map: ':slug/:id/assignments', provides: %i{png svg} do
    not_found unless params[:format]
    redirect to("https://img.shields.io/badge/mentors-needed-red.#{params[:format]}"), 307
  end
end
