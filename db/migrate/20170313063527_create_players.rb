class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :email
      t.string :f_name
      t.string :l_name
      t.string :user_name

      t.timestamps
    end
  end
end
