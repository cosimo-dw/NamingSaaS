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

      s = "用户 " + @order.user.id.to_s + " 创建了订单： " + @order.id.to_s
      History.create(:order_id => @order.id, :content => s)

      redirect_to @order
    else
      @product = Product.find(params[:order][:product_id])
      render 'new'
    end
  end

  def destroy
  end

  private

  def order_params
    params.require(:order).permit(:product_id, product_attribute_values_attributes: [ :product_attribute_id, :value, value_set: [] ])
  end
end
