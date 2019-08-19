class SeasonsController < ApplicationController
  before_action :build_movie_tvshow, only: :show
  def show
    @user = User.new
    @tv_show = TvShow.find_by id: params[:tv_show_id]
    @season = Season.find_by id: params[:id]

    @critic_score = @season.score(:critic)
                           .zero? ? "N/A" : @season.score(:critic).round(1)
    @audience_score = @season.score(:normal)
                             .zero? ? "N/A" : @season.score(:normal).round(1)

    @celebrities = Season.celebrities_list @season.id
  end

  private

  def build_movie_tvshow
    @top_score_movie = Movie.create_top_score
    @top_score_movie_tab = @top_score_movie.take Settings.tab_show

    @top_score_tvshow = TvShow.create_top_score
    @top_score_tvshow_tab = @top_score_tvshow.take Settings.tab_show
  end
end
