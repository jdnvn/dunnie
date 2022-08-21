class CreateUsersRooms < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :rooms do |t|
      t.references :user, type: :uuid, index: false
      t.references :room, type: :uuid, index: false
      t.index :user_id
      t.index :room_id
    end
  end
end
