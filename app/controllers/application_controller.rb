class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  before_action :require_login

  private
  def require_login
	  unless user_signed_in?
		  flash[:error] = "You must be logged in"
		  redirect_to("/dashboard")
		  return
	  end
  end
end
