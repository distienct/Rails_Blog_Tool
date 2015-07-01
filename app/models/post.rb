class Post < ActiveRecord::Base

	belongs_to :category
	belongs_to :user

	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liking_users, through: :likes, source: :user
	has_many :votes, dependent: :destroy
	has_many :voting_users, through: :votes, source: :user

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	has_many :favourites, dependent: :destroy
	has_many :favouriting_users, through: :favourites, source: :user
	
	has_many :collaborations, dependent: :destroy
	has_many :collaborating_users, through: :collaborations, source: :user

	validates :title, presence: {message: "Post must have a title!"}, uniqueness: true

	validates :body, presence: {message: "Post must have a body!"}

	scope :recent_three, lambda { order("updated_at DESC").limit(3) }


	def liked_by?(user)
		likes.where(user: user).present?
	end

	def like_for(user)
		likes.find_by_user_id(user)
	end

	def favourited_by?(user)
		favourites.where(user: user).present?
	end

	def favourite_for(user)
		favourites.find_by_user_id(user)
	end

	def vote_for(user)
    votes.find_by_user_id(user)
  end

	def vote_result
   count = 0
   votes.each {|v| v.is_up? ? count += 1 : count -= 1 }
   count
 end

end
