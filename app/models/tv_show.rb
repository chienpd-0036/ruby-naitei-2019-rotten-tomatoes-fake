class TvShow < ApplicationRecord
  has_many :seasons, dependent: :destroy

  mount_uploader :poster, TvShowPosterUploader

  scope :create_desc, ->{order updated_at: :desc}

  scope :create_top_score, ->{sort_by(&:critic_score).reverse}

  ATTR = %i(name info poster).freeze

  validates :name, presence: true,
    length: {maximum: Settings.tvshows.name_max_length}
  validates :info, presence: true,
    length: {maximum: Settings.tvshows.info_max_length}

  def critic_score
    arr = seasons.map(&:critic_score).reject(&:zero?)
    arr ? arr.reduce{|sum, score| sum + score} / arr.size : 0
  end

  def audience_score
    arr = seasons.map(&:audience_score).reject(&:zero?)
    arr ? arr.reduce{|sum, score| sum + score} / arr.size : 0
  end
end
