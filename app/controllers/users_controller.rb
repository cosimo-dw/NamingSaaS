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
      @all_order_types = [1,2, 3]
      @type_names =['个人取名','公司取名','八字断命']
      @selected_types = params[:types] || session[:types]||{}
      @whether_reply_types = [0,1]
      @whether_reply_names=['未反馈','已反馈']
      @selected_whether_reply = params[:reply_answer]||session[:reply_answer]||{}
      @orders = Order.where(:product_id => @selected_types)
      if @selected_whether_reply ==['0']
          @orders.joins(:answer).each do  |order|
            @orders =  @orders.where.not( :id => order.id)
          end
        elsif  @selected_whether_reply ==['1']
          @orders=@orders.joins(:answer)
      end

      if params[:types] != session[:types] and @selected_types != {}
        session[:types] = @selected_types
      end
      if params[:reply_answer] != session[:reply_answer] and @selected_whether_reply != {}
        session[:reply_answer] = @selected_whether_reply
      end
      @orders = @orders.paginate(page: params[:page])
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

      #new_messages =  @user.errors.full_messages


      #new_messages = []
      #@user.errors.full_messages.each do |m|
      #  if(m == "Password confirmation can't be blank")
      #    new_messages.push("密码确认不能为空！")
      #  elsif(m == "Password confirmation doesn't match Password")
      #    new_messages.push("密码确认和密码不同！")
      #  elsif(m == "Password can't be blank")
      #    new_messages.push("密码不能为空！")
      #  else
      #    new_messages.push(m.gsub(/[a-zA-Z\s]/, ''))
      #  end
      #end
      #
      #@user.errors.instance_eval do
      #  @@new_messages = new_messages
      #  def full_messages
      #    @@new_messages
      #  end
      #end
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
