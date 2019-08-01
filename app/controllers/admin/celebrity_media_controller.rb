class Admin::CelebrityMediaController < Admin::BaseController
  before_action :load_celebrity_medium, only: :destroy

  def create
    @celebrity_medium = CelebrityMedium.new celebrity_medium_params

    if @celebrity_medium.save
      flash[:success] = t ".create_success"
    else
      flash[:danger] = t ".create_failed"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # reviewable = @celebrity_medium.medium.reviewable
    @celebrity_medium.destroy
    flash[:notice] = t ".delete_success"
    redirect_back(fallback_location: root_path)
  end

  private

  def celebrity_medium_params
    params.require(:celebrity_medium).permit :role, :celebrity_id, :medium_id
  end

  def load_celebrity_medium
    @celebrity_medium = CelebrityMedium.find_by id: params[:id]

    return if @celebrity_medium
    flash[:danger] = t ".not_found"
    redirect_back(fallback_location: root_path)
  end
end
