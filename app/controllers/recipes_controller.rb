class RecipesController < ApplicationController
  before_filter :authenticate_user!
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = current_user.recipes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
    @ingredients = @recipe.ingredients

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions.inject(""){|sum, i| sum + i.formatted_content + "\n"}
    @ingredients = @recipe.ingredients.inject(""){|sum, i| sum + i.formatted_content + "\n"}
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(params[:recipe])

    respond_to do |format|
      if @recipe.save
        Instruction.multi_save(params[:instructions], @recipe)
        Ingredient.multi_save(params[:ingredients], @recipe)
        current_user.recipes << @recipe
        current_user.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        @recipe.instructions.delete_all
        @recipe.ingredients.delete_all
        Instruction.multi_save(params[:instructions], @recipe)
        Ingredient.multi_save(params[:ingredients], @recipe)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  def add_url
    @recipe = Site.add_recipe(params[:url])
    respond_to do |format|
      if @recipe
        current_user.recipes << @recipe
        current_user.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully added.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { 
          flash[:notice] ="Could not add url. Please check the site is in the list"
          redirect_to action: "index"  
        }
      end
    end
  end
end
