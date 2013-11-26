class CharactersController < ApplicationController
  before_action :admin_user
  def show
  end

  def index
    @characters = Character.search(params[:character],params[:page])
    @struct_collection = ['独']
    (12272..12283).each do |code|
      @struct_collection << [code].pack('U*')
    end
    @structure = params[:character] && params[:character][:structure]
    @zongbihua = params[:character] && params[:character][:zongbihua]
  end

  def edit
  end

  def update
  end
end
