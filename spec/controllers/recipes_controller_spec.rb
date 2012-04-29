require 'spec_helper'

describe RecipesController do
  include Devise::TestHelpers
  describe "GET index" do

    before (:each) do
      @user = User.make!
      sign_in @user
    end
      
    it 'gets all the current user recipes' do
      recipe = Recipe.make!(:user => @user)
      get :index
      response.should be_success
      assigns(:recipes).should eq([recipe])
    end

    it 'does not find any tagged user recipes' do
      recipe = Recipe.make!(:user => @user)
      get :index, {:tag => 'italian'}
      response.should be_success
      assigns(:recipes).should eq([])
    end

    it 'finds the tagged user recipe' do
      recipe = Recipe.make!(:user => @user, :tag_list => 'italian')
      recipe.save
      get :index, {:tag => 'italian'}
      response.should be_success
      assigns(:recipes).should eq([recipe])
    end

  end

  describe "GET show" do

    before (:each) do
      @user = User.make!
      sign_in @user
    end
    
    it 'gets all the selected recipe' do
      recipe = Recipe.make!(:complete, :user => @user)
      get :show, {:id => recipe.id}
      response.should be_success
      assigns(:recipe).should eq(recipe)
      assigns(:instructions).should eq recipe.instructions
      assigns(:ingredients).should eq recipe.ingredients
    end
    
    
  end

end
