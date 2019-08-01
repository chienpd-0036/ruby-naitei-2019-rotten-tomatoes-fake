class Admin::CelebritiesController < Admin::BaseController
  before_action :load_celebrity, except: %i(index new create)

  def index
    @celebrities = Celebrity.create_desc.page(params[:page])
                            .per Settings.celebrities.paginate
  end

  def new
    @celebrity = Celebrity.new
  end

  def create
    @celebrity = Celebrity.new celebrity_params

    if @celebrity.save
      flash[:success] = t ".create_success"
      redirect_to [:admin, @celebrity]
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @celebrity.update_attributes celebrity_params
      flash[:success] = t ".update_success"
      redirect_to [:admin, @celebrity]
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    @celebrity.destroy
    flash[:success] = t ".delete_success"
    redirect_to admin_celebrities_url
  end

  private

  def celebrity_params
    params.require(:celebrity).permit Celebrity::ATTR
  end

  def load_celebrity
    @celebrity = Celebrity.find_by id: params[:id]

    return if @celebrity
    flash[:danger] = t ".not_found"
    redirect_to admin_celebrities_url
  end
end
