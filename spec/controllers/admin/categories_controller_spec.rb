require 'rails_helper'
require 'admin/categories_controller'

RSpec.describe Admin::CategoriesController, type: :controller do
  describe 'administrator access' do
      # before :each do
      #   admin = create(:admin)
      #   session[:user_id] = admin.id
      # end

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
  end

end
