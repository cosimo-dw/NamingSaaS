class CharactersController < ApplicationController
  before_action :admin_user
  def show
  end

  def index
    @search = Search.new(Character, params[:search])
    @search.order = 'rank DESC'  # optional
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
    para = params.require(:character).permit(:zongbihua, :structure)
    if @character.origin.blank?
      para[:origin] = "原信息: #{@character.structure}, #{@character.zongbihua}画"
    end
    para
  end
end
