require 'ruby-debug'

class MessagesController < ApplicationController
  before_action :signed_in_user
  #before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    #@messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    #debugger
    current_order = Order.find_by(params[:message][:order_id])
    @message = current_order.messages.build(:content => params[:message][:content], :is_user => params[:message][:is_user])
    if @message.save
      flash[:success] = "Message was successfully created!"

      s = current_order.user.id.to_s + " create a message " + @message.id.to_s
      History.create(:order_id => current_order.id, :content => s)

      redirect_to current_order
    else
      flash[:success] = "Message was not created!"
      redirect_to current_order
    end
  end


  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update

  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    current_order = Order.find_by(params[:order_id])
    @message = current_order.messages.find_by(params[:id])

    s = current_order.user.id.to_s + " destroy a message " + @message.id.to_s
    History.create(:order_id => current_order.id, :content => s)

    @message.destroy
    redirect_to current_order
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
