class RemoveEmailFromTeamLists < ActiveRecord::Migration[5.0]
  def change
    remove_column :team_lists, :email, :string
  end
end
