#require 'ruby-debug'

class MessagesController < ApplicationController
  before_action :signed_in_user
  #before_action :set_message, only: [:show, :edit, :update, :destroy]


  def create
    #debugger
    current_order = Order.find_by(:id => params[:message][:order_id])


    # by current_user.admin  define :is_user
    # here there is a bug
    @message = current_order.messages.build(:content => params[:message][:content], :is_user => (not current_user.admin)) #?????????? why can't be false
    #debugger

    if @message.save
      flash[:success] = "留言成功！"
      if current_user.admin
        current_order.new_admin_message = true
      else
        current_order.new_user_message = true
      end
      current_order.save!

      if @message.is_user
        s = Time.now.to_s.gsub( " +0800", "") + ", 用户 #{current_order.user.id}(" + current_order.user.name.to_s + ") 发表了留言： #{@message.content}"
        current_order.histories.create(:content => s)
      else
        s = Time.now.to_s.gsub( " +0800", "") + ", 管理员发表了留言： #{@message.content}"
        current_order.histories.create(:content => s)
      end

      redirect_to current_order
    else
      flash[:error] = "留言失败！"
      redirect_to current_order
    end
  end

  def destroy
    #debugger
    @message = Message.find(params[:id])
    order = @message.order

    if @message.is_user
      s = Time.now.to_s.gsub( " +0800", "") + ", 用户 #{order.user.id}(" + order.user.name.to_s + ") 删除了留言： #{@message.content}"
      order.histories.create(:content => s)
    else
      s = Time.now.to_s.gsub( " +0800", "") + ", 管理员删除了留言： #{@message.content}"
      order.histories.create(:content => s)
    end

    @message.destroy
    flash[:success] = "留言删除成功！"
    redirect_to order
  end

  #private
    # Use callbacks to share common setup or constraints between actions.
  #  def set_message
  #    @message = Message.find(params[:id])
  #  end

    # Never trust parameters from the scary internet, only allow the white list through.
  #  def message_params
  #    params.require(:message).permit(:content)
  #  end
end
