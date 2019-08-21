class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy

  mount_uploader :poster, SeasonPosterUploader

  ATTR = %i(info poster season_number).freeze

  validates :info, presence: true,
            length: {maximum: Settings.seasons.info_max_length}
  validate :unique_season_number

  scope :celebrities_list, (
  lambda do |season_id|
    Celebrity.where(
        id: includes(episodes:
                         [medium: [celebrity_media: :celebrity]]).where(id: season_id)
                .pluck("celebrities.id").uniq
    )
  end)

  def score user_role
    arr = episodes.map { |e| e.score(user_role) }.reject(&:zero?)
    return 0 if arr&.empty?
    arr.reduce(:+) / arr.size
  end

  def critic_score
    arr = episodes.map(&:critic_score).reject(&:zero?)
    arr ? arr.reduce { |a, e| a + e } / arr.size : 0
  end

  def audience_score
    arr = episodes.map(&:audience_score).reject(&:zero?)
    arr ? arr.reduce { |a, e| a + e } / arr.size : 0
  end

  private

  def unique_season_number
    return unless tv_show.seasons.where(season_number: season_number).exists?
    errors.add :season_number, I18n.t("admin.seasons.duplicate")
  end
end
