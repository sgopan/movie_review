class Movie < ActiveRecord::Base
	searchkick
	belongs_to :user
	has_many :reviews

	validates :title, presence: true
	validates :description, presence: true
	validates :movie_length, presence: true
	validates :director, presence: true
	validates :rating, presence: true

	has_attached_file :image, styles: { medium: "400x600#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
