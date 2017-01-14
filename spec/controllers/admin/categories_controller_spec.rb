require 'rails_helper'
require 'admin/categories_controller'

RSpec.describe Admin::CategoriesController, type: :controller do
  describe 'administrator access' do
    let(:admin) { create(:admin) }
    let(:category) { create(:category, name: 'Computing') }
    before :each do
      set_user_session(admin)
    end

    describe 'GET #index' do
      it 'populates and array of categories' do
        computer = create(:category, name: 'Computer')
        phone = create(:category, name: 'Phone')

        get :index

        expect(assigns(:categories)).to match_array([computer, phone])
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'assigns the requested category to @category' do
        get :show, id: category
        expect(assigns(:category)).to eq category
      end

      it 'renders the :show template' do
        get :show, id: category
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it 'assigns a new Category to @category' do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new category in the database' do
          expect{ post :create, category: attributes_for(:category)}.to change(Category, :count).by(1)
        end
        it 'redirects to categories#index' do
          post :create, category: attributes_for(:category)
          expect(response).to redirect_to admin_categories_path
        end
      end
      context 'with invalid attributes' do
        it 'does not save the new category in the database' do
          expect{ post :create, category: attributes_for(:category, name: nil)}.to_not change(Category, :count)
        end
        it 're-renders the :new template' do
          post :create, category: attributes_for(:category, name: nil)
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested category to @category' do
        get :edit, id: category
        expect(assigns(:category)).to eq category
      end

      it 'renders the :edit template' do
        get :edit, id: category
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      context 'with valid attributes' do
        it 'locates the requested @category' do
          put :update, id: category, category: attributes_for(:category)
          expect(assigns(:category)).to eq(category)
        end

        it "changes @category's attributes" do
          put :update, id: category, category: attributes_for(:category, name: 'Phone')
          category.reload
          expect(category.name).to eq('Phone')
        end

        it 'redirects to categores#index' do
          put :update, id: category, category: attributes_for(:category)
          expect(response).to redirect_to admin_categories_path
        end
      end

      context 'with invalid attributes' do
        it 'does not update the category' do
          put :update, id: category, category: attributes_for(:category, name: nil)
          category.reload
          expect(category.name).to_not eq('Phone')
        end

        it 're-renders the :edit template' do
          put :update, id: category, category: attributes_for(:category, name: nil)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the category form database' do
        category
        expect{ delete :destroy, id: category }.to change(Category, :count).by(-1)
      end

      it 'redirects to categories#index' do
        delete :destroy, id: category
        expect(response).to redirect_to admin_categories_path
      end
    end
  end

end
