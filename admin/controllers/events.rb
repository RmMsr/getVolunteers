GetVolunteers::Admin.controllers :events do
  get :index do
    @title = 'Events'
    @events = Event.all
    render 'events/index'
  end

  get :new do
    @title = pat(:new_title, model: 'event')
    @event = Event.new
    render 'events/new'
  end

  post :create do
    @event = Event.new(params[:event])
    if @event.save
      @title = pat(:create_title, model: "event #{@event.id}")
      flash[:success] = pat(:create_success, model: 'Event')
      if params[:save_and_continue] then
        redirect(url(:events, :index))
      else
        redirect(url(:events, :edit, id: @event.id))
      end
    else
      @title = pat(:create_title, model: 'event')
      flash.now[:error] = pat(:create_error, model: 'event')
      render 'events/new'
    end
  end

  get :edit, with: :id do
    @title = pat(:edit_title, model: "event #{params[:id]}")
    @event = Event.get(params[:id])
    if @event
      render 'events/edit'
    else
      flash[:warning] = pat(:create_error, model: 'event', id: "#{params[:id]}")
      halt 404
    end
  end

  put :update, with: :id do
    @title = pat(:update_title, model: "event #{params[:id]}")
    @event = Event.get(params[:id])
    if @event
      if @event.update(params[:event])
        flash[:success] = pat(:update_success,
                              model: 'Event',
                              id: "#{params[:id]}")
        params[:save_and_continue] ?
            redirect(url(:events, :index)) :
            redirect(url(:events, :edit, id: @event.id))
      else
        flash.now[:error] = pat(:update_error, model: 'event')
        render 'events/edit'
      end
    else
      flash[:warning] = pat(:update_warning,
                            model: 'event',
                            id: "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, with: :id do
    @title = 'Events'
    event = Event.get(params[:id])
    if event
      if event.destroy
        flash[:success] = pat(:delete_success,
                              model: 'Event',
                              id: "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, model: 'event')
      end
      redirect url(:events, :index)
    else
      flash[:warning] = pat(:delete_warning,
                            model: 'event',
                            id: "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = 'Events'
    unless params[:event_ids]
      flash[:error] = pat(:destroy_many_error, model: 'event')
      redirect(url(:events, :index))
    end
    ids = params[:event_ids].split(',').map(&:strip)
    events = Event.all(id: ids)

    if events.destroy

      flash[:success] = pat(:destroy_many_success,
                            model: 'Events',
                            ids: "#{ids.join(', ')}")
    end
    redirect url(:events, :index)
  end
end
