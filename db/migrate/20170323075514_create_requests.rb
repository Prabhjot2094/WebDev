class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :request_from
      t.string :request_to
      t.string :status

      t.timestamps
    end
  end
end
