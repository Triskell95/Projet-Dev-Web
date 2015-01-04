class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
 	before_filter :set_global_search_variable

  def set_global_search_variable
    @q = Product.search(params[:q])
  end
end
