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
    context 'when user is not signed in' do
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
        post :create, recipe: { name: 'soup', description: 'good', directions: 'bake' }
        expect(Recipe.count).to eq 1
        expect(response).to redirect_to user_path(@user)
      end
    end
    context 'when new recipe fails to save' do
      it 'renders the new template and does Not save to the db' do
        post :create, recipe: { name: 'soup', description: 'good', directions: nil }
        expect(Recipe.count).to eq 0
        expect(response).to render_template('new')
      end
    end
  end

  describe '#show' do
    before do
      @user = create(:user)
      @recipe = create(:recipe, name: 'Soup', user: @user)
    end
    it 'displays the selected recipe' do
      get :show, id: @recipe.id
      expect(response).to be_success
      expect(assigns(:recipe).name).to eq 'Soup'
      expect(response).to render_template('show')
    end
  end

  describe '#edit' do
    before do
      @user = create(:user)
      @recipe = create(:recipe, user: @user)
    end
    context 'when user who created recipe is signed in' do
      before do
        sign_in @user
      end
      it 'displays the selected recipe for editing' do
        get :edit, id: @recipe.id
        expect(response).to be_success
        expect(assigns(:recipe).id).to eq @recipe.id
        expect(response).to render_template('edit')
      end
    end
    context 'when recipe does Not belong to current user' do
      it 'raises routing error' do
        expect {
          get :edit, id: @recipe.id
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

end
