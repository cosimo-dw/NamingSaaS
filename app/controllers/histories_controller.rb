class HistoriesController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user

  def index
    @histories = History.all
  end

  private
  def admin_user
    redirect_to (root_path) unless current_user.admin?
  end

end