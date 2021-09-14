class IngredientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  def index
    if params[:recipe_id]
      recipe = Recipe.find(params[:recipe_id])
      ingredients = recipe.ingredients
    else
      ingredients = Ingredient.all
    end
    render json: ingredients, include: :recipe
  end

  def show
    ingredient = Ingredient.find(params[:id])
    render json: ingredient
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    ingredient = recipe.ingredients.create(ingredient_params)
    render json: ingredient, status: :created
  end

private

  def ingredient_params
    params.permit(:name, :quantity)
  end

  def render_not_found_error
    render json: { errors: "Could not find record" }, status: :not_found
  end

end
