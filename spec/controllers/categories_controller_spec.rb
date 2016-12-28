require 'rails_helper'
require 'categories_controller'

describe CategoriesController, type: :controller do
  describe 'GET #index' do
    it 'populates an array of categories' do
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
      category = create(:category)
      get :show, id: category
      expect(assigns(:category)).to eq category
    end

    it 'renders the :show template' do
      category = create(:category)
      get :show, id: category
      expect(response).to render_template :show
    end
  end
end
