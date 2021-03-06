class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
	skip_before_action :require_login

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
	def create

	 @player = Player.new
	 @player.user_name = params_player[:player][:user_name]
	 @player.mobile = params_player[:player][:mobile]

	 if not @player.save
		 @player.errors.full_messages
		 print"---------------------------------------------\n"
		 print params_player[:player][:user_name]
		 redirect_to '/users/sign_up'
		 return
	 end
	 super
	 if not user_signed_in?
	 	@player.destroy
	 else
		 @player.update_attribute(:user_id,current_user.id)
	 end

	end

	def params_player
		params.require(:user).permit(:email,:password,:password_confirmation, player: [:user_name,:mobile])
	end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
	@team = current_user.player.teams
	@team.each do |t|
		request_to = Request.where(request_to: t.id)
		request_from = Request.where(request_from: t.id)

	destroyAllRequests(request_to)
	destroyAllRequests(request_from)
		end
    super
  end

	def destroyAllRequests(request)
		request.each do |r|
			r.destroy
		end	
	end
  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
