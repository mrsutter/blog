RSpec.describe Category, type: :model do
  describe '.destroy' do
    let(:category) { create(:category, :with_posts) }

    it 'destroys category posts' do
      posts_count = category.posts.count
      expect { category.destroy }
        .to change { Post.by_category(category).count }.by(-posts_count)
    end
  end
end
