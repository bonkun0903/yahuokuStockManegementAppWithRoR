class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @product = Product.all.order("id ASC")
    render json: @product
  end

  def show
    render json: set_product
  end

  def create
    begin
      @product = Product.create!(product_params)
      render json: @product
    rescue ArgumentError
      # TODO
    end
  end

  def update
    begin
      @product.update!(product_params)
      render json: @product
    rescue ArgumentError
      puts "引数エラー"
    end
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
      params.require(:product).permit(
        :category,
        :title,
        :description,
        :start_price,
        :count,
        :period,
        :end_time,
        :from_prefecture,
        :shipping_fee_defrayer,
        :payment_timing,
        :fee,
        :product_status,
        :returnable,
        :return_remark,
        # :image,
        :automatic_extension,
        :buyout_price,
        :automatic_relist,
        :automatic_price_cut,
        :delivery_method,
        :inventory_status,
        :zip_exported,
        :inventory_seal_exported,
        :shelf_id,
        :prefecture_id
      )
    end
end
