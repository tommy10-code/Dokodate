class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shop, only: [ :create, :destroy ]

  def index
    @q = current_user.favorite_shops.ransack(params[:q])
    @favorite_shops = @q.result

    if params[:favorited].present? && current_user
      @favorite_shops = @favorite_shops.favorited_by(current_user.id)
    end
  end

  # def favorite
  #   @favorite_shops = current_user.favorite_shops
  # end

  def create
    current_user.favorite(@shop)
  end

  def destroy
    current_user.unfavorite(@shop)
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
