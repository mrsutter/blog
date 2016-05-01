shared_context 'sign in user' do
  let!(:admin) { create(:user) }
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end
end

shared_context 'sign in admin' do
  let!(:admin) { create(:user) }

  before do
    sign_in(admin)
  end
end
