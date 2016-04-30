class Comment < ActiveRecord::Base
  include CommentRepository

  belongs_to :post
  belongs_to :user

  validates :post, presence: :true
  validates :body, presence: :true
end
