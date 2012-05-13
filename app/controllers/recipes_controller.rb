class RecipesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_user_recipe, :only => [:show, :edit, :update, :destroy]
  # GET /recipes
  # GET /recipes.json
  def index
    unless params[:tag].blank?
      @recipes = current_user.recipes.tagged_with(params[:tag]).order("created_at desc").page(params[:page]).per(10)
    else
      @recipes = current_user.recipes.order("created_at desc").page(params[:page]).per(10) 
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = current_user.recipes.find(params[:id])
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
    @recipe = current_user.recipes.find(params[:id])
    @instructions = @recipe.formatted_instructions
    @ingredients = @recipe.formatted_ingredients
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
    @recipe = current_user.recipes.find(params[:id])
    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        
        unless params[:instructions].nil?
          @recipe.instructions.delete_all
          Instruction.multi_save(params[:instructions], @recipe)
        end
        
        unless params[:ingredients].nil?
          @recipe.ingredients.delete_all
          Ingredient.multi_save(params[:ingredients], @recipe)
        end

        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render json: {:recipe => @recipe, :tags => @recipe.tag_list} }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  def add_url
    @recipe = Site.add_recipe(params[:url], current_user)
    respond_to do |format|
      if @recipe
        current_user.recipes << @recipe
        current_user.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully added.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { 
          flash[:notice] ="This site has not yet been cataloged. In the meantime you can copy and paste the recipe here."
          redirect_to action: :new  
        }
      end
    end
  end

  private
  def validate_user_recipe
    unless current_user.recipes.exists?(params[:id])
      redirect_to recipes_path, notice: 'You are no allowed to see this recipe.'
    end
  end
end
