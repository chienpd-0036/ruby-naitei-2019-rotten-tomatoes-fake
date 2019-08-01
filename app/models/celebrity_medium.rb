class CelebrityMedium < ApplicationRecord
  belongs_to :celebrity
  belongs_to :medium

  enum role: {actor: 0, director: 1}

  validates_uniqueness_of :celebrity_id, scope: %i(medium_id role)
end
