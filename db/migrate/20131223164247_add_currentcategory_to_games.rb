class AddCurrentcategoryToGames < ActiveRecord::Migration
  def change
    add_column :games, :currentcategory, :integer
  end
end
