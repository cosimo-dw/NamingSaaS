class HistoriesController < ApplicationController
  before_action :admin_user

  require 'csv'
   
  def csv_export

    @histories = History.find(:all)
     
    csv_string = CSV.generate do |csv|
      csv << ["历史记录"]
      @histories.each do |u|
        csv << [u.content]  
      end  
    end  
    send_data csv_string,  
             :type=>'text/csv; charset=iso-8859-1; header=present',  
             :disposition => "attachment; filename=export.txt"
  end 

  def index
    @histories = History.all
  end

end
