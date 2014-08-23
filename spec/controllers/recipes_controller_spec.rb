require 'rails_helper'

RSpec.describe RecipesController, :type => :controller do

  describe '#index' do
    before do
      @user = create(:user)
      @recipes = create_list(:recipe, 3, user: @user)
    end
    it 'displays a collection of recipes' do
      get :index
      expect(response).to be_success
      expect(assigns(:recipes).count).to eq 3
      expect(response).to render_template(:index)
    end
  end

  describe '#new' do
    before do
      @user = create(:user)
    end
    context 'when user is signed in' do
      before do
        sign_in @user
      end
      it 'sets up a new recipe instance' do
        get :new
        expect(response).to be_success
        expect(assigns(:recipe)).to be_new_record
        expect(response).to render_template('new')
      end
    end
    context 'when user is not signe in' do
      it 'redirects to sign in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    before do
      @user = create(:user)
      sign_in @user
    end
    context 'when new recipe is saved' do
      it 'creates a new recipe and saves it to the db' do
        expect {
          create(:recipe, user: @user)
        }.to change(Recipe, :count).by(1)
      end
    end
    context 'when new recipe fails to save' do
      it 'renders the new template and does Not save to the db' do
        post :create, recipe: { name: 'soup', description: 'good stuff', directions: nil }
        expect(response).to render_template('new')
        expect(Recipe.count).to eq 0
      end
    end
  end

end
