class Post < ActiveRecord::Base
  include PostRepository

  update_index('posts#post') { self }

  acts_as_taggable

  has_many :comments, dependent: :destroy
  belongs_to :category

  validates :category, presence: :true
  validates :name, presence: :true
  validates :body, presence: :true
end
