RSpec.describe User, type: :model do
  describe '.destroy' do
    let!(:user) { create(:user, :with_comments) }

    it "doesn't destroy user comments" do
      expect { user.destroy }.not_to change { Comment.count }
    end
  end
end
