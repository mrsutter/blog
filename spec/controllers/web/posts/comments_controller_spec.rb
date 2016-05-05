describe Web::Posts::CommentsController, type: :controller do
  let(:resource_post) { create(:post) }
  let(:post_id) { resource_post.id }

  describe '#create' do
    let(:body) { 'body' }

    context 'when params are correct' do
      def comment_params
        { body: body }
      end

      context 'when admin is signed in' do
        include_context 'sign in admin'

        it 'creates comment' do
          params = { post_id: post_id, comment: comment_params }
          expect { post :create, params }
            .to change { resource_post.comments.count }.by(1)

          comment = resource_post.comments.find_by(body: body)
          expect(comment.user).to eq(admin)

          expect(response).to redirect_to(post_url(resource_post))
        end
      end

      context 'when user is signed in' do
        include_context 'sign in user'

        it 'creates comment' do
          params = { post_id: post_id, comment: comment_params }
          expect { post :create, params }
            .to change { resource_post.comments.count }.by(1)

          comment = resource_post.comments.find_by(body: body)
          expect(comment.user).to eq(user)

          expect(response).to redirect_to(post_url(resource_post))
        end
      end

      context 'when user is guest' do
        context 'when captcha is verified' do
          before do
            stub_request(:post, Settings.recaptcha_api)
              .to_return(body: "{\n  \"success\": true\n}")
          end

          it 'creates comment' do
            params = { post_id: post_id, comment: comment_params }
            expect { post :create, params }
              .to change { resource_post.comments.count }.by(1)

            comment = resource_post.comments.find_by(body: body)
            expect(comment.user).to eq(nil)

            expect(response).to redirect_to(post_url(resource_post))
          end
        end

        context 'when captcha verification fails' do
          before do
            stub_request(:post, Settings.recaptcha_api)
              .to_return(body: "{\n  \"success\": false\n}")
          end

          it 'does not create comment' do
            params = { post_id: post_id, comment: comment_params }
            expect { post :create, params }
              .not_to change { resource_post.comments.count }
          end
        end

        context 'when captcha is unreachable' do
          before do
            stub_request(:post, Settings.recaptcha_api)
              .to_return(status: 500)
          end

          it 'does not create comment' do
            params = { post_id: post_id, comment: comment_params }
            expect { post :create, params }
              .not_to change { resource_post.comments.count }
          end
        end
      end
    end

    context 'when params are wrong' do
      include_context 'sign in admin'

      it 'does not comment' do
        params = { post_id: post_id, comment: { body: '' } }
        expect { post :create, params }
          .not_to change { resource_post.comments.count }

        comment = resource_post.comments.first
        expect(comment).to be_nil
      end
    end
  end

  describe '#accept' do
    include_context 'sign in admin'

    let(:comment) { create(:comment) }

    it 'destroys user task' do
      params = { post_id: comment.post.id, id: comment.id }

      expect { patch :accept, params }
        .to change { comment.reload.state }
        .from('new')
        .to('accepted')

      expect(response).to redirect_to(post_url(comment.post))
    end
  end

  describe '#decline' do
    include_context 'sign in admin'

    let(:comment) { create(:comment, state: 'accepted') }

    it 'destroys user task' do
      params = { post_id: comment.post.id, id: comment.id }

      expect { patch :decline, params }
        .to change { comment.reload.state }
        .from('accepted')
        .to('declined')

      expect(response).to redirect_to(post_url(comment.post))
    end
  end

  describe '#destroy' do
    include_context 'sign in admin'

    let(:body) { 'comment_to_destroy' }
    let(:resource_post) { create(:post) }
    let(:comment) { create(:comment, body: body, post: resource_post) }

    it 'destroys user task' do
      params = { post_id: resource_post.id, id: comment.id }

      expect { delete :destroy, params }
        .to change { resource_post.comments.count }.by(-1)

      expect(response).to redirect_to(post_url(resource_post))

      comment = resource_post.comments.find_by(body: body)
      expect(comment).to be nil
    end
  end
end
