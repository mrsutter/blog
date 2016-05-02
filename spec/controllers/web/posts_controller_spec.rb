describe Web::PostsController, type: :controller do
  describe '#index' do
    before do
      create(:post)
    end

    context 'when user is signed in' do
      include_context 'sign in user'

      it 'returns success' do
        get :index
        expect(response).to be_ok
      end
    end

    context 'when user is guest' do
      it 'returns success' do
        get :index
        expect(response).to be_ok
      end
    end

    context 'when admin is signed in' do
      include_context 'sign in admin'

      it 'returns success' do
        get :index
        expect(response).to be_ok
      end
    end
  end

  describe '#show' do
    let(:post) { create(:post) }

    context 'when user is signed in' do
      include_context 'sign in user'

      it 'returns success' do
        get :show, id: post.id
        expect(response).to be_ok
      end
    end

    context 'when user is guest' do
      it 'returns success' do
        get :show, id: post.id
        expect(response).to be_ok
      end
    end

    context 'when admin is signed in' do
      include_context 'sign in admin'

      it 'returns success' do
        get :show, id: post.id
        expect(response).to be_ok
      end
    end
  end

  describe '#new' do
    context 'when user is signed in' do
      include_context 'sign in user'

      it 'redirects to new session page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'when user is guest' do
      it 'redirects to new session page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'when admin is signed in' do
      include_context 'sign in admin'

      it 'returns success' do
        get :new
        expect(response).to be_ok
      end
    end
  end

  describe '#create' do
    let(:category) { create(:category) }
    let(:name) { 'post_to_create' }
    let(:body) { 'post_body' }
    let(:tag_list) { %w(cool_post first_post) }

    include_context 'sign in admin'

    def post_params(category_id, name, body, tag_list = [])
      {
        post: {
          category_id: category_id,
          name: name,
          body: body,
          tag_list: tag_list
        }
      }
    end

    context 'when params are correct' do
      it 'creates new post' do
        expect { post :create, post_params(category.id, name, body) }
          .to change { Post.count }.by(1)

        expect(response).to redirect_to(post_url(assigns(:post)))

        post = Post.find_by(name: name)
        expect(post.category).to eq(category)
        expect(post.body).to eq(body)
        expect(post.tag_list).to be_empty
      end

      it 'creates new post with tags' do
        expect { post :create, post_params(category.id, name, body, tag_list) }
          .to change { Post.count }.by(1)

        expect(response).to redirect_to(post_url(assigns(:post)))

        post = Post.find_by(name: name)
        expect(post.category).to eq(category)
        expect(post.body).to eq(body)
        expect(post.tag_list).to match_array(tag_list)
      end
    end

    context 'when params are wrong' do
      context 'when category is blank' do
        it "doesn't create user" do
          expect { post :create, post_params('', name, body) }
            .not_to change { Post.count }

          expect(response).to be_ok
        end
      end

      context 'when name is blank' do
        it "doesn't create user" do
          expect { post :create, post_params(category.id, '', body) }
            .not_to change { Post.count }

          expect(response).to be_ok
        end
      end

      context 'when body is blank' do
        it "doesn't create user" do
          expect { post :create, post_params(category.id, name, '') }
            .not_to change { Post.count }

          expect(response).to be_ok
        end
      end
    end
  end

  describe '#edit' do
    let(:post) { create(:post) }

    context 'when user is signed in' do
      include_context 'sign in user'

      it 'redirects to new session page' do
        get :edit, id: post.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'when user is guest' do
      it 'redirects to new session page' do
        get :edit, id: post.id
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'when admin is signed in' do
      include_context 'sign in admin'

      it 'returns success' do
        get :edit, id: post.id
        expect(response).to be_ok
      end
    end
  end

  describe '#update' do
    let(:category) { create(:category) }
    let(:name) { 'post_to_create' }
    let(:body) { 'post_body' }
    let(:tag_list) { %w(cool_post first_post) }

    let(:post) { create(:post) }

    include_context 'sign in admin'

    def post_params(category_id, name, body, tag_list = [])
      {
        category_id: category_id,
        name: name,
        body: body,
        tag_list: tag_list
      }
    end

    context 'when params are correct' do
      it 'updates category' do
        params = post_params(category.id, name, body)

        expect { patch :update, id: post.id, post: params }
          .to change { post.reload.category_id }.to(category.id)

        expect(response).to redirect_to(post_url(post))
      end

      it 'updates name' do
        params = post_params(category.id, name, body)

        expect { patch :update, id: post.id, post: params }
          .to change { post.reload.name }.to(name)

        expect(response).to redirect_to(post_url(post))
      end

      it 'updates body' do
        params = post_params(category.id, name, body)

        expect { patch :update, id: post.id, post: params }
          .to change { post.reload.body }.to(body)

        expect(response).to redirect_to(post_url(post))
      end

      it 'updates tag_list' do
        params = post_params(category.id, name, body, tag_list)

        patch :update, id: post.id, post: params
        expect(response).to redirect_to(post_url(post))

        post.reload

        expect(post.tag_list).to match_array(tag_list)
      end
    end

    context 'when params are wrong' do
      context 'when category is blank' do
        it "doesn't update task" do
          params = post_params('', name, body)

          expect { patch :update, id: post.id, post: params }
            .not_to change { post.reload.category_id }

          expect(response).to be_ok
        end
      end

      context 'when name is blank' do
        it "doesn't update task" do
          params = post_params(category.id, '', body)

          expect { patch :update, id: post.id, post: params }
            .not_to change { post.reload.name }

          expect(response).to be_ok
        end
      end

      context 'when body is blank' do
        it "doesn't update task" do
          params = post_params(category.id, name, '')

          expect { patch :update, id: post.id, post: params }
            .not_to change { post.reload.name }

          expect(response).to be_ok
        end
      end
    end
  end

  describe '#destroy' do
    let(:name) { 'post_to_destroy' }

    include_context 'sign in admin'

    let!(:post) { create(:post, name: name) }

    it 'destroys user task' do
      expect { delete :destroy, id: post.id }
        .to change { Post.count }.by(-1)

      expect(response).to redirect_to(root_url)

      post = Post.find_by(name: name)
      expect(post).to be nil
    end
  end
end
