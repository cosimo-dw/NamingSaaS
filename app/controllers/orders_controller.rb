class OrdersController < ApplicationController
  before_action :signed_in_user

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "Order created!"
      redirect_to @order
    else
      render 'new'
    end
  end

  def destroy
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :product_attrs)
  end
end