class Blog < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_and_belongs_to_many :categories
  belongs_to :user
  has_many :likes, as: :likeable

  validates :title, :content, presence: true

  has_one_attached :cover_image

  def cover_image_url
    rails_blob_url(self.cover_image, only_path: false) if self.cover_image.attached?
  end

  def liked?(user)
    self.likes.where(user: user).exists?
  end
end
