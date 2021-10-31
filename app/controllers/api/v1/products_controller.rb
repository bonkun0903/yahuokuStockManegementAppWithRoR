class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @product = Product.all.order("created_at DESC")
    render json: @product
  end

  def show
    render json: set_product
  end

  def create
    @product = Product.create!(product_params)
    render json: @product
  end

  def update
    @product.update(product_params)
  end

  def destroy
    @product.destroy!
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
# TODO
    def product_params
      params.require(:product).permit(:body, :done)
    end
end
