class CountrysearchController < ApplicationController
  def index
    @scountry = Country.search(params[:search]).page(params[:page])
  end
end
