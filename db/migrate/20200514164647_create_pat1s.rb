class CreatePat1s < ActiveRecord::Migration[6.0]
  def change
    create_table :pat1s do |t|
      t.string :position
      t.string :player
      t.float :rating

      t.timestamps
    end
  end
end
