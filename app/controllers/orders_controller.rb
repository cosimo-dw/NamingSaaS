#require 'ruby-debug'

class OrdersController < ApplicationController
  before_action :signed_in_user

  def new
    @product = Product.find_by_name(params[:product])
    if @product.nil?
      redirect_to :product => Product.first.name and return
    end
    @order = Order.new
    @product.product_attributes.each do |attr|
      @order.product_attribute_values.build product_attribute_id: attr.id
    end
  end

  def show
    #debugger
    @order = Order.find(params[:id])


    if current_user.admin and @order.new_user_message
      @order.new_user_message = false
    elsif not current_user.admin and @order.new_admin_message
      @order.new_admin_message = false
    end
    @order.save!


    #debugger
    @message = @order.messages.build    #
    #@my_order = User.find_by_id(@order.user_id) == current_user
    @messages = @order.messages.paginate(page: params[:page])

    @answer = @order.answer || @order.build_answer

    @order_type = Product.find_by(:id => @order.product_id).name



    #debugger
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.assign_price
    if @order.save
      flash[:success] = "创建订单成功！"

      s = Time.now.to_s.gsub( " +0800", "") + ", 用户 " + @order.user.id.to_s + '(' + @order.user.name.to_s + ") 创建了订单： " + @order.id.to_s
      History.create(:order_id => @order.id, :content => s)

      redirect_to @order
    else
      @product = Product.find(params[:order][:product_id])
      render 'new'
    end
  end

  def destroy
  end

  def update_price

    @order = Order.find_by_id(params[:id])
    new_price = params['新的定价'].to_i
    if new_price > 0
      @order.price = new_price
      @order.save!

      s = Time.now.to_s.gsub( " +0800", "") + ", 管理员将订单 " + @order.id.to_s + " 的价格修改为: " + new_price.to_s
      History.create(:order_id => @order.id, :content => s)

      flash[:success] = "更新定价成功！"
    else
      flash[:error] = "更新定价失败！"
    end



    redirect_to :action => 'show'
  end

  private

  def order_params
    params.require(:order).permit(:product_id, product_attribute_values_attributes: [ :product_attribute_id, :value, value_set: [] ])
  end
end
