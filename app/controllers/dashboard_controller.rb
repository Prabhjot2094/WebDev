class DashboardController < ApplicationController
	skip_before_action :require_login, only: [:index ,:signIn]

	def index
	end

	def signIn
		print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		print params[:password]
		user = User.find_for_authentication(:email => params[:email])
		print user
		if  !user.nil? and user.valid_password?(params[:password])
			sign_in user
			print "---------------------------------------"
			print user_signed_in?
			redirect_to("/dashboard")
			return
		else
			redirect_to("/dashboard")
			return 
		end
	end	
end
