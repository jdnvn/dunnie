class CreateUsersRooms < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :rooms, column_options: { null: false, foreign_key: true, type: :uuid } do |t|
      t.index [:user_id, :room_id]
      t.index [:room_id, :user_id]
    end
  end
end
