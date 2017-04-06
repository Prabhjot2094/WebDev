class MyTeamsController < ApplicationController
	def index
		@team = current_user.player.team_ids
		@newTeam = Team.new
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
			return
		else
			flash[:danger] = "Failure"
			render 'new'
		end
	end

	def edit
		begin
			@team = current_user.player.teams.find(params[:id])
		rescue
			redirect_to my_teams_path
			return
		end

		if @team.nil?
			redirect_to '/dashboard'
			return
		end
	end
	
	def getEditDetails
			@team = current_user.player.teams.find(params[:id])
			respond_to do |format|
				format.json {render json: @team}
			print "++++++++++++++++++++++++++++++++++++++++++++++++++"
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

		request_to = Request.where(request_to: params[:id])
		request_from = Request.where(request_from: params[:id])

		destroyAllRequests(request_to)
		destroyAllRequests(request_from)

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

	def matchedTeams
		@teamId = params[:id]
		@team = current_user.player.teams.find(params[:id])
		@matchedTeams = Team.match_teams(@team.location, @team.sport_id, @team.player_id, @team.id)
	end

	def saveRequest
		@request = Request.new

		@request.request_to = params[:req_to]
		@request.request_from = params[:req_from]
		@request.status = "0"

		if @request.save
			redirect_to my_teams_sentRequests_path
		else
			redirect_to my_teams_path
		end
	end

	def acceptRequest
		request = Request.find(params[:id])

		if request.update_attributes(status: 1)
			redirect_to my_teams_acceptedRequests_path
		else
			redirect_to my_teams_recievedRequests_path
		end
	end

	def deleteRequest
		request = Request.find(params[:id])

		if !request.nil?
			if request.destroy
				flash[:success] = "Deletion Successful"
			else
				flash[:danger] = "Unable to delete Request"
			end
		else
			flash[:danger] = "No Request Found"
			redirect_to my_teams_acceptedRequests_path
			return
		end
		redirect_to my_teams_acceptedRequests_path
	end

	def sentRequests
		@sentRequests = Request.where(request_from: current_user.player.team_ids, status: "0")
	end

	def recievedRequests
		@recievedRequests = Request.where(request_to: current_user.player.team_ids, status: "0")
	end
	
	def acceptedRequests
		teamIds = current_user.player.team_ids
		@acceptedSentRequests = Request.where(request_from: teamIds, status: "1")
		@acceptedRecievedRequests = Request.where( request_to: teamIds, status: "1")
	end

	def destroyAllRequests(request)
		request.each do |r|
			r.destroy
		end	
	end

	def params_team
		params.require(:team).permit(:team_name, :sport_id ,:no_of_players, :location)
	end

end
