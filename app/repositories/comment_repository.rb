module CommentRepository
  extend ActiveSupport::Concern

  included do
    scope :by_post, ->(post) { where(post: post) }
    scope :by_user, ->(user) { where(user: user) }
  end
end
