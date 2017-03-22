class AddLocationToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :location, :string
  end
end
