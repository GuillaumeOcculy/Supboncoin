require 'rails_helper'

describe UsersController do

  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'populates an array of contacts starting with the letter' do
        jones = create(:user, last_name: 'Jones')
        smith = create(:user, last_name: 'Smith')

        get :index, letter: 'S'

        expect(assigns(:users)).to match_array([smith])
      end
      it 'renders the :index template' do
        get :index, letter: 'S'
        expect(response).to render_template :index
      end
    end

    context 'without params[:letter]' do
      it 'populates an array of contacts' do
        jones = create(:user, last_name: 'Jones')
        smith = create(:user, last_name: 'Smith')

        get :index

        expect(assigns(:users)).to match_array([smith, jones])
      end
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      user = create(:user)
      get :show, id: user
      expect(assigns(:user)).to eq user
    end

    it 'renders the :show template' do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before :each do
      @user = create(:user)
      set_user_session(@user)
    end
    it 'assigns the requested user to @user' do

      get :edit, id: @user
      expect(assigns(:user)).to eq @user
    end
    it 'renders the :edit template' do

      get :edit, id: @user
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new user in the database' do
        expect{ post :create, user: attributes_for(:user)}.to change(User, :count).by(1)
      end
      it 'redirects to users#show' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end

    context 'with invalid attributes' do
      it ' does not save the new user in the database' do
        expect{ post :create, user: attributes_for(:invalid_user)}.to_not change(User, :count)
      end
      it 're-renders the :new template' do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @user = create(:user, first_name: 'Xavi', last_name: 'Hernandez')
      set_user_session(@user)
    end

    context 'with valid attributes' do
      it 'locates the requested @user' do
        patch :update, id: @user, user: attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        patch :update, id: @user, user: attributes_for(:user, first_name: 'Lionel', last_name: 'Messi')
        @user.reload
        expect(@user.first_name).to eq('Lionel')
        expect(@user.last_name).to eq('Messi')
      end

      it 'redirects to the user' do
        patch :update, id: @user, user: attributes_for(:user)
        expect(response).to redirect_to(assigns(@user))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, id: @user, user: attributes_for(:user, first_name: 'Lionel', username: nil)
        @user.reload
        expect(@user.first_name).to_not eq('Lionel')
        expect(@user.last_name).to      eq('Hernandez')
      end

      it 're-renders the #edit template' do
        patch :update, id: @user, user: attributes_for(:user, first_name: 'Lionel', username: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user)
      set_user_session(@user)
    end
    it 'deletes the contact form database' do
      expect{ delete :destroy, id: @user }.to change(User, :count).by(-1)
    end
    it 'redirects to users#index' do
      delete :destroy, id: @user
      expect(response).to redirect_to users_path
    end
  end


end
