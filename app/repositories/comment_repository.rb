module CommentRepository
  extend ActiveSupport::Concern

  included do
    scope :by_post, -> (post) { where(post: post) }
    scope :by_user, -> (user) { where(user: user) }
    scope :ordered, -> { order(created_at: :asc) }
    scope :visible, -> { where.not(state: :declined) }

    scope :available_for, -> (user) do
      return all if user.try(:admin?)
      visible
    end
  end
end
