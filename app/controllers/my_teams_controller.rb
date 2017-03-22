class MyTeamsController < ApplicationController

	def index
		@team = current_user.player.team_ids
	end

	def new
		@team = Team.new
	end

	def create
		@team = Team.new(params_team)
		@team.player_id = current_user.player.id 

		if @team.save 
			redirect_to my_teams_path
			flash[:success] = "Succesful"
		else
			flash[:danger] = "Failure"
			render 'new'
		end
	end

	def edit
		@team = current_user.player.teams.find(params[:id])

		if @team.nil?
			redirect_to '/dashboard/index'
		end
	end

	def update
		@team = current_user.player.teams.find(params[:id])

		if @team.update_attributes(params_team)
			redirect_to my_teams_path
		else
			render 'edit'
		end
	end

	def destroy
		@team = current_user.player.teams.find(params[:id])

		if !@team.nil?
			if @team.destroy
				flash[:success] = "Deletion Successful"
			else
				flash[:danger] = "Unable to delete form"
			end
		else
			flash[:danger] = "No Form Found"
			redirect_to my_teams_path
			return
		end
		redirect_to my_teams_path
	end


	def params_team
		params.require(:team).permit(:team_name, :sport_id ,:no_of_players)
	end

end
