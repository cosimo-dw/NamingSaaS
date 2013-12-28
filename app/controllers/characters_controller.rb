class CharactersController < ApplicationController
  before_action :admin_user
  def show
  end

  def index
    @search = Search.new(Character, params[:search])
    @search.order = 'code ASC'  # optional
    @characters = @search.run(params[:page])
    @structure = params[:search] && params[:search][:structure]
    @zongbihua = params[:search] && params[:search][:zongbihua]
  end

  def edit
  end

  def update
  end
end
