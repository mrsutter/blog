module PostRepository
  extend ActiveSupport::Concern

  included do
    scope :by_category, ->(category) { where(category: category) }
  end
end
