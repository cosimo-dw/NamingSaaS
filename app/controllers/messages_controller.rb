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
      flash[:success] = "Message was successfully created!"

      current_order.histories.create(content: "User #{current_order.user.id} create a message #{@message.content}")

      redirect_to current_order
    else
      flash[:success] = "Message was not created!"
      redirect_to current_order
    end
  end

  def destroy
    #debugger
    @message = Message.find(params[:id])
    order = @message.order

    order.histories.create(content: "User #{order.user.id} destroy a message #{@message.content}")

    @message.destroy
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
