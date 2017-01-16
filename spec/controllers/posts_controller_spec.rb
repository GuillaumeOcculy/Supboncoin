require 'rails_helper'

describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'populates an array of posts' do
      game = create(:post, name: 'Game')
      video = create(:post, name: 'Video')

      get :index
      expect(assigns(:posts)).to match_array([game, video])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post to @post' do
      post = create(:post)
      get :show, id: post
      expect(assigns(:post)).to eq post
    end

    it 'renders the :show template' do
      post = create(:post)
      get :show, id: post
      expect(response).to render_template :show
    end
  end

  context 'when user is signed in' do
    before :each do
      set_user_session(user)
      @post = create(:post, name: 'Iphone')
    end


    describe 'GET #new' do
      it 'assigns a new Post to @post' do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new post in the database' do
          expect{ post :create, post: attributes_for(:post, category_id: category, user_id: user)}.to change(Post, :count).by(1)
        end
        it 'redirects to the post#show' do
          post :create, post: attributes_for(:post, category_id: category, user_id: user)
          expect(response).to redirect_to post_path(assigns(:post))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new user in the database' do
          expect{ post :create, post: attributes_for(:invalid_post)}.to_not change(Post, :count)
        end
        it 'renders the :new template' do
          post :create, post: attributes_for(:invalid_post)
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      before :each do
        @post = create(:post, user_id: user.id)
      end

      it 'assigns the requested post to @post' do
        get :edit, id: @post
        expect(assigns(:post)).to eq @post
      end
      it 'renders the :edit template' do
        get :edit, id: @post
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      before :each do
        @post = create(:post, name: 'Iphone', user_id: user.id)
      end

      context 'with valid attributes' do
        it 'updates the requested @post' do
          put :update, id: @post, post: attributes_for(:post, name: 'Samsung')
          @post.reload
          expect(@post.name).to eq 'Samsung'
        end
        it 'locates the requested @post' do
          put :update, id: @post, post: attributes_for(:post)
          expect(assigns(:post)).to eq @post
        end
        it 'redirects to the post' do
          put :update, id: @post, post: attributes_for(:post)
          expect(response).to redirect_to(assigns(@post))
        end
      end

      context 'with invalid attributes' do
        it 'does not update the post' do
          put :update, id: @post, post: attributes_for(:invalid_post)
          expect(@post.name).to eq 'Iphone'
        end
        it 'renders the :edit template' do
          put :update, id: @post, post: attributes_for(:invalid_post)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:post) { create(:post, user_id: user.id) }
      it 'deletes the post from the database' do
        post
        expect{ delete :destroy, id: post }.to change(Post, :count).by(-1)
      end
      it 'redirects to posts#index' do
        delete :destroy, id: post
        expect(response).to redirect_to posts_path
      end
    end

    context 'when it is not correct user' do
      let(:post) { create(:post) }
      it 'redirects to root_path' do
        get :edit, id: post
        expect(response).to redirect_to root_path
      end
      it 'renders flash error message' do
        get :edit, id: post
        expect(flash[:danger]).to eq 'This is not your post !'
      end
    end
  end

  context 'when user is not signed in' do
    let(:post) {create(:post)}
    it 'redirects to sign in path' do

      get :edit, id: post
      expect(response).to redirect_to sign_in_path
    end

    it 'renders flash error message' do
      get :edit, id: post
      expect(flash[:danger]).to eq 'You need signed in'
    end
  end

end
