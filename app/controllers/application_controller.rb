class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  before_action :require_login, :navbarHighlight



  private
  def navbarHighlight
  @highlightHash = Hash.new#{"dashboard"=>'active'}#,"my_teams"=>"active", "sentRequests"=>"active","recievedRequests"=>"active","acceptedRequests"=>"active"}
		url = request.original_url()
		url = url.split('/')
		@highlightHash[url[-1]] = "active"
  end
  def require_login
	  unless user_signed_in?
		  flash[:danger] = "You must be logged in"
		  redirect_to("/dashboard")
		  return
	  end
  end
end
