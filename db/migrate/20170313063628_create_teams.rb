class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :team_id
      t.string :sport_id
      t.string :team_name

      t.timestamps
    end
  end
end
