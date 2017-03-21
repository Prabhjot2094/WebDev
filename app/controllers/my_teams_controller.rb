class MyTeamsController < ApplicationController

	def index
	end

	def new
		@team = Team.new
	end

	def create
		@team = Team.new(params_team)
		@team_details = Team_List.new(params_team_details)

		if @team_details.save
			@team.player = @team_details.id
			redirect_to '/dashboard/index'
		end

		if @team.save 
			redirect_to '/dashboard/index'
		else
			render 'new'
		end
	end

	def edit
		@team = current_user.player

		if @team.nil?
			redirect_to '/dashboard/index'
		end
	end

	def update
		@team = current_user.player

		if @team.update_attributes(params_team)
			redirect_to '/dashboard/index'
		else
			render 'edit'
		end
	end

	def params_team
		#params.require(:team).permit(:f_name.:l_name,)
	end

end