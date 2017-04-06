class AddMobileToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :mobile, :string
  end
end
