class Comment < ActiveRecord::Base
  include AASM
  include CommentRepository

  belongs_to :post
  belongs_to :user

  validates :post, presence: :true
  validates :body, presence: :true

  aasm column: :state, initial: :new do
    state :new
    state :accepted
    state :declined

    event :accept do
      transitions from: [:new, :declined], to: :accepted
    end

    event :decline do
      transitions from: [:new, :accepted], to: :declined
    end
  end
end
