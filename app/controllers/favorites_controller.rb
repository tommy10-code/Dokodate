class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shop, only: [ :create, :destroy ]

  def index
    @q = current_user.favorite_shops.ransack(params[:q])
    @favorite_shops = @q.result

    respond_to do |format|
      format.html
      format.json { render json: @favorite_shops.to_json(
        only: [ :id, :title, :address, :latitude, :longitude ],
        methods: [ :category_name, :scenes_name ]
        )}
    end
  end

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
