class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :index, :create]
  before_action :user_address_nil?, only: [:new, :show, :index, :create]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:notice] = "ありがとうございます。商品の出品が完了しました。"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(
      :user_id,
      :product_name,
      :product_intro,
      :raw_material,
      :fee,
      :expiration_date,
      :total_weight,
      { product_avatars: [] }
    )
  end

  def user_address_nil?
    address_nil_action
  end
end
