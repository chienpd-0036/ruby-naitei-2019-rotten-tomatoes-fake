class SearchController < ApplicationController
  before_action :build_movie_tvshow, only: :index
  def index
    redirect_to(fallback_location: root_path, alert: t("kw_blank")) if params[:keyword].blank?
    keyword = params[:keyword]
    @tvshows = TvShow.search keyword
    @movies = Movie.search keyword
  end

  private

  def build_movie_tvshow
    @top_score_movie = Movie.create_top_score
    @top_score_movie_tab = @top_score_movie.take Settings.tab_show

    @top_score_tvshow = TvShow.create_top_score
    @top_score_tvshow_tab = @top_score_tvshow.take Settings.tab_show
  end
end
