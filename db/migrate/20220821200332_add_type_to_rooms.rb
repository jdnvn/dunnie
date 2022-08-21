class AddTypeToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :type, :string
  end
end
