class User < ActiveRecord::Base

	has_secure_password

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_posts, through: :likes, source: :post
	has_many :votes, dependent: :destroy
	has_many :voted_posts, through: :votes, source: :post
	has_many :collaborations, dependent: :destroy
	has_many :collaborated_posts, through: :collaborations, source: :posts

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true,
						format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	def full_name
		"#{first_name} #{last_name}".strip.squeeze(" ")
	end

end
