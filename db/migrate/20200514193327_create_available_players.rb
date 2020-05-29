class CreateAvailablePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :available_players do |t|
      t.string :position
      t.string :player
      t.float :rating

      t.timestamps
    end
  end
end
