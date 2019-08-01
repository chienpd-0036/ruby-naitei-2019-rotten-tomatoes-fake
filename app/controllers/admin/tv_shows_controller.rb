class Admin::TvShowsController < Admin::BaseController
  before_action :load_tvshow, except: %i(index new create)

  def index
    @tv_shows = TvShow.all.page(params[:page]).per Settings.tvshows.paginate
  end

  def new
    @tv_show = TvShow.new
  end

  def create
    @tv_show = TvShow.new tv_show_params

    if @tv_show.save
      flash[:success] = t ".create_success"
      redirect_to [:admin, @tv_show]
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @tv_show.update_attributes tv_show_params
      flash[:success] = t ".update_success"
      redirect_to [:admin, @tv_show]
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @tv_show.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_tv_shows_url
  end

  private

  def tv_show_params
    params.require(:tv_show).permit TvShow::ATTR
  end

  def load_tvshow
    @tv_show = TvShow.find_by id: params[:id]

    return if @tv_show
    flash[:danger] = t ".not_found"
    redirect_to admin_tv_shows_url
  end
end
