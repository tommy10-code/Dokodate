class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  scope :favorited_by, ->(user_id) {
    joins(:favorites).where(favorites: { user_id: user_id }).distinct
  }

  def self.ransackable_attributes(auth_object = nil)
  [ "title", "address", "body", "category_id", "created_at", "latitude", "longitude" ]
  end

  def self.ransackable_associations(auth_object = nil)
  %w[scenes shop_scenes category]
  end

end
