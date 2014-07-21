require 'rails_helper'

RSpec.describe Recipe, :type => :model do

  describe '#index' do
    before do
      @user = create(:user)
      @recipes = create_list(:recipe, 3, user: @user)
    end
    it 'displays a collection of recipes', :focus do
      get :index
      expect(response).to be_success
      expect(assigns(:recipes).count).to eq 3
      expect(response).to render_template('index')
    end
  end

end
