class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :quiz_id
      t.string :link_url
      t.boolean :joinable

      t.timestamps
    end
  end
end
