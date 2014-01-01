#require 'ruby-debug'

class OrdersController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,     only: [:index, :update_price]

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


    if current_user.admin?
      @order.new_user_message = false
    else
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

  def update
    @order = Order.find(params[:id])

    @product = Product.find(@order.product_id)
    if @order.update_attributes(order_params)
      s = "#{l Time.now, format: :long}, 用户 #{@order.user.id}(#{@order.user.name}) 更新了订单：#{@order.id}"
      #s = Time.now.to_s.gsub( " +0800", "") + ", 用户 " + @order.user.id.to_s + '(' + @order.user.name.to_s + ") 创建了订单： " + @order.id.to_s
      History.create(:order_id => @order.id, :content => s)

      flash[:success] = "订单信息已被更新"
      redirect_to @order
    else
      render 'edit'
    end

  end

  def edit
    @order = Order.find(params[:id])
    @product = Product.find(@order.product_id)
    #debugger
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.assign_price
    if @order.save
      flash[:success] = "创建订单成功！"
      s = "#{l Time.now, format: :long}, 用户 #{@order.user.id}(#{@order.user.name}) 创建了订单：#{@order.id}"
      #s = Time.now.to_s.gsub( " +0800", "") + ", 用户 " + @order.user.id.to_s + '(' + @order.user.name.to_s + ") 创建了订单： " + @order.id.to_s
      History.create(:order_id => @order.id, :content => s)

      redirect_to @order
    else
      @product = Product.find(params[:order][:product_id])
      render 'new'
    end
  end

  def index
    @user = current_user
    para = params[:search] || {}
    para.reverse_merge!('product.name' => %w(个人取名 公司取名 八字断命), 'num_answers'=>%w(0 1))
    @search = Search.new(Order, para)
    @orders = @search.run(params[:page])
  end

  def update_box_status
    @order = Order.find(params[:id])
    if @order.is_message_box_closed
      @order.is_message_box_closed = false
      flash[:success] = "留言已开启！"
      s = "#{l Time.now, format: :long}, 订单 #{@order.id}被开启"
    else
      @order.is_message_box_closed = true
      flash[:error] = "留言已关闭！"
      s = "#{l Time.now, format: :long}, 订单 #{@order.id}被关闭"
    end
    @order.save!
    @order.histories.create(content: s)

    redirect_to :action => 'show'
  end

  def update_price

    @order = Order.find_by_id(params[:id])
    new_price = params['新的定价'].to_i
    if new_price > 0
      @order.price = new_price
      @order.save!

      s = "#{l Time.now, format: :long}, 管理员将订单 #{@order.id} 的价格修改为: #{new_price}"
      #s = Time.now.to_s.gsub( " +0800", "") + ", 管理员将订单 " + @order.id.to_s + " 的价格修改为: " + new_price.to_s
      @order.histories.create(content: s)

      flash[:success] = "更新定价成功！"
    else
      flash[:error] = "更新定价失败！"
    end

    redirect_to :action => 'show'
  end

  private

  def order_params
    params.require(:order).permit(:product_id, product_attribute_values_attributes: [ :product_attribute_id, :value, :id, value_set: [] ])
  end
end
