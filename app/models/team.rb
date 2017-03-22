class Team < ApplicationRecord
	belongs_to :player

	has_many :team_lists
end
