class Blog < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user
  validates :title, :content, presence: true
end
