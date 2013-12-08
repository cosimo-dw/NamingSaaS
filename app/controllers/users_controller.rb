require 'ruby-debug'

class UsersController < ApplicationController
  before_action :non_signed_in_user, only: [:new, :create]
  before_action :signed_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    #debugger
    if not @user.admin
      @orders = @user.orders.paginate(page: params[:page])
    else # if the current one is the admin
      @orders = Order.all.paginate(page: params[:page])
    end
    #debugger
    #@messages =  @user.orders.paginate(page: params[:page])
    #@messages = ["sss","ttt"].paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "欢迎！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "个人信息已被更新"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "该用户已被删除"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters

  def non_signed_in_user
    if signed_in?
      redirect_to root_path, notice: 'Already signed in.'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) or current_user.admin?
  end

end
