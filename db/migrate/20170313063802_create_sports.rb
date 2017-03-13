class CreateSports < ActiveRecord::Migration[5.0]
  def change
    create_table :sports do |t|
      t.string :sport_id
      t.string :sport_name

      t.timestamps
    end
  end
end
