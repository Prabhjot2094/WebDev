class AddReferenceToTeamLists < ActiveRecord::Migration[5.0]
  def change
    add_reference :team_lists, :player, foreign_key: true
  end
end
