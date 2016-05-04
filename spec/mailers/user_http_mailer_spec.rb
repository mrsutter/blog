RSpec.describe UserHttpMailer, type: :mailer do
  describe '.welcome_email' do
    let(:user) { create(:user) }

    context 'when everything is ok' do
      before do
        body = {
          from: Settings.mailer.from.no_reply,
          to: user.email,
          subject: I18n.t('user_mailer.welcome.subject')
        }

        stub_request(:post, Figaro.env.smtp_api_url)
          .with(body: hash_including(body))
      end

      it 'sends email' do
        expect { described_class.new(user).welcome_email }
          .not_to raise_error
      end
    end
  end
end
