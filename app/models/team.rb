class Team < ApplicationRecord
	belongs_to :player

	has_many :team_lists


	DISTANCE_THRESHOLD = 500

	def self.getDistance(location1,location2)
		begin
		directions = GoogleDirections.new(location1, location2)
		distance_in_miles = directions.distance_in_miles
		rescue
			return -1
		end

	end

	def self.getNearbyTeams(distanceHash)
		_nearbyTeams = Team.where(location: distanceHash.keys)
	end

	def self.match_teams(locationToBeMatched)
		distanceHash = Hash.new()
		_distinctTeams 	= Team.select(:location).distinct(:location)

		_distinctTeams.each_with_index do |_location,i|
			#print _location[:location]
			_distance = getDistance(_location[:location],locationToBeMatched)
			#print _distance
			if _distance.to_i<DISTANCE_THRESHOLD and _distance.to_i>=0
				distanceHash[_location[:location]] = _distance
			end
		end	
		print"-----------------"
		print distanceHash.keys
		getNearbyTeams(distanceHash)
	end


end
