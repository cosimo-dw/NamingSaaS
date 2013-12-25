class AnswersController < ApplicationController
  before_action :signed_in_user


  def create
    current_order = Order.find_by(:id => params[:answer][:order_id])
    #debugger

    if current_order.answer
      flash[:success] = "您已经为客户反馈过了！"
      redirect_to current_order
      return
    end

    # by current_user.admin  define :is_user
    @answer = current_order.build_answer(:content => params[:answer][:content], :chosen_name => params[:answer][:chosen_name])
    if @answer.save
      flash[:success] = "反馈给客户的信息保存成功！"
      current_order.save!

      redirect_to current_order
    else
      flash[:success] = "信息未能保存成功！"
      redirect_to current_order
    end

    #debugger

  end

  def update
    current_order = Order.find_by(:id => params[:answer][:order_id])
    @old_answer = current_order.answer
    if @old_answer
      @old_answer.update!(:content => params[:answer][:content] ,:chosen_name => params[:answer][:chosen_name]) #?????????? why can't be false
      flash[:success] = "反馈给客户的信息更新成功！"
      #debugger
    end

    redirect_to current_order
  end

end
