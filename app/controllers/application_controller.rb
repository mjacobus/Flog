class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_params
  
  def set_params 
    params[:limit] = 1 unless params[:limit]
  end
end
