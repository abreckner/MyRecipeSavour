require 'spec_helper'

describe RecipesController do
  include Devise::TestHelpers

  def valid_attributes
    {:recipe => {:name => 'test'}, :ingredients => 'test', :instructions => 'test'}
  end

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

    it 'does not allow someone else to see the recipe' do
      user = User.create(:email=>"test", :password => "test")
      recipe = Recipe.make!(:complete, :user => user)
      get :show, {:id => recipe.id}
      response.should redirect_to(recipes_path)
    end
    
  end

  describe "GET new" do

    before (:each) do
      @user = User.make!
      sign_in @user
    end
    
    it 'shows the new recipe page' do
      get :new
      response.should be_success
      assigns(:recipe).should_not == nil
    end
    
  end

  describe "GET edit" do

    before (:each) do
      @user = User.make!
      sign_in @user
    end
    
    it 'shows the edit page' do
      recipe = Recipe.make!(:complete, :user => @user)
      post :edit, {:id => recipe.id}
      response.should be_success
      assigns(:recipe).should eq(recipe)
      assigns(:instructions).should eq recipe.formatted_instructions
      assigns(:ingredients).should eq recipe.formatted_ingredients
    end

    it 'does not allow someone else to edit the recipe' do
      user = User.create(:email=>"test", :password => "test")
      recipe = Recipe.make!(:complete, :user => user)
      post :edit, {:id => recipe.id}
      response.should redirect_to(recipes_path)
    end
    
  end

  describe "POST create" do
    before (:each) do
      @user = User.make!
      sign_in @user
    end
    describe "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, valid_attributes
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created site as @site" do
        post :create, valid_attributes
        assigns(:recipe).should be_a(Recipe)
        assigns(:recipe).should be_persisted
      end

      it "redirects to the created site" do
        post :create, valid_attributes
        response.should redirect_to(Recipe.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved site as @site" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recipe.any_instance.stub(:save).and_return(false)
        post :create, {:recipe => {}}
        assigns(:recipe).should be_a_new(Recipe)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recipe.any_instance.stub(:save).and_return(false)
        post :create, {:recipe => {}}
        response.should render_template("new")
      end
    end
  end

  describe "POST update" do
    before (:each) do
      @user = User.make!
      sign_in @user
      @recipe = Recipe.make!(:user => @user)
    end

    it "should be valid" do
      post :update, {:recipe => {:name => 'test'}, :ingredients => 'test', :instructions => 'test', :id => @recipe.id}
      response.should redirect_to(@recipe)
    end

    it "should not be valid" do
      post :update, {:id => @recipe.id, :recipe => {:name => nil}, :ingredients => 'test', :instructions => 'test'}
      response.should render_template("edit")
    end

    it 'does not allow someone else to update the recipe' do
      user = User.create(:email=>"test", :password => "test")
      recipe = Recipe.make!(:complete, :user => user)
      post :update, {:id => recipe.id}
      response.should redirect_to(recipes_path)
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @user = User.make!
      sign_in @user
    end

    it "destroys the requested site" do
      recipe = Recipe.make!(:user => @user)
      expect {
        delete :destroy, {:id => recipe.id}
      }.to change(Recipe, :count).by(-1)
    end

    it "does not destroy the requested site if the user does not own the recipe" do
      recipe = Recipe.make!
      expect {
        delete :destroy, {:id => recipe.id}
      }.to change(Recipe, :count).by(0)
    end

    it "redirects to the sites list" do
      recipe = Recipe.make!(:user => @user)
      delete :destroy, {:id => recipe.id}
      response.should redirect_to(recipes_url)
    end
  end

  describe "add_url" do
    before (:each) do
      @user = User.make!
      sign_in @user
    end

    it "doesn't add the url" do
      Site.stub(:add_recipe).and_return false
      get :add_url
      response.should redirect_to(new_recipe_url)
    end

    it "adds the url" do
      recipe = Recipe.make!
      Site.stub(:add_recipe).and_return recipe
      get :add_url
      response.should redirect_to(recipe)
    end
  end

end
