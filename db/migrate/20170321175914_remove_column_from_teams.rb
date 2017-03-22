class RemoveColumnFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :player_id, :int
  end
end
