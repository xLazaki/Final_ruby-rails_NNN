class Channel < ApplicationRecord
  belongs_to :user
  has_many :videos
  has_one_attached :thumbnail
  has_many :follows
  has_many :users, through: :follows
end
