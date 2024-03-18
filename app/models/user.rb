class User < ApplicationRecord
  has_many :blogs
  has_one :profile
  has_many :likes
  has_many :monthly_summaries
  
  after_create :create_profile

  validates :username, :email, :first_name, :last_name, presence: true

  has_secure_password
end
