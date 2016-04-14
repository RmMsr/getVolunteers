GetVolunteers::Admin.controllers :series do
  get :index do
    @title = 'Series'
    @series = Series.all
    render 'series/index'
  end

  get :new do
    @title = pat(:new_title, model: 'series')
    @series = Series.new
    render 'series/new'
  end

  post :create do
    @series = Series.new(params[:series])
    if @series.save
      @title = pat(:create_title, model: "series #{@series.id}")
      flash[:success] = pat(:create_success, model: 'Series')
      if params[:save_and_continue] then
        redirect(url(:series, :index))
      else
        redirect(url(:series, :edit, id: @series.id))
      end
    else
      @title = pat(:create_title, model: 'series')
      flash.now[:error] = pat(:create_error, model: 'series')
      render 'series/new'
    end
  end

  get :edit, with: :id do
    @title = pat(:edit_title, model: "series #{params[:id]}")
    @series = Series.get(params[:id])
    if @series
      render 'series/edit'
    else
      flash[:warning] = pat('create_error',
                            model: 'series',
                            id: "#{params[:id]}")
      halt 404
    end
  end

  put :update, with: :id do
    @title = pat(:update_title, model: "series #{params[:id]}")
    @series = Series.get(params[:id])
    if @series
      if @series.update(params[:series])
        flash[:success] = pat(
            :update_success,
            model: 'Series',
            id: "#{params[:id]}")
        params[:save_and_continue] ?
            redirect(url(:series, :index)) :
            redirect(url(:series, :edit, id: @series.id))
      else
        flash.now[:error] = pat(:update_error, model: 'series')
        render 'series/edit'
      end
    else
      flash[:warning] = pat(:update_warning,
                            model: 'series',
                            id: "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, with: :id do
    @title = 'Series'
    series = Series.get(params[:id])
    if series
      if series.destroy
        flash[:success] = pat(:delete_success,
                              model: 'Series',
                              id: "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, model: 'series')
      end
      redirect url(:series, :index)
    else
      flash[:warning] = pat(:delete_warning,
                            model: 'series',
                            id: "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = 'Series'
    unless params[:series_ids]
      flash[:error] = pat(:destroy_many_error, model: 'series')
      redirect(url(:series, :index))
    end
    ids = params[:series_ids].split(',').map(&:strip)
    series = Series.all(id: ids)

    if series.destroy

      flash[:success] = pat(:destroy_many_success,
                            model: 'Series',
                            ids: "#{ids.join(', ')}")
    end
    redirect url(:series, :index)
  end
end
