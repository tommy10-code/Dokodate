class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  scope :favorited_by, ->(user_id) {
    joins(:favorites).where(favorites: { user_id: user_id }).distinct
  }
end
