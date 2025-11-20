class UsersController < ApplicationController
  before_action :authenticate_user!

  def favorites
    @q = current_user.favorite_shops.ransack(params[:q])
    @favorite_shops = @q.result

    if params[:favorited].present? && current_user
      @favorite_shops = @favorite_shops.favorited_by(current_user.id)
    end
  end
end
