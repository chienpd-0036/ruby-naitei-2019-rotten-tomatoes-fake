class Episode < ApplicationRecord
  after_create :create_medium

  belongs_to :season
  has_one :medium, as: :reviewable, dependent: :destroy

  ATTR = %i(info release_date episode_number).freeze

  validates :episode_number, presence: true
  validates :info, presence: true,
    length: {maximum: Settings.episodes.info_max_length}
  validate :unique_episode_number

  scope :celebrities_list, (
    lambda do |episode_id|
      Celebrity.where(id: includes(medium: [celebrity_media: :celebrity]).where(id: episode_id)
                                                                          .pluck("celebrities.id"))
    end)

  def score user_role
    medium.reviews
          .joins(:user).merge(User.role(user_role)).average(:score) || 0
  end

  private

  def unique_episode_number
    return unless season.episodes.where(episode_number: episode_number).exists?
    errors.add :episode_number, I18n.t(".duplicate")
  end
end
