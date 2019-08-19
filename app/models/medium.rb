class Medium < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  has_many :reviews, dependent: :destroy
  has_many :celebrity_media, dependent: :destroy
  # has_many :celebrities, through: :celebrity_media

  class << self
    def create_instance reviewable
      create reviewable: reviewable
    end
  end
end
