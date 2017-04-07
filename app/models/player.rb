class Player < ApplicationRecord
	has_many :teams, :dependent => :delete_all
end
