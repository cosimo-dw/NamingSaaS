class CharactersController < ApplicationController
  before_action :admin_user
  def show
  end

  def index
    @search = Search.new(Character, params[:search])
    @search.order = 'code ASC'  # optional
    @characters = @search.run(params[:page])
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    if @character.update_attributes(character_params)
      flash[:success] = "信息已被更新"
      redirect_to characters_path
    else
      render 'edit'
    end
  end

  private

  def character_params
    params.require(:character).permit(:zongbihua, :structure)
  end
end
