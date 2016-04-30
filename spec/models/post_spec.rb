RSpec.describe Post, type: :model do
  describe '.destroy' do
    let(:post) { create(:post, :with_comments) }

    it 'destroys category posts' do
      comments_count = post.comments.count
      expect { post.destroy }
        .to change { Comment.by_post(post).count }.by(-comments_count)
    end
  end
end
