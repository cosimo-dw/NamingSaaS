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
    @order = Order.find(params[:id])
    @messages = @order.messages.paginate(page: params[:page])
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.assign_price
    if @order.save!
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
    params.require(:order).permit(:product_id, product_attribute_values_attributes: [ :product_attribute_id, :value ])
  end
end