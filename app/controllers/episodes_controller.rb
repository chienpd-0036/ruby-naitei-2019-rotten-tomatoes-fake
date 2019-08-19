class EpisodesController < ApplicationController
  before_action :build_movie_tvshow, only: :show
  def show
    @tv_show = TvShow.find_by id: params[:tv_show_id]
    @season = Season.find_by id: params[:season_id]
    @episode = Episode.find_by id: params[:id]

    @critic_score = @episode.score(:critic)
                            .zero? ? "N/A" : @episode.score(:critic).round(1)
    @audience_score = @episode.score(:normal)
                              .zero? ? "N/A" : @episode.score(:normal).round(1)

    @review = Review.new

    @celebrities = Episode.celebrities_list @episode.id

    @reviewed = current_user.reviewed? @episode.medium if user_signed_in?
  end

  def build_movie_tvshow
    @top_score_movie = Movie.create_top_score
    @top_score_movie_tab = @top_score_movie.take 15

    @top_score_tvshow = TvShow.all.create_top_score
    @top_score_tvshow_tab = @top_score_tvshow.take 15
  end
end
