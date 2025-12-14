class HomeController < ApplicationController
  def index; end

  def guest_login
    user = User.find_by!(email: "guest@example.com")
    sign_in user
    redirect_to authenticated_root_path, notice: "ゲストでログインしました"
  end

  def terms; end
  def privacy; end
end
