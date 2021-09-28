class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!, if: :admin_url
  before_action :set_q, only: [:index, :search]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  def search
    @results = @q.result
  end

  private
  def set_q
    @q = Genre.ransack(params[:q])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

end
