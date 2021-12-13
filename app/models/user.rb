class User < ApplicationRecord
	has_secure_password 
	has_many :memberships, dependent: :destroy
	validates :email , presence: true
	has_one :channel , dependent: :destroy
	has_many :follows
	has_many :channels, through: :follows
	has_many :likes
	has_many :videos, through: :likes
	has_many :comments
	has_many :tags
end
