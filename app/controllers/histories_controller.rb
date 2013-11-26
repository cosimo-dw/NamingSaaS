class HistoriesController < ApplicationController
  before_action :admin_user

  def index
    @histories = History.all
  end

end