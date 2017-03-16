class DashboardController < ApplicationController
		def index
		end
		
		def chkCredentials
			print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			print params[:password]
			user = User.find_for_authentication(:email => params[:email])
			print user
			if user.valid_password?(params[:password])==true
				sign_in user
				print "---------------------------------------"
				print user_signed_in?
				redirect_to("/dashboard/index")
				return
			else
				redirect_to("/dashboard/index")
				return 
			end
		end	
	end
