class CreateTeamLists < ActiveRecord::Migration[5.0]
  def change
    create_table :team_lists do |t|
      t.string :team_id
      t.string :email

      t.timestamps
    end
  end
end
