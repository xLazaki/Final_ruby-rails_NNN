class Video < ApplicationRecord
	belongs_to :channel
	has_one_attached :clip
	has_one_attached :thumbnail
end
