class HistorysController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user

  def index
    @historys = History.all
  end

  private
  def admin_user
    current_user.admin?
  end

end