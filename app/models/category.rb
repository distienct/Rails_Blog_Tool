class Category < ActiveRecord::Base
	has_many :posts, dependent: :nullify
	validates :title, presence: {message: "Title required!"}

end
