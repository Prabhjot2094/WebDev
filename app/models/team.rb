class Team < ApplicationRecord
	belongs_to :player
	has_many :team_lists, :dependent => :delete_all

	validates :team_name,:location,:sport_id,:no_of_players, presence: true
	validates :sport_id,format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
	validates :no_of_players, numericality: {only_integer:true}

	DISTANCE_THRESHOLD = 500

	def self.getDistance(location1,location2)
		begin
			_directions = GoogleDirections.new(location1, location2)
			_distance_in_miles = _directions.distance_in_miles
		rescue Exception => e
			print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			print e
			return -1
		end

	end

	def self.getNearbyTeams(distanceHash, sportToBeMatched)
	end

	def self.match_teams(locationToBeMatched, sportToBeMatched, playerId, teamId)
		distanceHash = Hash.new()
		_distinctTeams 	= Team.select(:location).distinct(:location).where(sport_id: sportToBeMatched)

		_distinctTeams.each_with_index do |_location,i|
			_distance = getDistance(_location[:location],locationToBeMatched)
			if _distance.to_i<DISTANCE_THRESHOLD and _distance.to_i>=0
				distanceHash[_location[:location]] = _distance
			end
		end	
		_sentRequests = Request.select('id').where(request_from: teamId).pluck(:request_to)
		_recievedRequests = Request.select('id').where( request_to: teamId).pluck(:request_from)
		_recordsToExclude = _sentRequests+_recievedRequests

		#getNearbyTeams(distanceHash, sportToBeMatched)
		_nearbyTeams = Team.where(location: distanceHash.keys, sport_id: sportToBeMatched)\
			.where.not(player_id: playerId,id: _recordsToExclude)
	end


end
