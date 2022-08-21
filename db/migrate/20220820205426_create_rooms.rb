class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.datetime :expires_at

      t.timestamps
    end
  end
end
