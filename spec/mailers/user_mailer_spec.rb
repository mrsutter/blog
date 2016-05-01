RSpec.describe UserMailer, type: :mailer do
  describe '.welcome' do
    let!(:admin) { create(:user) }
    let(:user) { create(:user) }

    context 'when user role is admin' do
      let(:mail) { described_class.welcome_email(admin).deliver_now }

      it 'sends correct subject' do
        expect(mail.subject).to eq(I18n.t('user_mailer.welcome.subject'))
      end

      it 'sends message to correct address' do
        expect(mail.to).to eq([admin.email])
      end

      it 'sends email from correct address' do
        expect(mail.from).to eq([Settings.mailer.from.no_reply])
      end

      it 'sends greeting in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.greeting', name: admin.email))
      end

      it 'sends gratitude in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.gratitude'))
      end

      it 'sends host in body' do
        expect(mail.body.encoded)
          .to match(Settings.host)
      end

      it 'sends role in body' do
        role = User.human_attribute_value(:role, :admin).mb_chars.downcase.to_s
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.role', role: role))
      end

      it 'sends admin permissions in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.admin_permissions'))
      end

      it 'sends yours_respectfully in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.yours_respectfully'))
      end
    end

    context 'when user role is user' do
      let(:mail) { described_class.welcome_email(user).deliver_now }

      it 'sends correct subject' do
        expect(mail.subject).to eq(I18n.t('user_mailer.welcome.subject'))
      end

      it 'sends message to correct address' do
        expect(mail.to).to eq([user.email])
      end

      it 'sends email from correct address' do
        expect(mail.from).to eq([Settings.mailer.from.no_reply])
      end

      it 'sends greeting in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.greeting', name: user.email))
      end

      it 'sends gratitude in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.gratitude'))
      end

      it 'sends host in body' do
        expect(mail.body.encoded)
          .to match(Settings.host)
      end

      it 'sends role in body' do
        role = User.human_attribute_value(:role, :user).mb_chars.downcase.to_s
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.role', role: role))
      end

      it 'sends user permissions in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.user_permissions'))
      end

      it 'sends yours_respectfully in body' do
        expect(mail.body.encoded)
          .to match(I18n.t('user_mailer.welcome.yours_respectfully'))
      end
    end
  end
end
