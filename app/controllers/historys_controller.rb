class HistorysController < ApplicationController
  before_action :signed_in_user

  def index
    @historys = History.all
  end

end