class SearchController < ApplicationController
  def index
    @sfilms = Film.search(params[:search]).order("created_at DESC")
  end
end
