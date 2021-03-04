class StaticPagesController < ApplicationController
  MAX_RELATED_PRODUCT_COUNT = 12

  def home
    @products = Product.order(created_at: :desc).limit(MAX_RELATED_PRODUCT_COUNT)
  end

  def about
  end
end
