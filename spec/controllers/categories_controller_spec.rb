require 'rails_helper'

describe CategoriesController do
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
end
