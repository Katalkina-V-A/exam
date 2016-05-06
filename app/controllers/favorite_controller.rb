class FavoriteController < ApplicationController
  def index
    @favorites = Film.joins(:users).where('films_users.user_id = ?', @current_user.id)
  end
end
