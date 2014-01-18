class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :game_id
      t.string :name
      t.integer :passcode

      t.timestamps
    end
  end
end
