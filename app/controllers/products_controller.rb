class ProductsController < ApplicationController
  before_action :authenticate_user!,
                only: [:new, :show, :index, :create, :edit, :destroy, :update, :search]
  before_action :user_address_nil?,
                only: [:new, :show, :index, :create, :edit, :destroy, :update, :search]
  before_action :correct_user_product, only: [:edit, :update]

  def index
    @products = Product.includes(:user).order(created_at: :desc).page(params[:page]).per(12)
  end

  def search
    @products = Product.search_free_word(params[:free_word]).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
    @purchase = current_user.purchases.build
  end

  def self_index
    @products = current_user.products.includes(:user).
      order(created_at: :desc).page(params[:page]).per(12)
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
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "商品の編集が完了しました。"
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:notice] = "商品の削除が完了しました。"
    redirect_to products_path
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
      :categories,
      { product_avatars: [] }
    )
  end

  def user_address_nil?
    address_nil_action
  end

  def correct_user_product
    @product = Product.find(params[:id])
    user = @product.user
    redirect_to(root_url) unless user == current_user
  end
end
