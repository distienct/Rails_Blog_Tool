class User < ActiveRecord::Base

	mount_uploader :avatar, ImageUploader

	has_secure_password

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_posts, through: :likes, source: :post
	has_many :votes, dependent: :destroy
	has_many :voted_posts, through: :votes, source: :post
	has_many :collaborations, dependent: :destroy
	has_many :collaborated_posts, through: :collaborations, source: :post

	has_many :taggings, dependent: :destroy
	has_many :tagged_posts, through: :taggings, source: :post

	has_many :favourites, dependent: :destroy
	has_many :favourited_posts, through: :favourites, source: :post

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true,
						format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	def full_name
		"#{first_name} #{last_name}".strip.squeeze(" ")
	end

	def recent_five_made
		posts.order("updated_at DESC").limit(5)
	end

	def recent_five_joins
		collaborated_posts.order("created_at DESC").limit(5)
	end

end
