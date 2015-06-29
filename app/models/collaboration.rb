class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :post, uniqueness: {scope: :user_id}
end
