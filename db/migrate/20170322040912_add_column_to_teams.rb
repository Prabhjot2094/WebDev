class AddColumnToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :no_of_players, :string
  end
end
