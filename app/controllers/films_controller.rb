class FilmsController < ApplicationController
  before_action :check_authentication, except: :index
  before_action :check_edit, except: [:index, :show, :add]
  impressionist actions: [:show]
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  def index
    @films = Film.base.ordering.page(params[:page])
  end

  def show
  end

  def new
    @film = Film.new
  end

  def edit
  end

  def create
    @film = Film.new(film_params)
    if @film.save
      redirect_to @film, notice: 'Фильм создан.'
    else
      render :new
    end
  end

  def update
    if @film.update(film_params)
      redirect_to @film, notice: 'Фильм изменен.'
    else
      render :edit
    end
  end

  def destroy
    if @film.destroy
      redirect_to films_url, notice: 'Файл удален.'
    else
      render_error("Удаление фильма невозможно", url: @film)
    end
  end

  def add
    type = params[:type]
    if type == "favorite"
      user = @current_user
      film = Film.find(params[:id])
      if user.films.exists?(film)
        redirect_to :back, notice: 'Ничего не произошло.'
      else
        user.films << film
        redirect_to :back, notice: 'Добавлен в избранное.'
      end
    elsif type == "unfavorite"
      user = @current_user
      film = Film.find(params[:id])
      user.films.delete(film)
      redirect_to :back, notice: 'Удален из избранного.'
    else
      redirect_to :back, notice: 'Ничего не произошло.'
    end
  end

  private

  def set_film
    @film = Film.full.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:name, :origin_name, :slogan, :country_id, :genre_id, :director_id, :length, :year, :trailer_url, :cover, :description, :person_tokens, :budget)
  end

  def check_edit
    render_error unless Film.edit_by?(@current_user)
  end
end
