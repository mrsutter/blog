class Category < ActiveRecord::Base
  acts_as_tree

  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
